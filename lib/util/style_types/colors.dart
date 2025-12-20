import '../tokens/tokens.dart';

// CSS variable references for QualityNode brand colors
const String _qnPrimary = 'var(--qn-primary, #059669)';
const String _qnSecondary = 'var(--qn-secondary, #047857)';
const String _qnGradient =
    'var(--qn-gradient, linear-gradient(135deg, #059669 0%, #0891B2 100%))';
const String _qnGlow = 'var(--qn-glow, rgba(5, 150, 105, 0.35))';
const String _qnBorder = 'var(--qn-border, rgba(5, 150, 105, 0.25))';

/// Background color presets
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
  brandSecondary;

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
      };
}

/// Text/foreground color presets
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
        TextColor.star => '#F59E0B',
      };
}

/// Border color presets
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
