import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nfp110/navpages/alarm.dart';
import 'package:timezone/timezone.dart' as tz;
import '../models/alarm_info.dart';

class NotificationService {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('sc_launcher');
    var darwinInitializationSettings = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: darwinInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future showAlarmNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'channel_id',
      'my_channel',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification_sound'),
      importance: Importance.max,
      priority: Priority.high,
    );

    var notificationDetails = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: const DarwinNotificationDetails());

    await fln.show(0, title, body, notificationDetails);
  }

  static void scheduledAlarm(
      DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo,
      {required bool isRepeating}) async {
    // var scheduledNotificationDateTime =
    //     DateTime.now().add(const Duration(seconds: 10));
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Channel for Alarm Notification',
      icon: 'sc_launcher',
      sound: RawResourceAndroidNotificationSound('notification_sound'),
      largeIcon: DrawableResourceAndroidBitmap('sc_launcher'),
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
      sound: 'notification_sound.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    if (isRepeating) {
      await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'Office',
        alarmInfo.title,
        Time(
          scheduledNotificationDateTime.hour,
          scheduledNotificationDateTime.minute,
          scheduledNotificationDateTime.second,
        ),
        platformChannelSpecifics,
      );
    } else {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Office',
        alarmInfo.title,
        tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }
}
