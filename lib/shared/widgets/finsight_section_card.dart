import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_shadows.dart';
import '../../app/theme/app_typography.dart';
import '../../core/constants/app_spacing.dart';

/// Rounded white card with an optional title row.
class FinsightSectionCard extends StatelessWidget {
  const FinsightSectionCard({
    super.key,
    required this.child,
    this.title,
    this.trailing,
    this.color = AppColors.surface,
    this.padding = const EdgeInsets.all(AppSpacing.lg + 2),
  });

  final Widget child;
  final String? title;
  final Widget? trailing;
  final Color color;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.6)),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Row(
              children: [
                Expanded(child: Text(title!, style: AppTypography.title)),
                ?trailing,
              ],
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          child,
        ],
      ),
    );
  }
}
