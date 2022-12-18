import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nfp110/customs/clock_view.dart';
import '../customs/theme.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
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
      backgroundColor: CustomColors.backgroundColor,
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).primaryColor,
      //   title: const Text(
      //     'Sensicle',
      //     style: TextStyle(fontFamily: 'avenir'),
      //   ),
      // ),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sensicle',
                          style: TextStyle(
                            color: CustomColors.primaryBlue,
                            fontSize: 28,
                            fontFamily: 'avenir',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedTime,
                          style: TextStyle(
                            color: CustomColors.primaryBlue,
                            fontSize: 64,
                            fontFamily: 'avenir',
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
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
                        Text(
                          'Time Zone',
                          style: TextStyle(
                            color: CustomColors.primaryBlue,
                            fontSize: 22,
                            fontFamily: 'avenir',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.language,
                              color: CustomColors.onfire,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              'UTC $offSetSign$timezoneString',
                              style: TextStyle(
                                color: CustomColors.primaryContextColor,
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
