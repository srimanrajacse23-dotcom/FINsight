import 'package:flutter/material.dart';

import '../../core/models/finsight_profile.dart';
import '../../mock_data/mock_profiles.dart';
import '../../shared/navigation/dashboard_tab.dart';

class DashboardTabPlaceholder extends StatelessWidget {
  const DashboardTabPlaceholder({
    super.key,
    required this.tab,
    required this.profile,
  });

  final DashboardTab tab;
  final ProfileType profile;

  /// Identifies the visible placeholder for a profile and tab.
  /// Tests use this to check both the tab and profile context.
  static Key keyFor(ProfileType profile, DashboardTab tab) =>
      ValueKey<String>('dashboard-placeholder-${profile.name}-${tab.name}');

  String get profileLabel => MockProfiles.byType(profile).title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      key: keyFor(profile, tab),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  tab.selectedIcon,
                  size: 36,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                tab.label,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$profileLabel dashboard',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'This section is being prepared. '
                'Your ${tab.label.toLowerCase()} experience '
                'will appear here.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'FINsight · Simulated environment',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
