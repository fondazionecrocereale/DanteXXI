import 'package:injectable/injectable.dart';

import '../../entities/wallet_balance.dart';
import '../../repositories/wallet_repository.dart';

@injectable
class GetBalanceUsecase {
  final WalletRepository _walletRepository;

  GetBalanceUsecase(this._walletRepository);

  Future<WalletBalance> call(String address) async {
    return await _walletRepository.getBalance(address);
  }
}
