import 'package:jaspr/jaspr.dart';

import 'colors.dart';
import 'color_scheme.dart';

export 'colors.dart';
export 'color_scheme.dart';

/// Main theme configuration for Arcane Jaspr
class ArcaneTheme {
  /// The color scheme for light/dark mode
  final ContrastedColorScheme? scheme;

  /// The current theme mode
  final ThemeMode themeMode;

  /// The accent color theme (emerald, cyan, violet, amber)
  final AccentTheme accent;

  /// Border radius scaling (0.0 = square, 1.0 = fully rounded)
  final double radius;

  /// Surface opacity for glass effects
  final double surfaceOpacity;

  /// Surface opacity for light mode
  final double surfaceOpacityLight;

  /// Blur radius for surface effects
  final double surfaceBlur;

  /// Global scaling factor
  final double scaling;

  /// Contrast adjustment (-1.0 to 1.0)
  final double contrast;

  /// Hue spin in degrees
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
    this.scheme,
    this.themeMode = ThemeMode.system,
    this.accent = AccentTheme.emerald,
    this.radius = 0.5,
    this.surfaceOpacity = 0.8,
    this.surfaceOpacityLight = 0.9,
    this.surfaceBlur = 12.0,
    this.scaling = 1.0,
    this.contrast = 0.0,
    this.spin = 0.0,
    this.toast = const ArcaneToastTheme(),
    this.gutter = const GutterTheme(),
    this.navigation = const NavigationTheme(),
    this.cardCarousel = const CardCarouselTheme(),
    this.barrierColors = const ArcaneBarriers(),
  });

  /// Create a Supabase-styled theme with the given accent color
  factory ArcaneTheme.supabase({
    AccentTheme accent = AccentTheme.emerald,
    ThemeMode themeMode = ThemeMode.dark,
    double radius = 0.75, // More rounded for Supabase style
  }) {
    return ArcaneTheme(
      scheme: ContrastedColorScheme.supabase(accent: accent),
      accent: accent,
      themeMode: themeMode,
      radius: radius,
      surfaceOpacity: 0.9,
      surfaceOpacityLight: 0.95,
      surfaceBlur: 16.0,
    );
  }

  /// Get the current brightness
  Brightness get brightness => themeMode.brightness;

  /// Get the active color scheme
  ColorScheme get colorScheme {
    final baseScheme = scheme ?? ContrastedColorScheme.indigo();
    return baseScheme.scheme(brightness).spin(spin);
  }

  /// Copy with modifications
  ArcaneTheme copyWith({
    ContrastedColorScheme? scheme,
    ThemeMode? themeMode,
    AccentTheme? accent,
    double? radius,
    double? surfaceOpacity,
    double? surfaceOpacityLight,
    double? surfaceBlur,
    double? scaling,
    double? contrast,
    double? spin,
    ArcaneToastTheme? toast,
    GutterTheme? gutter,
    NavigationTheme? navigation,
    CardCarouselTheme? cardCarousel,
    ArcaneBarriers? barrierColors,
  }) {
    return ArcaneTheme(
      scheme: scheme ?? this.scheme,
      themeMode: themeMode ?? this.themeMode,
      accent: accent ?? this.accent,
      radius: radius ?? this.radius,
      surfaceOpacity: surfaceOpacity ?? this.surfaceOpacity,
      surfaceOpacityLight: surfaceOpacityLight ?? this.surfaceOpacityLight,
      surfaceBlur: surfaceBlur ?? this.surfaceBlur,
      scaling: scaling ?? this.scaling,
      contrast: contrast ?? this.contrast,
      spin: spin ?? this.spin,
      toast: toast ?? this.toast,
      gutter: gutter ?? this.gutter,
      navigation: navigation ?? this.navigation,
      cardCarousel: cardCarousel ?? this.cardCarousel,
      barrierColors: barrierColors ?? this.barrierColors,
    );
  }

  /// Create a copy with a different accent color
  ArcaneTheme withAccent(AccentTheme newAccent) {
    return copyWith(
      accent: newAccent,
      scheme: ContrastedColorScheme.supabase(accent: newAccent),
    );
  }

  /// Get effective surface opacity based on brightness
  double get effectiveSurfaceOpacity =>
      brightness == Brightness.light ? surfaceOpacityLight : surfaceOpacity;

  /// Calculate border radius in pixels
  double get borderRadiusPx => radius * 12 * scaling;

  /// CSS border radius value
  String get borderRadiusCss => '${borderRadiusPx}px';

  /// Get accent colors based on current brightness
  Color get accentPrimary =>
      brightness == Brightness.light ? accent.primaryLight : accent.primaryDark;
  Color get accentHover =>
      brightness == Brightness.light ? accent.hoverLight : accent.hoverDark;
  Color get accentContainer =>
      brightness == Brightness.light ? accent.containerLight : accent.containerDark;

  /// Generate CSS custom properties for the theme
  Map<String, String> get cssVariables {
    final cs = colorScheme;
    return {
      // Core color scheme
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

      // Accent colors (for Supabase-style theming)
      '--arcane-accent': accentPrimary.css,
      '--arcane-accent-hover': accentHover.css,
      '--arcane-accent-container': accentContainer.css,
      '--arcane-accent-foreground': brightness == Brightness.dark
          ? Colors.zinc950.css
          : Colors.white.css,

      // Muted/secondary text
      '--arcane-muted': cs.onSurfaceVariant.css,
      '--arcane-muted-foreground': brightness == Brightness.dark
          ? Colors.zinc400.css
          : Colors.zinc500.css,

      // Card styling
      '--arcane-card': cs.surface.css,
      '--arcane-card-foreground': cs.onSurface.css,

      // Border colors
      '--arcane-border': cs.outline.css,
      '--arcane-border-subtle': cs.outlineVariant.css,

      // Input styling
      '--arcane-input': cs.surfaceVariant.css,
      '--arcane-input-foreground': cs.onSurface.css,

      // Ring/focus color
      '--arcane-ring': cs.primary.css,

      // Destructive colors
      '--arcane-destructive': brightness == Brightness.dark
          ? Colors.red400.css
          : Colors.red600.css,
      '--arcane-destructive-foreground': Colors.white.css,

      // Success colors
      '--arcane-success': brightness == Brightness.dark
          ? Colors.emerald400.css
          : Colors.emerald600.css,
      '--arcane-success-foreground': Colors.white.css,

      // Warning colors
      '--arcane-warning': brightness == Brightness.dark
          ? Colors.amber400.css
          : Colors.amber600.css,
      '--arcane-warning-foreground': brightness == Brightness.dark
          ? Colors.zinc950.css
          : Colors.zinc950.css,

      // Info colors
      '--arcane-info': brightness == Brightness.dark
          ? Colors.cyan400.css
          : Colors.cyan600.css,
      '--arcane-info-foreground': Colors.white.css,

      // Border radius
      '--arcane-radius': borderRadiusCss,
      '--arcane-radius-sm': '${borderRadiusPx * 0.5}px',
      '--arcane-radius-md': '${borderRadiusPx}px',
      '--arcane-radius-lg': '${borderRadiusPx * 1.5}px',
      '--arcane-radius-xl': '${borderRadiusPx * 2}px',
      '--arcane-radius-2xl': '${borderRadiusPx * 3}px',
      '--arcane-radius-full': '9999px',

      // Scaling and effects
      '--arcane-scaling': '$scaling',
      '--arcane-surface-opacity': '$effectiveSurfaceOpacity',
      '--arcane-surface-blur': '${surfaceBlur}px',
      '--arcane-barrier-color': barrierColors.dialog.css,

      // Shadows (Supabase-style)
      '--arcane-shadow-sm': '0 1px 2px rgba(0, 0, 0, 0.05)',
      '--arcane-shadow': brightness == Brightness.dark
          ? '0 4px 6px -1px rgba(0, 0, 0, 0.3), 0 2px 4px -1px rgba(0, 0, 0, 0.2)'
          : '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)',
      '--arcane-shadow-lg': brightness == Brightness.dark
          ? '0 10px 15px -3px rgba(0, 0, 0, 0.4), 0 4px 6px -2px rgba(0, 0, 0, 0.3)'
          : '0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05)',
      '--arcane-shadow-xl': brightness == Brightness.dark
          ? '0 20px 25px -5px rgba(0, 0, 0, 0.5), 0 10px 10px -5px rgba(0, 0, 0, 0.3)'
          : '0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)',

      // Transition defaults
      '--arcane-transition-fast': '150ms ease',
      '--arcane-transition': '200ms ease',
      '--arcane-transition-slow': '300ms ease',

      // Extended backgrounds (missing from original)
      '--arcane-background-secondary': brightness == Brightness.dark
          ? '#0a0a0c'
          : '#f4f4f5',
      '--arcane-background-tertiary': brightness == Brightness.dark
          ? '#0f0f11'
          : '#e4e4e7',
      '--arcane-card-hover': brightness == Brightness.dark
          ? 'rgba(255, 255, 255, 0.05)'
          : 'rgba(0, 0, 0, 0.02)',
      '--arcane-card-alt': brightness == Brightness.dark
          ? '#18181b'
          : '#fafafa',
      '--arcane-navbar': brightness == Brightness.dark
          ? 'rgba(9, 9, 11, 0.8)'
          : 'rgba(255, 255, 255, 0.8)',

      // Extended text colors
      '--arcane-text-subtle': brightness == Brightness.dark
          ? '#71717a'
          : '#a1a1aa',
      '--arcane-text-faint': brightness == Brightness.dark
          ? '#52525b'
          : '#d4d4d8',

      // Tooltip
      '--arcane-tooltip': brightness == Brightness.dark
          ? '#27272a'
          : '#18181b',
      '--arcane-tooltip-foreground': brightness == Brightness.dark
          ? '#fafafa'
          : '#fafafa',

      // Code
      '--arcane-code-background': brightness == Brightness.dark
          ? '#18181b'
          : '#f4f4f5',

      // Success extended
      '--arcane-success-hover': brightness == Brightness.dark
          ? Colors.emerald300.css
          : Colors.emerald700.css,
      '--arcane-success-container': brightness == Brightness.dark
          ? 'rgba(16, 185, 129, 0.1)'
          : 'rgba(16, 185, 129, 0.1)',

      // Extra shadow
      '--arcane-shadow-xs': '0 1px 2px rgba(0, 0, 0, 0.05)',
    };
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
}
