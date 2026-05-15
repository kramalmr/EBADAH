import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF9F9F5);
  static const Color green = Color(0xFF60A856);
  static const Color darkGreen = Color(0xFF57984E);
  static const Color black = Color(0xFF1F1F1F);
  static const Color offBlack = Color(0xFF202020);
  static const Color offGray = Color(0xFF373737);
  static const Color slightGray = Color(0xFFE6E8EA);
  static const Color gray = Color(0xFF646464);
}

class AppTheme {
  static final TextTheme baseText = GoogleFonts.interTextTheme();
  static ThemeData light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.offWhite,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      surface: AppColors.pureWhite,
      primary: AppColors.green,
      secondary: AppColors.slightGray,
      tertiary: AppColors.gray,
    ),
  );
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.black,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      surface: AppColors.offBlack,
      primary: AppColors.green,
      secondary: AppColors.offGray,
      tertiary: AppColors.offWhite,
    ),
  );
}
