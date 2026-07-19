const String _qnPrimary = 'var(--qn-primary, #059669)';
const String _qnSecondary = 'var(--qn-secondary, #047857)';

/// Background color presets
enum Background {
  transparent,
  background,
  backgroundSecondary,
  backgroundTertiary,
  surface,
  surfaceVariant,
  card,
  cardHover,
  cardAlt,
  input,
  navbar,
  primary,
  secondary,
  tertiary,
  accent,
  accentContainer,
  success,
  successContainer,
  warning,
  error,
  info,
  overlay,
  tooltip,
  code,
  white,
  black,
  muted,
  brandPrimary,
  brandSecondary,
  glassTint,
  glassHeader,
  glassOverlay,
  destructive;

  String get css => switch (this) {
        Background.transparent => 'transparent',
        Background.background => 'var(--background)',
        Background.backgroundSecondary => 'var(--arcane-background-secondary, var(--muted))',
        Background.backgroundTertiary => 'var(--arcane-background-tertiary, var(--secondary))',
        Background.surface => 'var(--card)',
        Background.surfaceVariant => 'var(--secondary)',
        Background.card => 'var(--card)',
        Background.cardHover => 'var(--arcane-card-hover, var(--secondary))',
        Background.cardAlt => 'var(--arcane-card-alt, var(--secondary))',
        Background.input => 'var(--input)',
        Background.navbar => 'var(--arcane-navbar, color-mix(in srgb, var(--background) 80%, transparent))',
        Background.primary => 'var(--primary)',
        Background.secondary => 'var(--secondary)',
        Background.tertiary => 'var(--accent)',
        Background.accent => 'var(--primary)',
        Background.accentContainer => 'var(--arcane-accent-container, color-mix(in srgb, var(--primary) 10%, transparent))',
        Background.success => 'var(--success)',
        Background.successContainer => 'var(--arcane-success-container, color-mix(in srgb, var(--success) 10%, transparent))',
        Background.warning => 'var(--warning)',
        Background.error => 'var(--destructive)',
        Background.info => 'var(--info)',
        Background.overlay => 'var(--arcane-overlay, rgba(0, 0, 0, 0.5))',
        Background.tooltip => 'var(--popover)',
        Background.code => 'var(--arcane-code-background, var(--secondary))',
        Background.white => '#FFFFFF',
        Background.black => '#000000',
        Background.muted => 'var(--muted)',
        Background.brandPrimary => _qnPrimary,
        Background.brandSecondary => _qnSecondary,
        Background.glassTint => 'color-mix(in srgb, var(--foreground) 5%, transparent)',
        Background.glassHeader => 'color-mix(in srgb, var(--foreground) 3%, transparent)',
        Background.glassOverlay => 'color-mix(in srgb, var(--foreground) 8%, transparent)',
        Background.destructive => 'var(--destructive)',
      };
}

/// Text/foreground color presets
enum TextColor {
  primary,
  secondary,
  muted,
  mutedForeground,
  subtle,
  faint,
  accent,
  accentForeground,
  success,
  successForeground,
  warning,
  warningForeground,
  error,
  errorForeground,
  info,
  infoForeground,
  onPrimary,
  onSecondary,
  onBackground,
  onSurface,
  onSurfaceVariant,
  cardForeground,
  inputForeground,
  tooltipForeground,
  white,
  black,
  inherit,
  brandPrimary,
  brand,
  brandSecondary,
  star;

  String get css => switch (this) {
        TextColor.primary => 'var(--foreground)',
        TextColor.secondary => 'var(--card-foreground)',
        TextColor.muted => 'var(--muted-foreground)',
        TextColor.mutedForeground => 'var(--muted-foreground)',
        TextColor.subtle => 'color-mix(in srgb, var(--muted-foreground) 85%, transparent)',
        TextColor.faint => 'color-mix(in srgb, var(--muted-foreground) 65%, transparent)',
        TextColor.accent => 'var(--primary)',
        TextColor.accentForeground => 'var(--accent-foreground)',
        TextColor.success => 'var(--success)',
        TextColor.successForeground => 'var(--success-foreground)',
        TextColor.warning => 'var(--warning)',
        TextColor.warningForeground => 'var(--warning-foreground)',
        TextColor.error => 'var(--destructive)',
        TextColor.errorForeground => 'var(--destructive-foreground)',
        TextColor.info => 'var(--info)',
        TextColor.infoForeground => 'var(--info-foreground)',
        TextColor.onPrimary => 'var(--primary-foreground)',
        TextColor.onSecondary => 'var(--secondary-foreground)',
        TextColor.onBackground => 'var(--foreground)',
        TextColor.onSurface => 'var(--card-foreground)',
        TextColor.onSurfaceVariant => 'var(--secondary-foreground)',
        TextColor.cardForeground => 'var(--card-foreground)',
        TextColor.inputForeground => 'var(--foreground)',
        TextColor.tooltipForeground => 'var(--popover-foreground)',
        TextColor.white => '#FFFFFF',
        TextColor.black => '#000000',
        TextColor.inherit => 'inherit',
        TextColor.brandPrimary => _qnPrimary,
        TextColor.brand => _qnPrimary,
        TextColor.brandSecondary => _qnSecondary,
        TextColor.star => 'var(--warning)',
      };
}

/// Opacity and blend helpers for ANY CSS color string.
///
/// Colors cross the [ArcaneStyleData] boundary as raw strings — a hex value
/// (`#4CAF50`), a theme variable (`var(--primary)`), an `ArcaneColor.*.css`
/// token, or a runtime accent. The historic `${color}30` hex-alpha suffix hack
/// silently corrupts any non-hex color (`var(--primary)30` is invalid CSS);
/// these emit `color-mix()`, which works for every color form.
extension ArcaneColorOps on String {
  /// Fades this color toward transparent. [amount] is clamped to `0.0..1.0`.
  ///
  /// `'var(--primary)'.opacity(0.3)` → `color-mix(in srgb, var(--primary) 30%, transparent)`.
  String opacity(double amount) =>
      'color-mix(in srgb, $this ${_mixPercent(amount)}, transparent)';

  /// Blends [amount] of this color over [base] (alpha stays `1`).
  ///
  /// `'#000'.on('var(--card)', 0.1)` → `color-mix(in srgb, #000 10%, var(--card))`.
  String on(String base, double amount) =>
      'color-mix(in srgb, $this ${_mixPercent(amount)}, $base)';
}

String _mixPercent(double amount) {
  // Keep one decimal of precision so .opacity(0.125) -> 12.5% (not 13%) and
  // small values don't quantize to 0%. Emit a whole number when it is one.
  final double pct = (amount.clamp(0.0, 1.0) * 1000).round() / 10;
  return pct == pct.roundToDouble() ? '${pct.round()}%' : '$pct%';
}

/// Border color presets
enum BorderColor {
  standard,
  subtle,
  medium,
  light,
  ring,
  accent,
  success,
  warning,
  error,
  info,
  transparent,
  outline,
  outlineVariant;

  String get css => switch (this) {
        BorderColor.standard => 'var(--border)',
        BorderColor.subtle => 'var(--input)',
        BorderColor.medium => 'color-mix(in srgb, var(--foreground) 10%, transparent)',
        BorderColor.light => 'color-mix(in srgb, var(--foreground) 15%, transparent)',
        BorderColor.ring => 'var(--ring)',
        BorderColor.accent => 'var(--primary)',
        BorderColor.success => 'var(--success)',
        BorderColor.warning => 'var(--warning)',
        BorderColor.error => 'var(--destructive)',
        BorderColor.info => 'var(--info)',
        BorderColor.transparent => 'transparent',
        BorderColor.outline => 'var(--border)',
        BorderColor.outlineVariant => 'var(--input)',
      };
}
