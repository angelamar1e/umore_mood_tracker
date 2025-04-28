import 'package:flutter/material.dart';

class AppColors {
  static const Color mainColor = Color(0xFF4169E1);
  static const Color secondaryColor = Color(0xFF87CEEB);
  static const Color contentColorRed = Color(0xFFFF6347);
  static const Color contentColorOrange = Color(0xFFFFA500);
  static const Color contentColorYellow = Color(0xFFFFD700);
  static const Color contentColorGrey = Color(0xFFA9A9A9);
  static const Color contentColorGreen = Color(0xFF32CD32);
}

BoxDecoration gradientBackground() => BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF87CEEB), Color(0xFF4169E1)],
  ),
);
