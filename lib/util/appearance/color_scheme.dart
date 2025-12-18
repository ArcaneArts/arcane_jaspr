import 'colors.dart';

/// Brightness mode
enum Brightness { light, dark }

/// Theme mode
enum ThemeMode {
  system,
  light,
  dark;

  Brightness get brightness {
    switch (this) {
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.system:
        // In Jaspr, we'll default to dark or detect via JS
        return Brightness.dark;
    }
  }
}

/// Accent color theme for Supabase-style theming
enum AccentTheme {
  /// Emerald green (Supabase default)
  emerald,
  /// Cyan / Teal
  cyan,
  /// Purple / Violet
  violet,
  /// Orange / Amber
  amber;

  /// Get the primary color for this accent in dark mode
  Color get primaryDark {
    switch (this) {
      case AccentTheme.emerald:
        return Colors.emerald500;
      case AccentTheme.cyan:
        return Colors.cyan500;
      case AccentTheme.violet:
        return Colors.violet500;
      case AccentTheme.amber:
        return Colors.amber500;
    }
  }

  /// Get the primary color for this accent in light mode
  Color get primaryLight {
    switch (this) {
      case AccentTheme.emerald:
        return Colors.emerald600;
      case AccentTheme.cyan:
        return Colors.cyan600;
      case AccentTheme.violet:
        return Colors.violet600;
      case AccentTheme.amber:
        return Colors.amber600;
    }
  }

  /// Get the hover color for this accent in dark mode
  Color get hoverDark {
    switch (this) {
      case AccentTheme.emerald:
        return Colors.emerald400;
      case AccentTheme.cyan:
        return Colors.cyan400;
      case AccentTheme.violet:
        return Colors.violet400;
      case AccentTheme.amber:
        return Colors.amber400;
    }
  }

  /// Get the hover color for this accent in light mode
  Color get hoverLight {
    switch (this) {
      case AccentTheme.emerald:
        return Colors.emerald700;
      case AccentTheme.cyan:
        return Colors.cyan700;
      case AccentTheme.violet:
        return Colors.violet700;
      case AccentTheme.amber:
        return Colors.amber700;
    }
  }

  /// Get the muted/container color for this accent in dark mode
  Color get containerDark {
    switch (this) {
      case AccentTheme.emerald:
        return Colors.emerald950;
      case AccentTheme.cyan:
        return Colors.cyan950;
      case AccentTheme.violet:
        return Colors.violet950;
      case AccentTheme.amber:
        return Colors.amber950;
    }
  }

  /// Get the muted/container color for this accent in light mode
  Color get containerLight {
    switch (this) {
      case AccentTheme.emerald:
        return Colors.emerald100;
      case AccentTheme.cyan:
        return Colors.cyan100;
      case AccentTheme.violet:
        return Colors.violet100;
      case AccentTheme.amber:
        return Colors.amber100;
    }
  }
}

/// Color scheme for theming
class ColorScheme {
  final Brightness brightness;
  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color onInverseSurface;
  final Color inversePrimary;
  final Color surfaceTint;

  const ColorScheme({
    required this.brightness,
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.onInverseSurface,
    required this.inversePrimary,
    required this.surfaceTint,
  });

  /// Create a light color scheme
  factory ColorScheme.light({
    Color primary = const Color(0xFF6366F1),
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? tertiary,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color error = const Color(0xFFDC2626),
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? outline,
    Color? outlineVariant,
    Color? shadow,
    Color? scrim,
    Color? inverseSurface,
    Color? onInverseSurface,
    Color? inversePrimary,
    Color? surfaceTint,
  }) {
    return ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: onPrimary ?? Colors.white,
      primaryContainer: primaryContainer ?? primary.lighten(40),
      onPrimaryContainer: onPrimaryContainer ?? primary.darken(30),
      secondary: secondary ?? Colors.slate600,
      onSecondary: onSecondary ?? Colors.white,
      secondaryContainer: secondaryContainer ?? Colors.slate200,
      onSecondaryContainer: onSecondaryContainer ?? Colors.slate900,
      tertiary: tertiary ?? Colors.teal,
      onTertiary: onTertiary ?? Colors.white,
      tertiaryContainer: tertiaryContainer ?? const Color(0xFFB2DFDB),
      onTertiaryContainer: onTertiaryContainer ?? const Color(0xFF004D40),
      error: error,
      onError: onError ?? Colors.white,
      errorContainer: errorContainer ?? const Color(0xFFFEE2E2),
      onErrorContainer: onErrorContainer ?? const Color(0xFF7F1D1D),
      background: background ?? Colors.gray50,
      onBackground: onBackground ?? Colors.gray900,
      surface: surface ?? Colors.white,
      onSurface: onSurface ?? Colors.gray900,
      surfaceVariant: surfaceVariant ?? Colors.gray100,
      onSurfaceVariant: onSurfaceVariant ?? Colors.gray700,
      outline: outline ?? Colors.gray400,
      outlineVariant: outlineVariant ?? Colors.gray200,
      shadow: shadow ?? Colors.black,
      scrim: scrim ?? Colors.black,
      inverseSurface: inverseSurface ?? Colors.gray900,
      onInverseSurface: onInverseSurface ?? Colors.gray50,
      inversePrimary: inversePrimary ?? primary.lighten(20),
      surfaceTint: surfaceTint ?? primary,
    );
  }

  /// Create a dark color scheme
  factory ColorScheme.dark({
    Color primary = const Color(0xFF818CF8),
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? tertiary,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color error = const Color(0xFFF87171),
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? outline,
    Color? outlineVariant,
    Color? shadow,
    Color? scrim,
    Color? inverseSurface,
    Color? onInverseSurface,
    Color? inversePrimary,
    Color? surfaceTint,
  }) {
    return ColorScheme(
      brightness: Brightness.dark,
      primary: primary,
      onPrimary: onPrimary ?? Colors.gray900,
      primaryContainer: primaryContainer ?? primary.darken(30),
      onPrimaryContainer: onPrimaryContainer ?? primary.lighten(30),
      secondary: secondary ?? Colors.slate400,
      onSecondary: onSecondary ?? Colors.slate900,
      secondaryContainer: secondaryContainer ?? Colors.slate700,
      onSecondaryContainer: onSecondaryContainer ?? Colors.slate100,
      tertiary: tertiary ?? const Color(0xFF4DB6AC),
      onTertiary: onTertiary ?? Colors.gray900,
      tertiaryContainer: tertiaryContainer ?? const Color(0xFF004D40),
      onTertiaryContainer: onTertiaryContainer ?? const Color(0xFFB2DFDB),
      error: error,
      onError: onError ?? Colors.gray900,
      errorContainer: errorContainer ?? const Color(0xFF7F1D1D),
      onErrorContainer: onErrorContainer ?? const Color(0xFFFEE2E2),
      background: background ?? Colors.gray950,
      onBackground: onBackground ?? Colors.gray50,
      surface: surface ?? Colors.gray900,
      onSurface: onSurface ?? Colors.gray50,
      surfaceVariant: surfaceVariant ?? Colors.gray800,
      onSurfaceVariant: onSurfaceVariant ?? Colors.gray300,
      outline: outline ?? Colors.gray600,
      outlineVariant: outlineVariant ?? Colors.gray700,
      shadow: shadow ?? Colors.black,
      scrim: scrim ?? Colors.black,
      inverseSurface: inverseSurface ?? Colors.gray100,
      onInverseSurface: onInverseSurface ?? Colors.gray900,
      inversePrimary: inversePrimary ?? primary.darken(20),
      surfaceTint: surfaceTint ?? primary,
    );
  }

  /// Copy with modifications
  ColorScheme copyWith({
    Brightness? brightness,
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? tertiary,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? outline,
    Color? outlineVariant,
    Color? shadow,
    Color? scrim,
    Color? inverseSurface,
    Color? onInverseSurface,
    Color? inversePrimary,
    Color? surfaceTint,
  }) {
    return ColorScheme(
      brightness: brightness ?? this.brightness,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
      tertiary: tertiary ?? this.tertiary,
      onTertiary: onTertiary ?? this.onTertiary,
      tertiaryContainer: tertiaryContainer ?? this.tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer ?? this.onTertiaryContainer,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      errorContainer: errorContainer ?? this.errorContainer,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      shadow: shadow ?? this.shadow,
      scrim: scrim ?? this.scrim,
      inverseSurface: inverseSurface ?? this.inverseSurface,
      onInverseSurface: onInverseSurface ?? this.onInverseSurface,
      inversePrimary: inversePrimary ?? this.inversePrimary,
      surfaceTint: surfaceTint ?? this.surfaceTint,
    );
  }

  /// Spin all colors by degrees
  ColorScheme spin(double degrees) {
    if (degrees == 0) return this;
    return ColorScheme(
      brightness: brightness,
      primary: primary.spin(degrees),
      onPrimary: onPrimary,
      primaryContainer: primaryContainer.spin(degrees),
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary.spin(degrees),
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer.spin(degrees),
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary.spin(degrees),
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer.spin(degrees),
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: onInverseSurface,
      inversePrimary: inversePrimary.spin(degrees),
      surfaceTint: surfaceTint.spin(degrees),
    );
  }
}

/// Contrasted color scheme for light/dark mode support
class ContrastedColorScheme {
  final ColorScheme light;
  final ColorScheme dark;

  const ContrastedColorScheme({required this.light, required this.dark});

  /// Blue theme
  factory ContrastedColorScheme.blue() => ContrastedColorScheme(
        light: ColorScheme.light(primary: Colors.blue),
        dark: ColorScheme.dark(primary: const Color(0xFF60A5FA)),
      );

  /// Indigo theme (default)
  factory ContrastedColorScheme.indigo() => ContrastedColorScheme(
        light: ColorScheme.light(primary: Colors.indigo),
        dark: ColorScheme.dark(primary: const Color(0xFF818CF8)),
      );

  /// Purple theme
  factory ContrastedColorScheme.purple() => ContrastedColorScheme(
        light: ColorScheme.light(primary: Colors.purple),
        dark: ColorScheme.dark(primary: const Color(0xFFC084FC)),
      );

  /// Green theme
  factory ContrastedColorScheme.green() => ContrastedColorScheme(
        light: ColorScheme.light(primary: Colors.green),
        dark: ColorScheme.dark(primary: const Color(0xFF4ADE80)),
      );

  /// Teal theme
  factory ContrastedColorScheme.teal() => ContrastedColorScheme(
        light: ColorScheme.light(primary: Colors.teal),
        dark: ColorScheme.dark(primary: const Color(0xFF2DD4BF)),
      );

  /// Orange theme
  factory ContrastedColorScheme.orange() => ContrastedColorScheme(
        light: ColorScheme.light(primary: Colors.orange),
        dark: ColorScheme.dark(primary: const Color(0xFFFB923C)),
      );

  /// Rose theme
  factory ContrastedColorScheme.rose() => ContrastedColorScheme(
        light: ColorScheme.light(primary: Colors.rose),
        dark: ColorScheme.dark(primary: const Color(0xFFFB7185)),
      );

  /// Slate (neutral) theme
  factory ContrastedColorScheme.slate() => ContrastedColorScheme(
        light: ColorScheme.light(primary: Colors.slate600),
        dark: ColorScheme.dark(primary: Colors.slate400),
      );

  /// Supabase-style theme with configurable accent color
  /// Uses zinc-based dark mode and clean light mode
  factory ContrastedColorScheme.supabase({
    AccentTheme accent = AccentTheme.emerald,
  }) {
    return ContrastedColorScheme(
      light: ColorScheme(
        brightness: Brightness.light,
        primary: accent.primaryLight,
        onPrimary: Colors.white,
        primaryContainer: accent.containerLight,
        onPrimaryContainer: accent.primaryLight,
        secondary: Colors.zinc600,
        onSecondary: Colors.white,
        secondaryContainer: Colors.zinc200,
        onSecondaryContainer: Colors.zinc900,
        tertiary: Colors.zinc500,
        onTertiary: Colors.white,
        tertiaryContainer: Colors.zinc100,
        onTertiaryContainer: Colors.zinc800,
        error: Colors.red600,
        onError: Colors.white,
        errorContainer: Colors.red100,
        onErrorContainer: Colors.red900,
        background: Colors.zinc50,
        onBackground: Colors.zinc900,
        surface: Colors.white,
        onSurface: Colors.zinc900,
        surfaceVariant: Colors.zinc100,
        onSurfaceVariant: Colors.zinc600,
        outline: const Color(0x1A000000), // rgba(0,0,0,0.1)
        outlineVariant: const Color(0x0D000000), // rgba(0,0,0,0.05)
        shadow: Colors.black,
        scrim: Colors.black,
        inverseSurface: Colors.zinc900,
        onInverseSurface: Colors.zinc50,
        inversePrimary: accent.primaryDark,
        surfaceTint: accent.primaryLight,
      ),
      dark: ColorScheme(
        brightness: Brightness.dark,
        primary: accent.primaryDark,
        onPrimary: Colors.zinc950,
        primaryContainer: accent.containerDark,
        onPrimaryContainer: accent.primaryDark,
        secondary: Colors.zinc400,
        onSecondary: Colors.zinc950,
        secondaryContainer: Colors.zinc800,
        onSecondaryContainer: Colors.zinc200,
        tertiary: Colors.zinc500,
        onTertiary: Colors.zinc950,
        tertiaryContainer: Colors.zinc800,
        onTertiaryContainer: Colors.zinc300,
        error: Colors.red400,
        onError: Colors.zinc950,
        errorContainer: Colors.red950,
        onErrorContainer: Colors.red200,
        background: Colors.zinc950, // #09090B
        onBackground: Colors.zinc50,
        surface: Colors.zinc900, // #18181B
        onSurface: Colors.zinc50,
        surfaceVariant: Colors.zinc800, // #27272A
        onSurfaceVariant: Colors.zinc400,
        outline: const Color(0x803F3F46), // rgba(63,63,70,0.5)
        outlineVariant: const Color(0x403F3F46), // rgba(63,63,70,0.25)
        shadow: Colors.black,
        scrim: Colors.black,
        inverseSurface: Colors.zinc100,
        onInverseSurface: Colors.zinc900,
        inversePrimary: accent.primaryLight,
        surfaceTint: accent.primaryDark,
      ),
    );
  }

  /// Convenience factory for Supabase emerald (default Supabase look)
  factory ContrastedColorScheme.supabaseEmerald() =>
      ContrastedColorScheme.supabase(accent: AccentTheme.emerald);

  /// Convenience factory for Supabase cyan
  factory ContrastedColorScheme.supabaseCyan() =>
      ContrastedColorScheme.supabase(accent: AccentTheme.cyan);

  /// Convenience factory for Supabase violet
  factory ContrastedColorScheme.supabaseViolet() =>
      ContrastedColorScheme.supabase(accent: AccentTheme.violet);

  /// Convenience factory for Supabase amber
  factory ContrastedColorScheme.supabaseAmber() =>
      ContrastedColorScheme.supabase(accent: AccentTheme.amber);

  /// Get scheme for brightness
  ColorScheme scheme(Brightness brightness) {
    return brightness == Brightness.light ? light : dark;
  }

  /// Spin both schemes
  ContrastedColorScheme spin(double degrees) {
    return ContrastedColorScheme(
      light: light.spin(degrees),
      dark: dark.spin(degrees),
    );
  }
}
