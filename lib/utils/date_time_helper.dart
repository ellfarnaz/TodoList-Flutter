import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

class DateTimeHelper {
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (!_initialized) {
      await initializeDateFormatting('id_ID', null);
      Intl.defaultLocale = 'id_ID';
      _initialized = true;
      debugPrint('Date formatting initialized for id_ID');
    }
  }

  static String formatDate(DateTime date) {
    if (!_initialized) {
      throw Exception(
          'DateTimeHelper not initialized. Call initialize() first.');
    }
    return DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(date);
  }

  static String formatTime(TimeOfDay time) {
    if (!_initialized) {
      throw Exception(
          'DateTimeHelper not initialized. Call initialize() first.');
    }
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm', 'id_ID').format(dateTime);
  }

  static String formatFullDateTime(DateTime date, TimeOfDay time) {
    if (!_initialized) {
      throw Exception(
          'DateTimeHelper not initialized. Call initialize() first.');
    }
    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    return DateFormat('EEEE, d MMMM yyyy HH:mm', 'id_ID').format(dateTime);
  }

  static String getDayName(DateTime date) {
    if (!_initialized) {
      throw Exception(
          'DateTimeHelper not initialized. Call initialize() first.');
    }
    return DateFormat('EEEE', 'id_ID').format(date);
  }

  static String getMonthName(DateTime date) {
    if (!_initialized) {
      throw Exception(
          'DateTimeHelper not initialized. Call initialize() first.');
    }
    return DateFormat('MMMM', 'id_ID').format(date);
  }
}
