import 'package:flutter/material.dart';

class CustomColors {
  static Color primaryContextColor = Colors.white;
  static Color onfire = Colors.red;
  static Color dividerColor = Colors.white54;
  static Color backgroundColor = const Color.fromARGB(221, 26, 26, 26);
  static Color primaryBlue = const Color.fromARGB(255, 82, 177, 255);
  static Color menuBackgroundColor = backgroundColor;

  static Color clockBackground = backgroundColor;
  static Color clockOutline = const Color(0xFFEAECFF);
}

class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);

  static List<Color> sky = [const Color(0xFF6448FE), const Color(0xFF5FC6FF)];
  static List<Color> sunset = [
    const Color(0xFFFE6197),
    const Color(0xFFFFB463)
  ];
  static List<Color> sea = [const Color(0xFF61A3FE), const Color(0xFF63FFD5)];
  static List<Color> mango = [const Color(0xFFFFA738), const Color(0xFFFFE130)];
  static List<Color> fire = [const Color(0xFFFF5DCD), const Color(0xFFFF8484)];
}

class GradientTemplate {
  static List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
  ];
}
