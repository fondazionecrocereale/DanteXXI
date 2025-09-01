// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'italian_holiday.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItalianHolidayImpl _$$ItalianHolidayImplFromJson(Map<String, dynamic> json) =>
    _$ItalianHolidayImpl(
      name: json['name'] as String,
      date: json['date'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$$ItalianHolidayImplToJson(
        _$ItalianHolidayImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'date': instance.date,
      'message': instance.message,
    };

_$ItalianHolidaysImpl _$$ItalianHolidaysImplFromJson(
        Map<String, dynamic> json) =>
    _$ItalianHolidaysImpl(
      holidays: (json['holidays'] as List<dynamic>)
          .map((e) => ItalianHoliday.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ItalianHolidaysImplToJson(
        _$ItalianHolidaysImpl instance) =>
    <String, dynamic>{
      'holidays': instance.holidays,
    };
