import 'package:flutter/material.dart';

import '../../app/routes.dart';

enum DashboardTab {
  home(
    label: 'Home',
    icon: Icons.home_outlined,
    selectedIcon: Icons.home_rounded,
    pathSegment: AppRoutes.tabHome,
  ),

  pay(
    label: 'Pay',
    icon: Icons.send_outlined,
    selectedIcon: Icons.send_rounded,
    pathSegment: AppRoutes.tabPay,
  ),

  track(
    label: 'Track',
    icon: Icons.analytics_outlined,
    selectedIcon: Icons.analytics_rounded,
    pathSegment: AppRoutes.tabTrack,
  ),

  plan(
    label: 'Plan',
    icon: Icons.event_note_outlined,
    selectedIcon: Icons.event_note_rounded,
    pathSegment: AppRoutes.tabPlan,
  ),

  coach(
    label: 'Coach',
    icon: Icons.auto_awesome_outlined,
    selectedIcon: Icons.auto_awesome,
    pathSegment: AppRoutes.tabCoach,
  );

  const DashboardTab({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.pathSegment,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final String pathSegment;
}
