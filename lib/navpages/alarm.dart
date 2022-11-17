import 'package:flutter/material.dart';

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
        title: const Text('Alarmku'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Alarm Page',
              style: TextStyle(color: primaryBlue),
            ),
          ],
        ),
      ),
    );
  }
}
