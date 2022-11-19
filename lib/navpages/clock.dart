import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nfp110/customs/clock_view.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  final black87a = const Color.fromARGB(221, 26, 26, 26);
  final primaryBlue = const Color.fromARGB(255, 82, 177, 255);

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    var offSetSign = '';
    if (!timezoneString.startsWith('-')) {
      offSetSign = '+';
      print(timezoneString);
    }

    return Scaffold(
      backgroundColor: black87a,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Sensicle',
          style: TextStyle(fontFamily: 'avenir'),
        ),
      ),
      body: Container(
        height: 500,
        width: 500,
        padding: const EdgeInsets.all(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Column(
                  children: [
                    const Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
                    Text(
                      formattedTime,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 999,
                        fontFamily: 'avenir',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FittedBox(
                child: Column(
                  children: [
                    const Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0)),
                    Text(
                      formattedDate,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: 'avenir',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const ClockView(),
            const Expanded(
              child: Text(
                'Time Zone',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: 'avenir',
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  const Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    'UTC $offSetSign$timezoneString',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'avenir',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
