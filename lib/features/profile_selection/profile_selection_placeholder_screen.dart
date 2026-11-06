
import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../shared/widgets/finsight_section_card.dart';

class ProfileSelectionPlaceholderScreen extends StatelessWidget {
  const ProfileSelectionPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profiles = [
      'Personal / Individual',
      'Business',
      'Freelancer / Professional',
      'Merchant',
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose your profile',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
          FinSightSectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final profile in profiles)
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppSpacing.md,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).dividerColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusMd,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Text(profile),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
