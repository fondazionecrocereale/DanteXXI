import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entities/italian_holiday.dart';

class ItalianHolidaysService {
  static List<ItalianHoliday>? _holidays;

  static Future<List<ItalianHoliday>> getHolidays() async {
    if (_holidays != null) {
      return _holidays!;
    }

    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/italian_holidays.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final ItalianHolidays holidaysData = ItalianHolidays.fromJson(jsonData);
      _holidays = holidaysData.holidays;
      return _holidays!;
    } catch (e) {
      print('❌ Error loading Italian holidays: $e');
      return [];
    }
  }

  static Future<ItalianHoliday?> getTodayHoliday() async {
    final holidays = await getHolidays();
    final today = DateTime.now();
    final todayString =
        '${today.year.toString().padLeft(4, '0')}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    try {
      return holidays.firstWhere((holiday) => holiday.date == todayString);
    } catch (e) {
      return null; // No holiday today
    }
  }

  static Future<ItalianHoliday?> getNextHoliday() async {
    final holidays = await getHolidays();
    final today = DateTime.now();

    // Sort holidays by date
    final sortedHolidays = List<ItalianHoliday>.from(holidays);
    sortedHolidays.sort((a, b) => a.date.compareTo(b.date));

    // Find the next holiday
    for (final holiday in sortedHolidays) {
      final holidayDate = DateTime.parse(holiday.date);
      if (holidayDate.isAfter(today)) {
        return holiday;
      }
    }

    return null; // No more holidays this year
  }
}
