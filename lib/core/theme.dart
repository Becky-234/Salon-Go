import 'package:flutter/material.dart';

class AppColors {
  // Brand
  static const Color primary = Color(0xFF4A1A8C);
  static const Color primaryContainer = Color(0xFF6B2DBF);
  static const Color accent = Color(0xFFF5A623);
  static const Color accentDark = Color(0xFF3D2800);

  // Surfaces
  static const Color background = Color(0xFFFFF8FF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceContainer = Color(0xFFEDE5FF);
  static const Color surfaceContainerLow = Color(0xFFF5F0FF);

  // Text
  static const Color textDark = Color(0xFF1A0A3D);
  static const Color textMid = Color(0xFF4A3570);
  static const Color textGrey = Color(0xFF7B5EA8);

  // Semantic
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFBA1A1A);
  static const Color warning = Color(0xFFF5A623);

  // Sidebar
  static const Color sidebar = Color(0xFF2D1565);
  static const Color sidebarActive = Color(0xFF4A1A8C);

  // Borders
  static const Color outline = Color(0xFF7B5EA8);
  static const Color outlineVariant = Color(0xFFC5AEED);

  // Shadow
  static const Color shadow = Color(0x0F4A1A8C);
}

class AppTextStyles {
  static const TextStyle display = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.02 * 28,
    color: AppColors.textDark,
  );

  static const TextStyle headlineMd = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static const TextStyle bodyLg = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textDark,
  );

  static const TextStyle bodyMd = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textMid,
  );

  static const TextStyle labelCaps = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.05 * 12,
    color: AppColors.textGrey,
  );
}

class AppTheme {
  static ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        fontFamily: 'Inter',
        useMaterial3: true,
      );
}