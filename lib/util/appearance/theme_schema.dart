import 'colors.dart';
import 'color_scheme.dart';
import 'swatch.dart';

/// Base class for theme schemas
///
/// Each theme preset (red, blue, oledPurple, etc.) extends this class
/// to define its complete color configuration.
abstract class ThemeSchema {
  const ThemeSchema();

  /// Unique identifier for the theme (e.g., 'red', 'oled_blue')
  String get id;

  /// Display name for the theme (e.g., 'Red', 'OLED Blue')
  String get name;

  /// The primary accent color swatch (50-950)
  ColorSwatch get accentSwatch;

  /// The neutral/surface color swatch for backgrounds (50-950)
  ColorSwatch get neutralSwatch;

  /// Whether this is an OLED theme (true black backgrounds)
  bool get isOled => false;

  /// Whether this theme prefers dark mode by default
  bool get prefersDark => false;

  /// Whether this theme prefers light mode by default
  bool get prefersLight => false;

  // ========== Light Mode Colors ==========

  /// Background color for light mode
  Color get backgroundLight => neutralSwatch.shade50;

  /// Surface color for light mode
  Color get surfaceLight => Colors.white;

  /// Surface variant color for light mode
  Color get surfaceVariantLight => neutralSwatch.shade100;

  /// Text color for light mode
  Color get onBackgroundLight => neutralSwatch.shade900;

  /// Text on surface for light mode
  Color get onSurfaceLight => neutralSwatch.shade900;

  /// Text on surface variant for light mode
  Color get onSurfaceVariantLight => neutralSwatch.shade600;

  /// Outline/border color for light mode
  Color get outlineLight => neutralSwatch.shade300;

  /// Subtle outline for light mode
  Color get outlineVariantLight => neutralSwatch.shade200;

  // ========== Dark Mode Colors ==========

  /// Background color for dark mode
  Color get backgroundDark => neutralSwatch.shade950;

  /// Surface color for dark mode
  Color get surfaceDark => neutralSwatch.shade900;

  /// Surface variant color for dark mode
  Color get surfaceVariantDark => neutralSwatch.shade800;

  /// Text color for dark mode
  Color get onBackgroundDark => neutralSwatch.shade50;

  /// Text on surface for dark mode
  Color get onSurfaceDark => neutralSwatch.shade50;

  /// Text on surface variant for dark mode
  Color get onSurfaceVariantDark => neutralSwatch.shade400;

  /// Outline/border color for dark mode
  Color get outlineDark => neutralSwatch.shade700;

  /// Subtle outline for dark mode
  Color get outlineVariantDark => neutralSwatch.shade800;

  // ========== Accent Colors ==========

  /// Primary accent for light mode
  Color get accentLight => accentSwatch.primaryLight;

  /// Primary accent for dark mode
  Color get accentDark => accentSwatch.primaryDark;

  /// Accent hover for light mode
  Color get accentHoverLight => accentSwatch.hoverLight;

  /// Accent hover for dark mode
  Color get accentHoverDark => accentSwatch.hoverDark;

  /// Accent container for light mode
  Color get accentContainerLight => accentSwatch.containerLight;

  /// Accent container for dark mode
  Color get accentContainerDark => accentSwatch.containerDark;

  /// Foreground on accent for light mode
  Color get onAccentLight => accentSwatch.foregroundLight;

  /// Foreground on accent for dark mode
  Color get onAccentDark => accentSwatch.foregroundDark;

  /// Generate the ContrastedColorScheme for this theme
  ContrastedColorScheme toColorScheme() {
    return ContrastedColorScheme(
      light: ColorScheme(
        brightness: Brightness.light,
        primary: accentLight,
        onPrimary: onAccentLight,
        primaryContainer: accentContainerLight,
        onPrimaryContainer: accentLight,
        secondary: neutralSwatch.shade600,
        onSecondary: Colors.white,
        secondaryContainer: neutralSwatch.shade200,
        onSecondaryContainer: neutralSwatch.shade900,
        tertiary: neutralSwatch.shade500,
        onTertiary: Colors.white,
        tertiaryContainer: neutralSwatch.shade100,
        onTertiaryContainer: neutralSwatch.shade800,
        error: Colors.red600,
        onError: Colors.white,
        errorContainer: Colors.red100,
        onErrorContainer: Colors.red900,
        background: backgroundLight,
        onBackground: onBackgroundLight,
        surface: surfaceLight,
        onSurface: onSurfaceLight,
        surfaceVariant: surfaceVariantLight,
        onSurfaceVariant: onSurfaceVariantLight,
        outline: outlineLight,
        outlineVariant: outlineVariantLight,
        shadow: Colors.black,
        scrim: Colors.black,
        inverseSurface: neutralSwatch.shade900,
        onInverseSurface: neutralSwatch.shade50,
        inversePrimary: accentDark,
        surfaceTint: accentLight,
      ),
      dark: ColorScheme(
        brightness: Brightness.dark,
        primary: accentDark,
        onPrimary: onAccentDark,
        primaryContainer: accentContainerDark,
        onPrimaryContainer: accentDark,
        secondary: neutralSwatch.shade400,
        onSecondary: neutralSwatch.shade950,
        secondaryContainer: neutralSwatch.shade800,
        onSecondaryContainer: neutralSwatch.shade200,
        tertiary: neutralSwatch.shade500,
        onTertiary: neutralSwatch.shade950,
        tertiaryContainer: neutralSwatch.shade800,
        onTertiaryContainer: neutralSwatch.shade300,
        error: Colors.red400,
        onError: neutralSwatch.shade950,
        errorContainer: Colors.red950,
        onErrorContainer: Colors.red200,
        background: backgroundDark,
        onBackground: onBackgroundDark,
        surface: surfaceDark,
        onSurface: onSurfaceDark,
        surfaceVariant: surfaceVariantDark,
        onSurfaceVariant: onSurfaceVariantDark,
        outline: outlineDark,
        outlineVariant: outlineVariantDark,
        shadow: Colors.black,
        scrim: Colors.black,
        inverseSurface: neutralSwatch.shade100,
        onInverseSurface: neutralSwatch.shade900,
        inversePrimary: accentLight,
        surfaceTint: accentDark,
      ),
    );
  }

  /// Generate additional CSS variables for this theme
  Map<String, String> additionalCssVariables(Brightness brightness) {
    return {};
  }
}

/// Mixin for OLED themes with true black backgrounds
mixin OledThemeMixin on ThemeSchema {
  @override
  bool get isOled => true;

  @override
  bool get prefersDark => true;

  @override
  Color get backgroundDark => Colors.black; // #000000

  @override
  Color get surfaceDark => const Color(0xFF0A0A0A); // Near black

  @override
  Color get surfaceVariantDark => const Color(0xFF141414); // Slightly lighter
}

/// Mixin for monochromatic themes where accent = neutral
mixin MonochromaticThemeMixin on ThemeSchema {
  @override
  ColorSwatch get accentSwatch => neutralSwatch;
}
