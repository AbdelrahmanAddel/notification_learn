import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

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
    var scheduleTime = tz.TZDateTime(tz.local, 2025, 9, 4, 22, 16);
    print(tz.TZDateTime.now(tz.local));
    if (tz.TZDateTime.now(tz.local).isAfter(scheduleTime)) {
      scheduleTime = scheduleTime.add(Duration(minutes: 1));
    }
    print(scheduleTime);

    await localNotification.zonedSchedule(
      3,
      'Scheduled Notification',
      'Scheduled Body',
      scheduleTime,
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
