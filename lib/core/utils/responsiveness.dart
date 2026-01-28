/// Handel Responsiveness

import 'package:flutter/material.dart';

/// Defines the layout breakpoints used across the app.
/// 600px is the industry standard split for 7-inch tablets vs phones.
class AppBreakpoints {
  static const double tablet = 600;
}

/// Handy extensions to make responsive logic cleaner in the UI.
/// Usage: if (context.isTablet) ...
extension ResponsiveContext on BuildContext {

  // Performance tip: using sizeOf is slightly more efficient than .of().size
  // because it only rebuilds if the *size* changes, not other Query data.
  double get width => MediaQuery.sizeOf(this).width;

  /// Returns TRUE for phones (iPhone, Pixel, etc.)
  bool get isMobile => width < AppBreakpoints.tablet;

  /// Returns TRUE for tablets (iPad, Galaxy Tab)
  bool get isTablet => width >= AppBreakpoints.tablet;

  /// Calculates how many columns to show in the Masonry Grid.
  /// Pinterest standard:
  /// - 2 columns on phones
  /// - 3 columns on small tablets/portrait
  /// - 4 columns on large tablets/landscape
  int get gridColumnCount {
    if (width > 840) return 4; // iPad Pro / Large Landscape
    if (width > 600) return 3; // iPad Mini / Standard Tablet
    return 2;                  // Standard Phone view
  }
}