import 'package:dotted_border/dotted_border.dart';
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
          children: <Widget>[
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
                          margin: const EdgeInsets.only(bottom: 32),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: gradientColor,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: gradientColor.last.withOpacity(0.4),
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: const Offset(4, 4),
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.label,
                                        color: CustomColors.primaryContextColor,
                                        size: 24,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        alarm.title!,
                                        style: TextStyle(
                                          color:
                                              CustomColors.primaryContextColor,
                                          fontFamily: 'avenir',
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    'Mon-Fri',
                                    style: TextStyle(
                                      color: CustomColors.primaryContextColor,
                                      fontFamily: 'avenir',
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        alarmTime,
                                        style: TextStyle(
                                          color:
                                              CustomColors.primaryContextColor,
                                          fontFamily: 'avenir',
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      IconButton(
                                          icon: Icon(Icon.delete),
                                          color:
                                              CustomColors.primaryContextColor,
                                          onPressed: () {
                                            deleteAlarm(alarm.id);
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).followedBy([
                        if (_currentAlarms!.length < 5)
                          DottedBorder(
                            strokeWidth: 2,
                            color: CustomColors.clockOutline,
                            borderType: BorderType.RRect,
                            radius: Radius.circular(24),
                            dashPattern: [5, 4],
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: CustomColors.clockBackground,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24)),
                              ),
                              child: MaterialButton(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 16),
                                onPressed: () {
                                  _alarmTimeString = DateFormat('HH:mm')
                                      .format(DateTime.now());
                                  showModalBottomSheet(
                                    useRootNavigator: true,
                                    context: context,
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(24),
                                      ),
                                    ),
                                    builder: (context) {
                                      return StatefulBuilder(
                                        builder: (context, setModalState) {
                                          return Container(
                                            padding: const EdgeInsets.all(32),
                                            child: Column(
                                              children: [
                                                TextButton(
                                                  onPressed: () async {
                                                    var selectedTime =
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                    );
                                                    if (selectedTime != null) {
                                                      final now =
                                                          DateTime.now();
                                                      var selectedDateTime =
                                                          DateTime(
                                                        now.year,
                                                        now.month,
                                                        now.day,
                                                        selectedTime.hour,
                                                        selectedTime.minute,
                                                      );
                                                      _alarmTime =
                                                          selectedDateTime;
                                                      setModalState(() {
                                                        _alarmTimeString =
                                                            DateFormat('HH:mm')
                                                                .format(
                                                                    selectedDateTime);
                                                      });
                                                    }
                                                  },
                                                  child: Text(
                                                    _alarmTimeString,
                                                    style: TextStyle(
                                                      fontSize: 32,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  title: Text('Repeat'),
                                                  trailing: Switch(
                                                    onChanged: (value) {
                                                      setModalState(() {
                                                        _isRepeatSelected =
                                                            value;
                                                      });
                                                    },
                                                    value: _isRepeatSelected,
                                                  ),
                                                ),
                                                ListTile(
                                                  title: Text('Sound'),
                                                  trailing: Icon(
                                                      Icons.arrow_forward_ios),
                                                ),
                                                ListTile(
                                                  title: Text('Title'),
                                                  trailing: Icon(
                                                      Icons.arrow_forward_ios),
                                                ),
                                                FloatingActionButton.extended(
                                                  onPressed: () {
                                                    onSaveAlarm(
                                                        _isRepeatSelected);
                                                  },
                                                  icon: Icons.alarm,
                                                  label: Text('Save'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Column(
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/add.png',
                                      scale: 1.5,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Add Alarm',
                                      style: TextStyle(
                                        color: CustomColors.primaryContextColor,
                                        fontFamily: 'avenir',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        else
                          Center(
                            child: Text(
                              'Only 5 alarms allowed!',
                              style: TextStyle(
                                  color: CustomColors.primaryContextColor),
                            ),
                          ),
                      ]).toList(),
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

  void onSaveAlarm(bool isRepeating) {
    DateTime? scheduleAlarmDateTime;
    if (_alarmTime!.isAfter(DateTime.now())) {
      scheduleAlarmDateTime = _alarmTime;
    } else {
      scheduleAlarmDateTime = _alarmTime!.add(const Duration(days: 1));
    }

    var alarmInfo = AlarmInfo(
      title: 'alarm',
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: _currentAlarms!.length,
    );
    _alarmHelper.insertAlarm(alarmInfo);
    if (scheduleAlarmDateTime != null) {
      NotificationService.scheduledAlarm(scheduleAlarmDateTime, alarmInfo,
          isRepeating: isRepeating);
    }
    Navigator.pop(context);
    loadAlarms();
  }

  void deleteAlarm(int? id) {
    _alarmHelper.delete(id);
    loadAlarms();
  }
}
