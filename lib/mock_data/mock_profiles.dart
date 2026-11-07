import 'package:flutter/material.dart';

import '../core/models/finsight_profile.dart';

/// Simulated profile data (V1 has no real accounts or money movement).
class MockProfiles {
  MockProfiles._();

  static const List<FinsightProfile> all = [
    FinsightProfile(
      type: ProfileType.personal,
      title: 'Personal',
      tagline: 'Everyday money, simplified',
      description: 'Track spending, plan budgets and grow your savings.',
      icon: Icons.person_rounded,
      highlights: ['Budgets & goals', 'Gold', 'Insurance'],
    ),
    FinsightProfile(
      type: ProfileType.business,
      title: 'Business',
      tagline: 'Run your company finances',
      description: 'Manage cash flow, payables and team spending in one place.',
      icon: Icons.business_center_rounded,
      highlights: ['Cash flow', 'Invoices', 'Reports'],
    ),
    FinsightProfile(
      type: ProfileType.freelancer,
      title: 'Freelancer / Professional',
      tagline: 'Income that moves with you',
      description: 'Handle irregular income, clients and tax set-asides.',
      icon: Icons.laptop_mac_rounded,
      highlights: ['Client payments', 'Tax pots', 'Income trends'],
    ),
    FinsightProfile(
      type: ProfileType.merchant,
      title: 'Merchant',
      tagline: 'Sell, collect and settle',
      description: 'Accept simulated payments and watch daily sales.',
      icon: Icons.storefront_rounded,
      highlights: ['Scan & collect', 'Daily sales', 'Settlements'],
    ),
  ];

  static FinsightProfile byType(ProfileType type) =>
      all.firstWhere((p) => p.type == type);
}
