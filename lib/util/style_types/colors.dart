import '../tokens/tokens.dart';

// CSS variable references for QualityNode brand colors
const String _qnPrimary = 'var(--qn-primary, #059669)';
const String _qnSecondary = 'var(--qn-secondary, #047857)';

/// Background color presets for container backgrounds.
///
/// These presets map to CSS custom properties that automatically adapt
/// to the current theme (light/dark mode and color scheme).
///
/// ## Semantic Backgrounds
///
/// | Preset              | Use Case                               |
/// |---------------------|----------------------------------------|
/// | `background`        | Page/app background                    |
/// | `surface`           | Elevated surfaces (cards, panels)      |
/// | `surfaceVariant`    | Secondary surfaces                     |
/// | `card`              | Card backgrounds                       |
/// | `input`             | Form input backgrounds                 |
///
/// ## Status Backgrounds
///
/// | Preset              | Use Case                               |
/// |---------------------|----------------------------------------|
/// | `accent`            | Primary actions, highlights            |
/// | `success`           | Success states, confirmations          |
/// | `warning`           | Warning states, cautions               |
/// | `error`             | Error states, destructive actions      |
/// | `info`              | Informational states                   |
///
/// ## Example
///
/// ```dart
/// ArcaneDiv(
///   styles: const ArcaneStyleData(
///     background: Background.surface,      // Standard card
///     // background: Background.accent,    // Highlighted card
///     // background: Background.glassTint, // Glass morphism
///   ),
///   children: [...],
/// )
/// ```
enum Background {
  /// Fully transparent
  transparent,

  /// Main background
  background,

  /// Secondary background
  backgroundSecondary,

  /// Tertiary background
  backgroundTertiary,

  /// Primary surface
  surface,

  /// Surface variant
  surfaceVariant,

  /// Card background
  card,

  /// Card hover state
  cardHover,

  /// Alternate card
  cardAlt,

  /// Input field background
  input,

  /// Navbar background
  navbar,

  /// Primary color
  primary,

  /// Secondary color
  secondary,

  /// Tertiary color
  tertiary,

  /// Accent color
  accent,

  /// Accent container
  accentContainer,

  /// Success background
  success,

  /// Success container
  successContainer,

  /// Warning background
  warning,

  /// Error/destructive background
  error,

  /// Info background
  info,

  /// Overlay (for modals)
  overlay,

  /// Tooltip background
  tooltip,

  /// Code block background
  code,

  /// Pure white
  white,

  /// Pure black
  black,

  /// Muted background
  muted,

  /// Brand primary (theme-reactive)
  brandPrimary,

  /// Brand secondary (theme-reactive)
  brandSecondary,

  /// Glass tint (rgba white 5%)
  glassTint,

  /// Glass header (rgba white 3%)
  glassHeader,

  /// Glass overlay (rgba white 8%)
  glassOverlay,

  /// Destructive/error background
  destructive;

  String get css => switch (this) {
        Background.transparent => ArcaneColors.transparent,
        Background.background => ArcaneColors.background,
        Background.backgroundSecondary => ArcaneColors.backgroundSecondary,
        Background.backgroundTertiary => ArcaneColors.backgroundTertiary,
        Background.surface => ArcaneColors.surface,
        Background.surfaceVariant => ArcaneColors.surfaceVariant,
        Background.card => ArcaneColors.card,
        Background.cardHover => ArcaneColors.cardHover,
        Background.cardAlt => ArcaneColors.cardAlt,
        Background.input => ArcaneColors.input,
        Background.navbar => ArcaneColors.navbar,
        Background.primary => ArcaneColors.primary,
        Background.secondary => ArcaneColors.secondary,
        Background.tertiary => ArcaneColors.tertiary,
        Background.accent => ArcaneColors.accent,
        Background.accentContainer => ArcaneColors.accentContainer,
        Background.success => ArcaneColors.success,
        Background.successContainer => ArcaneColors.successContainer,
        Background.warning => ArcaneColors.warning,
        Background.error => ArcaneColors.error,
        Background.info => ArcaneColors.info,
        Background.overlay => ArcaneColors.backgroundOverlay,
        Background.tooltip => ArcaneColors.tooltip,
        Background.code => ArcaneColors.codeBackground,
        Background.white => ArcaneColors.white,
        Background.black => ArcaneColors.black,
        Background.muted => ArcaneColors.muted,
        Background.brandPrimary => _qnPrimary,
        Background.brandSecondary => _qnSecondary,
        Background.glassTint => ArcaneColors.onSurfaceAlpha05,
        Background.glassHeader => ArcaneColors.onSurfaceAlpha03,
        Background.glassOverlay => ArcaneColors.onSurfaceAlpha08,
        Background.destructive => ArcaneColors.error,
      };
}

/// Text/foreground color presets for typography.
///
/// These colors automatically adapt to theme changes and ensure proper
/// contrast ratios for accessibility.
///
/// ## Common Text Colors
///
/// | Preset           | Use Case                                |
/// |------------------|----------------------------------------|
/// | `primary`        | Main body text                          |
/// | `secondary`      | Secondary/supporting text               |
/// | `muted`          | De-emphasized text                      |
/// | `accent`         | Links, highlighted text                 |
/// | `onSurface`      | Text on surface backgrounds             |
///
/// ## Status Colors
///
/// | Preset              | Use Case                             |
/// |---------------------|--------------------------------------|
/// | `success`           | Success messages                     |
/// | `warning`           | Warning messages                     |
/// | `error`             | Error messages                       |
/// | `info`              | Info messages                        |
///
/// ## Example
///
/// ```dart
/// ArcaneText(
///   'Hello World',
///   color: TextColor.primary,   // Main text
///   // color: TextColor.muted,  // De-emphasized
///   // color: TextColor.accent, // Highlighted
/// )
/// ```
enum TextColor {
  /// Primary text (on background)
  primary,

  /// Secondary text (on surface)
  secondary,

  /// Muted text
  muted,

  /// Muted foreground
  mutedForeground,

  /// Subtle text (less visible than muted)
  subtle,

  /// Faint text (least visible)
  faint,

  /// Accent colored text
  accent,

  /// Accent foreground (text on accent backgrounds)
  accentForeground,

  /// Success colored text
  success,

  /// Success foreground
  successForeground,

  /// Warning colored text
  warning,

  /// Warning foreground
  warningForeground,

  /// Error colored text
  error,

  /// Error foreground
  errorForeground,

  /// Info colored text
  info,

  /// Info foreground
  infoForeground,

  /// Text on primary backgrounds
  onPrimary,

  /// Text on secondary backgrounds
  onSecondary,

  /// Text on background
  onBackground,

  /// Text on surface
  onSurface,

  /// Text on surface variant
  onSurfaceVariant,

  /// Card foreground
  cardForeground,

  /// Input foreground
  inputForeground,

  /// Tooltip foreground
  tooltipForeground,

  /// Pure white text
  white,

  /// Pure black text
  black,

  /// Inherit from parent
  inherit,

  /// Brand primary color (theme-reactive)
  brandPrimary,

  /// Brand color alias for brandPrimary
  brand,

  /// Brand secondary color (theme-reactive)
  brandSecondary,

  /// Neon pink
  neonPink,

  /// Neon cyan
  neonCyan,

  /// Neon purple
  neonPurple,

  /// Neon green
  neonGreen,

  /// Neon orange
  neonOrange,

  /// Star/rating color (gold/yellow)
  star;

  String get css => switch (this) {
        TextColor.primary => ArcaneColors.onBackground,
        TextColor.secondary => ArcaneColors.onSurface,
        TextColor.muted => ArcaneColors.muted,
        TextColor.mutedForeground => ArcaneColors.mutedForeground,
        TextColor.subtle => ArcaneColors.textSubtle,
        TextColor.faint => ArcaneColors.textFaint,
        TextColor.accent => ArcaneColors.accent,
        TextColor.accentForeground => ArcaneColors.accentForeground,
        TextColor.success => ArcaneColors.success,
        TextColor.successForeground => ArcaneColors.successForeground,
        TextColor.warning => ArcaneColors.warning,
        TextColor.warningForeground => ArcaneColors.warningForeground,
        TextColor.error => ArcaneColors.error,
        TextColor.errorForeground => ArcaneColors.errorForeground,
        TextColor.info => ArcaneColors.info,
        TextColor.infoForeground => ArcaneColors.infoForeground,
        TextColor.onPrimary => ArcaneColors.onPrimary,
        TextColor.onSecondary => ArcaneColors.onSecondary,
        TextColor.onBackground => ArcaneColors.onBackground,
        TextColor.onSurface => ArcaneColors.onSurface,
        TextColor.onSurfaceVariant => ArcaneColors.onSurfaceVariant,
        TextColor.cardForeground => ArcaneColors.cardForeground,
        TextColor.inputForeground => ArcaneColors.inputForeground,
        TextColor.tooltipForeground => ArcaneColors.tooltipForeground,
        TextColor.white => ArcaneColors.white,
        TextColor.black => ArcaneColors.black,
        TextColor.inherit => 'inherit',
        TextColor.brandPrimary => _qnPrimary,
        TextColor.brand => _qnPrimary,
        TextColor.brandSecondary => _qnSecondary,
        TextColor.neonPink => ArcaneColors.neonPink,
        TextColor.neonCyan => ArcaneColors.neonCyan,
        TextColor.neonPurple => ArcaneColors.neonPurple,
        TextColor.neonGreen => ArcaneColors.neonGreen,
        TextColor.neonOrange => ArcaneColors.neonOrange,
        TextColor.star => ArcaneColors.warning,
      };
}

/// Border color presets for element borders.
///
/// Use with [BorderPreset] for complete border styling, or use
/// these colors with custom border widths and styles.
///
/// ## Common Border Colors
///
/// | Preset       | Use Case                                  |
/// |--------------|-------------------------------------------|
/// | `standard`   | Default borders                           |
/// | `subtle`     | Barely visible dividers                   |
/// | `accent`     | Highlighted/focused elements              |
/// | `ring`       | Focus ring color                          |
///
/// ## Example
///
/// ```dart
/// ArcaneDiv(
///   styles: const ArcaneStyleData(
///     border: BorderPreset.accent, // Complete border
///     // Or use borderColor with custom styles
///   ),
/// )
/// ```
enum BorderColor {
  /// Primary border
  standard,

  /// Subtle border
  subtle,

  /// Medium border
  medium,

  /// Light border
  light,

  /// Focus ring color
  ring,

  /// Accent border
  accent,

  /// Success border
  success,

  /// Warning border
  warning,

  /// Error border
  error,

  /// Info border
  info,

  /// Transparent border
  transparent,

  /// Outline color
  outline,

  /// Outline variant
  outlineVariant;

  String get css => switch (this) {
        BorderColor.standard => ArcaneColors.border,
        BorderColor.subtle => ArcaneColors.borderSubtle,
        BorderColor.medium => ArcaneColors.borderMedium,
        BorderColor.light => ArcaneColors.borderLight,
        BorderColor.ring => ArcaneColors.ring,
        BorderColor.accent => ArcaneColors.accent,
        BorderColor.success => ArcaneColors.success,
        BorderColor.warning => ArcaneColors.warning,
        BorderColor.error => ArcaneColors.error,
        BorderColor.info => ArcaneColors.info,
        BorderColor.transparent => ArcaneColors.transparent,
        BorderColor.outline => ArcaneColors.outline,
        BorderColor.outlineVariant => ArcaneColors.outlineVariant,
      };
}

/// Neon/gaming accent colors
enum NeonColor {
  pink,
  cyan,
  purple,
  green,
  orange;

  String get css => switch (this) {
        NeonColor.pink => ArcaneColors.neonPink,
        NeonColor.cyan => ArcaneColors.neonCyan,
        NeonColor.purple => ArcaneColors.neonPurple,
        NeonColor.green => ArcaneColors.neonGreen,
        NeonColor.orange => ArcaneColors.neonOrange,
      };
}

/// Game-specific brand colors
enum GameColor {
  minecraft,
  rust,
  ark,
  valheim,
  cs2,
  terraria;

  String get css => switch (this) {
        GameColor.minecraft => ArcaneColors.minecraftGreen,
        GameColor.rust => ArcaneColors.rustOrange,
        GameColor.ark => ArcaneColors.arkBlue,
        GameColor.valheim => ArcaneColors.valheimGold,
        GameColor.cs2 => ArcaneColors.cs2Orange,
        GameColor.terraria => ArcaneColors.terrariaGreen,
      };
}
