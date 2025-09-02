import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'lesson.dart';

// Importación explícita de archivos generados
// Estos archivos son generados automáticamente por build_runner
part 'divine_comedy_model.freezed.dart';
part 'divine_comedy_model.g.dart';

@freezed
class DivineComedyModel with _$DivineComedyModel {
  const factory DivineComedyModel({
    required String title,
    required List<String> cefrRange,
    required ColorModel baseColor,
    required ColorModel textColor,
    required ColorModel cardColor,
    required String backgroundImage,
    required List<Lesson> lessons,
    @Default(0) int totalLessons,
    @Default(0) int completedLessons,
    @Default(0) double progressPercentage,
  }) = _DivineComedyModel;

  factory DivineComedyModel.fromJson(Map<String, dynamic> json) =>
      _$DivineComedyModelFromJson(json);
}

@freezed
class ColorModel with _$ColorModel {
  const factory ColorModel({
    required int red,
    required int green,
    required int blue,
  }) = _ColorModel;

  factory ColorModel.fromJson(Map<String, dynamic> json) =>
      _$ColorModelFromJson(json);
}

// Nuevos tipos de ejercicios
enum ExerciseType {
  multipleChoice('multiple_choice', 'Opción Múltiple', Icons.check_circle),
  translation('translation', 'Traducción', Icons.translate),
  fillInTheBlank('fill_in_the_blank', 'Completar Espacios', Icons.edit),
  matchingPairs('matching_pairs', 'Emparejar Pares', Icons.compare_arrows),
  videoComprehension(
    'video_comprehension',
    'Comprensión de Video',
    Icons.video_library,
  ),
  audioComprehension(
    'audio_comprehension',
    'Comprensión de Audio',
    Icons.headphones,
  ),
  speaking('speaking', 'Pronunciación', Icons.mic),
  writing('writing', 'Escritura', Icons.create),
  listening('listening', 'Escucha', Icons.hearing),
  reading('reading', 'Lectura', Icons.book),
  conversation('conversation', 'Conversación', Icons.chat),
  rolePlay('role_play', 'Juego de Roles', Icons.people),
  vocabulary('vocabulary', 'Vocabulario', Icons.language),
  grammar('grammar', 'Gramática', Icons.school),
  analysis('analysis', 'Análisis', Icons.analytics),
  discussion('discussion', 'Discusión', Icons.forum),
  practice('practice', 'Práctica', Icons.fitness_center),
  evaluation('evaluation', 'Evaluación', Icons.assessment),
  feedback('feedback', 'Retroalimentación', Icons.feedback),
  research('research', 'Investigación', Icons.search),
  theory('theory', 'Teoría', Icons.science),
  comparison('comparison', 'Comparación', Icons.compare),
  criticism('criticism', 'Crítica', Icons.rate_review),
  publication('publication', 'Publicación', Icons.publish),
  pedagogy('pedagogy', 'Pedagogía', Icons.psychology),
  creativeWriting('creative_writing', 'Escritura Creativa', Icons.brush),
  advancedPractice('advanced_practice', 'Práctica Avanzada', Icons.trending_up),
  interpretation('interpretation', 'Interpretación', Icons.psychology),
  performance('performance', 'Interpretación', Icons.theater_comedy),
  study('study', 'Estudio', Icons.school),
  watching('watching', 'Visualización', Icons.visibility);

  const ExerciseType(this.value, this.label, this.icon);
  final String value;
  final String label;
  final IconData icon;
}

// Sistema de vidas y rachas
class LivesSystem {
  static const int maxLives = 5;
  static const int livesRegenerationTime = 30; // minutos

  static int getCurrentLives(int lives) => lives.clamp(0, maxLives);
  static bool canPlayLesson(int lives) => lives > 0;
  static int loseLife(int currentLives) =>
      (currentLives - 1).clamp(0, maxLives);
  static int gainLife(int currentLives) =>
      (currentLives + 1).clamp(0, maxLives);
}

class StreakSystem {
  static int calculateStreak(int currentStreak, bool lessonCompleted) {
    if (lessonCompleted) {
      return currentStreak + 1;
    } else {
      return 0; // Reset streak on failure
    }
  }

  static int updateMaxStreak(int currentMaxStreak, int currentStreak) {
    return currentStreak > currentMaxStreak ? currentStreak : currentMaxStreak;
  }

  static int calculateXP(int baseXP, int streak, int difficulty) {
    final streakMultiplier = 1 + (streak * 0.1); // 10% bonus per day in streak
    final difficultyMultiplier =
        1 + (difficulty * 0.2); // 20% bonus per difficulty level
    return (baseXP * streakMultiplier * difficultyMultiplier).round();
  }
}

// Extension para convertir ColorModel a Color
extension ColorModelExtension on ColorModel {
  Color toColor() => Color.fromRGBO(red, green, blue, 1.0);
}
