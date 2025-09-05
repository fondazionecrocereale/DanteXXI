import 'package:injectable/injectable.dart';

import '../../repositories/wallet_repository.dart';

@injectable
class RefreshBalanceUsecase {
  final WalletRepository _walletRepository;

  RefreshBalanceUsecase(this._walletRepository);

  Future<void> call(String address) async {
    await _walletRepository.refreshBalance(address);
  }
}
