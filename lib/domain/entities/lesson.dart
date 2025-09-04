
class Lesson {
  final int id;
  final bool isCompleted;
  final bool isUnlocked;
  final String livello;
  final List<int> nextLessonIds;
  final Position position;
  final String title;
  final String uid;
  final String? description;
  final List<String> exerciseTypes;
  final int lives;
  final int currentStreak;
  final int maxStreak;
  final int totalXP;
  final int timeSpent;
  final bool isReplayable;
  final int difficulty;
  final String estimatedTime;
  final String category;

  const Lesson({
    required this.id,
    required this.isCompleted,
    required this.isUnlocked,
    required this.livello,
    required this.nextLessonIds,
    required this.position,
    required this.title,
    required this.uid,
    this.description,
    this.exerciseTypes = const [],
    this.lives = 0,
    this.currentStreak = 0,
    this.maxStreak = 0,
    this.totalXP = 0,
    this.timeSpent = 0,
    this.isReplayable = false,
    this.difficulty = 0,
    this.estimatedTime = '',
    this.category = '',
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as int? ?? 0,
      isCompleted: json['isCompleted'] as bool? ?? false,
      isUnlocked: json['isUnlocked'] as bool? ?? false,
      livello: json['livello'] as String? ?? '',
      nextLessonIds:
          (json['nextLessonIds'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
      position: json['position'] != null
          ? Position.fromJson(json['position'] as Map<String, dynamic>)
          : const Position(x: 0.0, y: 0.0),
      title: json['title'] as String? ?? '',
      uid: json['uid'] as String? ?? '',
      description: json['description'] as String?,
      exerciseTypes:
          (json['exerciseTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      lives: json['lives'] as int? ?? 0,
      currentStreak: json['currentStreak'] as int? ?? 0,
      maxStreak: json['maxStreak'] as int? ?? 0,
      totalXP: json['totalXP'] as int? ?? 0,
      timeSpent: json['timeSpent'] as int? ?? 0,
      isReplayable: json['isReplayable'] as bool? ?? false,
      difficulty: json['difficulty'] as int? ?? 0,
      estimatedTime: json['estimatedTime'] as String? ?? '',
      category: json['category'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isCompleted': isCompleted,
      'isUnlocked': isUnlocked,
      'livello': livello,
      'nextLessonIds': nextLessonIds,
      'position': position.toJson(),
      'title': title,
      'uid': uid,
      'description': description,
      'exerciseTypes': exerciseTypes,
      'lives': lives,
      'currentStreak': currentStreak,
      'maxStreak': maxStreak,
      'totalXP': totalXP,
      'timeSpent': timeSpent,
      'isReplayable': isReplayable,
      'difficulty': difficulty,
      'estimatedTime': estimatedTime,
      'category': category,
    };
  }

  Lesson copyWith({
    int? id,
    bool? isCompleted,
    bool? isUnlocked,
    String? livello,
    List<int>? nextLessonIds,
    Position? position,
    String? title,
    String? uid,
    String? description,
    List<String>? exerciseTypes,
    int? lives,
    int? currentStreak,
    int? maxStreak,
    int? totalXP,
    int? timeSpent,
    bool? isReplayable,
    int? difficulty,
    String? estimatedTime,
    String? category,
  }) {
    return Lesson(
      id: id ?? this.id,
      isCompleted: isCompleted ?? this.isCompleted,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      livello: livello ?? this.livello,
      nextLessonIds: nextLessonIds ?? this.nextLessonIds,
      position: position ?? this.position,
      title: title ?? this.title,
      uid: uid ?? this.uid,
      description: description ?? this.description,
      exerciseTypes: exerciseTypes ?? this.exerciseTypes,
      lives: lives ?? this.lives,
      currentStreak: currentStreak ?? this.currentStreak,
      maxStreak: maxStreak ?? this.maxStreak,
      totalXP: totalXP ?? this.totalXP,
      timeSpent: timeSpent ?? this.timeSpent,
      isReplayable: isReplayable ?? this.isReplayable,
      difficulty: difficulty ?? this.difficulty,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      category: category ?? this.category,
    );
  }

  @override
  String toString() {
    return 'Lesson(id: $id, isCompleted: $isCompleted, isUnlocked: $isUnlocked, livello: $livello, nextLessonIds: $nextLessonIds, position: $position, title: $title, uid: $uid, description: $description, exerciseTypes: $exerciseTypes, lives: $lives, currentStreak: $currentStreak, maxStreak: $maxStreak, totalXP: $totalXP, timeSpent: $timeSpent, isReplayable: $isReplayable, difficulty: $difficulty, estimatedTime: $estimatedTime, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Lesson &&
        other.id == id &&
        other.isCompleted == isCompleted &&
        other.isUnlocked == isUnlocked &&
        other.livello == livello &&
        other.nextLessonIds == nextLessonIds &&
        other.position == position &&
        other.title == title &&
        other.uid == uid &&
        other.description == description &&
        other.exerciseTypes == exerciseTypes &&
        other.lives == lives &&
        other.currentStreak == currentStreak &&
        other.maxStreak == maxStreak &&
        other.totalXP == totalXP &&
        other.timeSpent == timeSpent &&
        other.isReplayable == isReplayable &&
        other.difficulty == difficulty &&
        other.estimatedTime == estimatedTime &&
        other.category == category;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      isCompleted,
      isUnlocked,
      livello,
      nextLessonIds,
      position,
      title,
      uid,
      description,
      exerciseTypes,
      lives,
      currentStreak,
      maxStreak,
      totalXP,
      timeSpent,
      isReplayable,
      difficulty,
      estimatedTime,
      category,
    );
  }
}

class Position {
  final double x;
  final double y;

  const Position({required this.x, required this.y});

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      x: (json['x'] as num?)?.toDouble() ?? 0.0,
      y: (json['y'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'x': x, 'y': y};
  }

  @override
  String toString() => 'Position(x: $x, y: $y)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Position && other.x == x && other.y == y;
  }

  @override
  int get hashCode => Object.hash(x, y);
}
