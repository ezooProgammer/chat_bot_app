import 'package:flutter/material.dart';

class ThemeApp {
  ThemeApp._();

  static ThemeData themeApp() {
    return ThemeData(
      fontFamily: 'Cairo',
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFe42a50),
        brightness: Brightness.light,
      ),
    );
  }
}