import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/swap/swap_bloc.dart';
import '../../bloc/swap/swap_event.dart';
import '../../bloc/swap/swap_state.dart';

class SwapPage extends StatefulWidget {
  const SwapPage({super.key});

  @override
  State<SwapPage> createState() => _SwapPageState();
}

class _SwapPageState extends State<SwapPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  String _selectedFromCurrency = 'MercadoPago';
  String _selectedToCurrency = 'Fiorino';

  @override
  void initState() {
    super.initState();
    context.read<SwapBloc>().add(const SwapEvent.loadRequested());
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Swap'), centerTitle: true),
      body: BlocConsumer<SwapBloc, SwapState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {},
            loaded: (swaps) {},
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            },
            creating: () {},
            created: (swap) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Swap creado exitosamente'),
                  backgroundColor: Colors.green,
                ),
              );
              context.read<SwapBloc>().add(const SwapEvent.swapCreated());
            },
            exchangeRateLoaded: (rate) {},
            fiorinoAmountCalculated: (amount) {},
          );
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  'Intercambiar Tokens',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Convierte tu saldo de MercadoPago a tokens Fiorino d\'oro',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 32),

                // Swap Form
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // From Currency
                          _buildCurrencySelector(
                            context,
                            'Desde',
                            _selectedFromCurrency,
                            ['MercadoPago', 'Fiorino'],
                            (value) {
                              setState(() {
                                _selectedFromCurrency = value!;
                                if (value == 'Fiorino') {
                                  _selectedToCurrency = 'MercadoPago';
                                } else {
                                  _selectedToCurrency = 'Fiorino';
                                }
                              });
                            },
                          ),
                          const SizedBox(height: 16),

                          // Amount Input
                          TextFormField(
                            controller: _amountController,
                            decoration: InputDecoration(
                              labelText: 'Cantidad',
                              hintText: '0.00',
                              suffixText: _selectedFromCurrency == 'MercadoPago'
                                  ? 'ARS'
                                  : 'FIORINO',
                              prefixIcon: const Icon(Icons.attach_money),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingresa una cantidad';
                              }
                              final amount = double.tryParse(value);
                              if (amount == null || amount <= 0) {
                                return 'Ingresa una cantidad válida';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              // TODO: Calculate conversion rate
                            },
                          ),
                          const SizedBox(height: 16),

                          // Swap Arrow
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.swap_vert,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // To Currency
                          _buildCurrencySelector(
                            context,
                            'A',
                            _selectedToCurrency,
                            ['MercadoPago', 'Fiorino'],
                            (value) {
                              setState(() {
                                _selectedToCurrency = value!;
                                if (value == 'Fiorino') {
                                  _selectedFromCurrency = 'MercadoPago';
                                } else {
                                  _selectedFromCurrency = 'Fiorino';
                                }
                              });
                            },
                          ),
                          const SizedBox(height: 16),

                          // Conversion Rate
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).colorScheme.outline.withOpacity(0.2),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Tipo de Cambio',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.7),
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '1 ARS = 0.001 FIORINO',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Recibirás: 0.00 FIORINO',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Swap Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: state.maybeWhen(
                                creating: () => null,
                                orElse: () => _performSwap,
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                              child: state.maybeWhen(
                                creating: () => const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                                orElse: () => const Text('Realizar Swap'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Swap History
                Text(
                  'Historial de Swaps',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                _buildSwapHistory(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCurrencySelector(
    BuildContext context,
    String label,
    String selectedValue,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: selectedValue,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: option == 'MercadoPago'
                          ? Colors.blue.withOpacity(0.1)
                          : Colors.amber.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      option == 'MercadoPago'
                          ? Icons.payment
                          : Icons.account_balance_wallet,
                      size: 16,
                      color: option == 'MercadoPago'
                          ? Colors.blue
                          : Colors.amber,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(option),
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildSwapHistory() {
    return BlocBuilder<SwapBloc, SwapState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (swaps) {
            if (swaps.isEmpty) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Icon(
                        Icons.swap_horiz_outlined,
                        size: 48,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No hay swaps realizados',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(0.7),
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tus intercambios aparecerán aquí',
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
              children: swaps.map((swap) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.swap_horiz,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      '${swap.mercadopagoAmount.toStringAsFixed(2)} ARS → ${(swap.fiorinoAmount / 1000000).toStringAsFixed(6)} FIORINO',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      'Tasa: ${swap.exchangeRate.toStringAsFixed(6)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(swap.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _getStatusText(swap.status),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _getStatusColor(swap.status),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
          error: (message) => Center(child: Text('Error: $message')),
          creating: () => const Center(child: CircularProgressIndicator()),
          created: (swap) => const Center(child: Text('Swap creado')),
          exchangeRateLoaded: (rate) =>
              const Center(child: Text('Tasa cargada')),
          fiorinoAmountCalculated: (amount) =>
              const Center(child: Text('Cantidad calculada')),
        );
      },
    );
  }

  Color _getStatusColor(dynamic status) {
    switch (status.toString()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(dynamic status) {
    switch (status.toString()) {
      case 'completed':
        return 'Completado';
      case 'pending':
        return 'Pendiente';
      case 'failed':
        return 'Fallido';
      default:
        return 'Desconocido';
    }
  }

  void _performSwap() {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text);
      final fiorinoAmount = (amount * 0.001 * 1000000)
          .round(); // Convert to micro units

      context.read<SwapBloc>().add(
        SwapEvent.createSwap(
          mercadopagoAmount: amount,
          fiorinoAmount: fiorinoAmount,
          exchangeRate: 0.001,
        ),
      );
    }
  }
}
