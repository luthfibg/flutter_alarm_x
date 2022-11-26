import 'dart:ffi';

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nfp110/navpages/alarm.dart';
import 'package:nfp110/navpages/clock.dart';
import 'package:nfp110/navpages/our_apps.dart';
import 'package:nfp110/navpages/sensor.dart';
import 'package:nfp110/navpages/timer.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('sc_launcher');
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          requestCriticalPermission: false,
          onDidReceiveLocalNotification: ((id, title, body, payload) async {}));
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Time Management App',
      home: DoubleBack(
          background: Color.fromARGB(255, 71, 71, 71), child: MainPage()),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  final primaryAppColor = const Color.fromARGB(255, 82, 177, 255);
  final secondaryAppColor = CupertinoColors.white;

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      confineInSafeArea: true,
      screens: screens(),
      items: navBarItems(),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0.0),
        colorBehindNavBar: Colors.white,
      ),
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style19,
      backgroundColor: Colors.black,
    );
  }

  List<Widget> screens() {
    return [
      const MyAlarm(),
      const MyTimer(),
      const ClockPage(),
      const MySensor(),
      const OurApps(),
    ];
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.alarm),
        iconSize: 22,
        textStyle: const TextStyle(fontSize: 12),
        title: 'Alarm',
        activeColorPrimary: secondaryAppColor,
        inactiveColorPrimary: primaryAppColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.timer),
        iconSize: 22,
        textStyle: const TextStyle(fontSize: 12),
        title: 'Timer',
        activeColorPrimary: secondaryAppColor,
        inactiveColorPrimary: primaryAppColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.clock),
        iconSize: 32,
        textStyle: const TextStyle(fontSize: 12),
        title: 'Clock',
        activeColorPrimary: secondaryAppColor,
        inactiveColorPrimary: primaryAppColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.sensors),
        iconSize: 22,
        textStyle: const TextStyle(fontSize: 12),
        title: 'Sensor',
        activeColorPrimary: secondaryAppColor,
        inactiveColorPrimary: primaryAppColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.apps),
        iconSize: 22,
        textStyle: const TextStyle(fontSize: 12),
        title: 'From Us',
        activeColorPrimary: secondaryAppColor,
        inactiveColorPrimary: primaryAppColor,
      )
    ];
  }
}
