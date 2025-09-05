import '../entities/wallet_balance.dart';

abstract class WalletRepository {
  Future<WalletBalance> getBalance(String address);
  Future<void> refreshBalance(String address);
  Stream<WalletBalance> watchBalance(String address);
}
