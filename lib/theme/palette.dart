/// Complete color palette derived from [ThemeSeed].
///
/// All colors are stored as int (0xAARRGGBB format).
/// This is the full set of colors needed by the CSS generator.
class ThemePalette {
  /// Whether this is a dark mode palette.
  final bool isDark;

  // ============================================
  // Core
  // ============================================

  /// Main background color.
  final int background;

  /// Main text color.
  final int foreground;

  // ============================================
  // Card / Popover
  // ============================================

  /// Card/surface background.
  final int card;

  /// Card text color.
  final int cardForeground;

  /// Card hover state.
  final int cardHover;

  /// Popover/dropdown background.
  final int popover;

  /// Popover text color.
  final int popoverForeground;

  // ============================================
  // Primary
  // ============================================

  /// Primary brand color.
  final int primary;

  /// Text on primary background.
  final int primaryForeground;

  /// Primary at 10% opacity for containers.
  final int primaryContainer;

  // ============================================
  // Secondary
  // ============================================

  /// Secondary/muted surface color.
  final int secondary;

  /// Text on secondary background.
  final int secondaryForeground;

  /// Secondary container.
  final int secondaryContainer;

  // ============================================
  // Accent
  // ============================================

  /// Accent color for highlights.
  final int accent;

  /// Text on accent background.
  final int accentForeground;

  /// Accent hover state.
  final int accentHover;

  /// Accent container.
  final int accentContainer;

  // ============================================
  // Muted
  // ============================================

  /// Muted background.
  final int muted;

  /// Muted text (for secondary text, placeholders).
  final int mutedForeground;

  // ============================================
  // Semantic: Destructive
  // ============================================

  final int destructive;
  final int destructiveForeground;
  final int destructiveHover;
  final int destructiveContainer;

  // ============================================
  // Semantic: Success
  // ============================================

  final int success;
  final int successForeground;
  final int successHover;
  final int successContainer;

  // ============================================
  // Semantic: Warning
  // ============================================

  final int warning;
  final int warningForeground;
  final int warningHover;
  final int warningContainer;

  // ============================================
  // Semantic: Info
  // ============================================

  final int info;
  final int infoForeground;
  final int infoHover;
  final int infoContainer;

  // ============================================
  // Borders & Input
  // ============================================

  /// Border color.
  final int border;

  /// Input border color.
  final int input;

  /// Focus ring color.
  final int ring;

  // ============================================
  // Overlays
  // ============================================

  /// Modal overlay (50% black typically).
  final int overlay;

  /// Navbar background (semi-transparent).
  final int navbar;

  /// Code block background.
  final int codeBackground;

  // ============================================
  // Shadows
  // ============================================

  /// Neutral structural shadow presets.
  ///
  /// These are intentionally fixed rather than palette inputs so themes cannot
  /// turn structural elevation into colored bloom or glow.
  String get shadowXs => '0 1px 2px rgba(0, 0, 0, 0.05)';
  String get shadowSm =>
      '0 1px 3px rgba(0, 0, 0, 0.1), 0 1px 2px rgba(0, 0, 0, 0.06)';
  String get shadowMd =>
      '0 4px 6px rgba(0, 0, 0, 0.1), 0 2px 4px rgba(0, 0, 0, 0.06)';
  String get shadowLg =>
      '0 10px 15px rgba(0, 0, 0, 0.1), 0 4px 6px rgba(0, 0, 0, 0.05)';
  String get shadowXl =>
      '0 20px 25px rgba(0, 0, 0, 0.15), 0 8px 10px rgba(0, 0, 0, 0.04)';

  const ThemePalette({
    required this.isDark,
    // Core
    required this.background,
    required this.foreground,
    // Card
    required this.card,
    required this.cardForeground,
    required this.cardHover,
    required this.popover,
    required this.popoverForeground,
    // Primary
    required this.primary,
    required this.primaryForeground,
    required this.primaryContainer,
    // Secondary
    required this.secondary,
    required this.secondaryForeground,
    required this.secondaryContainer,
    // Accent
    required this.accent,
    required this.accentForeground,
    required this.accentHover,
    required this.accentContainer,
    // Muted
    required this.muted,
    required this.mutedForeground,
    // Destructive
    required this.destructive,
    required this.destructiveForeground,
    required this.destructiveHover,
    required this.destructiveContainer,
    // Success
    required this.success,
    required this.successForeground,
    required this.successHover,
    required this.successContainer,
    // Warning
    required this.warning,
    required this.warningForeground,
    required this.warningHover,
    required this.warningContainer,
    // Info
    required this.info,
    required this.infoForeground,
    required this.infoHover,
    required this.infoContainer,
    // Borders
    required this.border,
    required this.input,
    required this.ring,
    // Overlays
    required this.overlay,
    required this.navbar,
    required this.codeBackground,
  });
}
