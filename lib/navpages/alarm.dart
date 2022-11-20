import 'package:flutter/material.dart';
import 'package:nfp110/data.dart';

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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: alarms.map((alarm) {
                  return Container(
                    margin: const EdgeInsets.only(top: 30),
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
                }).toList(),
              ),
            ),
            Center(
              child: Text(
                'Alarm Page',
                style: TextStyle(color: primaryBlue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
