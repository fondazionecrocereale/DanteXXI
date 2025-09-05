import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/transactions/transactions_bloc.dart';
import '../../bloc/transactions/transactions_event.dart';
import '../../bloc/transactions/transactions_state.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  String _selectedFilter = 'Todas';

  @override
  void initState() {
    super.initState();
    context.read<TransactionsBloc>().add(
      const TransactionsEvent.loadRequested('fiorino1demo123'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transacciones'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedFilter = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Todas', child: Text('Todas')),
              const PopupMenuItem(value: 'Enviadas', child: Text('Enviadas')),
              const PopupMenuItem(value: 'Recibidas', child: Text('Recibidas')),
              const PopupMenuItem(value: 'Swaps', child: Text('Swaps')),
            ],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_selectedFilter),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<TransactionsBloc, TransactionsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (transactions) => _buildTransactionsList(transactions),
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error al cargar transacciones',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TransactionsBloc>().add(
                        const TransactionsEvent.loadRequested(
                          'fiorino1demo123',
                        ),
                      );
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
            sending: () => const Center(child: CircularProgressIndicator()),
            sent: (txHash) => const Center(child: Text('Transacción enviada')),
          );
        },
      ),
    );
  }

  Widget _buildTransactionsList(List<dynamic> transactions) {
    if (transactions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No hay transacciones',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Tus transacciones aparecerán aquí cuando realices operaciones',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<TransactionsBloc>().add(
          const TransactionsEvent.refreshRequested(),
        );
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getTransactionColor(
                    transaction.type,
                  ).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  _getTransactionIcon(transaction.type),
                  color: _getTransactionColor(transaction.type),
                  size: 20,
                ),
              ),
              title: Text(
                _getTransactionTitle(transaction.type),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getTransactionSubtitle(transaction),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatDate(transaction.timestamp),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _formatAmount(transaction),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: _getAmountColor(transaction.type),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(
                        transaction.status,
                      ).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _getStatusText(transaction.status),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: _getStatusColor(transaction.status),
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
        },
      ),
    );
  }

  Color _getTransactionColor(dynamic type) {
    // This would be based on your transaction type enum
    if (type.toString().contains('send')) {
      return Theme.of(context).colorScheme.error;
    } else if (type.toString().contains('receive')) {
      return Theme.of(context).colorScheme.primary;
    } else {
      return Theme.of(context).colorScheme.secondary;
    }
  }

  IconData _getTransactionIcon(dynamic type) {
    if (type.toString().contains('send')) {
      return Icons.arrow_upward;
    } else if (type.toString().contains('receive')) {
      return Icons.arrow_downward;
    } else {
      return Icons.swap_horiz;
    }
  }

  String _getTransactionTitle(dynamic type) {
    if (type.toString().contains('send')) {
      return 'Enviado';
    } else if (type.toString().contains('receive')) {
      return 'Recibido';
    } else {
      return 'Swap';
    }
  }

  String _getTransactionSubtitle(dynamic transaction) {
    // This would be based on your transaction structure
    return 'Transacción ${transaction.id}';
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return 'Hace ${difference.inDays} día${difference.inDays > 1 ? 's' : ''}';
    } else if (difference.inHours > 0) {
      return 'Hace ${difference.inHours} hora${difference.inHours > 1 ? 's' : ''}';
    } else if (difference.inMinutes > 0) {
      return 'Hace ${difference.inMinutes} minuto${difference.inMinutes > 1 ? 's' : ''}';
    } else {
      return 'Ahora';
    }
  }

  String _formatAmount(dynamic transaction) {
    // This would be based on your transaction structure
    final amount = transaction.amount / 1000000; // Convert from micro units
    final isSend = transaction.type.toString().contains('send');
    return '${isSend ? '-' : '+'}${amount.toStringAsFixed(6)}';
  }

  Color _getAmountColor(dynamic type) {
    if (type.toString().contains('send')) {
      return Theme.of(context).colorScheme.error;
    } else {
      return Theme.of(context).colorScheme.primary;
    }
  }

  Color _getStatusColor(dynamic status) {
    if (status.toString().contains('confirmed')) {
      return Theme.of(context).colorScheme.primary;
    } else if (status.toString().contains('pending')) {
      return Theme.of(context).colorScheme.tertiary;
    } else {
      return Theme.of(context).colorScheme.error;
    }
  }

  String _getStatusText(dynamic status) {
    if (status.toString().contains('confirmed')) {
      return 'Confirmado';
    } else if (status.toString().contains('pending')) {
      return 'Pendiente';
    } else {
      return 'Fallido';
    }
  }

  void _showTransactionDetails(BuildContext context, dynamic transaction) {
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
              _DetailRow('Tipo', _getTransactionTitle(transaction.type)),
              _DetailRow('Estado', _getStatusText(transaction.status)),
              _DetailRow('Cantidad', '${transaction.amount / 1000000} FIORINO'),
              if (transaction.fee != null)
                _DetailRow('Comisión', '${transaction.fee! / 1000000} FIORINO'),
              _DetailRow('De', transaction.fromAddress),
              _DetailRow('Para', transaction.toAddress),
              if (transaction.memo != null && transaction.memo!.isNotEmpty)
                _DetailRow('Mensaje', transaction.memo!),
              _DetailRow('Fecha', _formatDate(transaction.timestamp)),
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
