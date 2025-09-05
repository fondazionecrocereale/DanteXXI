import 'package:injectable/injectable.dart';

import '../../domain/entities/wallet_balance.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../services/blockchain_service.dart';

@injectable
class WalletRepositoryImpl implements WalletRepository {
  final BlockchainService _blockchainService;

  WalletRepositoryImpl(this._blockchainService);

  @override
  Future<WalletBalance> getBalance(String address) async {
    try {
      final fiorinoBalance = await _blockchainService.getBalance(address);
      final fiorinoPrice = await _blockchainService.getFiorinoPrice();
      final usdBalance =
          fiorinoBalance * fiorinoPrice / 1000000; // Convertir a USD

      return WalletBalance(
        fiorinoBalance: fiorinoBalance,
        usdBalance: usdBalance,
        fiorinoPrice: fiorinoPrice,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      // Devolver balance vacío en caso de error
      return WalletBalance.empty();
    }
  }

  @override
  Future<void> refreshBalance(String address) async {
    // En una implementación real, esto podría invalidar caché o forzar actualización
    await getBalance(address);
  }

  @override
  Stream<WalletBalance> watchBalance(String address) async* {
    // En una implementación real, esto podría usar WebSockets o polling
    while (true) {
      yield await getBalance(address);
      await Future.delayed(const Duration(seconds: 30));
    }
  }
}
