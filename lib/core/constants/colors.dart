import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFF6C63FF);
  static const Color secondary = Color(0xFF4A90E2);

  // Status Colors
  static const Color green = Color(0xFF34C759);
  static const Color orange = Color(0xFFFF9500);
  static const Color teal = Color(0xFF5AC8FA);
  static const Color yellow = Color(0xFFFFCC00);

  // Light Theme Colors
  static const Color background = Color(0xFFF5F7FB);
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF1D1D1F);
  static const Color textSecondary = Color(0xFF86868B);

  // Dark Theme Colors
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color textPrimaryDark = Color(0xFFF5F5F7);
  static const Color textSecondaryDark = Color(0xFFAEAEB2);

  // Refined Gradients to match color grading
  static const Gradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFF5D59F1),
      Color(0xFFA894FF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient categoryGradient1 = LinearGradient(
    colors: [Color(0xFFFF7171), Color(0xFFFF9A9E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient categoryGradient2 = LinearGradient(
    colors: [Color(0xFFF6D365), Color(0xFFFDA085)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient categoryGradient3 = LinearGradient(
    colors: [Color(0xFF84FAB0), Color(0xFF8FD3F4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
