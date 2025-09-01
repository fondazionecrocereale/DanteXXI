// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radio_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RadioStationImpl _$$RadioStationImplFromJson(Map<String, dynamic> json) =>
    _$RadioStationImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      streamUrl: json['streamUrl'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      logo: json['logo'] as String,
      isPlaying: json['isPlaying'] as bool? ?? false,
    );

Map<String, dynamic> _$$RadioStationImplToJson(_$RadioStationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'streamUrl': instance.streamUrl,
      'description': instance.description,
      'category': instance.category,
      'logo': instance.logo,
      'isPlaying': instance.isPlaying,
    };
