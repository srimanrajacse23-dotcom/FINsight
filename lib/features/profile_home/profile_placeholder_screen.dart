import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/models/finsight_profile.dart';
import '../../core/responsive/finsight_layout.dart';
import '../../mock_data/mock_profiles.dart';
import '../../shared/components/finsight_hero_card.dart';
import '../../shared/components/finsight_primary_button.dart';
import '../../shared/components/finsight_wordmark.dart';
import '../../shared/widgets/finsight_section_card.dart';

/// One shared placeholder destination for all four profiles.
class ProfilePlaceholderScreen extends StatelessWidget {
  const ProfilePlaceholderScreen({super.key, required this.type});

  final ProfileType type;

  @override
  Widget build(BuildContext context) {
    final profile = MockProfiles.byType(type);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.page,
        vertical: AppSpacing.lg,
      ),
      child: FinContentFrame(
        maxWidth: FinLayout.formMaxWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FinsightWordmark(size: 26),
            const SizedBox(height: AppSpacing.xl),
            FinsightHeroCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Icon(profile.icon, color: AppColors.gold, size: 28),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'You are in as',
                    style: AppTypography.body.copyWith(
                      color: AppColors.textOnDarkMuted,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    profile.title,
                    style: AppTypography.headline.copyWith(
                      color: AppColors.textOnDark,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    profile.tagline,
                    style: AppTypography.body.copyWith(
                      color: AppColors.textOnDarkMuted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            FinsightSectionCard(
              title: 'Dashboard coming soon',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(profile.description, style: AppTypography.body),
                  const SizedBox(height: AppSpacing.md),
                  for (final h in profile.highlights)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.positive,
                            size: 20,
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Text(h, style: AppTypography.subtitle),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            FinsightPrimaryButton(
              label: 'Switch profile',
              leadingIcon: Icons.swap_horiz_rounded,
              variant: FinsightButtonVariant.tonal,
              onPressed: () => context.go(AppRoutes.profileSelection),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
