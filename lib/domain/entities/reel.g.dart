// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubtitleImpl _$$SubtitleImplFromJson(Map<String, dynamic> json) =>
    _$SubtitleImpl(
      endTime: json['endTime'] as String,
      isWordKey: json['isWordKey'] as bool,
      startTime: json['startTime'] as String,
      text: json['text'] as String,
      translation: json['translation'] as String,
      translationEN: json['translationEN'] as String,
      translationPR: json['translationPR'] as String,
    );

Map<String, dynamic> _$$SubtitleImplToJson(_$SubtitleImpl instance) =>
    <String, dynamic>{
      'endTime': instance.endTime,
      'isWordKey': instance.isWordKey,
      'startTime': instance.startTime,
      'text': instance.text,
      'translation': instance.translation,
      'translationEN': instance.translationEN,
      'translationPR': instance.translationPR,
    };
