import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../shared/widgets/finsight_section_card.dart';

class ProfileSelectionPlaceholderScreen extends StatelessWidget {
  const ProfileSelectionPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profiles = ['Personal / Individual', 'Business', 'Freelancer / Professional', 'Merchant'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Choose your profile', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: AppSpacing.lg),
        FinSightSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final profile in profiles)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Text('• $profile'),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
