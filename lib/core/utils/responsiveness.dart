import 'package:flutter/material.dart';

const double _designWidth = 375.0;
const double _designHeight = 812.0;

class AppBreakpoints {
  static const double tablet = 600;
}

/// 2. ADD THE EXTENSIONS
extension ResponsiveSize on num {
  /// Calculate width relative to the screen width
  /// Usage: 50.w  (If screen is double the design width, this becomes 100)
  double w(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return (this / _designWidth) * screenWidth;
  }

  /// Calculate height relative to the screen height
  /// Usage: 200.h
  double h(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    return (this / _designHeight) * screenHeight;
  }

  /// Calculate font size (sp - Scalable Pixel)
  /// Usage: 16.sp
  double sp(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    // Scale text based on width but clamp it so it doesn't get too huge on tablets
    double scaleFactor = screenWidth / _designWidth;
    if (scaleFactor > 1.5) scaleFactor = 1.5; // Cap scaling for tablets
    return this * scaleFactor;
  }
}

extension ResponsiveContext on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;
  bool get isMobile => width < AppBreakpoints.tablet;
  bool get isTablet => width >= AppBreakpoints.tablet;
}