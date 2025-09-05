import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/reward/get_rewards_usecase.dart';
import '../../../domain/usecases/reward/claim_reward_usecase.dart';
import 'rewards_event.dart';
import 'rewards_state.dart';

@injectable
class RewardsBloc extends Bloc<RewardsEvent, RewardsState> {
  final GetRewardsUsecase _getRewardsUsecase;
  final ClaimRewardUsecase _claimRewardUsecase;

  RewardsBloc(this._getRewardsUsecase, this._claimRewardUsecase)
    : super(const RewardsState.initial()) {
    on<LoadRequested>(_onLoadRequested);
    on<RefreshRequested>(_onRefreshRequested);
    on<ClaimReward>(_onClaimReward);
    on<RewardClaimed>(_onRewardClaimed);
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<RewardsState> emit,
  ) async {
    emit(const RewardsState.loading());

    try {
      final rewards = await _getRewardsUsecase();
      emit(RewardsState.loaded(rewards));
    } catch (e) {
      emit(RewardsState.error('Error al cargar las recompensas: $e'));
    }
  }

  Future<void> _onRefreshRequested(
    RefreshRequested event,
    Emitter<RewardsState> emit,
  ) async {
    emit(const RewardsState.loading());

    try {
      final rewards = await _getRewardsUsecase();
      emit(RewardsState.loaded(rewards));
    } catch (e) {
      emit(RewardsState.error('Error al actualizar las recompensas: $e'));
    }
  }

  Future<void> _onClaimReward(
    ClaimReward event,
    Emitter<RewardsState> emit,
  ) async {
    emit(const RewardsState.claiming());

    try {
      final reward = await _claimRewardUsecase(event.rewardId);
      emit(RewardsState.claimed(reward));
    } catch (e) {
      emit(RewardsState.error('Error al reclamar recompensa: $e'));
    }
  }

  Future<void> _onRewardClaimed(
    RewardClaimed event,
    Emitter<RewardsState> emit,
  ) async {
    // Recargar recompensas después de reclamar una
    add(const LoadRequested());
  }
}
