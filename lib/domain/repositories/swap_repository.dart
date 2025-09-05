import '../entities/swap.dart';

abstract class SwapRepository {
  Future<List<Swap>> getSwaps();
  Future<Swap> getSwapById(String id);
  Future<Swap> createSwap({
    required double mercadopagoAmount,
    required int fiorinoAmount,
    required double exchangeRate,
  });
  Future<Swap> updateSwapStatus(String id, SwapStatus status);
  Future<double> getExchangeRate();
  Future<int> calculateFiorinoAmount(double arsAmount);
  Stream<List<Swap>> watchSwaps();
}
