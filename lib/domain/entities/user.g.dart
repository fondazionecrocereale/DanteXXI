// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      avatar: json['avatar'] as String?,
      level: json['level'] as String?,
      totalXP: (json['totalXP'] as num?)?.toInt(),
      currentStreak: (json['currentStreak'] as num?)?.toInt(),
      longestStreak: (json['longestStreak'] as num?)?.toInt(),
      lessonsCompleted: (json['lessonsCompleted'] as num?)?.toInt(),
      exercisesCompleted: (json['exercisesCompleted'] as num?)?.toInt(),
      wordsLearned: (json['wordsLearned'] as num?)?.toInt(),
      joinDate: json['joinDate'] == null
          ? null
          : DateTime.parse(json['joinDate'] as String),
      isPremium: json['isPremium'] as bool?,
      country: json['country'] as String?,
      credits: json['credits'] as String?,
      currency: json['currency'] as String?,
      intereses: (json['intereses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      language: json['language'] as String?,
      lastSignIn: json['lastSignIn'] == null
          ? null
          : DateTime.parse(json['lastSignIn'] as String),
      uid: json['uid'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatar': instance.avatar,
      'level': instance.level,
      'totalXP': instance.totalXP,
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'lessonsCompleted': instance.lessonsCompleted,
      'exercisesCompleted': instance.exercisesCompleted,
      'wordsLearned': instance.wordsLearned,
      'joinDate': instance.joinDate?.toIso8601String(),
      'isPremium': instance.isPremium,
      'country': instance.country,
      'credits': instance.credits,
      'currency': instance.currency,
      'intereses': instance.intereses,
      'language': instance.language,
      'lastSignIn': instance.lastSignIn?.toIso8601String(),
      'uid': instance.uid,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$LoginRequestImpl _$$LoginRequestImplFromJson(Map<String, dynamic> json) =>
    _$LoginRequestImpl(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$LoginRequestImplToJson(_$LoginRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

_$RegisterRequestImpl _$$RegisterRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$RegisterRequestImpl(
      email: json['email'] as String,
      password: json['password'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );

Map<String, dynamic> _$$RegisterRequestImplToJson(
        _$RegisterRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };

_$AuthResponseImpl _$$AuthResponseImplFromJson(Map<String, dynamic> json) =>
    _$AuthResponseImpl(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$AuthResponseImplToJson(_$AuthResponseImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'message': instance.message,
    };

_$ErrorResponseImpl _$$ErrorResponseImplFromJson(Map<String, dynamic> json) =>
    _$ErrorResponseImpl(
      error: json['error'] as String,
      message: json['message'] as String?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ErrorResponseImplToJson(_$ErrorResponseImpl instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'statusCode': instance.statusCode,
    };
