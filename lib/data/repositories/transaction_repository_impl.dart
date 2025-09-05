import 'package:injectable/injectable.dart';

import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../services/blockchain_service.dart';

@injectable
class TransactionRepositoryImpl implements TransactionRepository {
  final BlockchainService _blockchainService;

  TransactionRepositoryImpl(this._blockchainService);

  @override
  Future<List<Transaction>> getTransactions(String address) async {
    try {
      final history = await _blockchainService.getTransactionHistory(address);
      return history.map((tx) => _mapToTransaction(tx, address)).toList();
    } catch (e) {
      // Devolver transacciones simuladas en caso de error
      return _getMockTransactions(address);
    }
  }

  @override
  Future<Transaction> getTransactionById(String id) async {
    // En una implementación real, esto buscaría la transacción específica
    final transactions = await getTransactions('fiorino1demo123');
    return transactions.firstWhere((tx) => tx.id == id);
  }

  @override
  Future<String> sendTransaction({
    required String toAddress,
    required int amount,
    String? memo,
  }) async {
    try {
      return await _blockchainService.sendTokens(
        toAddress: toAddress,
        amount: amount,
        memo: memo,
      );
    } catch (e) {
      throw Exception('Error al enviar transacción: $e');
    }
  }

  @override
  Future<String> receiveTransaction({
    required String fromAddress,
    required int amount,
    String? memo,
  }) async {
    // En una implementación real, esto podría crear una transacción de recepción
    return 'receive_tx_${DateTime.now().millisecondsSinceEpoch}';
  }

  @override
  Stream<List<Transaction>> watchTransactions(String address) async* {
    // En una implementación real, esto podría usar WebSockets
    while (true) {
      yield await getTransactions(address);
      await Future.delayed(const Duration(seconds: 30));
    }
  }

  Transaction _mapToTransaction(Map<String, dynamic> tx, String address) {
    final messages = tx['tx']['body']['messages'] as List;
    final message = messages.first;
    final amount = int.parse(message['amount'].first['amount'] as String);
    final fromAddress = message['from_address'] as String;
    final toAddress = message['to_address'] as String;

    final isSend = fromAddress == address;
    final isReceive = toAddress == address;

    return Transaction(
      id: tx['txhash'] as String,
      fromAddress: fromAddress,
      toAddress: toAddress,
      amount: amount,
      type: isSend ? TransactionType.send : TransactionType.receive,
      status: TransactionStatus.confirmed,
      timestamp: DateTime.parse(tx['timestamp'] as String),
      hash: tx['txhash'] as String,
    );
  }

  List<Transaction> _getMockTransactions(String address) {
    return [
      Transaction(
        id: '1',
        fromAddress: 'fiorino1...abc123',
        toAddress: address,
        amount: 1000000, // 1 FIORINO
        type: TransactionType.receive,
        status: TransactionStatus.confirmed,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        memo: 'Pago de servicios',
        hash: '0x123...abc',
      ),
      Transaction(
        id: '2',
        fromAddress: address,
        toAddress: 'fiorino1...def456',
        amount: 500000, // 0.5 FIORINO
        type: TransactionType.send,
        status: TransactionStatus.confirmed,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        memo: 'Reembolso',
        hash: '0x456...def',
        fee: 1000,
      ),
      Transaction(
        id: '3',
        fromAddress: address,
        toAddress: 'fiorino1...ghi789',
        amount: 2000000, // 2 FIORINO
        type: TransactionType.send,
        status: TransactionStatus.pending,
        timestamp: DateTime.now().subtract(const Duration(hours: 6)),
        memo: 'Transferencia',
        hash: '0x789...ghi',
        fee: 2000,
      ),
    ];
  }
}
