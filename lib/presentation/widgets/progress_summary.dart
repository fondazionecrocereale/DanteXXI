import 'package:flutter/material.dart';
import '../../domain/entities/user_progress.dart';
import '../../core/constants/app_colors.dart';

class ProgressSummary extends StatelessWidget {
  final UserProgress userProgress;

  const ProgressSummary({super.key, required this.userProgress});

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
          Text(
            'Tu Progreso',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildProgressCard(
                  'Nivel',
                  '${userProgress.currentLevel}',
                  Icons.trending_up,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildProgressCard(
                  'Puntos',
                  '${userProgress.totalPoints}',
                  Icons.stars,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildProgressCard(
                  'Lecciones',
                  '${userProgress.totalLessonsCompleted}',
                  Icons.school,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildProgressCard(
                  'Ejercicios',
                  '${userProgress.totalExercisesCompleted}',
                  Icons.assignment,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildExperienceBar(),
          const SizedBox(height: 8),
          _buildStreakInfo(),
        ],
      ),
    );
  }

  Widget _buildProgressCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryBlue, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceBar() {
    final progress =
        userProgress.experienceToNextLevel /
        100.0; // Asumiendo 100 XP por nivel

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Experiencia al siguiente nivel',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            Text(
              '${userProgress.experienceToNextLevel.toInt()}/100 XP',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress.clamp(0.0, 1.0),
          backgroundColor: AppColors.progressBackground,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.progressFill),
          minHeight: 8,
        ),
      ],
    );
  }

  Widget _buildStreakInfo() {
    return Row(
      children: [
        Icon(
          Icons.local_fire_department,
          color: userProgress.currentStreak > 0
              ? Colors.orange
              : AppColors.textSecondary,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          'Racha actual: ${userProgress.currentStreak} días',
          style: TextStyle(
            fontSize: 14,
            color: userProgress.currentStreak > 0
                ? AppColors.textPrimary
                : AppColors.textSecondary,
            fontWeight: userProgress.currentStreak > 0
                ? FontWeight.w600
                : FontWeight.normal,
          ),
        ),
        if (userProgress.streakBonus > 0) ...[
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '+${userProgress.streakBonus} bonus',
              style: TextStyle(
                fontSize: 12,
                color: Colors.orange[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class AchievementCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isUnlocked;
  final DateTime? unlockedAt;

  const AchievementCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.isUnlocked,
    this.unlockedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isUnlocked
            ? AppColors.backgroundCard
            : AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isUnlocked ? AppColors.primaryBlue : AppColors.borderLight,
          width: isUnlocked ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isUnlocked ? AppColors.primaryBlue : AppColors.textLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: isUnlocked ? Colors.white : AppColors.textSecondary,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isUnlocked
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                if (isUnlocked && unlockedAt != null)
                  Text(
                    'Desbloqueado el ${_formatDate(unlockedAt!)}',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.primaryBlue,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
          if (isUnlocked)
            Icon(Icons.check_circle, color: AppColors.success, size: 20),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
