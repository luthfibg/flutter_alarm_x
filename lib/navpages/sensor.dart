import 'package:flutter/material.dart';

class MySensor extends StatefulWidget {
  const MySensor({super.key});

  @override
  State<MySensor> createState() => _MySensorState();
}

class _MySensorState extends State<MySensor> {
  final black87a = const Color.fromARGB(221, 26, 26, 26);
  final primaryBlue = const Color.fromARGB(255, 82, 177, 255);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black87a,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Distance Sensor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Under Development!',
              style: TextStyle(color: primaryBlue),
            ),
          ],
        ),
      ),
    );
  }
}
