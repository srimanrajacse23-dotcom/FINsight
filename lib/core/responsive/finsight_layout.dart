import 'package:flutter/material.dart';

enum FinFormFactor { mobile, tablet, desktop }

/// Responsive helpers for FINsight screens.
class FinLayout {
  FinLayout._();

  static const double tabletMin = 600;
  static const double desktopMin = 1024;

  static const double formMaxWidth = 520;
  static const double contentMaxWidth = 1120;

  static FinFormFactor of(double width) {
    if (width >= desktopMin) return FinFormFactor.desktop;
    if (width >= tabletMin) return FinFormFactor.tablet;
    return FinFormFactor.mobile;
  }

  static FinFormFactor formFactor(BuildContext context) =>
      of(MediaQuery.sizeOf(context).width);
}

/// Centres [child] horizontally and caps its width at [maxWidth].
///
/// The child always receives a tight, finite width, making it safe to use
/// Expanded, full-width buttons and cards inside the frame.
class FinContentFrame extends StatelessWidget {
  const FinContentFrame({
    super.key,
    required this.child,
    this.maxWidth = FinLayout.contentMaxWidth,
  }) : assert(maxWidth > 0 && maxWidth < double.infinity);

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: SizedBox(width: double.infinity, child: child),
      ),
    );
  }
}
