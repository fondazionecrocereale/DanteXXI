import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../domain/entities/swap.dart';
import '../../domain/repositories/swap_repository.dart';
import '../services/blockchain_service.dart';
import '../services/mercadopago_service.dart';

@injectable
class SwapRepositoryImpl implements SwapRepository {
  final BlockchainService _blockchainService;
  final MercadoPagoService _mercadopagoService;
  late SharedPreferences _prefs;

  SwapRepositoryImpl(this._blockchainService, this._mercadopagoService) {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<List<Swap>> getSwaps() async {
    try {
      final swapsJson = _prefs.getStringList('swaps') ?? [];
      return swapsJson.map((json) => Swap.fromJson(jsonDecode(json))).toList();
    } catch (e) {
      return _getMockSwaps();
    }
  }

  @override
  Future<Swap> getSwapById(String id) async {
    final swaps = await getSwaps();
    return swaps.firstWhere((swap) => swap.id == id);
  }

  @override
  Future<Swap> createSwap({
    required double mercadopagoAmount,
    required int fiorinoAmount,
    required double exchangeRate,
  }) async {
    try {
      final swap = Swap(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        mercadopagoAmount: mercadopagoAmount,
        fiorinoAmount: fiorinoAmount,
        exchangeRate: exchangeRate,
        status: SwapStatus.pending,
        createdAt: DateTime.now(),
      );

      // Guardar en SharedPreferences
      final swaps = await getSwaps();
      swaps.add(swap);
      final swapsJson = swaps.map((s) => jsonEncode(s.toJson())).toList();
      await _prefs.setStringList('swaps', swapsJson);

      // Simular procesamiento del swap
      await Future.delayed(const Duration(seconds: 2));

      // Actualizar estado a completado
      final completedSwap = swap.copyWith(
        status: SwapStatus.completed,
        completedAt: DateTime.now(),
        fiorinoTxHash: 'swap_tx_${DateTime.now().millisecondsSinceEpoch}',
      );

      // Actualizar en SharedPreferences
      final updatedSwaps = swaps
          .map((s) => s.id == swap.id ? completedSwap : s)
          .toList();
      final updatedSwapsJson = updatedSwaps
          .map((s) => jsonEncode(s.toJson()))
          .toList();
      await _prefs.setStringList('swaps', updatedSwapsJson);

      return completedSwap;
    } catch (e) {
      throw Exception('Error al crear swap: $e');
    }
  }

  @override
  Future<Swap> updateSwapStatus(String id, SwapStatus status) async {
    final swaps = await getSwaps();
    final swapIndex = swaps.indexWhere((swap) => swap.id == id);

    if (swapIndex == -1) {
      throw Exception('Swap no encontrado');
    }

    final updatedSwap = swaps[swapIndex].copyWith(
      status: status,
      completedAt: status == SwapStatus.completed ? DateTime.now() : null,
    );

    swaps[swapIndex] = updatedSwap;
    final swapsJson = swaps.map((s) => jsonEncode(s.toJson())).toList();
    await _prefs.setStringList('swaps', swapsJson);

    return updatedSwap;
  }

  @override
  Future<double> getExchangeRate() async {
    return await _mercadopagoService.getExchangeRate();
  }

  @override
  Future<int> calculateFiorinoAmount(double arsAmount) async {
    return await _mercadopagoService.calculateFiorinoAmount(arsAmount);
  }

  @override
  Stream<List<Swap>> watchSwaps() async* {
    // En una implementación real, esto podría usar WebSockets
    while (true) {
      yield await getSwaps();
      await Future.delayed(const Duration(seconds: 30));
    }
  }

  List<Swap> _getMockSwaps() {
    return [
      Swap(
        id: '1',
        mercadopagoAmount: 1000.0,
        fiorinoAmount: 1000000, // 1 FIORINO
        exchangeRate: 0.001,
        status: SwapStatus.completed,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        completedAt: DateTime.now().subtract(const Duration(hours: 2)),
        fiorinoTxHash: 'swap_tx_123',
      ),
      Swap(
        id: '2',
        mercadopagoAmount: 500.0,
        fiorinoAmount: 500000, // 0.5 FIORINO
        exchangeRate: 0.001,
        status: SwapStatus.completed,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        completedAt: DateTime.now().subtract(const Duration(days: 1)),
        fiorinoTxHash: 'swap_tx_456',
      ),
    ];
  }
}
