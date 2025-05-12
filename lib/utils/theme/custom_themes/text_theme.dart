import 'package:flutter/material.dart';

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTextTheme = const TextTheme(
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black87),
    headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black87),

    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black87),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87),
    titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black87),

    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black87),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black54),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black45),

    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black54),
    labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black45),
  );

  static TextTheme darkTextTheme = const TextTheme(
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white70),
    headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white70),

    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white70),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white70),
    titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white60),

    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white70),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white60),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white54),

    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white70),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white60),
    labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.white54),
  );
}
