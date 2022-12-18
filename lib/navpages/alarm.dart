// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:nfp110/alarm_helper.dart';
// import 'package:nfp110/data.dart';
// import 'package:nfp110/main.dart';
import '../customs/theme.dart';
import 'package:nfp110/models/alarm_info.dart';

import '../notification_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MyAlarm extends StatefulWidget {
  const MyAlarm({super.key});

  @override
  State<MyAlarm> createState() => _MyAlarmState();
}

class _MyAlarmState extends State<MyAlarm> with SingleTickerProviderStateMixin {
  DateTime? _alarmTime;
  late String _alarmTimeString;
  bool _isRepeatSelected = false;
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>>? _alarms;
  List<AlarmInfo>? _currentAlarms;

  @override
  void initState() {
    _alarmTime = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) {
      print('------database initialized');
      loadAlarms();
    });
    super.initState();
    NotificationService.initialize(flutterLocalNotificationsPlugin);
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
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
              child: FutureBuilder<List<AlarmInfo>>(
                future: _alarms,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _currentAlarms = snapshot.data;
                    return ListView(
                      children: snapshot.data!.map<Widget>((alarm) {
                        var alarmTime =
                            DateFormat('hh:mm aa').format(alarm.alarmDateTime!);
                        var gradientColor = GradientTemplate
                            .gradientTemplate[alarm.gradientColorIndex!].colors;
                        return Container(

                        )
                      }),
                    );
                  }
                  return const Center(
                    child: Text(
                      'Loading...',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
              // child: ListView(
              //   children: alarms.map<Widget>((alarm) {
              //     return Container(
              //       margin: const EdgeInsets.only(bottom: 30),
              //       padding:
              //           const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              //       decoration: BoxDecoration(
              //         gradient: LinearGradient(
              //           colors: , // alarm.gradientColors,
              //           begin: Alignment.centerLeft,
              //           end: Alignment.centerRight,
              //         ),
              //         boxShadow: [
              //           BoxShadow(
              //               color: Colors.green.withOpacity(0.5),
              //               blurRadius: 3,
              //               spreadRadius: 0,
              //               offset: const Offset(4, 4)),
              //         ],
              //         borderRadius: const BorderRadius.all(Radius.circular(16)),
              //       ),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Row(
              //                 children: const [
              //                   Icon(
              //                     Icons.label,
              //                     color: Colors.white,
              //                     size: 24,
              //                   ),
              //                   SizedBox(
              //                     width: 8,
              //                   ),
              //                   Text(
              //                     'Office',
              //                     style: TextStyle(
              //                       color: Colors.white,
              //                       fontFamily: 'avenir',
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //               Switch(
              //                 value: true,
              //                 onChanged: (bool value) {},
              //                 activeColor: Colors.white,
              //               ),
              //             ],
              //           ),
              //           const SizedBox(
              //             height: 18,
              //           ),
              //           const Text(
              //             'Mon-Fri',
              //             style: TextStyle(
              //               color: Colors.white,
              //               fontFamily: 'avenir',
              //               fontSize: 18,
              //             ),
              //           ),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: const [
              //               Text(
              //                 '07:00',
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontFamily: 'avenir',
              //                   fontWeight: FontWeight.w500,
              //                   fontSize: 30,
              //                 ),
              //               ),
              //               Icon(
              //                 Icons.keyboard_arrow_down,
              //                 size: 23,
              //                 color: Colors.white,
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     );
              //   }).followedBy([
              //     DottedBorder(
              //       color: primaryBlue,
              //       strokeWidth: 3,
              //       borderType: BorderType.RRect,
              //       radius: const Radius.circular(24),
              //       dashPattern: const [5, 4],
              //       child: Container(
              //         width: double.infinity,
              //         decoration: const BoxDecoration(
              //             color: Color.fromARGB(158, 41, 93, 138),
              //             borderRadius: BorderRadius.all(Radius.circular(18))),
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 32, vertical: 16),
              //         height: 120,
              //         child: OutlinedButton(
              //           onPressed: () {
              //             NotificationService.scheduledAlarm(
              //               title: 'Good Morning',
              //               body: 'Hey! Wake up',
              //               fln: flutterLocalNotificationsPlugin,
              //             );
              //           },
              //           child: Column(
              //             children: [
              //               Image.asset(
              //                 'assets/add_alarm24.png',
              //                 scale: 0.75,
              //               ),
              //               const SizedBox(
              //                 height: 8,
              //               ),
              //               Text(
              //                 'Add Alarm',
              //                 style: TextStyle(
              //                   color: primaryBlue,
              //                   fontFamily: 'avenir',
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ]).toList(),
              // ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Under Development !',
                style: TextStyle(color: CustomColors.primaryBlue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
