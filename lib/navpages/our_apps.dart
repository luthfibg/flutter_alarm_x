import 'package:flutter/material.dart';

class OurApps extends StatelessWidget {
  const OurApps({super.key});

  final black87a = const Color.fromARGB(221, 26, 26, 26);
  final primaryBlue = const Color.fromARGB(255, 82, 177, 255);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black87a,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Our Apps'),
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
