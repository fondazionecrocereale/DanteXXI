import 'dart:ui';

class LearningNode {
  final String id;
  final String title;
  final String description;
  final String level;
  final Offset position;
  final bool isUnlocked;
  final bool isCompleted;
  final List<String> nextNodeIds;
  final List<String> exerciseTypes;
  final String? audioUrl;
  final String? imageUrl;
  final int? estimatedDuration;
  final List<String>? prerequisites;
  final Map<String, dynamic>? metadata;

  const LearningNode({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.position,
    required this.isUnlocked,
    required this.isCompleted,
    required this.nextNodeIds,
    required this.exerciseTypes,
    this.audioUrl,
    this.imageUrl,
    this.estimatedDuration,
    this.prerequisites,
    this.metadata,
  });

  factory LearningNode.empty() => const LearningNode(
    id: '',
    title: '',
    description: '',
    level: '',
    position: Offset.zero,
    isUnlocked: false,
    isCompleted: false,
    nextNodeIds: [],
    exerciseTypes: [],
  );

  LearningNode copyWith({
    String? id,
    String? title,
    String? description,
    String? level,
    Offset? position,
    bool? isUnlocked,
    bool? isCompleted,
    List<String>? nextNodeIds,
    List<String>? exerciseTypes,
    String? audioUrl,
    String? imageUrl,
    int? estimatedDuration,
    List<String>? prerequisites,
    Map<String, dynamic>? metadata,
  }) {
    return LearningNode(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      level: level ?? this.level,
      position: position ?? this.position,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      isCompleted: isCompleted ?? this.isCompleted,
      nextNodeIds: nextNodeIds ?? this.nextNodeIds,
      exerciseTypes: exerciseTypes ?? this.exerciseTypes,
      audioUrl: audioUrl ?? this.audioUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      prerequisites: prerequisites ?? this.prerequisites,
      metadata: metadata ?? this.metadata,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'level': level,
      'position': {'x': position.dx, 'y': position.dy},
      'isUnlocked': isUnlocked,
      'isCompleted': isCompleted,
      'nextNodeIds': nextNodeIds,
      'exerciseTypes': exerciseTypes,
      'audioUrl': audioUrl,
      'imageUrl': imageUrl,
      'estimatedDuration': estimatedDuration,
      'prerequisites': prerequisites,
      'metadata': metadata,
    };
  }

  factory LearningNode.fromJson(Map<String, dynamic> json) {
    return LearningNode(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      level: json['level'] ?? '',
      position: Offset(
        (json['position']?['x'] ?? 0.0).toDouble(),
        (json['position']?['y'] ?? 0.0).toDouble(),
      ),
      isUnlocked: json['isUnlocked'] ?? false,
      isCompleted: json['isCompleted'] ?? false,
      nextNodeIds: List<String>.from(json['nextNodeIds'] ?? []),
      exerciseTypes: List<String>.from(json['exerciseTypes'] ?? []),
      audioUrl: json['audioUrl'],
      imageUrl: json['imageUrl'],
      estimatedDuration: json['estimatedDuration'],
      prerequisites: json['prerequisites'] != null
          ? List<String>.from(json['prerequisites'])
          : null,
      metadata: json['metadata'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LearningNode && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'LearningNode(id: $id, title: $title, level: $level)';
  }
}
