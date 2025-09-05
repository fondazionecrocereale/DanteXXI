enum RewardType {
  courseCompletion,
  dailyLogin,
  streakBonus,
  referral,
  achievement,
}

enum RewardStatus { pending, claimed, expired }

class Reward {
  final String id;
  final String title;
  final String description;
  final int fiorinoAmount; // En microunidades
  final RewardType type;
  final RewardStatus status;
  final DateTime createdAt;
  final DateTime? claimedAt;
  final DateTime? expiresAt;
  final String? courseId; // Para recompensas de cursos
  final Map<String, dynamic>? metadata;

  const Reward({
    required this.id,
    required this.title,
    required this.description,
    required this.fiorinoAmount,
    required this.type,
    required this.status,
    required this.createdAt,
    this.claimedAt,
    this.expiresAt,
    this.courseId,
    this.metadata,
  });

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      fiorinoAmount: json['fiorinoAmount'] as int,
      type: RewardType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => RewardType.achievement,
      ),
      status: RewardStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => RewardStatus.pending,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      claimedAt: json['claimedAt'] != null
          ? DateTime.parse(json['claimedAt'] as String)
          : null,
      expiresAt: json['expiresAt'] != null
          ? DateTime.parse(json['expiresAt'] as String)
          : null,
      courseId: json['courseId'] as String?,
      metadata: json['metadata'] != null
          ? Map<String, dynamic>.from(json['metadata'] as Map)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'fiorinoAmount': fiorinoAmount,
      'type': type.name,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'claimedAt': claimedAt?.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'courseId': courseId,
      'metadata': metadata,
    };
  }

  Reward copyWith({
    String? id,
    String? title,
    String? description,
    int? fiorinoAmount,
    RewardType? type,
    RewardStatus? status,
    DateTime? createdAt,
    DateTime? claimedAt,
    DateTime? expiresAt,
    String? courseId,
    Map<String, dynamic>? metadata,
  }) {
    return Reward(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      fiorinoAmount: fiorinoAmount ?? this.fiorinoAmount,
      type: type ?? this.type,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      claimedAt: claimedAt ?? this.claimedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      courseId: courseId ?? this.courseId,
      metadata: metadata ?? this.metadata,
    );
  }

  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  bool get canBeClaimed {
    return status == RewardStatus.pending && !isExpired;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Reward &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.fiorinoAmount == fiorinoAmount &&
        other.type == type &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.claimedAt == claimedAt &&
        other.expiresAt == expiresAt &&
        other.courseId == courseId &&
        other.metadata == metadata;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        fiorinoAmount.hashCode ^
        type.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        claimedAt.hashCode ^
        expiresAt.hashCode ^
        courseId.hashCode ^
        metadata.hashCode;
  }

  @override
  String toString() {
    return 'Reward(id: $id, title: $title, description: $description, fiorinoAmount: $fiorinoAmount, type: $type, status: $status, createdAt: $createdAt, claimedAt: $claimedAt, expiresAt: $expiresAt, courseId: $courseId, metadata: $metadata)';
  }
}
