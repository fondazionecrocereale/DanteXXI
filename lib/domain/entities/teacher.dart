import 'package:freezed_annotation/freezed_annotation.dart';

part 'teacher.freezed.dart';
part 'teacher.g.dart';

@freezed
class Teacher with _$Teacher {
  const factory Teacher({
    required String id,
    required String name,
    required String email,
    required String bio,
    required String profileImageUrl,
    required String coverImageUrl,
    String? presentationVideoUrl,
    required String logoUrl,
    required bool isVerified,
    required int totalStudents,
    required int totalCourses,
    required int totalArticles,
    required double rating,
    required List<String> specializations,
    required List<String> languages,
    required DateTime joinDate,
    required bool isActive,
    String? website,
    String? instagram,
    String? youtube,
    String? tiktok,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Teacher;

  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);
}

@freezed
class TeacherStats with _$TeacherStats {
  const factory TeacherStats({
    required String teacherId,
    required int totalEarnings,
    required int totalSales,
    required int totalViews,
    required int totalLikes,
    required int totalComments,
    required double averageRating,
    required int totalReels,
    required int totalArticles,
    required int totalCourses,
    required DateTime lastUpdated,
  }) = _TeacherStats;

  factory TeacherStats.fromJson(Map<String, dynamic> json) =>
      _$TeacherStatsFromJson(json);
}
