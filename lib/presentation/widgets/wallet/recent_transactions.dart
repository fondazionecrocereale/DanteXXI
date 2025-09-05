import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/transaction.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data - in real app this would come from a bloc
    final mockTransactions = [
      Transaction(
        id: '1',
        fromAddress: 'fiorino1...abc123',
        toAddress: 'fiorino1...def456',
        amount: 1000000, // 1 FIORINO in micro units
        type: TransactionType.send,
        status: TransactionStatus.confirmed,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        memo: 'Pago de servicios',
        hash: '0x123...abc',
        fee: 1000,
      ),
      Transaction(
        id: '2',
        fromAddress: 'fiorino1...ghi789',
        toAddress: 'fiorino1...abc123',
        amount: 500000, // 0.5 FIORINO
        type: TransactionType.receive,
        status: TransactionStatus.confirmed,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        memo: 'Reembolso',
        hash: '0x456...def',
      ),
      Transaction(
        id: '3',
        fromAddress: 'fiorino1...abc123',
        toAddress: 'fiorino1...jkl012',
        amount: 2000000, // 2 FIORINO
        type: TransactionType.send,
        status: TransactionStatus.pending,
        timestamp: DateTime.now().subtract(const Duration(hours: 6)),
        memo: 'Transferencia',
        hash: '0x789...ghi',
        fee: 2000,
      ),
    ];

    if (mockTransactions.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 48,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'No hay transacciones recientes',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tus transacciones aparecerán aquí',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: mockTransactions.map((transaction) {
        return _TransactionItem(transaction: transaction);
      }).toList(),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const _TransactionItem({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isSend = transaction.type == TransactionType.send;
    final amount = transaction.amount / 1000000; // Convert from micro units
    final formattedAmount = NumberFormat(
      '#,##0.000000',
      'es_ES',
    ).format(amount);
    final formattedTime = DateFormat(
      'dd/MM HH:mm',
    ).format(transaction.timestamp);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isSend
                ? Theme.of(context).colorScheme.error.withOpacity(0.1)
                : Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            isSend ? Icons.arrow_upward : Icons.arrow_downward,
            color: isSend
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).colorScheme.primary,
            size: 20,
          ),
        ),
        title: Text(
          isSend ? 'Enviado' : 'Recibido',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isSend
                  ? 'Para: ${_shortenAddress(transaction.toAddress)}'
                  : 'De: ${_shortenAddress(transaction.fromAddress)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (transaction.memo != null && transaction.memo!.isNotEmpty)
              Text(
                transaction.memo!,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
              ),
            Text(
              formattedTime,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${isSend ? '-' : '+'}$formattedAmount',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: isSend
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _getStatusColor(
                  context,
                  transaction.status,
                ).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _getStatusText(transaction.status),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _getStatusColor(context, transaction.status),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          _showTransactionDetails(context, transaction);
        },
      ),
    );
  }

  String _shortenAddress(String address) {
    if (address.length <= 16) return address;
    return '${address.substring(0, 8)}...${address.substring(address.length - 8)}';
  }

  Color _getStatusColor(BuildContext context, TransactionStatus status) {
    switch (status) {
      case TransactionStatus.confirmed:
        return Theme.of(context).colorScheme.primary;
      case TransactionStatus.pending:
        return Theme.of(context).colorScheme.tertiary;
      case TransactionStatus.failed:
        return Theme.of(context).colorScheme.error;
    }
  }

  String _getStatusText(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.confirmed:
        return 'Confirmado';
      case TransactionStatus.pending:
        return 'Pendiente';
      case TransactionStatus.failed:
        return 'Fallido';
    }
  }

  void _showTransactionDetails(BuildContext context, Transaction transaction) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detalles de Transacción'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _DetailRow('ID', transaction.id),
              _DetailRow(
                'Tipo',
                transaction.type == TransactionType.send
                    ? 'Envío'
                    : 'Recepción',
              ),
              _DetailRow('Estado', _getStatusText(transaction.status)),
              _DetailRow('Cantidad', '${transaction.amount / 1000000} FIORINO'),
              if (transaction.fee != null)
                _DetailRow('Comisión', '${transaction.fee! / 1000000} FIORINO'),
              _DetailRow('De', transaction.fromAddress),
              _DetailRow('Para', transaction.toAddress),
              if (transaction.memo != null && transaction.memo!.isNotEmpty)
                _DetailRow('Mensaje', transaction.memo!),
              _DetailRow(
                'Fecha',
                DateFormat('dd/MM/yyyy HH:mm:ss').format(transaction.timestamp),
              ),
              if (transaction.hash != null)
                _DetailRow('Hash', transaction.hash!),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}
