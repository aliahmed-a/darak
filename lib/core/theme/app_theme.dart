import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const seedColor = Color(0xFF3949AB);
  static const _lightBackground = Color(0xFFF5F5F9);
  static const _lightSurface = Colors.white;
  static const _darkBackground = Color(0xFF11131F);
  static const _darkSurface = Color(0xFF1B1E30);

  /// Brand hero gradient for elevated surfaces (splash screen, dashboard
  /// balance card). Hardcoded rather than derived from [ColorScheme] so it
  /// stays rich/saturated regardless of what `fromSeed` produces for dark
  /// mode (which tends to desaturate/lighten the primary color).
  static const heroGradientLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2C3B8C), Color(0xFF4C63D2)],
  );

  static const heroGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A2159), Color(0xFF34428C)],
  );

  static LinearGradient heroGradient(Brightness brightness) =>
      brightness == Brightness.dark ? heroGradientDark : heroGradientLight;

  static ThemeData get light => _build(
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
        background: _lightBackground,
        surface: _lightSurface,
      );

  static ThemeData get dark => _build(
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.dark),
        background: _darkBackground,
        surface: _darkSurface,
      );

  static TextTheme _textTheme(TextTheme base) {
    return base.copyWith(
      headlineSmall: base.headlineSmall?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.5),
      titleLarge: base.titleLarge?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.3),
      titleMedium: base.titleMedium?.copyWith(fontWeight: FontWeight.w700),
      titleSmall: base.titleSmall?.copyWith(fontWeight: FontWeight.w600),
      bodyLarge: base.bodyLarge?.copyWith(height: 1.4),
      bodyMedium: base.bodyMedium?.copyWith(height: 1.4),
      labelLarge: base.labelLarge?.copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.2),
    );
  }

  static ThemeData _build({
    required ColorScheme colorScheme,
    required Color background,
    required Color surface,
  }) {
    final base = ThemeData(useMaterial3: true, colorScheme: colorScheme);

    return base.copyWith(
      scaffoldBackgroundColor: background,
      textTheme: _textTheme(base.textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.4,
          color: colorScheme.onSurface,
        ),
        toolbarHeight: 64,
      ),
      cardTheme: CardThemeData(
        elevation: 1.5,
        color: surface,
        surfaceTintColor: Colors.transparent,
        shadowColor: colorScheme.shadow.withValues(alpha: 0.12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: colorScheme.primaryContainer,
        elevation: 0,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => base.textTheme.labelSmall?.copyWith(
            fontWeight: states.contains(WidgetState.selected) ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
