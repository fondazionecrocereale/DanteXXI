import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/wallet/get_balance_usecase.dart';
import '../../../domain/usecases/wallet/refresh_balance_usecase.dart';
import 'wallet_event.dart';
import 'wallet_state.dart';

@injectable
class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final GetBalanceUsecase _getBalanceUsecase;
  final RefreshBalanceUsecase _refreshBalanceUsecase;
  String? _currentAddress;

  WalletBloc(this._getBalanceUsecase, this._refreshBalanceUsecase)
    : super(const WalletState.initial()) {
    on<LoadRequested>(_onLoadRequested);
    on<RefreshRequested>(_onRefreshRequested);
    on<BalanceUpdated>(_onBalanceUpdated);
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<WalletState> emit,
  ) async {
    _currentAddress = event.address;
    emit(const WalletState.loading());

    try {
      final balance = await _getBalanceUsecase(event.address);
      emit(WalletState.loaded(balance));
    } catch (e) {
      emit(WalletState.error('Error al cargar el balance: $e'));
    }
  }

  Future<void> _onRefreshRequested(
    RefreshRequested event,
    Emitter<WalletState> emit,
  ) async {
    if (_currentAddress == null) return;

    emit(const WalletState.loading());

    try {
      await _refreshBalanceUsecase(_currentAddress!);
      final balance = await _getBalanceUsecase(_currentAddress!);
      emit(WalletState.loaded(balance));
    } catch (e) {
      emit(WalletState.error('Error al actualizar el balance: $e'));
    }
  }

  Future<void> _onBalanceUpdated(
    BalanceUpdated event,
    Emitter<WalletState> emit,
  ) async {
    if (_currentAddress == null) return;

    try {
      final balance = await _getBalanceUsecase(_currentAddress!);
      emit(WalletState.loaded(balance));
    } catch (e) {
      emit(WalletState.error('Error al actualizar el balance: $e'));
    }
  }
}
