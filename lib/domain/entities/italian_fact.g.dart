// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'italian_fact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItalianFactImpl _$$ItalianFactImplFromJson(Map<String, dynamic> json) =>
    _$ItalianFactImpl(
      topic: json['topic'] as String,
      description: json['description'] as String,
      date: json['date'] as String,
      message: json['message'] as String,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$ItalianFactImplToJson(_$ItalianFactImpl instance) =>
    <String, dynamic>{
      'topic': instance.topic,
      'description': instance.description,
      'date': instance.date,
      'message': instance.message,
      'url': instance.url,
    };

_$ItalianFactsImpl _$$ItalianFactsImplFromJson(Map<String, dynamic> json) =>
    _$ItalianFactsImpl(
      facts: (json['facts'] as List<dynamic>)
          .map((e) => ItalianFact.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ItalianFactsImplToJson(_$ItalianFactsImpl instance) =>
    <String, dynamic>{
      'facts': instance.facts,
    };
