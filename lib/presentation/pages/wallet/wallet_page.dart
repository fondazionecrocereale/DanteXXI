import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/wallet/wallet_bloc.dart';
import '../../bloc/wallet/wallet_event.dart';
import '../../bloc/wallet/wallet_state.dart';
import '../../bloc/rewards/rewards_bloc.dart';
import '../../bloc/rewards/rewards_event.dart';
import '../../bloc/rewards/rewards_state.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_state.dart';
import '../../widgets/wallet/wallet_balance_card.dart';
import '../../widgets/wallet/quick_actions.dart';
import '../../widgets/wallet/recent_transactions.dart';
import '../../widgets/wallet/rewards_card.dart';
import '../../widgets/wallet/user_web3_info.dart';
import '../swap/swap_page.dart';
import '../transactions/transactions_page.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  void initState() {
    super.initState();
    // Cargar datos iniciales usando la dirección del usuario autenticado
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      final walletAddress =
          authState.user['walletAddress'] ?? 'fiorino1demo123';
      context.read<WalletBloc>().add(WalletEvent.loadRequested(walletAddress));
      context.read<RewardsBloc>().add(const RewardsEvent.loadRequested());
    } else {
      // Usar dirección demo si no está autenticado
      context.read<WalletBloc>().add(
        const WalletEvent.loadRequested('fiorino1demo123'),
      );
      context.read<RewardsBloc>().add(const RewardsEvent.loadRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fiorino Wallet'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Implement notifications
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<WalletBloc>().add(const WalletEvent.refreshRequested());
          context.read<RewardsBloc>().add(
            const RewardsEvent.refreshRequested(),
          );
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Wallet Balance Card
              BlocBuilder<WalletBloc, WalletState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const WalletBalanceCardSkeleton(),
                    loading: () => const WalletBalanceCardSkeleton(),
                    loaded: (balance) => WalletBalanceCard(balance: balance),
                    error: (message) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 48,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Error al cargar el balance',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              message,
                              style: Theme.of(context).textTheme.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                context.read<WalletBloc>().add(
                                  const WalletEvent.refreshRequested(),
                                );
                              },
                              child: const Text('Reintentar'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // User Web3 Info
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, authState) {
                  if (authState is AuthAuthenticated) {
                    return UserWeb3Info(user: authState.user);
                  }
                  return const SizedBox.shrink();
                },
              ),

              const SizedBox(height: 24),

              // Quick Actions
              Text(
                'Acciones Rápidas',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const QuickActions(),
              const SizedBox(height: 24),

              // Rewards Card
              BlocBuilder<RewardsBloc, RewardsState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () => const SizedBox.shrink(),
                    loaded: (rewards) => Column(
                      children: [
                        RewardsCard(rewards: rewards),
                        const SizedBox(height: 24),
                      ],
                    ),
                    error: (message) => const SizedBox.shrink(),
                    claiming: () => const SizedBox.shrink(),
                    claimed: (reward) => const SizedBox.shrink(),
                  );
                },
              ),

              // Recent Transactions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transacciones Recientes',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TransactionsPage(),
                        ),
                      );
                    },
                    child: const Text('Ver todas'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const RecentTransactions(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const SwapPage()));
        },
        icon: const Icon(Icons.swap_horiz),
        label: const Text('Swap'),
      ),
    );
  }
}
