// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseImpl _$$CourseImplFromJson(Map<String, dynamic> json) => _$CourseImpl(
      id: json['id'] as String,
      teacherId: json['teacherId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      videoUrl: json['videoUrl'] as String,
      price: (json['price'] as num).toDouble(),
      isFree: json['isFree'] as bool,
      level: $enumDecode(_$CourseLevelEnumMap, json['level']),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      duration: (json['duration'] as num).toInt(),
      totalLessons: (json['totalLessons'] as num).toInt(),
      completedLessons: (json['completedLessons'] as num).toInt(),
      rating: (json['rating'] as num).toDouble(),
      totalStudents: (json['totalStudents'] as num).toInt(),
      status: $enumDecode(_$CourseStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      previewVideoUrl: json['previewVideoUrl'] as String?,
      prerequisites: (json['prerequisites'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      certificateUrl: json['certificateUrl'] as String?,
    );

Map<String, dynamic> _$$CourseImplToJson(_$CourseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'teacherId': instance.teacherId,
      'title': instance.title,
      'description': instance.description,
      'thumbnailUrl': instance.thumbnailUrl,
      'videoUrl': instance.videoUrl,
      'price': instance.price,
      'isFree': instance.isFree,
      'level': _$CourseLevelEnumMap[instance.level]!,
      'tags': instance.tags,
      'duration': instance.duration,
      'totalLessons': instance.totalLessons,
      'completedLessons': instance.completedLessons,
      'rating': instance.rating,
      'totalStudents': instance.totalStudents,
      'status': _$CourseStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'previewVideoUrl': instance.previewVideoUrl,
      'prerequisites': instance.prerequisites,
      'certificateUrl': instance.certificateUrl,
    };

const _$CourseLevelEnumMap = {
  CourseLevel.beginner: 'beginner',
  CourseLevel.intermediate: 'intermediate',
  CourseLevel.advanced: 'advanced',
  CourseLevel.expert: 'expert',
};

const _$CourseStatusEnumMap = {
  CourseStatus.draft: 'draft',
  CourseStatus.published: 'published',
  CourseStatus.archived: 'archived',
  CourseStatus.comingSoon: 'comingSoon',
};

_$CourseLessonImpl _$$CourseLessonImplFromJson(Map<String, dynamic> json) =>
    _$CourseLessonImpl(
      id: json['id'] as String,
      courseId: json['courseId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      videoUrl: json['videoUrl'] as String,
      duration: (json['duration'] as num).toInt(),
      order: (json['order'] as num).toInt(),
      isFree: json['isFree'] as bool,
      isCompleted: json['isCompleted'] as bool,
      transcript: json['transcript'] as String?,
      resources: (json['resources'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$CourseLessonImplToJson(_$CourseLessonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'courseId': instance.courseId,
      'title': instance.title,
      'description': instance.description,
      'videoUrl': instance.videoUrl,
      'duration': instance.duration,
      'order': instance.order,
      'isFree': instance.isFree,
      'isCompleted': instance.isCompleted,
      'transcript': instance.transcript,
      'resources': instance.resources,
    };

_$CoursePurchaseImpl _$$CoursePurchaseImplFromJson(Map<String, dynamic> json) =>
    _$CoursePurchaseImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      courseId: json['courseId'] as String,
      teacherId: json['teacherId'] as String,
      amount: (json['amount'] as num).toDouble(),
      status: $enumDecode(_$PurchaseStatusEnumMap, json['status']),
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
      accessExpiry: DateTime.parse(json['accessExpiry'] as String),
      transactionHash: json['transactionHash'] as String?,
    );

Map<String, dynamic> _$$CoursePurchaseImplToJson(
        _$CoursePurchaseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'courseId': instance.courseId,
      'teacherId': instance.teacherId,
      'amount': instance.amount,
      'status': _$PurchaseStatusEnumMap[instance.status]!,
      'purchaseDate': instance.purchaseDate.toIso8601String(),
      'accessExpiry': instance.accessExpiry.toIso8601String(),
      'transactionHash': instance.transactionHash,
    };

const _$PurchaseStatusEnumMap = {
  PurchaseStatus.pending: 'pending',
  PurchaseStatus.completed: 'completed',
  PurchaseStatus.failed: 'failed',
  PurchaseStatus.refunded: 'refunded',
};
