import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nfp110/data.dart';
import 'package:nfp110/main.dart';

class MyAlarm extends StatefulWidget {
  const MyAlarm({super.key});

  @override
  State<MyAlarm> createState() => _MyAlarmState();
}

class _MyAlarmState extends State<MyAlarm> with SingleTickerProviderStateMixin {
  final black87a = const Color.fromARGB(221, 26, 26, 26);
  final primaryBlue = const Color.fromARGB(255, 82, 177, 255);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black87a,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: const Text('Alarm'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: alarms.map<Widget>((alarm) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: alarm.gradientColors,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: alarm.gradientColors.last.withOpacity(0.5),
                            blurRadius: 3,
                            spreadRadius: 0,
                            offset: const Offset(4, 4)),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.label,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Office',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'avenir',
                                  ),
                                ),
                              ],
                            ),
                            Switch(
                              value: true,
                              onChanged: (bool value) {},
                              activeColor: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        const Text(
                          'Mon-Fri',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'avenir',
                            fontSize: 18,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              '07:00',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'avenir',
                                fontWeight: FontWeight.w500,
                                fontSize: 30,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 23,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).followedBy([
                  DottedBorder(
                    color: primaryBlue,
                    strokeWidth: 3,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(24),
                    dashPattern: const [5, 4],
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(158, 41, 93, 138),
                          borderRadius: BorderRadius.all(Radius.circular(18))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      height: 120,
                      child: OutlinedButton(
                        onPressed: () {
                          scheduledAlarm();
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/add_alarm24.png',
                              scale: 0.75,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Add Alarm',
                              style: TextStyle(
                                color: primaryBlue,
                                fontFamily: 'avenir',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]).toList(),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Under Development !',
                style: TextStyle(color: primaryBlue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scheduledAlarm() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(const Duration(seconds: 10));
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Channel for Alarm Notification',
      icon: 'sc_launcher',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('sc_launcher'),
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
      sound: 'a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(0, 'Office',
        'Good Morning! Time to go to Office!', platformChannelSpecifics,
        payload: 'sc_launcher');
  }
}
