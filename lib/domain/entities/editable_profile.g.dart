// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editable_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EditableProfileImpl _$$EditableProfileImplFromJson(
        Map<String, dynamic> json) =>
    _$EditableProfileImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      avatar: json['avatar'] as String?,
      level: json['level'] as String?,
      country: json['country'] as String?,
      language: json['language'] as String?,
      interests: (json['interests'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      bio: json['bio'] as String?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      phoneNumber: json['phoneNumber'] as String?,
      timezone: json['timezone'] as String?,
      emailNotifications: json['emailNotifications'] as bool?,
      pushNotifications: json['pushNotifications'] as bool?,
      learningGoal: json['learningGoal'] as String?,
      dailyGoalMinutes: (json['dailyGoalMinutes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$EditableProfileImplToJson(
        _$EditableProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatar': instance.avatar,
      'level': instance.level,
      'country': instance.country,
      'language': instance.language,
      'interests': instance.interests,
      'bio': instance.bio,
      'birthDate': instance.birthDate?.toIso8601String(),
      'phoneNumber': instance.phoneNumber,
      'timezone': instance.timezone,
      'emailNotifications': instance.emailNotifications,
      'pushNotifications': instance.pushNotifications,
      'learningGoal': instance.learningGoal,
      'dailyGoalMinutes': instance.dailyGoalMinutes,
    };

_$ProfileUpdateRequestImpl _$$ProfileUpdateRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ProfileUpdateRequestImpl(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      avatar: json['avatar'] as String?,
      level: json['level'] as String?,
      country: json['country'] as String?,
      language: json['language'] as String?,
      interests: (json['interests'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      bio: json['bio'] as String?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      phoneNumber: json['phoneNumber'] as String?,
      timezone: json['timezone'] as String?,
      emailNotifications: json['emailNotifications'] as bool?,
      pushNotifications: json['pushNotifications'] as bool?,
      learningGoal: json['learningGoal'] as String?,
      dailyGoalMinutes: (json['dailyGoalMinutes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ProfileUpdateRequestImplToJson(
        _$ProfileUpdateRequestImpl instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatar': instance.avatar,
      'level': instance.level,
      'country': instance.country,
      'language': instance.language,
      'interests': instance.interests,
      'bio': instance.bio,
      'birthDate': instance.birthDate?.toIso8601String(),
      'phoneNumber': instance.phoneNumber,
      'timezone': instance.timezone,
      'emailNotifications': instance.emailNotifications,
      'pushNotifications': instance.pushNotifications,
      'learningGoal': instance.learningGoal,
      'dailyGoalMinutes': instance.dailyGoalMinutes,
    };
