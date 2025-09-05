import 'package:freezed_annotation/freezed_annotation.dart';

part 'transactions_event.freezed.dart';

@freezed
class TransactionsEvent with _$TransactionsEvent {
  const factory TransactionsEvent.loadRequested(String address) = LoadRequested;
  const factory TransactionsEvent.refreshRequested() = RefreshRequested;
  const factory TransactionsEvent.sendTransaction({
    required String toAddress,
    required int amount,
    String? memo,
  }) = SendTransaction;
  const factory TransactionsEvent.transactionSent(String txHash) =
      TransactionSent;
}
