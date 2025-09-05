// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeacherImpl _$$TeacherImplFromJson(Map<String, dynamic> json) =>
    _$TeacherImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      bio: json['bio'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      coverImageUrl: json['coverImageUrl'] as String,
      presentationVideoUrl: json['presentationVideoUrl'] as String?,
      logoUrl: json['logoUrl'] as String,
      isVerified: json['isVerified'] as bool,
      totalStudents: (json['totalStudents'] as num).toInt(),
      totalCourses: (json['totalCourses'] as num).toInt(),
      totalArticles: (json['totalArticles'] as num).toInt(),
      rating: (json['rating'] as num).toDouble(),
      specializations: (json['specializations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      languages:
          (json['languages'] as List<dynamic>).map((e) => e as String).toList(),
      joinDate: DateTime.parse(json['joinDate'] as String),
      isActive: json['isActive'] as bool,
      website: json['website'] as String?,
      instagram: json['instagram'] as String?,
      youtube: json['youtube'] as String?,
      tiktok: json['tiktok'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$TeacherImplToJson(_$TeacherImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'bio': instance.bio,
      'profileImageUrl': instance.profileImageUrl,
      'coverImageUrl': instance.coverImageUrl,
      'presentationVideoUrl': instance.presentationVideoUrl,
      'logoUrl': instance.logoUrl,
      'isVerified': instance.isVerified,
      'totalStudents': instance.totalStudents,
      'totalCourses': instance.totalCourses,
      'totalArticles': instance.totalArticles,
      'rating': instance.rating,
      'specializations': instance.specializations,
      'languages': instance.languages,
      'joinDate': instance.joinDate.toIso8601String(),
      'isActive': instance.isActive,
      'website': instance.website,
      'instagram': instance.instagram,
      'youtube': instance.youtube,
      'tiktok': instance.tiktok,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$TeacherStatsImpl _$$TeacherStatsImplFromJson(Map<String, dynamic> json) =>
    _$TeacherStatsImpl(
      teacherId: json['teacherId'] as String,
      totalEarnings: (json['totalEarnings'] as num).toInt(),
      totalSales: (json['totalSales'] as num).toInt(),
      totalViews: (json['totalViews'] as num).toInt(),
      totalLikes: (json['totalLikes'] as num).toInt(),
      totalComments: (json['totalComments'] as num).toInt(),
      averageRating: (json['averageRating'] as num).toDouble(),
      totalReels: (json['totalReels'] as num).toInt(),
      totalArticles: (json['totalArticles'] as num).toInt(),
      totalCourses: (json['totalCourses'] as num).toInt(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$TeacherStatsImplToJson(_$TeacherStatsImpl instance) =>
    <String, dynamic>{
      'teacherId': instance.teacherId,
      'totalEarnings': instance.totalEarnings,
      'totalSales': instance.totalSales,
      'totalViews': instance.totalViews,
      'totalLikes': instance.totalLikes,
      'totalComments': instance.totalComments,
      'averageRating': instance.averageRating,
      'totalReels': instance.totalReels,
      'totalArticles': instance.totalArticles,
      'totalCourses': instance.totalCourses,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };
