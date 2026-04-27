import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _notifications.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (payload) {
        print("Clicked notification payload: $payload");
      },
    );
  }

  /// 🔔 Instant (new lead)
  static Future<void> showInstant(String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
      'instant_channel',
      'Instant Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    await _notifications.show(
     id:  0,
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(android: androidDetails),
      payload: "lead",
    );
  }

  /// ⏰ Schedule
  static Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime date,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'schedule_channel',
      'Scheduled Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    await _notifications.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(date, tz.local),
      notificationDetails: const NotificationDetails(android: androidDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: "scheduled",
    );
  }
}