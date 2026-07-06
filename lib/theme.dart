import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color background = Color(0xFF070D1F);
  static const Color surface = Color(0xFF0C1324);
  static const Color surfaceContainer = Color(0xFF191F31);
  static const Color surfaceContainerLow = Color(0xFF151B2D);
  static const Color surfaceContainerLowest = Color(0xFF070D1F);
  static const Color surfaceContainerHigh = Color(0xFF23293C);
  static const Color primary = Color(0xFF22D3EE); // Cyan
  static const Color secondary = Color(0xFF45DFA4); // Emerald
  static const Color onBackground = Color(0xFFDCE1FB);
  static const Color onSurface = Color(0xFFDCE1FB);
  static const Color onSurfaceVariant = Color(0xFF94A3B8); // Slate-gray secondary labels
  static const Color outline = Color(0xFF859397);
  static const Color outlineVariant = Color(0xFF1E293B);
  
  static const Color error = Color(0xFFFFB4AB);
  static const Color textWhite = Colors.white;
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: Color(0xFF00363E),
        onSecondary: Color(0xFF003825),
        onSurface: AppColors.onSurface,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.inter(
          fontSize: 48,
          fontWeight: FontWeight.w800,
          height: 1.1,
          letterSpacing: -0.96, // -0.02em
          color: AppColors.textWhite,
        ),
        headlineLarge: GoogleFonts.inter(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          height: 1.2,
          letterSpacing: -0.32, // -0.01em
          color: AppColors.textWhite,
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          height: 1.3,
          color: AppColors.textWhite,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          height: 1.6,
          color: AppColors.onSurfaceVariant,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          height: 1.6,
          color: AppColors.onSurfaceVariant,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.6, // 0.05em
          color: AppColors.primary,
        ),
      ),
    );
  }

  // Custom text style helper for JetBrains Mono code
  static TextStyle codeStyle({
    double fontSize = 14,
    Color color = AppColors.onSurface,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      height: 1.5,
    );
  }
}
