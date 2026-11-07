import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../app/theme/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/responsive/finsight_layout.dart';
import '../../mock_data/mock_profiles.dart';
import '../../shared/components/finsight_primary_button.dart';
import '../../shared/components/finsight_profile_card.dart';
import '../../shared/components/finsight_wordmark.dart';
import 'selected_profile_provider.dart';

/// Four selectable profile cards plus a Continue button.
class ProfileSelectionScreen extends ConsumerWidget {
  const ProfileSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedProfileProvider);
    final columns = FinLayout.formFactor(context) == FinFormFactor.mobile
        ? 1
        : 2;
    final profiles = MockProfiles.all;

    Widget cardFor(int i) {
      final profile = profiles[i];

      return FinsightProfileCard(
        profile: profile,
        selected: selected == profile.type,
        onTap: () =>
            ref.read(selectedProfileProvider.notifier).select(profile.type),
      );
    }

    final List<Widget> cards;

    if (columns == 1) {
      cards = [
        for (var i = 0; i < profiles.length; i++) ...[
          cardFor(i),
          const SizedBox(height: AppSpacing.md),
        ],
      ];
    } else {
      cards = [];

      for (var i = 0; i < profiles.length; i += columns) {
        final end = math.min(i + columns, profiles.length);

        cards.add(
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var j = i; j < end; j++) ...[
                  Expanded(child: cardFor(j)),
                  if (j < end - 1) const SizedBox(width: AppSpacing.md),
                ],
              ],
            ),
          ),
        );

        cards.add(const SizedBox(height: AppSpacing.md));
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.page,
        vertical: AppSpacing.lg,
      ),
      child: FinContentFrame(
        maxWidth: columns == 1 ? FinLayout.formMaxWidth : 900,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  tooltip: 'Back',
                  onPressed: () => context.go(AppRoutes.home),
                  icon: const Icon(Icons.arrow_back_rounded),
                ),
                const SizedBox(width: AppSpacing.sm),
                const FinsightWordmark(size: 26),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            const Text('Choose your profile', style: AppTypography.headline),
            const SizedBox(height: AppSpacing.sm),
            const Text(
              'Pick the experience that fits how you use money. '
              'You can switch later.',
              style: AppTypography.body,
            ),
            const SizedBox(height: AppSpacing.xl),
            ...cards,
            const SizedBox(height: AppSpacing.md),
            FinsightPrimaryButton(
              label: 'Continue',
              trailingIcon: Icons.arrow_forward_rounded,
              onPressed: selected == null
                  ? null
                  : () => context.go(MockProfiles.byType(selected).routePath),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
