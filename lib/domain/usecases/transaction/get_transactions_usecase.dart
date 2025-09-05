import 'package:injectable/injectable.dart';

import '../../entities/transaction.dart';
import '../../repositories/transaction_repository.dart';

@injectable
class GetTransactionsUsecase {
  final TransactionRepository _transactionRepository;

  GetTransactionsUsecase(this._transactionRepository);

  Future<List<Transaction>> call(String address) async {
    return await _transactionRepository.getTransactions(address);
  }
}
