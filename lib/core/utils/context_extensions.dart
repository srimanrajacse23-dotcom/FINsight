import 'package:flutter/widgets.dart';

import '../responsive/breakpoints.dart';

extension ScreenSizeX on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;

  bool get isMobile => width < AppBreakpoints.mobile;
  bool get isTablet => width >= AppBreakpoints.mobile && width < AppBreakpoints.tablet;
  bool get isDesktop => width >= AppBreakpoints.tablet;
}
