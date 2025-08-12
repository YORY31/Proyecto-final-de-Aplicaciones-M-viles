import 'package:flutter/material.dart';
import 'app_color.dart';
import './app_text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: const TextTheme(
      displayLarge: AppTextStyles.heading1,
      bodyLarge: AppTextStyles.body,
    ),
  );
}
