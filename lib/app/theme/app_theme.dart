import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import 'app_colors.dart';

abstract final class AppTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.ivory,
    colorScheme: const ColorScheme.light(
      primary: AppColors.forestGreen,
      secondary: AppColors.paleSage,
      surface: AppColors.card,
      onSurface: AppColors.ink,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink),
      titleLarge: TextStyle(fontWeight: FontWeight.w600, color: AppColors.ink),
      bodyLarge: TextStyle(height: 1.5, color: AppColors.ink),
      bodyMedium: TextStyle(height: 1.5, color: AppColors.ink),
    ),
    cardTheme: const CardThemeData(
      color: AppColors.card,
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSpacing.radiusLg)),
        side: BorderSide(color: AppColors.border),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.ink,
      elevation: 0,
      centerTitle: false,
    ),
  );
}
