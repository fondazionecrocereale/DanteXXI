import 'package:flutter/material.dart';
import '../../domain/entities/user_progress.dart';
import '../../core/constants/app_colors.dart';

class LivesDisplay extends StatelessWidget {
  final UserProgress userProgress;
  final VoidCallback? onRegenerateLives;

  const LivesDisplay({
    super.key,
    required this.userProgress,
    this.onRegenerateLives,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Vidas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              if (userProgress.canRegenerateLives && onRegenerateLives != null)
                TextButton.icon(
                  onPressed: onRegenerateLives,
                  icon: const Icon(Icons.refresh, size: 16),
                  label: const Text('Regenerar'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryBlue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildLivesIndicator()),
              const SizedBox(width: 16),
              _buildLivesInfo(),
            ],
          ),
          if (userProgress.canRegenerateLives &&
              userProgress.livesToRegenerate > 0)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Puedes regenerar ${userProgress.livesToRegenerate} vidas hoy',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLivesIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(userProgress.maxLives, (index) {
        final isActive = index < userProgress.currentLives;
        final isRegeneratable =
            userProgress.canRegenerateLives &&
            index >= userProgress.currentLives &&
            index < userProgress.currentLives + userProgress.livesToRegenerate;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: Icon(
            isActive ? Icons.favorite : Icons.favorite_border,
            color: isActive
                ? Colors.red
                : isRegeneratable
                ? Colors.orange
                : Colors.grey,
            size: 24,
          ),
        );
      }),
    );
  }

  Widget _buildLivesInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${userProgress.currentLives}/${userProgress.maxLives}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          'vidas activas',
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class LivesRegenerationDialog extends StatelessWidget {
  final UserProgress userProgress;
  final VoidCallback onConfirm;

  const LivesRegenerationDialog({
    super.key,
    required this.userProgress,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Regenerar Vidas'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('¿Quieres regenerar ${userProgress.livesToRegenerate} vidas?'),
          const SizedBox(height: 8),
          Text(
            'Esto te costará ${userProgress.livesToRegenerate * 10} puntos de experiencia.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            foregroundColor: Colors.white,
          ),
          child: const Text('Confirmar'),
        ),
      ],
    );
  }
}
