import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Shared elevation and shadow styles for FINsight.
class AppShadows {
  AppShadows._();

  static final List<BoxShadow> card = [
    BoxShadow(
      color: AppColors.forestDeep.withValues(alpha: 0.06),
      blurRadius: 20,
      offset: const Offset(0, 6),
    ),
  ];

  static final List<BoxShadow> soft = [
    BoxShadow(
      color: AppColors.forestDeep.withValues(alpha: 0.04),
      blurRadius: 28,
      offset: const Offset(0, 10),
    ),
  ];

  static final List<BoxShadow> hero = [
    BoxShadow(
      color: AppColors.forestDeep.withValues(alpha: 0.28),
      blurRadius: 32,
      offset: const Offset(0, 16),
    ),
  ];

  static final List<BoxShadow> button = [
    BoxShadow(
      color: AppColors.forestDeep.withValues(alpha: 0.22),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];
}
