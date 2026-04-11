import 'package:flutter/material.dart';
import 'package:news_app/core/gen/fonts.gen.dart';

abstract final class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      fontFamily: FontFamily.satoshi,
      colorScheme: ColorScheme.light(
        primary: const Color(0xFF2F78FF),
        onPrimary: const Color(0xFFFFFFFF),
        secondary: const Color(0xFFC1C1C1),
        onSecondary: const Color(0xFFFFFFFF),
        surface: const Color(0xFFFFFFFF),
      ),
    );
  }
}
