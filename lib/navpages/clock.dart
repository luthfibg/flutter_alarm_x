import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: black87a,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Sensicle'),
      ),
      body: SizedBox(
        child: Column(
          children: const [
            Expanded(
              child: Text(
                'Clock',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ClockView(),
          ],
        ),
      ),
    );
  }
}
