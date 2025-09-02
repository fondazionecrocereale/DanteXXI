import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LearningProgressService {
  static const String _progressKey = 'learning_progress';
  static const String _livesKey = 'user_lives';
  static const String _streakKey = 'user_streak';
  static const String _maxStreakKey = 'max_streak';
  static const String _lastLifeRegenerationKey = 'last_life_regeneration';
  static const String _totalXPKey = 'total_xp';
  static const String _lessonsCompletedKey = 'lessons_completed';
  static const String _exercisesCompletedKey = 'exercises_completed';
  static const String _wordsLearnedKey = 'words_learned';
  static const String _currentLevelKey = 'current_level';

  // Sistema de vidas
  static Future<int> getCurrentLives() async {
    final prefs = await SharedPreferences.getInstance();
    final lives = prefs.getInt(_livesKey) ?? 5;
    final lastRegeneration = prefs.getInt(_lastLifeRegenerationKey) ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;

    // Regenerar vidas si han pasado 30 minutos
    if (lives < 5) {
      final minutesPassed = (now - lastRegeneration) / (1000 * 60);
      final livesToRegenerate = (minutesPassed / 30).floor();

      if (livesToRegenerate > 0) {
        final newLives = (lives + livesToRegenerate).clamp(0, 5);
        await prefs.setInt(_livesKey, newLives);
        await prefs.setInt(_lastLifeRegenerationKey, now);
        return newLives;
      }
    }

    return lives;
  }

  static Future<bool> canPlayLesson() async {
    final lives = await getCurrentLives();
    return lives > 0;
  }

  static Future<int> loseLife() async {
    final prefs = await SharedPreferences.getInstance();
    final currentLives = await getCurrentLives();
    final newLives = (currentLives - 1).clamp(0, 5);
    await prefs.setInt(_livesKey, newLives);

    // Si es la primera vida perdida, registrar el tiempo
    if (newLives < 5 && currentLives == 5) {
      await prefs.setInt(
        _lastLifeRegenerationKey,
        DateTime.now().millisecondsSinceEpoch,
      );
    }

    return newLives;
  }

  static Future<int> gainLife() async {
    final prefs = await SharedPreferences.getInstance();
    final currentLives = await getCurrentLives();
    final newLives = (currentLives + 1).clamp(0, 5);
    await prefs.setInt(_livesKey, newLives);
    return newLives;
  }

  // Sistema de rachas
  static Future<int> getCurrentStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_streakKey) ?? 0;
  }

  static Future<int> getMaxStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_maxStreakKey) ?? 0;
  }

  static Future<int> updateStreak(bool lessonCompleted) async {
    final prefs = await SharedPreferences.getInstance();
    final currentStreak = await getCurrentStreak();
    final maxStreak = await getMaxStreak();

    int newStreak;
    if (lessonCompleted) {
      newStreak = currentStreak + 1;
    } else {
      newStreak = 0; // Reset streak on failure
    }

    await prefs.setInt(_streakKey, newStreak);

    // Actualizar racha máxima si es necesario
    if (newStreak > maxStreak) {
      await prefs.setInt(_maxStreakKey, newStreak);
    }

    return newStreak;
  }

  // Sistema de XP
  static Future<int> getTotalXP() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_totalXPKey) ?? 0;
  }

  static Future<int> addXP(int baseXP, int difficulty) async {
    final prefs = await SharedPreferences.getInstance();
    final currentXP = await getTotalXP();
    final currentStreak = await getCurrentStreak();

    // Calcular XP con multiplicadores
    final streakMultiplier =
        1 + (currentStreak * 0.1); // 10% bonus por día en racha
    final difficultyMultiplier =
        1 + (difficulty * 0.2); // 20% bonus por nivel de dificultad
    final earnedXP = (baseXP * streakMultiplier * difficultyMultiplier).round();

    final newTotalXP = currentXP + earnedXP;
    await prefs.setInt(_totalXPKey, newTotalXP);

    return earnedXP;
  }

  // Progreso de lecciones
  static Future<Map<String, dynamic>> getLessonProgress(int lessonId) async {
    final prefs = await SharedPreferences.getInstance();
    final progressData = prefs.getString('$_progressKey$lessonId');

    if (progressData != null) {
      return json.decode(progressData);
    }

    return {
      'isCompleted': false,
      'isUnlocked': false,
      'totalXP': 0,
      'timeSpent': 0,
      'attempts': 0,
      'bestScore': 0,
      'lastPlayed': null,
    };
  }

  static Future<void> updateLessonProgress(
    int lessonId,
    Map<String, dynamic> progress,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_progressKey$lessonId', json.encode(progress));
  }

  static Future<void> completeLesson(
    int lessonId,
    int earnedXP,
    int timeSpent,
  ) async {
    final progress = await getLessonProgress(lessonId);
    progress['isCompleted'] = true;
    progress['totalXP'] = earnedXP;
    progress['timeSpent'] = timeSpent;
    progress['lastPlayed'] = DateTime.now().toIso8601String();

    await updateLessonProgress(lessonId, progress);

    // Actualizar estadísticas globales
    await _updateGlobalStats(earnedXP, timeSpent);
  }

  static Future<void> _updateGlobalStats(int earnedXP, int timeSpent) async {
    final prefs = await SharedPreferences.getInstance();

    // Actualizar XP total
    final currentXP = await getTotalXP();
    await prefs.setInt(_totalXPKey, currentXP + earnedXP);

    // Actualizar lecciones completadas
    final lessonsCompleted = prefs.getInt(_lessonsCompletedKey) ?? 0;
    await prefs.setInt(_lessonsCompletedKey, lessonsCompleted + 1);

    // Actualizar tiempo total
    final totalTimeSpent = prefs.getInt('total_time_spent') ?? 0;
    await prefs.setInt('total_time_spent', totalTimeSpent + timeSpent);
  }

  // Nivel actual
  static Future<String> getCurrentLevel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentLevelKey) ?? 'A1';
  }

  static Future<void> updateLevel(String newLevel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentLevelKey, newLevel);
  }

  // Estadísticas generales
  static Future<Map<String, dynamic>> getGlobalStats() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'totalXP': await getTotalXP(),
      'currentStreak': await getCurrentStreak(),
      'maxStreak': await getMaxStreak(),
      'lessonsCompleted': prefs.getInt(_lessonsCompletedKey) ?? 0,
      'exercisesCompleted': prefs.getInt(_exercisesCompletedKey) ?? 0,
      'wordsLearned': prefs.getInt(_wordsLearnedKey) ?? 0,
      'currentLevel': await getCurrentLevel(),
      'currentLives': await getCurrentLives(),
      'totalTimeSpent': prefs.getInt('total_time_spent') ?? 0,
    };
  }

  // Sincronización con PostgreSQL
  static Future<void> syncWithDatabase(Map<String, dynamic> userData) async {
    // Aquí se implementaría la sincronización con la API de Golang
    // Por ahora solo actualizamos los datos locales

    final prefs = await SharedPreferences.getInstance();

    // Sincronizar nivel
    if (userData['level'] != null) {
      await prefs.setString(_currentLevelKey, userData['level']);
    }

    // Sincronizar XP total
    if (userData['total_xp'] != null) {
      await prefs.setInt(_totalXPKey, userData['total_xp']);
    }

    // Sincronizar racha actual
    if (userData['current_streak'] != null) {
      await prefs.setInt(_streakKey, userData['current_streak']);
    }

    // Sincronizar racha máxima
    if (userData['longest_streak'] != null) {
      await prefs.setInt(_maxStreakKey, userData['longest_streak']);
    }

    // Sincronizar lecciones completadas
    if (userData['lessons_completed'] != null) {
      await prefs.setInt(_lessonsCompletedKey, userData['lessons_completed']);
    }

    // Sincronizar ejercicios completados
    if (userData['exercises_completed'] != null) {
      await prefs.setInt(
        _exercisesCompletedKey,
        userData['exercises_completed'],
      );
    }

    // Sincronizar palabras aprendidas
    if (userData['words_learned'] != null) {
      await prefs.setInt(_wordsLearnedKey, userData['words_learned']);
    }
  }

  // Preparar datos para enviar a PostgreSQL
  static Future<Map<String, dynamic>> prepareDataForDatabase() async {
    final stats = await getGlobalStats();

    return {
      'total_xp': stats['totalXP'],
      'current_streak': stats['currentStreak'],
      'longest_streak': stats['maxStreak'],
      'lessons_completed': stats['lessonsCompleted'],
      'exercises_completed': stats['exercisesCompleted'],
      'words_learned': stats['wordsLearned'],
      'level': stats['currentLevel'],
    };
  }

  // Verificar si el usuario puede avanzar de nivel
  static Future<bool> canAdvanceLevel() async {
    final stats = await getGlobalStats();
    final currentLevel = stats['currentLevel'] as String;
    final lessonsCompleted = stats['lessonsCompleted'] as int;

    // Lógica para determinar si puede avanzar
    switch (currentLevel) {
      case 'A1':
        return lessonsCompleted >= 9; // Todas las lecciones de A1
      case 'A2':
        return lessonsCompleted >= 18; // A1 + A2
      case 'B1':
        return lessonsCompleted >= 27; // A1 + A2 + B1
      case 'B2':
        return lessonsCompleted >= 36; // A1 + A2 + B1 + B2
      case 'C1':
        return lessonsCompleted >= 45; // A1 + A2 + B1 + B2 + C1
      case 'C2':
        return false; // Nivel máximo
      default:
        return false;
    }
  }

  // Obtener el siguiente nivel
  static String getNextLevel(String currentLevel) {
    switch (currentLevel) {
      case 'A1':
        return 'A2';
      case 'A2':
        return 'B1';
      case 'B1':
        return 'B2';
      case 'B2':
        return 'C1';
      case 'C1':
        return 'C2';
      default:
        return currentLevel;
    }
  }
}
