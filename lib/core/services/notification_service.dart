import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:url_launcher/url_launcher.dart';
import 'italian_facts_service.dart';
import '../../domain/entities/italian_fact.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (_isInitialized) return;

    // Initialize timezone
    tz.initializeTimeZones();

    // Android settings
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS settings
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    // Initialize settings
    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // Initialize plugin
    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    _isInitialized = true;
    print('✅ NotificationService initialized');
  }

  static void _onNotificationTapped(NotificationResponse response) async {
    print('🔔 Notification tapped: ${response.payload}');

    if (response.payload != null && response.payload!.isNotEmpty) {
      try {
        final Uri url = Uri.parse(response.payload!);
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
          print('🌐 Launched URL: $url');
        } else {
          print('❌ Could not launch URL: $url');
        }
      } catch (e) {
        print('❌ Error launching URL: $e');
      }
    }
  }

  static Future<void> scheduleDailyFactNotification() async {
    await initialize();

    // Cancel existing notifications
    await _notifications.cancelAll();

    // Schedule new daily notification at 9:00 AM
    await _notifications.zonedSchedule(
      1, // Unique ID
      '🇮🇹 Curiosità Italiana',
      'Scopri qualcosa di nuovo sull\'Italia oggi!',
      _nextInstanceOfNineAM(),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'italian_facts_channel',
          'Curiosità Italiane',
          channelDescription: 'Notificaciones diarias sobre Italia',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    print('✅ Daily fact notification scheduled');
  }

  static tz.TZDateTime _nextInstanceOfNineAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      9,
      0,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  static Future<void> scheduleRandomFactNotification() async {
    await initialize();

    try {
      final ItalianFact? fact =
          await ItalianFactsService.getRandomFactWithUrl();

      if (fact != null) {
        await _notifications.zonedSchedule(
          2, // Unique ID for random facts
          '🇮🇹 ${fact.topic}',
          fact.message,
          tz.TZDateTime.now(
            tz.local,
          ).add(const Duration(seconds: 5)), // Show in 5 seconds
          NotificationDetails(
            android: AndroidNotificationDetails(
              'italian_facts_random_channel',
              'Curiosità Italiane Aleatorie',
              channelDescription: 'Notificaciones aleatorias sobre Italia',
              importance: Importance.high,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: fact.url, // Pass URL as payload
        );

        print('✅ Random fact notification scheduled: ${fact.topic}');
      } else {
        print('⚠️ No facts with URL available for notification');
      }
    } catch (e) {
      print('❌ Error scheduling random fact notification: $e');
    }
  }

  static Future<void> showImmediateFactNotification() async {
    await initialize();

    try {
      final ItalianFact? fact =
          await ItalianFactsService.getRandomFactWithUrl();

      if (fact != null) {
        await _notifications.show(
          3, // Unique ID for immediate notifications
          '🇮🇹 ${fact.topic}',
          fact.message,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'italian_facts_immediate_channel',
              'Curiosità Italiane Inmediatas',
              channelDescription: 'Notificaciones inmediatas sobre Italia',
              importance: Importance.high,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          payload: fact.url, // Pass URL as payload
        );

        print('✅ Immediate fact notification shown: ${fact.topic}');
      } else {
        print('⚠️ No facts with URL available for immediate notification');
      }
    } catch (e) {
      print('❌ Error showing immediate fact notification: $e');
    }
  }

  static Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
    print('✅ All notifications cancelled');
  }

  static Future<List<PendingNotificationRequest>>
  getPendingNotifications() async {
    return await _notifications.pendingNotificationRequests();
  }
}


