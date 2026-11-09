import 'package:flutter/material.dart';

/// Central brand palette for the Topitup Retailer app.
///
/// Every color used by the app should come from here so that no default
/// Flutter/Material colors (for example the default blue) leak into the UI.
class AppColors {
  const AppColors._();

  // Brand
  static const Color brandRed = Color(0xFFC8102E);
  static const Color brandRedDark = Color(0xFF9A0C23);
  static const Color brandRedLight = Color(0xFFE11D3A);
  static const Color brandRedSoft = Color(0xFFFCE4E8);

  // Neutral
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF8F8F8);
  static const Color ink = Color(0xFF1A1A1A);
  static const Color inkMuted = Color(0xFF5F6368);

  static const Color grey100 = Color(0xFFF2F2F2);
  static const Color grey200 = Color(0xFFE6E6E6);
  static const Color grey300 = Color(0xFFD0D0D0);
  static const Color grey500 = Color(0xFF8A8A8A);

  // Dark surfaces
  static const Color darkSurface = Color(0xFF121212);
  static const Color darkSurfaceElevated = Color(0xFF1E1E1E);
  static const Color darkOutline = Color(0xFF3A3A3A);

  // Feedback
  static const Color error = Color(0xFFBA1A1A);
  static const Color success = Color(0xFF1B873F);
  static const Color warning = Color(0xFFB26A00);
}
