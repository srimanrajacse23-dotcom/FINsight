import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../shared/widgets/finsight_section_card.dart';

class ProfileSelectionPlaceholderScreen extends StatelessWidget {
  const ProfileSelectionPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profiles = ['Personal / Individual', 'Business', 'Freelancer / Professional', 'Merchant'];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 900;
        final tileWidth = isDesktop ? 280.0 : double.infinity;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose your profile', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.lg),
            FinSightSectionCard(
              child: Wrap(
                spacing: AppSpacing.md,
                runSpacing: AppSpacing.md,
                children: [
                  for (final profile in profiles)
                    SizedBox(
                      width: tileWidth,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).dividerColor),
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          child: Text(profile),
                        ),
                      ),
                    ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
