import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/reward.dart';

class RewardsCard extends StatelessWidget {
  final List<Reward> rewards;

  const RewardsCard({super.key, required this.rewards});

  @override
  Widget build(BuildContext context) {
    final availableRewards = rewards.where((r) => r.canBeClaimed).toList();
    final claimedRewards = rewards
        .where((r) => r.status == RewardStatus.claimed)
        .toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recompensas',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to rewards page
                  },
                  child: const Text('Ver todas'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (availableRewards.isNotEmpty) ...[
              Text(
                'Disponibles (${availableRewards.length})',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              ...availableRewards
                  .take(3)
                  .map(
                    (reward) => _RewardItem(
                      reward: reward,
                      onClaim: () {
                        // TODO: Implement claim reward
                      },
                    ),
                  ),
              if (availableRewards.length > 3) ...[
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    // Navigate to rewards page
                  },
                  child: Text('Ver ${availableRewards.length - 3} más'),
                ),
              ],
            ],
            if (claimedRewards.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Reclamadas (${claimedRewards.length})',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              ...claimedRewards
                  .take(2)
                  .map((reward) => _RewardItem(reward: reward, onClaim: null)),
            ],
            if (rewards.isEmpty) ...[
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.card_giftcard_outlined,
                      size: 48,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No hay recompensas disponibles',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Completa cursos y actividades para ganar Fiorino',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.5),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _RewardItem extends StatelessWidget {
  final Reward reward;
  final VoidCallback? onClaim;

  const _RewardItem({required this.reward, this.onClaim});

  @override
  Widget build(BuildContext context) {
    final fiorinoAmount = reward.fiorinoAmount / 1000000;
    final formattedAmount = NumberFormat(
      '#,##0.000000',
      'es_ES',
    ).format(fiorinoAmount);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: reward.canBeClaimed
            ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: reward.canBeClaimed
              ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
              : Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getRewardColor(context, reward.type).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              _getRewardIcon(reward.type),
              color: _getRewardColor(context, reward.type),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reward.title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  reward.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                if (reward.expiresAt != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Expira: ${DateFormat('dd/MM/yyyy').format(reward.expiresAt!)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$formattedAmount FIORINO',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              if (reward.canBeClaimed && onClaim != null)
                ElevatedButton(
                  onPressed: onClaim,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    minimumSize: Size.zero,
                  ),
                  child: const Text('Reclamar'),
                )
              else if (reward.status == RewardStatus.claimed)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Reclamada',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
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
