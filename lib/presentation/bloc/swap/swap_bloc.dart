import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/swap/create_swap_usecase.dart';
import '../../../domain/usecases/swap/get_swaps_usecase.dart';
import '../wallet/wallet_bloc.dart';
import 'swap_event.dart';
import 'swap_state.dart';

@injectable
class SwapBloc extends Bloc<SwapEvent, SwapState> {
  final GetSwapsUsecase _getSwapsUsecase;
  final CreateSwapUsecase _createSwapUsecase;

  SwapBloc(this._getSwapsUsecase, this._createSwapUsecase)
    : super(const SwapState.initial()) {
    on<LoadRequested>(_onLoadRequested);
    on<RefreshRequested>(_onRefreshRequested);
    on<CreateSwap>(_onCreateSwap);
    on<SwapCreated>(_onSwapCreated);
    on<GetExchangeRate>(_onGetExchangeRate);
    on<CalculateFiorinoAmount>(_onCalculateFiorinoAmount);
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<SwapState> emit,
  ) async {
    emit(const SwapState.loading());

    try {
      final swaps = await _getSwapsUsecase();
      emit(SwapState.loaded(swaps));
    } catch (e) {
      emit(SwapState.error('Error al cargar los swaps: $e'));
    }
  }

  Future<void> _onRefreshRequested(
    RefreshRequested event,
    Emitter<SwapState> emit,
  ) async {
    emit(const SwapState.loading());

    try {
      final swaps = await _getSwapsUsecase();
      emit(SwapState.loaded(swaps));
    } catch (e) {
      emit(SwapState.error('Error al actualizar los swaps: $e'));
    }
  }

  Future<void> _onCreateSwap(CreateSwap event, Emitter<SwapState> emit) async {
    emit(const SwapState.creating());

    try {
      final swap = await _createSwapUsecase(
        mercadopagoAmount: event.mercadopagoAmount,
        fiorinoAmount: event.fiorinoAmount,
        exchangeRate: event.exchangeRate,
      );
      emit(SwapState.created(swap));
    } catch (e) {
      emit(SwapState.error('Error al crear swap: $e'));
    }
  }

  Future<void> _onSwapCreated(
    SwapCreated event,
    Emitter<SwapState> emit,
  ) async {
    // Recargar swaps después de crear uno nuevo
    add(const LoadRequested());
  }

  Future<void> _onGetExchangeRate(
    GetExchangeRate event,
    Emitter<SwapState> emit,
  ) async {
    try {
      // En una implementación real, esto vendría del servicio
      const rate = 0.001; // 1 ARS = 0.001 FIORINO
      emit(SwapState.exchangeRateLoaded(rate));
    } catch (e) {
      emit(SwapState.error('Error al obtener tasa de cambio: $e'));
    }
  }

  Future<void> _onCalculateFiorinoAmount(
    CalculateFiorinoAmount event,
    Emitter<SwapState> emit,
  ) async {
    try {
      // En una implementación real, esto usaría el servicio
      const rate = 0.001; // 1 ARS = 0.001 FIORINO
      final fiorinoAmount = (event.arsAmount * rate * 1000000).round();
      emit(SwapState.fiorinoAmountCalculated(fiorinoAmount));
    } catch (e) {
      emit(SwapState.error('Error al calcular cantidad de Fiorino: $e'));
    }
  }
}
