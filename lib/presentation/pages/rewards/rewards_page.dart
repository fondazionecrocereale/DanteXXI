import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/rewards/rewards_bloc.dart';
import '../../bloc/rewards/rewards_event.dart';
import '../../bloc/rewards/rewards_state.dart';
import '../../../domain/entities/reward.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  String _selectedFilter = 'Todas';

  @override
  void initState() {
    super.initState();
    context.read<RewardsBloc>().add(const RewardsEvent.loadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recompensas'),
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
              const PopupMenuItem(
                value: 'Disponibles',
                child: Text('Disponibles'),
              ),
              const PopupMenuItem(
                value: 'Reclamadas',
                child: Text('Reclamadas'),
              ),
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
      body: BlocConsumer<RewardsBloc, RewardsState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {},
            loaded: (rewards) {},
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            },
            claiming: () {},
            claimed: (reward) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Recompensa "${reward.title}" reclamada exitosamente',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              context.read<RewardsBloc>().add(
                const RewardsEvent.rewardClaimed(),
              );
            },
          );
        },
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (rewards) => _buildRewardsList(rewards),
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
                    'Error al cargar recompensas',
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
                      context.read<RewardsBloc>().add(
                        const RewardsEvent.loadRequested(),
                      );
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
            claiming: () => const Center(child: CircularProgressIndicator()),
            claimed: (reward) =>
                const Center(child: Text('Recompensa reclamada')),
          );
        },
      ),
    );
  }

  Widget _buildRewardsList(List<Reward> rewards) {
    final filteredRewards = _filterRewards(rewards);

    if (filteredRewards.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.card_giftcard_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No hay recompensas ${_selectedFilter.toLowerCase()}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Completa cursos y actividades para ganar Fiorino',
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
        context.read<RewardsBloc>().add(const RewardsEvent.refreshRequested());
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredRewards.length,
        itemBuilder: (context, index) {
          final reward = filteredRewards[index];
          return _RewardCard(
            reward: reward,
            onClaim: reward.canBeClaimed
                ? () {
                    context.read<RewardsBloc>().add(
                      RewardsEvent.claimReward(reward.id),
                    );
                  }
                : null,
          );
        },
      ),
    );
  }

  List<Reward> _filterRewards(List<Reward> rewards) {
    switch (_selectedFilter) {
      case 'Disponibles':
        return rewards.where((r) => r.canBeClaimed).toList();
      case 'Reclamadas':
        return rewards.where((r) => r.status == RewardStatus.claimed).toList();
      default:
        return rewards;
    }
  }
}

class _RewardCard extends StatelessWidget {
  final Reward reward;
  final VoidCallback? onClaim;

  const _RewardCard({required this.reward, this.onClaim});

  @override
  Widget build(BuildContext context) {
    final fiorinoAmount = reward.fiorinoAmount / 1000000;
    final formattedAmount = NumberFormat(
      '#,##0.000000',
      'es_ES',
    ).format(fiorinoAmount);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _getRewardColor(
                      context,
                      reward.type,
                    ).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(
                    _getRewardIcon(reward.type),
                    color: _getRewardColor(context, reward.type),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reward.title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        reward.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$formattedAmount FIORINO',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildStatusChip(context),
                  ],
                ),
              ],
            ),
            if (reward.expiresAt != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Expira: ${DateFormat('dd/MM/yyyy').format(reward.expiresAt!)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (reward.canBeClaimed && onClaim != null) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onClaim,
                  icon: const Icon(Icons.card_giftcard),
                  label: const Text('Reclamar Recompensa'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    if (reward.canBeClaimed) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Disponible',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.green,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    } else if (reward.status == RewardStatus.claimed) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Reclamada',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    } else if (reward.isExpired) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Expirada',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.red,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Pendiente',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
  }

  Color _getRewardColor(BuildContext context, RewardType type) {
    switch (type) {
      case RewardType.courseCompletion:
        return Theme.of(context).colorScheme.primary;
      case RewardType.dailyLogin:
        return Theme.of(context).colorScheme.secondary;
      case RewardType.streakBonus:
        return Theme.of(context).colorScheme.tertiary;
      case RewardType.referral:
        return Theme.of(context).colorScheme.error;
      case RewardType.achievement:
        return Colors.amber;
    }
  }

  IconData _getRewardIcon(RewardType type) {
    switch (type) {
      case RewardType.courseCompletion:
        return Icons.school;
      case RewardType.dailyLogin:
        return Icons.login;
      case RewardType.streakBonus:
        return Icons.local_fire_department;
      case RewardType.referral:
        return Icons.person_add;
      case RewardType.achievement:
        return Icons.emoji_events;
    }
  }
}
