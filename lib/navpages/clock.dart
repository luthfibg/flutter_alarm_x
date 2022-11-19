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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedTime,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 64,
                            fontFamily: 'avenir',
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'avenir',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 6,
                    fit: FlexFit.tight,
                    child: Align(
                      alignment: Alignment.center,
                      child: ClockView(
                        size: MediaQuery.of(context).size.height / 3,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Time Zone',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: 'avenir',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
