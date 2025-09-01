import 'package:freezed_annotation/freezed_annotation.dart';

part 'italian_holiday.freezed.dart';
part 'italian_holiday.g.dart';

@freezed
class ItalianHoliday with _$ItalianHoliday {
  const factory ItalianHoliday({
    required String name,
    required String date,
    required String message,
  }) = _ItalianHoliday;

  factory ItalianHoliday.fromJson(Map<String, dynamic> json) =>
      _$ItalianHolidayFromJson(json);
}

@freezed
class ItalianHolidays with _$ItalianHolidays {
  const factory ItalianHolidays({required List<ItalianHoliday> holidays}) =
      _ItalianHolidays;

  factory ItalianHolidays.fromJson(Map<String, dynamic> json) =>
      _$ItalianHolidaysFromJson(json);
}
