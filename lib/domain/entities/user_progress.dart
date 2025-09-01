class UserProgress {
  final String userId;
  final int currentLives;
  final int maxLives;
  final DateTime lastLifeRegeneration;
  final int currentStreak;
  final DateTime lastStudyDate;
  final int totalLessonsCompleted;
  final int totalExercisesCompleted;
  final double averageScore;
  final int totalStudyTime; // en minutos
  final List<String> unlockedAchievements;
  final Map<String, LessonProgress> lessonProgress;
  final Map<String, AudiobookProgress> audiobookProgress;
  final int totalPoints;
  final int currentLevel;
  final double experienceToNextLevel;

  const UserProgress({
    required this.userId,
    required this.currentLives,
    required this.maxLives,
    required this.lastLifeRegeneration,
    required this.currentStreak,
    required this.lastStudyDate,
    required this.totalLessonsCompleted,
    required this.totalExercisesCompleted,
    required this.averageScore,
    required this.totalStudyTime,
    required this.unlockedAchievements,
    required this.lessonProgress,
    required this.audiobookProgress,
    required this.totalPoints,
    required this.currentLevel,
    required this.experienceToNextLevel,
  });

  UserProgress copyWith({
    String? userId,
    int? currentLives,
    int? maxLives,
    DateTime? lastLifeRegeneration,
    int? currentStreak,
    DateTime? lastStudyDate,
    int? totalLessonsCompleted,
    int? totalExercisesCompleted,
    double? averageScore,
    int? totalStudyTime,
    List<String>? unlockedAchievements,
    Map<String, LessonProgress>? lessonProgress,
    Map<String, AudiobookProgress>? audiobookProgress,
    int? totalPoints,
    int? currentLevel,
    double? experienceToNextLevel,
  }) {
    return UserProgress(
      userId: userId ?? this.userId,
      currentLives: currentLives ?? this.currentLives,
      maxLives: maxLives ?? this.maxLives,
      lastLifeRegeneration: lastLifeRegeneration ?? this.lastLifeRegeneration,
      currentStreak: currentStreak ?? this.currentStreak,
      lastStudyDate: lastStudyDate ?? this.lastStudyDate,
      totalLessonsCompleted:
          totalLessonsCompleted ?? this.totalLessonsCompleted,
      totalExercisesCompleted:
          totalExercisesCompleted ?? this.totalExercisesCompleted,
      averageScore: averageScore ?? this.averageScore,
      totalStudyTime: totalStudyTime ?? this.totalStudyTime,
      unlockedAchievements: unlockedAchievements ?? this.unlockedAchievements,
      lessonProgress: lessonProgress ?? this.lessonProgress,
      audiobookProgress: audiobookProgress ?? this.audiobookProgress,
      totalPoints: totalPoints ?? this.totalPoints,
      currentLevel: currentLevel ?? this.currentLevel,
      experienceToNextLevel:
          experienceToNextLevel ?? this.experienceToNextLevel,
    );
  }

  // Verificar si se pueden regenerar vidas
  bool get canRegenerateLives {
    final now = DateTime.now();
    final lastRegeneration = DateTime(
      lastLifeRegeneration.year,
      lastLifeRegeneration.month,
      lastLifeRegeneration.day,
    );
    final today = DateTime(now.year, now.month, now.day);

    return today.isAfter(lastRegeneration) && currentLives < maxLives;
  }

  // Calcular vidas que se pueden regenerar
  int get livesToRegenerate {
    if (!canRegenerateLives) return 0;
    return maxLives - currentLives;
  }

  // Verificar si se puede estudiar hoy
  bool get canStudyToday {
    final now = DateTime.now();
    final lastStudy = DateTime(
      lastStudyDate.year,
      lastStudyDate.month,
      lastStudyDate.day,
    );
    final today = DateTime(now.year, now.month, now.day);

    return today.isAfter(lastStudy);
  }

  // Calcular bonus de racha
  int get streakBonus {
    if (currentStreak >= 30) return 5;
    if (currentStreak >= 7) return 2;
    if (currentStreak >= 3) return 1;
    return 0;
  }

  // Verificar si tiene vidas suficientes
  bool hasEnoughLives(int requiredLives) {
    return currentLives >= requiredLives;
  }

  // Consumir vidas
  UserProgress consumeLives(int lives) {
    if (currentLives < lives) {
      throw Exception('No hay suficientes vidas');
    }
    return copyWith(currentLives: currentLives - lives);
  }

  // Ganar vidas
  UserProgress gainLives(int lives) {
    return copyWith(currentLives: (currentLives + lives).clamp(0, maxLives));
  }

  // Completar lección
  UserProgress completeLesson(String lessonId, double score, int timeSpent) {
    final lesson =
        lessonProgress[lessonId] ??
        LessonProgress(
          lessonId: lessonId,
          isCompleted: false,
          bestScore: 0.0,
          attempts: 0,
          totalTime: 0,
          lastCompleted: null,
        );

    final updatedLesson = lesson.complete(score, timeSpent);
    final updatedProgress = Map<String, LessonProgress>.from(lessonProgress);
    updatedProgress[lessonId] = updatedLesson;

    final newTotalLessons = lesson.isCompleted
        ? totalLessonsCompleted
        : totalLessonsCompleted + 1;
    final newTotalExercises = totalExercisesCompleted + 1;
    final newTotalTime = totalStudyTime + timeSpent;
    final newAverageScore =
        ((averageScore * (newTotalExercises - 1)) + score) / newTotalExercises;

    return copyWith(
      lessonProgress: updatedProgress,
      totalLessonsCompleted: newTotalLessons,
      totalExercisesCompleted: newTotalExercises,
      totalStudyTime: newTotalTime,
      averageScore: newAverageScore,
      lastStudyDate: DateTime.now(),
      currentStreak: canStudyToday ? currentStreak + 1 : currentStreak,
    );
  }

  // Ganar puntos
  UserProgress gainPoints(int points) {
    final newTotalPoints = totalPoints + points;
    final newExperience = experienceToNextLevel + points;

    // Calcular si sube de nivel
    final experienceNeeded = _calculateExperienceForLevel(currentLevel + 1);
    final newLevel = newExperience >= experienceNeeded
        ? currentLevel + 1
        : currentLevel;
    final newExperienceToNext = newLevel > currentLevel
        ? newExperience - experienceNeeded
        : newExperience;

    return copyWith(
      totalPoints: newTotalPoints,
      currentLevel: newLevel,
      experienceToNextLevel: newExperienceToNext,
    );
  }

  // Calcular experiencia necesaria para el siguiente nivel
  int _calculateExperienceForLevel(int level) {
    return level * 100; // Fórmula simple: 100 puntos por nivel
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'currentLives': currentLives,
      'maxLives': maxLives,
      'lastLifeRegeneration': lastLifeRegeneration.toIso8601String(),
      'currentStreak': currentStreak,
      'lastStudyDate': lastStudyDate.toIso8601String(),
      'totalLessonsCompleted': totalLessonsCompleted,
      'totalExercisesCompleted': totalExercisesCompleted,
      'averageScore': averageScore,
      'totalStudyTime': totalStudyTime,
      'unlockedAchievements': unlockedAchievements,
      'lessonProgress': lessonProgress.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
      'audiobookProgress': audiobookProgress.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
      'totalPoints': totalPoints,
      'currentLevel': currentLevel,
      'experienceToNextLevel': experienceToNextLevel,
    };
  }

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      userId: json['userId'] ?? '',
      currentLives: json['currentLives'] ?? 5,
      maxLives: json['maxLives'] ?? 5,
      lastLifeRegeneration: DateTime.parse(
        json['lastLifeRegeneration'] ?? DateTime.now().toIso8601String(),
      ),
      currentStreak: json['currentStreak'] ?? 0,
      lastStudyDate: DateTime.parse(
        json['lastStudyDate'] ?? DateTime.now().toIso8601String(),
      ),
      totalLessonsCompleted: json['totalLessonsCompleted'] ?? 0,
      totalExercisesCompleted: json['totalExercisesCompleted'] ?? 0,
      averageScore: (json['averageScore'] ?? 0.0).toDouble(),
      totalStudyTime: json['totalStudyTime'] ?? 0,
      unlockedAchievements: List<String>.from(
        json['unlockedAchievements'] ?? [],
      ),
      lessonProgress:
          (json['lessonProgress'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, LessonProgress.fromJson(value)),
          ) ??
          {},
      audiobookProgress:
          (json['audiobookProgress'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, AudiobookProgress.fromJson(value)),
          ) ??
          {},
      totalPoints: json['totalPoints'] ?? 0,
      currentLevel: json['currentLevel'] ?? 1,
      experienceToNextLevel: (json['experienceToNextLevel'] ?? 0.0).toDouble(),
    );
  }

  factory UserProgress.initial(String userId) {
    return UserProgress(
      userId: userId,
      currentLives: 5,
      maxLives: 5,
      lastLifeRegeneration: DateTime.now(),
      currentStreak: 0,
      lastStudyDate: DateTime.now().subtract(const Duration(days: 1)),
      totalLessonsCompleted: 0,
      totalExercisesCompleted: 0,
      averageScore: 0.0,
      totalStudyTime: 0,
      unlockedAchievements: [],
      lessonProgress: {},
      audiobookProgress: {},
      totalPoints: 0,
      currentLevel: 1,
      experienceToNextLevel: 0.0,
    );
  }
}

class LessonProgress {
  final String lessonId;
  final bool isCompleted;
  final double bestScore;
  final int attempts;
  final int totalTime; // en minutos
  final DateTime? lastCompleted;

  const LessonProgress({
    required this.lessonId,
    required this.isCompleted,
    required this.bestScore,
    required this.attempts,
    required this.totalTime,
    this.lastCompleted,
  });

  LessonProgress copyWith({
    String? lessonId,
    bool? isCompleted,
    double? bestScore,
    int? attempts,
    int? totalTime,
    DateTime? lastCompleted,
  }) {
    return LessonProgress(
      lessonId: lessonId ?? this.lessonId,
      isCompleted: isCompleted ?? this.isCompleted,
      bestScore: bestScore ?? this.bestScore,
      attempts: attempts ?? this.attempts,
      totalTime: totalTime ?? this.totalTime,
      lastCompleted: lastCompleted ?? this.lastCompleted,
    );
  }

  // Completar lección
  LessonProgress complete(double score, int timeSpent) {
    return copyWith(
      isCompleted: true,
      bestScore: score > bestScore ? score : bestScore,
      attempts: attempts + 1,
      totalTime: totalTime + timeSpent,
      lastCompleted: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lessonId': lessonId,
      'isCompleted': isCompleted,
      'bestScore': bestScore,
      'attempts': attempts,
      'totalTime': totalTime,
      'lastCompleted': lastCompleted?.toIso8601String(),
    };
  }

  factory LessonProgress.fromJson(Map<String, dynamic> json) {
    return LessonProgress(
      lessonId: json['lessonId'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
      bestScore: (json['bestScore'] ?? 0.0).toDouble(),
      attempts: json['attempts'] ?? 0,
      totalTime: json['totalTime'] ?? 0,
      lastCompleted: json['lastCompleted'] != null
          ? DateTime.parse(json['lastCompleted'])
          : null,
    );
  }
}

class AudiobookProgress {
  final String audiobookId;
  final double progress; // 0.0 a 1.0
  final int totalTime; // en minutos
  final DateTime? lastListened;
  final List<String> completedChapters;
  final bool isBookmarked;

  const AudiobookProgress({
    required this.audiobookId,
    required this.progress,
    required this.totalTime,
    this.lastListened,
    required this.completedChapters,
    required this.isBookmarked,
  });

  AudiobookProgress copyWith({
    String? audiobookId,
    double? progress,
    int? totalTime,
    DateTime? lastListened,
    List<String>? completedChapters,
    bool? isBookmarked,
  }) {
    return AudiobookProgress(
      audiobookId: audiobookId ?? this.audiobookId,
      progress: progress ?? this.progress,
      totalTime: totalTime ?? this.totalTime,
      lastListened: lastListened ?? this.lastListened,
      completedChapters: completedChapters ?? this.completedChapters,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }

  // Marcar capítulo como completado
  AudiobookProgress completeChapter(String chapterId) {
    final updatedChapters = List<String>.from(completedChapters);
    if (!updatedChapters.contains(chapterId)) {
      updatedChapters.add(chapterId);
    }

    return copyWith(
      completedChapters: updatedChapters,
      lastListened: DateTime.now(),
    );
  }

  // Actualizar progreso
  AudiobookProgress updateProgress(double newProgress, int timeSpent) {
    return copyWith(
      progress: newProgress.clamp(0.0, 1.0),
      totalTime: totalTime + timeSpent,
      lastListened: DateTime.now(),
    );
  }

  // Cambiar estado de marcador
  AudiobookProgress toggleBookmark() {
    return copyWith(isBookmarked: !isBookmarked);
  }

  Map<String, dynamic> toJson() {
    return {
      'audiobookId': audiobookId,
      'progress': progress,
      'totalTime': totalTime,
      'lastListened': lastListened?.toIso8601String(),
      'completedChapters': completedChapters,
      'isBookmarked': isBookmarked,
    };
  }

  factory AudiobookProgress.fromJson(Map<String, dynamic> json) {
    return AudiobookProgress(
      audiobookId: json['audiobookId'] ?? '',
      progress: (json['progress'] ?? 0.0).toDouble(),
      totalTime: json['totalTime'] ?? 0,
      lastListened: json['lastListened'] != null
          ? DateTime.parse(json['lastListened'])
          : null,
      completedChapters: List<String>.from(json['completedChapters'] ?? []),
      isBookmarked: json['isBookmarked'] ?? false,
    );
  }

  factory AudiobookProgress.initial(String audiobookId) {
    return AudiobookProgress(
      audiobookId: audiobookId,
      progress: 0.0,
      totalTime: 0,
      lastListened: null,
      completedChapters: [],
      isBookmarked: false,
    );
  }
}
