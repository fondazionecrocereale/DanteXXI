// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'divine_comedy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DivineComedyModelImpl _$$DivineComedyModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DivineComedyModelImpl(
      title: json['title'] as String,
      cefrRange:
          (json['cefrRange'] as List<dynamic>).map((e) => e as String).toList(),
      baseColor: ColorModel.fromJson(json['baseColor'] as Map<String, dynamic>),
      textColor: ColorModel.fromJson(json['textColor'] as Map<String, dynamic>),
      cardColor: ColorModel.fromJson(json['cardColor'] as Map<String, dynamic>),
      backgroundImage: json['backgroundImage'] as String,
      lessons: (json['lessons'] as List<dynamic>)
          .map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalLessons: (json['totalLessons'] as num?)?.toInt() ?? 0,
      completedLessons: (json['completedLessons'] as num?)?.toInt() ?? 0,
      progressPercentage: (json['progressPercentage'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$DivineComedyModelImplToJson(
        _$DivineComedyModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'cefrRange': instance.cefrRange,
      'baseColor': instance.baseColor,
      'textColor': instance.textColor,
      'cardColor': instance.cardColor,
      'backgroundImage': instance.backgroundImage,
      'lessons': instance.lessons,
      'totalLessons': instance.totalLessons,
      'completedLessons': instance.completedLessons,
      'progressPercentage': instance.progressPercentage,
    };

_$ColorModelImpl _$$ColorModelImplFromJson(Map<String, dynamic> json) =>
    _$ColorModelImpl(
      red: (json['red'] as num).toInt(),
      green: (json['green'] as num).toInt(),
      blue: (json['blue'] as num).toInt(),
    );

Map<String, dynamic> _$$ColorModelImplToJson(_$ColorModelImpl instance) =>
    <String, dynamic>{
      'red': instance.red,
      'green': instance.green,
      'blue': instance.blue,
    };
