import 'package:jaspr/jaspr.dart';

import 'colors.dart';
import 'color_scheme.dart';
import 'swatch.dart';
import 'theme_schema.dart';
import 'themes/themes.dart';

export 'colors.dart';
export 'color_scheme.dart';
export 'swatch.dart';
export 'theme_schema.dart';
export 'themes/themes.dart';

/// Main theme configuration for Arcane Jaspr
///
/// Use one of the preset themes to instantly style your entire app:
/// ```dart
/// ArcaneApp(
///   theme: ArcaneTheme.red,
///   child: MyApp(),
/// )
/// ```
///
/// All 19 theme presets are available:
/// - Primary colors: red, orange, yellow, green, blue, indigo, purple, pink
/// - Neutrals: darkGrey, grey, lightGrey, white, black
/// - OLED variants: oledRed, oledGreen, oledBlue, oledPurple, oledWhite
class ArcaneTheme {
  /// The theme schema defining all colors
  final ThemeSchema schema;

  /// The current theme mode (system, light, dark)
  final ThemeMode themeMode;

  /// Border radius scaling (0.0 = square, 1.0 = fully rounded)
  final double radius;

  /// Surface opacity for glass effects in dark mode
  final double surfaceOpacity;

  /// Surface opacity for light mode
  final double surfaceOpacityLight;

  /// Blur radius for surface effects
  final double surfaceBlur;

  /// Global scaling factor
  final double scaling;

  /// Hue spin in degrees (rotates all colors)
  final double spin;

  /// Toast theme configuration
  final ArcaneToastTheme toast;

  /// Gutter theme configuration
  final GutterTheme gutter;

  /// Navigation theme configuration
  final NavigationTheme navigation;

  /// Card carousel theme configuration
  final CardCarouselTheme cardCarousel;

  /// Barrier colors for dialogs/overlays
  final ArcaneBarriers barrierColors;

  const ArcaneTheme({
    this.schema = const GreenThemeSchema(),
    this.themeMode = ThemeMode.system,
    this.radius = 0.5,
    this.surfaceOpacity = 0.8,
    this.surfaceOpacityLight = 0.9,
    this.surfaceBlur = 12.0,
    this.scaling = 1.0,
    this.spin = 0.0,
    this.toast = const ArcaneToastTheme(),
    this.gutter = const GutterTheme(),
    this.navigation = const NavigationTheme(),
    this.cardCarousel = const CardCarouselTheme(),
    this.barrierColors = const ArcaneBarriers(),
  });

  // =========================================================================
  // STATIC THEME PRESETS - Access as ArcaneTheme.red, ArcaneTheme.oledBlue
  // =========================================================================

  // Primary Color Themes
  static const ArcaneTheme red = ArcaneTheme(schema: RedThemeSchema());
  static const ArcaneTheme orange = ArcaneTheme(schema: OrangeThemeSchema());
  static const ArcaneTheme yellow = ArcaneTheme(schema: YellowThemeSchema());
  static const ArcaneTheme green = ArcaneTheme(schema: GreenThemeSchema());
  static const ArcaneTheme blue = ArcaneTheme(schema: BlueThemeSchema());
  static const ArcaneTheme indigo = ArcaneTheme(schema: IndigoThemeSchema());
  static const ArcaneTheme purple = ArcaneTheme(schema: PurpleThemeSchema());
  static const ArcaneTheme pink = ArcaneTheme(schema: PinkThemeSchema());

  // Neutral/Monochromatic Themes
  static const ArcaneTheme darkGrey =
      ArcaneTheme(schema: DarkGreyThemeSchema());
  static const ArcaneTheme grey = ArcaneTheme(schema: GreyThemeSchema());
  static const ArcaneTheme lightGrey =
      ArcaneTheme(schema: LightGreyThemeSchema());
  static const ArcaneTheme white = ArcaneTheme(schema: WhiteThemeSchema());
  static const ArcaneTheme black = ArcaneTheme(schema: BlackThemeSchema());

  // OLED Themes (true black backgrounds for battery saving)
  static const ArcaneTheme oledRed = ArcaneTheme(schema: OledRedThemeSchema());
  static const ArcaneTheme oledGreen =
      ArcaneTheme(schema: OledGreenThemeSchema());
  static const ArcaneTheme oledBlue =
      ArcaneTheme(schema: OledBlueThemeSchema());
  static const ArcaneTheme oledPurple =
      ArcaneTheme(schema: OledPurpleThemeSchema());
  static const ArcaneTheme oledWhite =
      ArcaneTheme(schema: OledWhiteThemeSchema());

  /// List of all available theme presets
  static const List<ArcaneTheme> all = [
    red,
    orange,
    yellow,
    green,
    blue,
    indigo,
    purple,
    pink,
    darkGrey,
    grey,
    lightGrey,
    white,
    black,
    oledRed,
    oledGreen,
    oledBlue,
    oledPurple,
    oledWhite,
  ];

  /// Get the current brightness
  Brightness get brightness {
    if (themeMode == ThemeMode.system) {
      if (schema.prefersDark) return Brightness.dark;
      if (schema.prefersLight) return Brightness.light;
      return Brightness.dark; // Default to dark
    }
    return themeMode.brightness;
  }

  /// Whether currently in dark mode
  bool get isDark => brightness == Brightness.dark;

  /// Whether currently in light mode
  bool get isLight => brightness == Brightness.light;

  /// Get the active color scheme
  ColorScheme get colorScheme {
    return schema.toColorScheme().scheme(brightness).spin(spin);
  }

  /// Get the accent swatch
  ColorSwatch get accentSwatch => schema.accentSwatch;

  /// Get the neutral swatch
  ColorSwatch get neutralSwatch => schema.neutralSwatch;

  /// Whether this is an OLED theme
  bool get isOled => schema.isOled;

  /// Copy with modifications
  ArcaneTheme copyWith({
    ThemeSchema? schema,
    ThemeMode? themeMode,
    double? radius,
    double? surfaceOpacity,
    double? surfaceOpacityLight,
    double? surfaceBlur,
    double? scaling,
    double? spin,
    ArcaneToastTheme? toast,
    GutterTheme? gutter,
    NavigationTheme? navigation,
    CardCarouselTheme? cardCarousel,
    ArcaneBarriers? barrierColors,
  }) {
    return ArcaneTheme(
      schema: schema ?? this.schema,
      themeMode: themeMode ?? this.themeMode,
      radius: radius ?? this.radius,
      surfaceOpacity: surfaceOpacity ?? this.surfaceOpacity,
      surfaceOpacityLight: surfaceOpacityLight ?? this.surfaceOpacityLight,
      surfaceBlur: surfaceBlur ?? this.surfaceBlur,
      scaling: scaling ?? this.scaling,
      spin: spin ?? this.spin,
      toast: toast ?? this.toast,
      gutter: gutter ?? this.gutter,
      navigation: navigation ?? this.navigation,
      cardCarousel: cardCarousel ?? this.cardCarousel,
      barrierColors: barrierColors ?? this.barrierColors,
    );
  }

  /// Create a copy with a different theme schema
  ArcaneTheme withSchema(ThemeSchema newSchema) {
    return copyWith(schema: newSchema);
  }

  /// Get effective surface opacity based on brightness
  double get effectiveSurfaceOpacity =>
      brightness == Brightness.light ? surfaceOpacityLight : surfaceOpacity;

  /// Calculate border radius in pixels
  double get borderRadiusPx => radius * 12 * scaling;

  /// CSS border radius value
  String get borderRadiusCss => '${borderRadiusPx}px';

  /// Get current accent color
  Color get accentPrimary =>
      isDark ? schema.accentDark : schema.accentLight;

  /// Get current accent hover color
  Color get accentHover =>
      isDark ? schema.accentHoverDark : schema.accentHoverLight;

  /// Get current accent container color
  Color get accentContainer =>
      isDark ? schema.accentContainerDark : schema.accentContainerLight;

  /// Get current accent foreground color
  Color get accentForeground =>
      isDark ? schema.onAccentDark : schema.onAccentLight;

  /// Generate CSS custom properties for the theme
  ///
  /// This generates 150+ CSS variables that control the entire app appearance.
  /// Components use these variables via ArcaneColors tokens.
  Map<String, String> get cssVariables {
    final cs = colorScheme;
    String rgb(Color color) => '${color.red}, ${color.green}, ${color.blue}';

    final vars = <String, String>{
      // =====================================================================
      // CORE COLOR SCHEME (Material-style semantic colors)
      // =====================================================================
      '--arcane-primary': cs.primary.css,
      '--arcane-on-primary': cs.onPrimary.css,
      '--arcane-primary-container': cs.primaryContainer.css,
      '--arcane-on-primary-container': cs.onPrimaryContainer.css,
      '--arcane-secondary': cs.secondary.css,
      '--arcane-on-secondary': cs.onSecondary.css,
      '--arcane-secondary-container': cs.secondaryContainer.css,
      '--arcane-on-secondary-container': cs.onSecondaryContainer.css,
      '--arcane-tertiary': cs.tertiary.css,
      '--arcane-on-tertiary': cs.onTertiary.css,
      '--arcane-error': cs.error.css,
      '--arcane-on-error': cs.onError.css,
      '--arcane-background': cs.background.css,
      '--arcane-on-background': cs.onBackground.css,
      '--arcane-surface': cs.surface.css,
      '--arcane-on-surface': cs.onSurface.css,
      '--arcane-surface-variant': cs.surfaceVariant.css,
      '--arcane-on-surface-variant': cs.onSurfaceVariant.css,
      '--arcane-outline': cs.outline.css,
      '--arcane-outline-variant': cs.outlineVariant.css,
      '--arcane-shadow-color': cs.shadow.css,
      '--arcane-scrim': cs.scrim.withOpacity(0.5).css,
      '--arcane-inverse-surface': cs.inverseSurface.css,
      '--arcane-on-inverse-surface': cs.onInverseSurface.css,
      '--arcane-surface-tint': cs.surfaceTint.css,

      // =====================================================================
      // ACCENT COLORS (Primary brand/action colors)
      // =====================================================================
      '--arcane-accent': accentPrimary.css,
      '--arcane-accent-hover': accentHover.css,
      '--arcane-accent-container': accentContainer.css,
      '--arcane-accent-foreground': accentForeground.css,

      // =====================================================================
      // SEMANTIC COLORS (Success, Warning, Error, Info)
      // =====================================================================
      // Destructive/Error
      '--arcane-destructive': isDark ? Colors.red400.css : Colors.red600.css,
      '--arcane-destructive-foreground': Colors.white.css,
      '--arcane-destructive-hover': isDark ? Colors.red300.css : Colors.red700.css,
      '--arcane-destructive-container': 'rgba(${rgb(isDark ? Colors.red400 : Colors.red600)}, 0.1)',

      // Success
      '--arcane-success': isDark ? Colors.emerald400.css : Colors.emerald600.css,
      '--arcane-success-foreground': Colors.white.css,
      '--arcane-success-hover': isDark ? Colors.emerald300.css : Colors.emerald700.css,
      '--arcane-success-container': 'rgba(${rgb(isDark ? Colors.emerald400 : Colors.emerald600)}, 0.1)',

      // Warning
      '--arcane-warning': isDark ? Colors.amber400.css : Colors.amber600.css,
      '--arcane-warning-foreground': Colors.zinc950.css,
      '--arcane-warning-hover': isDark ? Colors.amber300.css : Colors.amber700.css,
      '--arcane-warning-container': 'rgba(${rgb(isDark ? Colors.amber400 : Colors.amber600)}, 0.1)',

      // Info
      '--arcane-info': isDark ? Colors.cyan400.css : Colors.cyan600.css,
      '--arcane-info-foreground': Colors.white.css,
      '--arcane-info-hover': isDark ? Colors.cyan300.css : Colors.cyan700.css,
      '--arcane-info-container': 'rgba(${rgb(isDark ? Colors.cyan400 : Colors.cyan600)}, 0.1)',

      // =====================================================================
      // TEXT & MUTED COLORS
      // =====================================================================
      '--arcane-muted': cs.onSurfaceVariant.css,
      '--arcane-muted-foreground':
          isDark ? neutralSwatch.shade400.css : neutralSwatch.shade500.css,
      '--arcane-text-subtle': 'rgba(${rgb(cs.onSurfaceVariant)}, 0.85)',
      '--arcane-text-faint': 'rgba(${rgb(cs.onSurfaceVariant)}, 0.65)',

      // =====================================================================
      // SURFACE & CONTAINER COLORS
      // =====================================================================
      '--arcane-card': cs.surface.css,
      '--arcane-card-foreground': cs.onSurface.css,
      '--arcane-card-hover': isDark
          ? 'rgba(${rgb(cs.onSurface)}, 0.05)'
          : 'rgba(${rgb(cs.onSurface)}, 0.02)',
      '--arcane-card-alt': cs.surfaceVariant.css,
      '--arcane-input': cs.surfaceVariant.css,
      '--arcane-input-foreground': cs.onSurface.css,

      // Extended backgrounds
      '--arcane-background-secondary': isDark
          ? cs.background.lighten(3).css
          : cs.background.darken(3).css,
      '--arcane-background-tertiary': isDark
          ? cs.background.lighten(6).css
          : cs.background.darken(6).css,
      '--arcane-navbar':
          'rgba(${rgb(cs.background)}, ${effectiveSurfaceOpacity})',

      // =====================================================================
      // BORDER COLORS
      // =====================================================================
      '--arcane-border': cs.outline.css,
      '--arcane-border-subtle': cs.outlineVariant.css,
      '--arcane-ring': accentPrimary.css,

      // =====================================================================
      // OVERLAY & BARRIER COLORS
      // =====================================================================
      '--arcane-overlay': barrierColors.dialog.css,
      '--arcane-overlay-strong': cs.scrim.withOpacity(0.7).css,
      '--arcane-barrier-color': barrierColors.dialog.css,
      '--arcane-tooltip': cs.surfaceVariant.css,
      '--arcane-tooltip-foreground': cs.onSurface.css,
      '--arcane-code-background': cs.surfaceVariant.css,

      // =====================================================================
      // BORDER RADIUS
      // =====================================================================
      '--arcane-radius': borderRadiusCss,
      '--arcane-radius-xs': '${borderRadiusPx * 0.25}px',
      '--arcane-radius-sm': '${borderRadiusPx * 0.5}px',
      '--arcane-radius-md': borderRadiusCss,
      '--arcane-radius-lg': '${borderRadiusPx * 1.5}px',
      '--arcane-radius-xl': '${borderRadiusPx * 2}px',
      '--arcane-radius-2xl': '${borderRadiusPx * 3}px',
      '--arcane-radius-full': '9999px',

      // =====================================================================
      // EFFECTS (Shadows, Transitions, Blur)
      // =====================================================================
      '--arcane-scaling': '$scaling',
      '--arcane-surface-opacity': '$effectiveSurfaceOpacity',
      '--arcane-surface-blur': '${surfaceBlur}px',

      // Shadows
      '--arcane-shadow-xs': '0 1px 2px rgba(0, 0, 0, 0.05)',
      '--arcane-shadow-sm': '0 1px 2px rgba(0, 0, 0, 0.05)',
      '--arcane-shadow': isDark
          ? '0 4px 6px -1px rgba(0, 0, 0, 0.3), 0 2px 4px -1px rgba(0, 0, 0, 0.2)'
          : '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)',
      '--arcane-shadow-lg': isDark
          ? '0 10px 15px -3px rgba(0, 0, 0, 0.4), 0 4px 6px -2px rgba(0, 0, 0, 0.3)'
          : '0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05)',
      '--arcane-shadow-xl': isDark
          ? '0 20px 25px -5px rgba(0, 0, 0, 0.5), 0 10px 10px -5px rgba(0, 0, 0, 0.3)'
          : '0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)',

      // Transitions
      '--arcane-transition-fast': '150ms ease',
      '--arcane-transition': '200ms ease',
      '--arcane-transition-slow': '300ms ease',

      // Glows
      '--arcane-accent-glow': 'rgba(${rgb(accentPrimary)}, 0.10)',
      '--arcane-secondary-glow': 'rgba(${rgb(cs.tertiary)}, 0.10)',
      '--arcane-grid-color': 'rgba(${rgb(accentPrimary)}, 0.03)',

      // =====================================================================
      // RGB CHANNELS (for alpha compositing)
      // =====================================================================
      '--arcane-primary-rgb': rgb(cs.primary),
      '--arcane-secondary-rgb': rgb(cs.secondary),
      '--arcane-tertiary-rgb': rgb(cs.tertiary),
      '--arcane-error-rgb': rgb(cs.error),
      '--arcane-on-error-rgb': rgb(cs.onError),
      '--arcane-background-rgb': rgb(cs.background),
      '--arcane-on-background-rgb': rgb(cs.onBackground),
      '--arcane-surface-rgb': rgb(cs.surface),
      '--arcane-on-surface-rgb': rgb(cs.onSurface),
      '--arcane-surface-variant-rgb': rgb(cs.surfaceVariant),
      '--arcane-on-surface-variant-rgb': rgb(cs.onSurfaceVariant),
      '--arcane-outline-rgb': rgb(cs.outline),
      '--arcane-outline-variant-rgb': rgb(cs.outlineVariant),
      '--arcane-border-rgb': rgb(cs.outline),
      '--arcane-card-rgb': rgb(cs.surface),
      '--arcane-input-rgb': rgb(cs.surfaceVariant),
      '--arcane-accent-rgb': rgb(accentPrimary),
      '--arcane-accent-hover-rgb': rgb(accentHover),
      '--arcane-accent-container-rgb': rgb(accentContainer),
      '--arcane-destructive-rgb': rgb(isDark ? Colors.red400 : Colors.red600),
      '--arcane-success-rgb': rgb(isDark ? Colors.emerald400 : Colors.emerald600),
      '--arcane-warning-rgb': rgb(isDark ? Colors.amber400 : Colors.amber600),
      '--arcane-info-rgb': rgb(isDark ? Colors.cyan400 : Colors.cyan600),
      '--arcane-muted-rgb': rgb(cs.onSurfaceVariant),
    };

    // =========================================================================
    // ACCENT SWATCH (Full 50-950 scale)
    // =========================================================================
    vars.addAll(accentSwatch.toCssVariables('--arcane-accent'));

    // =========================================================================
    // NEUTRAL SWATCH (Full 50-950 scale)
    // =========================================================================
    vars.addAll(neutralSwatch.toCssVariables('--arcane-neutral'));

    // =========================================================================
    // ADDITIONAL SCHEMA-SPECIFIC VARIABLES
    // =========================================================================
    vars.addAll(schema.additionalCssVariables(brightness));

    return vars;
  }

  /// Generate inline style string for CSS variables
  String get cssVariablesStyle {
    return cssVariables.entries.map((e) => '${e.key}: ${e.value}').join('; ');
  }

  /// Get theme from context (via InheritedComponent)
  static ArcaneTheme of(BuildContext context) {
    return ArcaneThemeProvider.of(context)?.theme ?? const ArcaneTheme();
  }

  /// Try to get theme from context
  static ArcaneTheme? maybeOf(BuildContext context) {
    return ArcaneThemeProvider.of(context)?.theme;
  }
}

/// Toast theme configuration
class ArcaneToastTheme {
  final Duration duration;
  final double maxWidth;

  const ArcaneToastTheme({
    this.duration = const Duration(seconds: 4),
    this.maxWidth = 400,
  });
}

/// Gutter theme configuration
class GutterTheme {
  final double small;
  final double medium;
  final double large;

  const GutterTheme({
    this.small = 8,
    this.medium = 16,
    this.large = 24,
  });
}

/// Navigation theme configuration
class NavigationTheme {
  final double sidebarWidth;
  final double sidebarCollapsedWidth;
  final double bottomNavHeight;

  const NavigationTheme({
    this.sidebarWidth = 280,
    this.sidebarCollapsedWidth = 64,
    this.bottomNavHeight = 64,
  });
}

/// Card carousel theme configuration
class CardCarouselTheme {
  final double cardWidth;
  final double cardHeight;
  final double spacing;

  const CardCarouselTheme({
    this.cardWidth = 300,
    this.cardHeight = 200,
    this.spacing = 16,
  });
}

/// Barrier colors for overlays
class ArcaneBarriers {
  final Color barrierColor;
  final double barrierOpacity;
  final Color? dialogBarrierColor;
  final double? dialogBarrierOpacity;
  final Color? menuBarrierColor;
  final double? menuBarrierOpacity;

  const ArcaneBarriers({
    this.barrierColor = Colors.black,
    this.barrierOpacity = 0.5,
    this.dialogBarrierColor,
    this.dialogBarrierOpacity,
    this.menuBarrierColor,
    this.menuBarrierOpacity,
  });

  Color get dialog => (dialogBarrierColor ?? barrierColor)
      .withOpacity(dialogBarrierOpacity ?? barrierOpacity);

  Color get menu => (menuBarrierColor ?? barrierColor)
      .withOpacity(menuBarrierOpacity ?? barrierOpacity);
}

/// InheritedComponent for theme propagation
class ArcaneThemeProvider extends InheritedComponent {
  final ArcaneTheme theme;

  const ArcaneThemeProvider({
    required this.theme,
    required super.child,
    super.key,
  });

  static ArcaneThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedComponentOfExactType<ArcaneThemeProvider>();
  }

  @override
  bool updateShouldNotify(ArcaneThemeProvider oldComponent) {
    return theme != oldComponent.theme;
  }
}

/// Extension to easily access theme from context
extension ArcaneThemeContext on BuildContext {
  ArcaneTheme get arcaneTheme => ArcaneTheme.of(this);
  ColorScheme get colorScheme => arcaneTheme.colorScheme;
  ColorSwatch get accentSwatch => arcaneTheme.accentSwatch;
  ColorSwatch get neutralSwatch => arcaneTheme.neutralSwatch;
  bool get isDarkMode => arcaneTheme.isDark;
  bool get isLightMode => arcaneTheme.isLight;
}
