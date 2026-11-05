import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';

class FinSightSectionCard extends StatelessWidget {
  const FinSightSectionCard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: child,
      ),
    );
  }
}
