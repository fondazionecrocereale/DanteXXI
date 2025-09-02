import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_texts.dart';
import '../../domain/entities/lesson.dart';

class LessonsPage extends StatefulWidget {
  const LessonsPage({super.key});

  @override
  State<LessonsPage> createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  int _selectedCategoryIndex = 0;

  final List<LessonCategory> _categories = [
    LessonCategory(
      name: 'Principiante',
      level: 'A1',
      color: AppColors.primaryBlue,
      lessonCount: 12,
      completedCount: 8,
    ),
    LessonCategory(
      name: 'Elemental',
      level: 'A2',
      color: AppColors.secondaryGreen,
      lessonCount: 15,
      completedCount: 3,
    ),
    LessonCategory(
      name: 'Intermedio',
      level: 'B1',
      color: AppColors.secondaryOrange,
      lessonCount: 18,
      completedCount: 0,
    ),
    LessonCategory(
      name: 'Avanzado',
      level: 'B2',
      color: AppColors.secondaryBlue,
      lessonCount: 20,
      completedCount: 0,
    ),
  ];

  final List<Lesson> _lessons = [
    Lesson(
      id: 1,
      title: 'Saludos Básicos',
      description: 'Aprende a saludar en italiano',
      livello: 'A1',
      isCompleted: false,
      isUnlocked: true,
      nextLessonIds: [2],
      position: const Position(x: 0.1, y: 0.1),
      uid: '1',
      exerciseTypes: ['vocabulary'],
      lives: 3,
      currentStreak: 0,
      maxStreak: 0,
      totalXP: 0,
      timeSpent: 0,
      isReplayable: false,
      difficulty: 1,
      estimatedTime: '15 min',
      category: 'basic',
    ),
    Lesson(
      id: 2,
      title: 'Números 1-20',
      description: 'Cuenta en italiano del 1 al 20',
      livello: 'A1',
      isCompleted: false,
      isUnlocked: true,
      nextLessonIds: [3],
      position: const Position(x: 0.3, y: 0.1),
      uid: '2',
      exerciseTypes: ['vocabulary'],
      lives: 3,
      currentStreak: 0,
      maxStreak: 0,
      totalXP: 0,
      timeSpent: 0,
      isReplayable: false,
      difficulty: 1,
      estimatedTime: '20 min',
      category: 'basic',
    ),
    Lesson(
      id: 3,
      title: 'Colores',
      description: 'Los colores básicos en italiano',
      livello: 'A1',
      isCompleted: false,
      isUnlocked: true,
      nextLessonIds: [4],
      position: const Position(x: 0.5, y: 0.1),
      uid: '3',
      exerciseTypes: ['vocabulary'],
      lives: 3,
      currentStreak: 0,
      maxStreak: 0,
      totalXP: 0,
      timeSpent: 0,
      isReplayable: false,
      difficulty: 1,
      estimatedTime: '18 min',
      category: 'basic',
    ),
    Lesson(
      id: 4,
      title: 'Familia',
      description: 'Miembros de la familia en italiano',
      livello: 'A1',
      isCompleted: false,
      isUnlocked: true,
      nextLessonIds: [5],
      position: const Position(x: 0.7, y: 0.1),
      uid: '4',
      exerciseTypes: ['vocabulary'],
      lives: 3,
      currentStreak: 0,
      maxStreak: 0,
      totalXP: 0,
      timeSpent: 0,
      isReplayable: false,
      difficulty: 1,
      estimatedTime: '25 min',
      category: 'basic',
    ),
    Lesson(
      id: 5,
      title: 'Comida Básica',
      description: 'Alimentos y bebidas comunes',
      livello: 'A1',
      isCompleted: false,
      isUnlocked: true,
      nextLessonIds: [6],
      position: const Position(x: 0.9, y: 0.1),
      uid: '5',
      exerciseTypes: ['vocabulary'],
      lives: 3,
      currentStreak: 0,
      maxStreak: 0,
      totalXP: 0,
      timeSpent: 0,
      isReplayable: false,
      difficulty: 1,
      estimatedTime: '22 min',
      category: 'basic',
    ),
    Lesson(
      id: 6,
      title: 'Días de la Semana',
      description: 'Los 7 días de la semana',
      livello: 'A1',
      isCompleted: false,
      isUnlocked: true,
      nextLessonIds: [],
      position: const Position(x: 0.5, y: 0.3),
      uid: '6',
      exerciseTypes: ['vocabulary'],
      lives: 3,
      currentStreak: 0,
      maxStreak: 0,
      totalXP: 0,
      timeSpent: 0,
      isReplayable: false,
      difficulty: 1,
      estimatedTime: '16 min',
      category: 'basic',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lecciones'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Categorías de nivel
            _buildCategoryTabs(),

            // Contenido de lecciones
            Expanded(child: _buildLessonsContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategoryIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
            child: Container(
              width: 120,
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? category.color : AppColors.backgroundCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? category.color : AppColors.borderLight,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: category.color.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: AppColors.shadowLight,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    category.name,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? AppColors.primaryWhite
                          : AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category.level,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected
                          ? AppColors.primaryWhite.withValues(alpha: 0.8)
                          : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${category.completedCount}/${category.lessonCount}',
                    style: TextStyle(
                      fontSize: 10,
                      color: isSelected
                          ? AppColors.primaryWhite.withValues(alpha: 0.8)
                          : AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLessonsContent() {
    final filteredLessons = _lessons.where((lesson) {
      final selectedCategory = _categories[_selectedCategoryIndex];
      return lesson.livello == selectedCategory.level;
    }).toList();

    if (filteredLessons.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school_outlined,
              size: 64,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'No hay lecciones disponibles',
              style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredLessons.length,
      itemBuilder: (context, index) {
        final lesson = filteredLessons[index];
        return _buildLessonCard(lesson);
      },
    );
  }

  Widget _buildLessonCard(Lesson lesson) {
    // Obtener el color basado en el nivel
    Color lessonColor = _getColorForLevel(lesson.livello);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _openLesson(lesson),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Icono de la lección
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: lessonColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    _getIconForCategory(lesson.category),
                    color: lessonColor,
                    size: 30,
                  ),
                ),

                const SizedBox(width: 16),

                // Información de la lección
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            lesson.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: lessonColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              lesson.livello,
                              style: TextStyle(
                                color: lessonColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      Text(
                        lesson.description ?? 'Sin descripción',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: AppColors.textLight,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            lesson.estimatedTime,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textLight,
                            ),
                          ),

                          const Spacer(),

                          if (lesson.isCompleted)
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
                                    'Completada',
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
                            Text(
                              '${lesson.totalXP} XP',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: lessonColor,
                              ),
                            ),
                        ],
                      ),

                      if (!lesson.isCompleted && lesson.totalXP > 0) ...[
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value:
                              lesson.totalXP / 100, // Normalizar XP a progreso
                          backgroundColor: AppColors.progressBackground,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            lessonColor,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                // Botón de play
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: lessonColor,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: lessonColor.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    lesson.isCompleted ? Icons.replay : Icons.play_arrow,
                    color: AppColors.primaryWhite,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openLesson(Lesson lesson) {
    // TODO: Implementar navegación a la lección específica
    Color lessonColor = _getColorForLevel(lesson.livello);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Abriendo lección: ${lesson.title}'),
        backgroundColor: lessonColor,
      ),
    );
  }

  Color _getColorForLevel(String level) {
    switch (level) {
      case 'A1':
        return AppColors.primaryBlue;
      case 'A2':
        return AppColors.secondaryGreen;
      case 'B1':
        return AppColors.secondaryOrange;
      case 'B2':
        return AppColors.secondaryBlue;
      default:
        return AppColors.primaryBlue;
    }
  }

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'basic':
        return Icons.school;
      case 'vocabulary':
        return Icons.book;
      case 'grammar':
        return Icons.edit;
      case 'conversation':
        return Icons.chat;
      default:
        return Icons.school;
    }
  }
}

class LessonCategory {
  final String name;
  final String level;
  final Color color;
  final int lessonCount;
  final int completedCount;

  LessonCategory({
    required this.name,
    required this.level,
    required this.color,
    required this.lessonCount,
    required this.completedCount,
  });
}
