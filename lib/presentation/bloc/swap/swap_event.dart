import 'package:freezed_annotation/freezed_annotation.dart';

part 'swap_event.freezed.dart';

@freezed
class SwapEvent with _$SwapEvent {
  const factory SwapEvent.loadRequested() = LoadRequested;
  const factory SwapEvent.refreshRequested() = RefreshRequested;
  const factory SwapEvent.createSwap({
    required double mercadopagoAmount,
    required int fiorinoAmount,
    required double exchangeRate,
  }) = CreateSwap;
  const factory SwapEvent.swapCreated() = SwapCreated;
  const factory SwapEvent.getExchangeRate() = GetExchangeRate;
  const factory SwapEvent.calculateFiorinoAmount(double arsAmount) =
      CalculateFiorinoAmount;
}
