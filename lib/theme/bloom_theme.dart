import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloom_colors.dart';

abstract final class BloomTheme {
  static ThemeData get light {
    final colorScheme = const ColorScheme.light(
      primary: BloomColors.primary,
      onPrimary: BloomColors.onPrimary,
      primaryContainer: BloomColors.primaryContainer,
      onPrimaryContainer: BloomColors.onPrimaryContainer,
      secondary: BloomColors.secondary,
      onSecondary: BloomColors.onSecondary,
      secondaryContainer: BloomColors.secondaryContainer,
      onSecondaryContainer: BloomColors.onSecondaryContainer,
      tertiary: BloomColors.tertiary,
      onTertiary: BloomColors.onTertiary,
      tertiaryContainer: BloomColors.tertiaryContainer,
      surface: BloomColors.surface,
      onSurface: BloomColors.onSurface,
      onSurfaceVariant: BloomColors.onSurfaceVariant,
      outline: BloomColors.outline,
      outlineVariant: BloomColors.outlineVariant,
      error: BloomColors.error,
      errorContainer: BloomColors.errorContainer,
    );

    final serif = GoogleFonts.notoSerifTextTheme();
    final sans = GoogleFonts.beVietnamProTextTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: BloomColors.background,
      textTheme: sans.copyWith(
        displayLarge: serif.displayLarge?.copyWith(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          height: 44 / 36,
          letterSpacing: -0.72,
          color: BloomColors.primary,
        ),
        displayMedium: serif.displayMedium?.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          height: 34 / 28,
          color: BloomColors.primary,
        ),
        headlineMedium: serif.headlineMedium?.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          height: 32 / 24,
          color: BloomColors.onSurface,
        ),
        headlineSmall: serif.headlineSmall?.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 28 / 20,
          color: BloomColors.onSurface,
        ),
        bodyLarge: sans.bodyLarge?.copyWith(
          fontSize: 18,
          height: 28 / 18,
          color: BloomColors.onSurface,
        ),
        bodyMedium: sans.bodyMedium?.copyWith(
          fontSize: 16,
          height: 24 / 16,
          color: BloomColors.onSurface,
        ),
        bodySmall: sans.bodySmall?.copyWith(
          fontSize: 14,
          height: 20 / 14,
          color: BloomColors.onSurfaceVariant,
        ),
        labelLarge: sans.labelLarge?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.14,
        ),
        labelSmall: sans.labelSmall?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.24,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: BloomColors.surface,
        foregroundColor: BloomColors.primary,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: true,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: BloomColors.primary,
          foregroundColor: BloomColors.onPrimary,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.beVietnamPro(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: BloomColors.surfaceContainer,
        indicatorColor: BloomColors.secondaryContainer,
        labelTextStyle: WidgetStatePropertyAll(
          GoogleFonts.beVietnamPro(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
      cardTheme: CardThemeData(
        color: BloomColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: BloomColors.outlineVariant.withValues(alpha: 0.35)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: BloomColors.card,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: const BorderSide(color: BloomColors.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: const BorderSide(color: BloomColors.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: const BorderSide(color: BloomColors.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
    );
  }
}
