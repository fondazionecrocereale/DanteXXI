import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  int _selectedTypeIndex = 0;
  int _selectedDifficultyIndex = 0;

  final List<ExerciseType> _exerciseTypes = [
    ExerciseType(
      name: 'Gramática',
      icon: Icons.auto_stories,
      color: AppColors.primaryBlue,
      description: 'Ejercicios de gramática italiana',
    ),
    ExerciseType(
      name: 'Vocabulario',
      icon: Icons.translate,
      color: AppColors.secondaryGreen,
      description: 'Aprende nuevas palabras',
    ),
    ExerciseType(
      name: 'Pronunciación',
      icon: Icons.record_voice_over,
      color: AppColors.secondaryOrange,
      description: 'Mejora tu pronunciación',
    ),
    ExerciseType(
      name: 'Comprensión',
      icon: Icons.hearing,
      color: AppColors.secondaryBlue,
      description: 'Escucha y entiende',
    ),
    ExerciseType(
      name: 'Conversación',
      icon: Icons.chat_bubble,
      color: AppColors.secondaryPurple,
      description: 'Practica diálogos',
    ),
  ];

  final List<DifficultyLevel> _difficultyLevels = [
    DifficultyLevel(
      name: 'Fácil',
      level: 'A1',
      color: AppColors.success,
      description: 'Principiantes',
    ),
    DifficultyLevel(
      name: 'Medio',
      level: 'A2-B1',
      color: AppColors.warning,
      description: 'Intermedio',
    ),
    DifficultyLevel(
      name: 'Difícil',
      level: 'B2-C1',
      color: AppColors.error,
      description: 'Avanzado',
    ),
  ];

  final List<Exercise> _exercises = [
    Exercise(
      id: '1',
      title: 'Artículos Definidos',
      description: 'Completa las frases con el artículo correcto',
      type: 'Gramática',
      difficulty: 'A1',
      questionCount: 10,
      timeLimit: '8 min',
      isCompleted: false,
      score: 0,
      color: AppColors.primaryBlue,
      icon: Icons.auto_stories,
    ),
    Exercise(
      id: '2',
      title: 'Saludos y Despedidas',
      description: 'Aprende las expresiones básicas de cortesía',
      type: 'Vocabulario',
      difficulty: 'A1',
      questionCount: 8,
      timeLimit: '6 min',
      isCompleted: false,
      score: 0,
      color: AppColors.secondaryGreen,
      icon: Icons.translate,
    ),
    Exercise(
      id: '3',
      title: 'Pronunciación de Vocales',
      description: 'Practica la pronunciación de las vocales italianas',
      type: 'Pronunciación',
      difficulty: 'A1',
      questionCount: 12,
      timeLimit: '10 min',
      isCompleted: false,
      score: 0,
      color: AppColors.secondaryOrange,
      icon: Icons.record_voice_over,
    ),
    Exercise(
      id: '4',
      title: 'Números del 1 al 100',
      description: 'Escucha y escribe los números correctos',
      type: 'Comprensión',
      difficulty: 'A1',
      questionCount: 15,
      timeLimit: '12 min',
      isCompleted: false,
      score: 0,
      color: AppColors.secondaryBlue,
      icon: Icons.hearing,
    ),
    Exercise(
      id: '5',
      title: 'Presentaciones',
      description: 'Practica presentarte en italiano',
      type: 'Conversación',
      difficulty: 'A1',
      questionCount: 6,
      timeLimit: '8 min',
      isCompleted: false,
      score: 0,
      color: AppColors.secondaryPurple,
      icon: Icons.chat_bubble,
    ),
    Exercise(
      id: '6',
      title: 'Verbos Regulares -ARE',
      description: 'Conjuga verbos regulares en presente',
      type: 'Gramática',
      difficulty: 'A2',
      questionCount: 20,
      timeLimit: '15 min',
      isCompleted: false,
      score: 0,
      color: AppColors.primaryBlue,
      icon: Icons.auto_stories,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicios'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Tipos de ejercicios
            _buildExerciseTypeTabs(),

            // Niveles de dificultad
            _buildDifficultyTabs(),

            // Lista de ejercicios
            Expanded(child: _buildExercisesList()),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseTypeTabs() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _exerciseTypes.length,
        itemBuilder: (context, index) {
          final type = _exerciseTypes[index];
          final isSelected = _selectedTypeIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTypeIndex = index;
              });
            },
            child: Container(
              width: 100,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? type.color : AppColors.backgroundCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? type.color : AppColors.borderLight,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: type.color.withValues(alpha: 0.3),
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
                  Icon(
                    type.icon,
                    color: isSelected ? AppColors.primaryWhite : type.color,
                    size: 24,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    type.name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppColors.primaryWhite
                          : AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDifficultyTabs() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: _difficultyLevels.asMap().entries.map((entry) {
          final index = entry.key;
          final level = entry.value;
          final isSelected = _selectedDifficultyIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDifficultyIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? level.color : AppColors.backgroundCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? level.color : AppColors.borderLight,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      level.name,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? AppColors.primaryWhite
                            : level.color,
                      ),
                    ),
                    Text(
                      level.level,
                      style: TextStyle(
                        fontSize: 10,
                        color: isSelected
                            ? AppColors.primaryWhite.withValues(alpha: 0.8)
                            : AppColors.textSecondary,
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

  Widget _buildExercisesList() {
    final filteredExercises = _exercises.where((exercise) {
      final selectedType = _exerciseTypes[_selectedTypeIndex];
      final selectedDifficulty = _difficultyLevels[_selectedDifficultyIndex];

      return exercise.type == selectedType.name &&
          exercise.difficulty == selectedDifficulty.level.split('-')[0];
    }).toList();

    if (filteredExercises.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.quiz_outlined, size: 64, color: AppColors.textSecondary),
            const SizedBox(height: 16),
            Text(
              'No hay ejercicios disponibles',
              style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 8),
            Text(
              'Cambia los filtros para ver más ejercicios',
              style: TextStyle(fontSize: 14, color: AppColors.textLight),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredExercises.length,
      itemBuilder: (context, index) {
        final exercise = filteredExercises[index];
        return _buildExerciseCard(exercise);
      },
    );
  }

  Widget _buildExerciseCard(Exercise exercise) {
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
          onTap: () => _startExercise(exercise),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Icono del ejercicio
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: exercise.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        exercise.icon,
                        color: exercise.color,
                        size: 24,
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Información del ejercicio
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exercise.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            exercise.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Botón de inicio
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: exercise.color,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: exercise.color.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        exercise.isCompleted ? Icons.replay : Icons.play_arrow,
                        color: AppColors.primaryWhite,
                        size: 24,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Detalles del ejercicio
                Row(
                  children: [
                    _buildExerciseDetail(
                      icon: Icons.quiz,
                      label: '${exercise.questionCount} preguntas',
                      color: AppColors.textSecondary,
                    ),

                    const SizedBox(width: 24),

                    _buildExerciseDetail(
                      icon: Icons.access_time,
                      label: exercise.timeLimit,
                      color: AppColors.textSecondary,
                    ),

                    const Spacer(),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getDifficultyColor(
                          exercise.difficulty,
                        ).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        exercise.difficulty,
                        style: TextStyle(
                          color: _getDifficultyColor(exercise.difficulty),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                if (exercise.isCompleted) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.success.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: AppColors.success,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Completado - Puntuación: ${exercise.score}%',
                          style: TextStyle(
                            color: AppColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseDetail({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12, color: color)),
      ],
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'A1':
        return AppColors.success;
      case 'A2':
        return AppColors.warning;
      case 'B1':
      case 'B2':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  void _startExercise(Exercise exercise) {
    // TODO: Implementar navegación al ejercicio específico
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Iniciando ejercicio: ${exercise.title}'),
        backgroundColor: exercise.color,
        action: SnackBarAction(
          label: 'OK',
          textColor: AppColors.primaryWhite,
          onPressed: () {},
        ),
      ),
    );
  }
}

class ExerciseType {
  final String name;
  final IconData icon;
  final Color color;
  final String description;

  ExerciseType({
    required this.name,
    required this.icon,
    required this.color,
    required this.description,
  });
}

class DifficultyLevel {
  final String name;
  final String level;
  final Color color;
  final String description;

  DifficultyLevel({
    required this.name,
    required this.level,
    required this.color,
    required this.description,
  });
}

class Exercise {
  final String id;
  final String title;
  final String description;
  final String type;
  final String difficulty;
  final int questionCount;
  final String timeLimit;
  final bool isCompleted;
  final int score;
  final Color color;
  final IconData icon;

  Exercise({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.difficulty,
    required this.questionCount,
    required this.timeLimit,
    required this.isCompleted,
    required this.score,
    required this.color,
    required this.icon,
  });
}
