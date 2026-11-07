import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_motion.dart';
import '../../app/theme/app_shadows.dart';
import '../../app/theme/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/models/finsight_profile.dart';

/// Selectable profile card used on the profile selection screen.
class FinsightProfileCard extends StatelessWidget {
  const FinsightProfileCard({
    super.key,
    required this.profile,
    required this.selected,
    required this.onTap,
  });

  final FinsightProfile profile;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppMotion.medium,
      curve: AppMotion.standard,
      decoration: BoxDecoration(
        color: selected ? AppColors.mint : AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: selected ? AppColors.forest : AppColors.border,
          width: selected ? 2 : 1,
        ),
        boxShadow: selected ? AppShadows.card : AppShadows.soft,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg + 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: selected ? Colors.white : AppColors.mint,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: Icon(
                        profile.icon,
                        color: AppColors.forest,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md + 2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(profile.title, style: AppTypography.title),
                          const SizedBox(height: 2),
                          Text(profile.tagline, style: AppTypography.caption),
                        ],
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: AppMotion.fast,
                      child: Icon(
                        selected
                            ? Icons.check_circle_rounded
                            : Icons.radio_button_unchecked_rounded,
                        key: ValueKey<bool>(selected),
                        color: selected ? AppColors.forest : AppColors.border,
                        size: 26,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Text(profile.description, style: AppTypography.body),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final h in profile.highlights)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? Colors.white
                              : AppColors.goldSoft.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Text(
                          h,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.forestDeep,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
