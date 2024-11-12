import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/material.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    try {
      debugPrint('Initializing notification service...');

      tz.initializeTimeZones();

      // Konfigurasi untuk Android
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      // Konfigurasi untuk semua platform
      const InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);

      // Initialize plugin
      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) async {
          debugPrint('Notification clicked: ${details.payload}');
        },
      );

      // Request permissions
      final platform = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      if (platform != null) {
        debugPrint('Requesting Android notification permissions...');
        final granted = await platform.requestNotificationsPermission();
        debugPrint('Notification permission granted: $granted');
      }

      debugPrint('Notification service initialized successfully');
    } catch (e) {
      debugPrint('Error initializing notification service: $e');
    }
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    try {
      debugPrint(
          'Scheduling notification: ID=$id, Title=$title, Time=${scheduledDate.toString()}');

      // Buat channel notification untuk Android
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'todo_tasks', // channel id
        'Task Reminders', // channel name
        channelDescription: 'Notifications for task reminders',
        importance: Importance.max,
        priority: Priority.high,
        enableVibration: true,
        enableLights: true,
        playSound: true,
        icon: '@mipmap/ic_launcher',
      );

      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      // Convert to TZDateTime
      final tz.TZDateTime tzDateTime =
          tz.TZDateTime.from(scheduledDate, tz.local);

      // Schedule notification
      await _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tzDateTime,
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );

      debugPrint('Notification scheduled successfully');
    } catch (e) {
      debugPrint('Error scheduling notification: $e');
    }
  }

  // Method untuk membatalkan notifikasi
  Future<void> cancelNotification(int id) async {
    try {
      await _flutterLocalNotificationsPlugin.cancel(id);
      debugPrint('Notification cancelled: ID=$id');
    } catch (e) {
      debugPrint('Error cancelling notification: $e');
    }
  }

  // Method untuk membatalkan semua notifikasi
  Future<void> cancelAllNotifications() async {
    try {
      await _flutterLocalNotificationsPlugin.cancelAll();
      debugPrint('All notifications cancelled');
    } catch (e) {
      debugPrint('Error cancelling all notifications: $e');
    }
  }
}
