import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

// @mipmap/ic_launcher

class LocalNotification {
  static FlutterLocalNotificationsPlugin localNotification =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> notificationStream =
      StreamController();
  static onTap(NotificationResponse response) {
    notificationStream.add(response);
  }

  static Future init() async {
    await localNotification.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  static Future sendScheduleNotification() async {
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    await localNotification.zonedSchedule(
      3,
      'Scheduled Notification',
      'Scheduled Body',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }

  static Future sendSimpleNotification() async {
    await localNotification.show(
      0,
      'Simple Notification',
      'This is a simple notification',
      _notificationDetails(),
    );
  }

  static Future sendRepeatedNotification() async {
    await localNotification.periodicallyShow(
      1,
      'Repeated Notification',
      'Repeated Body',
      RepeatInterval.everyMinute,
      _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }

  static NotificationDetails _notificationDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_Id',
        'Simple Channel',
        sound: RawResourceAndroidNotificationSound(
          'sound.wav'.split('.').first,
        ),
      ),
    );
  }

  static Future cancelAllNotifications() async {
    await localNotification.cancelAll();
  }
}
