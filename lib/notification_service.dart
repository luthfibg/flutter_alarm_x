import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nfp110/navpages/alarm.dart';

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

  static Future scheduledAlarm({
    var id = 0,
    required String title,
    required String body,
    required FlutterLocalNotificationsPlugin fln,
  }) async {
    var scheduledNotificationDateTime =
        DateTime.now().add(const Duration(seconds: 10));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      title,
      body,
      channelDescription: 'Channel for Alarm Notification',
      icon: 'sc_launcher',
      sound: const RawResourceAndroidNotificationSound('notification_sound'),
      largeIcon: const DrawableResourceAndroidBitmap('sc_launcher'),
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
      sound: 'notification_sound.mp3',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.schedule(
      id,
      title,
      body,
      scheduledNotificationDateTime,
      platformChannelSpecifics,
    );
  }
}
