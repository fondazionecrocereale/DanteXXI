import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_texts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedTabIndex = 0;

  final List<ProfileTab> _tabs = [
    ProfileTab(
      name: 'Perfil',
      icon: Icons.person,
      color: AppColors.primaryBlue,
    ),
    ProfileTab(
      name: 'Logros',
      icon: Icons.emoji_events,
      color: AppColors.secondaryOrange,
    ),
    ProfileTab(
      name: 'Progreso',
      icon: Icons.trending_up,
      color: AppColors.secondaryGreen,
    ),
  ];

  final UserProfile _userProfile = UserProfile(
    id: '1',
    firstName: 'Marco',
    lastName: 'Rossi',
    email: 'marco.rossi@email.com',
    avatar: 'https://via.placeholder.com/150',
    level: 'A2',
    totalXP: 1250,
    currentStreak: 7,
    longestStreak: 15,
    lessonsCompleted: 18,
    exercisesCompleted: 45,
    wordsLearned: 120,
    joinDate: DateTime(2024, 1, 15),
    isPremium: false,
  );

  final List<Achievement> _achievements = [
    Achievement(
      id: '1',
      name: 'Primer Paso',
      description: 'Completa tu primera lección',
      icon: Icons.school,
      color: AppColors.primaryBlue,
      isUnlocked: true,
      unlockedDate: DateTime(2024, 1, 16),
      xpReward: 50,
    ),
    Achievement(
      id: '2',
      name: 'Estudiante Dedicado',
      description: 'Mantén una racha de 7 días',
      icon: Icons.local_fire_department,
      color: AppColors.secondaryOrange,
      isUnlocked: true,
      unlockedDate: DateTime(2024, 1, 22),
      xpReward: 100,
    ),
    Achievement(
      id: '3',
      name: 'Vocabulario Rico',
      description: 'Aprende 100 palabras',
      icon: Icons.translate,
      color: AppColors.secondaryGreen,
      isUnlocked: true,
      unlockedDate: DateTime(2024, 1, 25),
      xpReward: 150,
    ),
    Achievement(
      id: '4',
      name: 'Gramático Experto',
      description: 'Completa 20 ejercicios de gramática',
      icon: Icons.auto_stories,
      color: AppColors.secondaryBlue,
      isUnlocked: false,
      unlockedDate: null,
      xpReward: 200,
    ),
    Achievement(
      id: '5',
      name: 'Conversador Fluido',
      description: 'Completa 10 ejercicios de conversación',
      icon: Icons.chat_bubble,
      color: AppColors.secondaryPurple,
      isUnlocked: false,
      unlockedDate: null,
      xpReward: 250,
    ),
  ];

  final List<LearningProgress> _learningProgress = [
    LearningProgress(
      category: 'Saludos',
      level: 'A1',
      progress: 0.9,
      lessonsCompleted: 3,
      totalLessons: 3,
      color: AppColors.primaryBlue,
    ),
    LearningProgress(
      category: 'Números',
      level: 'A1',
      progress: 0.7,
      lessonsCompleted: 2,
      totalLessons: 3,
      color: AppColors.secondaryGreen,
    ),
    LearningProgress(
      category: 'Colores',
      level: 'A1',
      progress: 0.5,
      lessonsCompleted: 1,
      totalLessons: 2,
      color: AppColors.secondaryOrange,
    ),
    LearningProgress(
      category: 'Familia',
      level: 'A1',
      progress: 0.3,
      lessonsCompleted: 1,
      totalLessons: 3,
      color: AppColors.secondaryBlue,
    ),
    LearningProgress(
      category: 'Comida',
      level: 'A2',
      progress: 0.0,
      lessonsCompleted: 0,
      totalLessons: 4,
      color: AppColors.secondaryPurple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _openSettings(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tabs de navegación
          _buildTabNavigation(),

          // Contenido de las tabs
          Expanded(child: _buildTabContent()),
        ],
      ),
    );
  }

  Widget _buildTabNavigation() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: _tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = _selectedTabIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? tab.color : AppColors.backgroundCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? tab.color : AppColors.borderLight,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      tab.icon,
                      color: isSelected ? AppColors.primaryWhite : tab.color,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      tab.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? AppColors.primaryWhite : tab.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildProfileTab();
      case 1:
        return _buildAchievementsTab();
      case 2:
        return _buildProgressTab();
      default:
        return _buildProfileTab();
    }
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header del perfil
          _buildProfileHeader(),

          const SizedBox(height: 24),

          // Estadísticas principales
          _buildMainStats(),

          const SizedBox(height: 24),

          // Información personal
          _buildPersonalInfo(),

          const SizedBox(height: 24),

          // Acciones rápidas
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.italianGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar y nombre
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.primaryWhite.withValues(alpha: 0.2),
                backgroundImage: NetworkImage(_userProfile.avatar),
                child: _userProfile.avatar.isEmpty
                    ? Icon(
                        Icons.person,
                        size: 40,
                        color: AppColors.primaryWhite,
                      )
                    : null,
              ),

              const SizedBox(width: 20),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_userProfile.firstName} ${_userProfile.lastName}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryWhite,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryWhite.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Nivel ${_userProfile.level}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Botón de editar
              IconButton(
                onPressed: () => _editProfile(),
                icon: Icon(Icons.edit, color: AppColors.primaryWhite, size: 24),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // XP y racha
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.star,
                  label: 'XP Total',
                  value: '${_userProfile.totalXP}',
                  color: AppColors.primaryWhite,
                ),
              ),

              Expanded(
                child: _buildStatItem(
                  icon: Icons.local_fire_department,
                  label: 'Racha Actual',
                  value: '${_userProfile.currentStreak} días',
                  color: AppColors.primaryWhite,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: color.withValues(alpha: 0.8)),
        ),
      ],
    );
  }

  Widget _buildMainStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.school,
            title: 'Lecciones',
            value: '${_userProfile.lessonsCompleted}',
            subtitle: 'Completadas',
            color: AppColors.primaryBlue,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: _buildStatCard(
            icon: Icons.quiz,
            title: 'Ejercicios',
            value: '${_userProfile.exercisesCompleted}',
            subtitle: 'Resueltos',
            color: AppColors.secondaryGreen,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: _buildStatCard(
            icon: Icons.translate,
            title: 'Palabras',
            value: '${_userProfile.wordsLearned}',
            subtitle: 'Aprendidas',
            color: AppColors.secondaryOrange,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: color, size: 20),
          ),

          const SizedBox(height: 12),

          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),

          Text(
            subtitle,
            style: const TextStyle(fontSize: 10, color: AppColors.textLight),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Información Personal',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 16),

          _buildInfoRow(
            icon: Icons.email,
            label: 'Email',
            value: _userProfile.email,
            color: AppColors.primaryBlue,
          ),

          const SizedBox(height: 12),

          _buildInfoRow(
            icon: Icons.calendar_today,
            label: 'Miembro desde',
            value: _formatDate(_userProfile.joinDate),
            color: AppColors.secondaryGreen,
          ),

          const SizedBox(height: 12),

          _buildInfoRow(
            icon: Icons.workspace_premium,
            label: 'Plan',
            value: _userProfile.isPremium ? 'Premium' : 'Gratuito',
            color: _userProfile.isPremium
                ? AppColors.warning
                : AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 18),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Acciones Rápidas',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                icon: Icons.share,
                label: 'Compartir',
                onTap: () => _shareProfile(),
                color: AppColors.primaryBlue,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: _buildActionButton(
                icon: Icons.download,
                label: 'Exportar',
                onTap: () => _exportProgress(),
                color: AppColors.secondaryGreen,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: _buildActionButton(
                icon: Icons.help,
                label: 'Ayuda',
                onTap: () => _showHelp(),
                color: AppColors.secondaryOrange,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _achievements.length,
      itemBuilder: (context, index) {
        final achievement = _achievements[index];
        return _buildAchievementCard(achievement);
      },
    );
  }

  Widget _buildAchievementCard(Achievement achievement) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icono del logro
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: achievement.isUnlocked
                  ? achievement.color.withValues(alpha: 0.1)
                  : AppColors.textLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              achievement.icon,
              color: achievement.isUnlocked
                  ? achievement.color
                  : AppColors.textLight,
              size: 30,
            ),
          ),

          const SizedBox(width: 16),

          // Información del logro
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: achievement.isUnlocked
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  achievement.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: achievement.isUnlocked
                          ? AppColors.warning
                          : AppColors.textLight,
                    ),

                    const SizedBox(width: 4),

                    Text(
                      '${achievement.xpReward} XP',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: achievement.isUnlocked
                            ? AppColors.warning
                            : AppColors.textLight,
                      ),
                    ),

                    const Spacer(),

                    if (achievement.isUnlocked)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 16,
                              color: AppColors.success,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Desbloqueado',
                              style: TextStyle(
                                color: AppColors.success,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.textLight.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Bloqueado',
                          style: TextStyle(
                            color: AppColors.textLight,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _learningProgress.length,
      itemBuilder: (context, index) {
        final progress = _learningProgress[index];
        return _buildProgressCard(progress);
      },
    );
  }

  Widget _buildProgressCard(LearningProgress progress) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: progress.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(Icons.school, color: progress.color, size: 25),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      progress.category,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: progress.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        progress.level,
                        style: TextStyle(
                          color: progress.color,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                '${(progress.progress * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: progress.color,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Barra de progreso
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progreso',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    '${progress.lessonsCompleted}/${progress.totalLessons} lecciones',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: progress.color,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              LinearProgressIndicator(
                value: progress.progress,
                backgroundColor: AppColors.progressBackground,
                valueColor: AlwaysStoppedAnimation<Color>(progress.color),
                borderRadius: BorderRadius.circular(4),
                minHeight: 8,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _editProfile() {
    // TODO: Implementar edición de perfil
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Función de edición de perfil próximamente'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _openSettings() {
    // TODO: Implementar navegación a configuraciones
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navegando a configuraciones'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _shareProfile() {
    // TODO: Implementar compartir perfil
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Compartiendo perfil...'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _exportProgress() {
    // TODO: Implementar exportar progreso
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Exportando progreso...'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _showHelp() {
    // TODO: Implementar mostrar ayuda
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Mostrando ayuda...'),
        backgroundColor: AppColors.warning,
      ),
    );
  }
}

class ProfileTab {
  final String name;
  final IconData icon;
  final Color color;

  ProfileTab({required this.name, required this.icon, required this.color});
}

class UserProfile {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;
  final String level;
  final int totalXP;
  final int currentStreak;
  final int longestStreak;
  final int lessonsCompleted;
  final int exercisesCompleted;
  final int wordsLearned;
  final DateTime joinDate;
  final bool isPremium;

  UserProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
    required this.level,
    required this.totalXP,
    required this.currentStreak,
    required this.longestStreak,
    required this.lessonsCompleted,
    required this.exercisesCompleted,
    required this.wordsLearned,
    required this.joinDate,
    required this.isPremium,
  });
}

class Achievement {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final bool isUnlocked;
  final DateTime? unlockedDate;
  final int xpReward;

  Achievement({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.isUnlocked,
    this.unlockedDate,
    required this.xpReward,
  });
}

class LearningProgress {
  final String category;
  final String level;
  final double progress;
  final int lessonsCompleted;
  final int totalLessons;
  final Color color;

  LearningProgress({
    required this.category,
    required this.level,
    required this.progress,
    required this.lessonsCompleted,
    required this.totalLessons,
    required this.color,
  });
}
