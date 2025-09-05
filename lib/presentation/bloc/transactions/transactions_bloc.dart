import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/transaction/get_transactions_usecase.dart';
import '../../../domain/usecases/transaction/send_transaction_usecase.dart';
import 'transactions_event.dart';
import 'transactions_state.dart';

@injectable
class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final GetTransactionsUsecase _getTransactionsUsecase;
  final SendTransactionUsecase _sendTransactionUsecase;
  String? _currentAddress;

  TransactionsBloc(this._getTransactionsUsecase, this._sendTransactionUsecase)
    : super(const TransactionsState.initial()) {
    on<LoadRequested>(_onLoadRequested);
    on<RefreshRequested>(_onRefreshRequested);
    on<SendTransaction>(_onSendTransaction);
    on<TransactionSent>(_onTransactionSent);
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<TransactionsState> emit,
  ) async {
    _currentAddress = event.address;
    emit(const TransactionsState.loading());

    try {
      final transactions = await _getTransactionsUsecase(event.address);
      emit(TransactionsState.loaded(transactions));
    } catch (e) {
      emit(TransactionsState.error('Error al cargar las transacciones: $e'));
    }
  }

  Future<void> _onRefreshRequested(
    RefreshRequested event,
    Emitter<TransactionsState> emit,
  ) async {
    if (_currentAddress == null) return;

    emit(const TransactionsState.loading());

    try {
      final transactions = await _getTransactionsUsecase(_currentAddress!);
      emit(TransactionsState.loaded(transactions));
    } catch (e) {
      emit(
        TransactionsState.error('Error al actualizar las transacciones: $e'),
      );
    }
  }

  Future<void> _onSendTransaction(
    SendTransaction event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(const TransactionsState.sending());

    try {
      final txHash = await _sendTransactionUsecase(
        toAddress: event.toAddress,
        amount: event.amount,
        memo: event.memo,
      );
      emit(TransactionsState.sent(txHash));
    } catch (e) {
      emit(TransactionsState.error('Error al enviar transacción: $e'));
    }
  }

  Future<void> _onTransactionSent(
    TransactionSent event,
    Emitter<TransactionsState> emit,
  ) async {
    if (_currentAddress == null) return;

    // Recargar transacciones después de enviar
    add(RefreshRequested());
  }
}
