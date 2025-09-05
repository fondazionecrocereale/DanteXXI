import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/transaction.dart';

part 'transactions_state.freezed.dart';

@freezed
class TransactionsState with _$TransactionsState {
  const factory TransactionsState.initial() = _Initial;
  const factory TransactionsState.loading() = _Loading;
  const factory TransactionsState.loaded(List<Transaction> transactions) =
      _Loaded;
  const factory TransactionsState.error(String message) = _Error;
  const factory TransactionsState.sending() = _Sending;
  const factory TransactionsState.sent(String txHash) = _Sent;
}
