import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../core/models/finsight_profile.dart';
import '../../core/responsive/finsight_layout.dart';
import '../../mock_data/mock_profiles.dart';
import '../components/finsight_backdrop.dart';
import '../components/finsight_wordmark.dart';
import 'dashboard_tab.dart';

/// Shared responsive frame for every dashboard tab.
class DashboardShell extends StatelessWidget {
  const DashboardShell({
    super.key,
    required this.navigationShell,
    required this.profile,
  });

  static const Key profileLabelKey = Key('dashboard-profile-label');
  static const Key switchProfileKey = Key('dashboard-switch-profile');

  static const double _compactRailWidth = 80;
  static const double _extendedRailWidth = 248;

  final StatefulNavigationShell navigationShell;
  final ProfileType profile;

  int get _selectedIndex => navigationShell.currentIndex;

  String get _profileLabel => MockProfiles.byType(profile).title;

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(index, initialLocation: index == _selectedIndex);
  }

  void _switchProfile(BuildContext context) {
    context.go(AppRoutes.profileSelection);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final formFactor = FinLayout.of(constraints.maxWidth);
        final isMobile = formFactor == FinFormFactor.mobile;

        return Scaffold(
          body: FinsightBackdrop(
            showBottomWaves: false,
            child: SafeArea(
              bottom: !isMobile,
              child: switch (formFactor) {
                FinFormFactor.mobile => SizedBox.expand(child: navigationShell),
                FinFormFactor.tablet => _buildRailLayout(
                  context,
                  extended: false,
                ),
                FinFormFactor.desktop => _buildRailLayout(
                  context,
                  extended: true,
                ),
              },
            ),
          ),
          bottomNavigationBar: isMobile
              ? NavigationBar(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onDestinationSelected,
                  destinations: [
                    for (final tab in DashboardTab.values)
                      NavigationDestination(
                        icon: Icon(tab.icon),
                        selectedIcon: Icon(tab.selectedIcon),
                        label: tab.label,
                      ),
                  ],
                )
              : null,
        );
      },
    );
  }

  Widget _buildRailLayout(BuildContext context, {required bool extended}) {
    final theme = Theme.of(context);

    return Row(
      children: [
        SizedBox(
          width: extended ? _extendedRailWidth : _compactRailWidth,
          child: ColoredBox(
            color: theme.colorScheme.surface,
            child: Column(
              children: [
                Expanded(
                  child: NavigationRail(
                    extended: extended,
                    minWidth: _compactRailWidth,
                    minExtendedWidth: _extendedRailWidth,
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: _onDestinationSelected,
                    labelType: extended
                        ? null
                        : NavigationRailLabelType.selected,
                    leading: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: extended
                          ? const FinsightWordmark(size: 22, showMark: true)
                          : Icon(
                              Icons.account_balance_wallet_rounded,
                              size: 30,
                              color: theme.colorScheme.primary,
                            ),
                    ),
                    destinations: [
                      for (final tab in DashboardTab.values)
                        NavigationRailDestination(
                          icon: Icon(tab.icon),
                          selectedIcon: Icon(tab.selectedIcon),
                          label: Text(tab.label),
                        ),
                    ],
                  ),
                ),
                _buildRailFooter(context, extended: extended),
              ],
            ),
          ),
        ),
        const VerticalDivider(width: 1, thickness: 1),
        Expanded(child: navigationShell),
      ],
    );
  }

  Widget _buildRailFooter(BuildContext context, {required bool extended}) {
    if (!extended) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: IconButton(
          key: switchProfileKey,
          tooltip: 'Switch profile',
          onPressed: () => _switchProfile(context),
          icon: const Icon(Icons.swap_horiz_rounded),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 12, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const SizedBox(height: 12),
          Text(
            _profileLabel,
            key: profileLabelKey,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            key: switchProfileKey,
            onPressed: () => _switchProfile(context),
            icon: const Icon(Icons.swap_horiz_rounded),
            label: const Text('Switch profile'),
          ),
        ],
      ),
    );
  }
}
