import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../core/utils/context_extensions.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.isDesktop ? AppSpacing.xl : AppSpacing.lg;
    final maxWidth = context.isDesktop ? 1100.0 : 760.0;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: AppSpacing.lg,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
