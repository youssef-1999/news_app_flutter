import 'package:flutter/material.dart';
import 'package:news_app/themes/app_colors.dart';

class AppTheme {
  static final ValueNotifier<ThemeMode> themeMode = ValueNotifier(
    ThemeMode.light,
  );

  static void toggleTheme() {
    themeMode.value = themeMode.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightBgColor,
    dividerColor: AppColors.lightTextColor,
    dividerTheme: const DividerThemeData(
      color: AppColors.lightTextColor,
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.lightBgColor),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightBgColor,
      foregroundColor: AppColors.darkBgColor,
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkBgColor,
    dividerColor: AppColors.lightTextColor,
dividerTheme: const DividerThemeData(
      color: AppColors.lightTextColor,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.darkBgColor,
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBgColor,
      foregroundColor: AppColors.lightBgColor,
    ),
  );
}
