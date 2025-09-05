import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/swap.dart';

part 'swap_state.freezed.dart';

@freezed
class SwapState with _$SwapState {
  const factory SwapState.initial() = _Initial;
  const factory SwapState.loading() = _Loading;
  const factory SwapState.loaded(List<Swap> swaps) = _Loaded;
  const factory SwapState.error(String message) = _Error;
  const factory SwapState.creating() = _Creating;
  const factory SwapState.created(Swap swap) = _Created;
  const factory SwapState.exchangeRateLoaded(double rate) = _ExchangeRateLoaded;
  const factory SwapState.fiorinoAmountCalculated(int amount) =
      _FiorinoAmountCalculated;
}
