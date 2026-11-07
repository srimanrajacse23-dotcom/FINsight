import 'package:flutter/material.dart';

import '../components/finsight_backdrop.dart';

/// Common page frame: ivory backdrop, safe area, optional bottom waves.
class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.child,
    this.showBottomWaves = false,
  });

  final Widget child;
  final bool showBottomWaves;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FinsightBackdrop(
        showBottomWaves: showBottomWaves,
        child: SafeArea(child: child),
      ),
    );
  }
}
