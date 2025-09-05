import '../entities/transaction.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> getTransactions(String address);
  Future<Transaction> getTransactionById(String id);
  Future<String> sendTransaction({
    required String toAddress,
    required int amount,
    String? memo,
  });
  Future<String> receiveTransaction({
    required String fromAddress,
    required int amount,
    String? memo,
  });
  Stream<List<Transaction>> watchTransactions(String address);
}
