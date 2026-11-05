import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';
import '../../core/constants/app_spacing.dart';
import '../../shared/components/finsight_primary_button.dart';
import '../../shared/widgets/finsight_section_card.dart';

class OnboardingPlaceholderScreen extends StatelessWidget {
  const OnboardingPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Welcome to FINsight', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Unified Intelligent Financial Management Platform',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: AppSpacing.lg),
        const FinSightSectionCard(
          child: Text(
            'This is a foundational placeholder screen. Dashboards for Personal, Business, Freelancer and Merchant profiles will be added in upcoming iterations using mock financial data only.',
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        FinSightPrimaryButton(
          label: 'Continue to Profile Selection',
          onPressed: () => context.go(AppRoutes.profileSelection),
        ),
      ],
    );
  }
}
