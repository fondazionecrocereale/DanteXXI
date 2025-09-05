import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/reward.dart';

part 'rewards_state.freezed.dart';

@freezed
class RewardsState with _$RewardsState {
  const factory RewardsState.initial() = _Initial;
  const factory RewardsState.loading() = _Loading;
  const factory RewardsState.loaded(List<Reward> rewards) = _Loaded;
  const factory RewardsState.error(String message) = _Error;
  const factory RewardsState.claiming() = _Claiming;
  const factory RewardsState.claimed(Reward reward) = _Claimed;
}
