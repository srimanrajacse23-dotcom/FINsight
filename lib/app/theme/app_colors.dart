import 'package:flutter/material.dart';

/// Central FINsight colour palette.
class AppColors {
  AppColors._();

  // Backgrounds & surfaces
  static const Color ivory = Color(0xFFFAF7F0);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color mint = Color(0xFFE6F3EA);
  static const Color mintDeep = Color(0xFFCFE8D9);

  // Brand greens
  static const Color forestDeep = Color(0xFF0A3B2A);
  static const Color forest = Color(0xFF0F4D36);
  static const Color forestMid = Color(0xFF1B6B4A);

  // Indicators
  static const Color positive = Color(0xFF1FA34A);
  static const Color positiveSoft = Color(0xFFDDF3E4);
  static const Color expense = Color(0xFFD92D20);
  static const Color expenseSoft = Color(0xFFFDE8E6);

  // Accents
  static const Color gold = Color(0xFFC9A24B);
  static const Color goldSoft = Color(0xFFF6E8C3);

  // Text
  static const Color textPrimary = Color(0xFF10261C);
  static const Color textSecondary = Color(0xFF5B6B62);
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color textOnDarkMuted = Color(0xFFCFE3D8);

  // Lines
  static const Color border = Color(0xFFE7E2D6);

  // Gradients
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [forestMid, forest, forestDeep],
  );
}
