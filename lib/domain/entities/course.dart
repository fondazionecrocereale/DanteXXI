import 'package:freezed_annotation/freezed_annotation.dart';

part 'course.freezed.dart';
part 'course.g.dart';

@freezed
class Course with _$Course {
  const factory Course({
    required String id,
    required String teacherId,
    required String title,
    required String description,
    required String thumbnailUrl,
    required String videoUrl,
    required double price, // En Fiorino
    required bool isFree,
    required CourseLevel level,
    required List<String> tags,
    required int duration, // En minutos
    required int totalLessons,
    required int completedLessons,
    required double rating,
    required int totalStudents,
    required CourseStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? previewVideoUrl,
    List<String>? prerequisites,
    String? certificateUrl,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
}

@freezed
class CourseLesson with _$CourseLesson {
  const factory CourseLesson({
    required String id,
    required String courseId,
    required String title,
    required String description,
    required String videoUrl,
    required int duration, // En minutos
    required int order,
    required bool isFree,
    required bool isCompleted,
    String? transcript,
    List<String>? resources,
  }) = _CourseLesson;

  factory CourseLesson.fromJson(Map<String, dynamic> json) =>
      _$CourseLessonFromJson(json);
}

@freezed
class CoursePurchase with _$CoursePurchase {
  const factory CoursePurchase({
    required String id,
    required String userId,
    required String courseId,
    required String teacherId,
    required double amount, // En Fiorino
    required PurchaseStatus status,
    required DateTime purchaseDate,
    required DateTime accessExpiry,
    String? transactionHash,
  }) = _CoursePurchase;

  factory CoursePurchase.fromJson(Map<String, dynamic> json) =>
      _$CoursePurchaseFromJson(json);
}

enum CourseLevel { beginner, intermediate, advanced, expert }

enum CourseStatus { draft, published, archived, comingSoon }

enum PurchaseStatus { pending, completed, failed, refunded }
