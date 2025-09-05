import 'package:injectable/injectable.dart';

import '../../repositories/transaction_repository.dart';

@injectable
class SendTransactionUsecase {
  final TransactionRepository _transactionRepository;

  SendTransactionUsecase(this._transactionRepository);

  Future<String> call({
    required String toAddress,
    required int amount,
    String? memo,
  }) async {
    return await _transactionRepository.sendTransaction(
      toAddress: toAddress,
      amount: amount,
      memo: memo,
    );
  }
}
