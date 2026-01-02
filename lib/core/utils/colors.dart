import 'package:flutter/material.dart';

class AppColors {
  // Main colors - Professional SaaS palette
  static const Color primary = Color(0xFF4361EE); // Professional blue
  static const Color primaryLight = Color(0xFF4895EF); // Light blue
  static const Color primaryDark = Color(0xFF3A0CA3); // Dark blue
  static const Color secondary = Color(0xFF4CC9F0); // Cyan for accents
  static const Color accent = Color(0xFF7209B7); // Violet for CTAs

  // States and feedback
  static const Color error = Color(0xFFED434C); // Red from logo
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFFCBD2A); // Orange from logo
  static const Color info = Color(0xFF3C85EC);

  // Gray levels for text and backgrounds
  static const Color light = Color(0xFFF8F9FA); // Light background
  static const Color dark = Color(0xFF212529); // Dark text
  static const Color lightGrey = Color(0xFFE9ECEF);
  static const Color black = Colors.black;
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color white = Color(0xFFFFFFFF);

  // Project-specific colors
  static const Color projectPlanning = Color(0xFF4CC9F0); // Planning
  static const Color projectInProgress = Color(0xFF4361EE); // In progress
  static const Color projectCompleted = Color(0xFF4CAF50); // Completed
  static const Color projectOnHold = Color(0xFFFFB74D); // On hold
  static const Color projectCancelled = Color(0xFFF44336); // Cancelled

  // Colors for charts and graphs
  static const List<Color> chartColors = [
    Color(0xFF4361EE),
    Color(0xFF4895EF),
    Color(0xFF4CC9F0),
    Color(0xFF7209B7),
    Color(0xFF3A0CA3),
    Color(0xFF4CAF50),
    Color(0xFFFFB74D),
    Color(0xFFF44336),
  ];

  // Dark theme
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkCard = Color(0xFF1E1E1E);
  static const Color darkSurface = Color(0xFF242627);

  // Transparencies
  static const Color primaryWithOpacity10 = Color(0x1A4361EE);
  static const Color primaryWithOpacity20 = Color(0x334361EE);
  static const Color darkWithOpacity50 = Color(0x80212529);

  // Social Colors
  static const Color googleRed = Color(0xFFDB4437);
  static const Color facebookBlue = Color(0xFF4267B2);
  static const Color appleBlack = Color(0xFF000000);

  // Chat specific
  static const Color chatBubbleSent = Color(0xFF9F4895);
}
