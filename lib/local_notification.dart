import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotifications =
      FlutterLocalNotificationsPlugin();
  static onTap(NotificationResponse notificationResponse) {}
  static Future init() async {
    _askForNotificationPermission();
    InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    flutterLocalNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  static Future showOneTimeMessage() async {
    await flutterLocalNotifications.show(
      0,
      'Ont Time Message',
      '',
      NotificationDetails(
        android: AndroidNotificationDetails(
          priority: Priority.max,
          importance: Importance.max,
          icon: '@mipmap/ic_launcher',
          "channel_Id",
          'channel_Name',
        ),
      ),
    );
  }

  static Future showScheduleMessage() async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'channel_id', // معرف القناة
          'channel_name',
          channelDescription: 'وصف القناة', // وصف القناة

          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',

          icon: '@mipmap/ic_launcher',
        );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotifications.periodicallyShow(
      1,
      'This is Title Test',
      'Some Thing',
      RepeatInterval.everyMinute,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      payload: 'test_payload',
    );
  }

  static Future cancelMessage() async {
    await flutterLocalNotifications.cancel(0);
  }

  static Future<void> _askForNotificationPermission() async {
    final androidImplementation = flutterLocalNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidImplementation != null) {
      await androidImplementation.requestNotificationsPermission();
    }
  }
}
