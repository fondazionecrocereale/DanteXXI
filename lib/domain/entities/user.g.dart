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
      did: json['did'] as String?,
      walletAddress: json['walletAddress'] as String?,
      isWeb3Enabled: json['isWeb3Enabled'] as bool?,
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
      'did': instance.did,
      'walletAddress': instance.walletAddress,
      'isWeb3Enabled': instance.isWeb3Enabled,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
