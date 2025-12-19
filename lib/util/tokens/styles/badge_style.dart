import '../tokens.dart';

// =============================================================================
// BADGE STYLE PRESETS
// =============================================================================

/// Badge styling presets
/// Use like: ArcaneBadge(style: BadgeStyle.success)
class BadgeStyle {
  final Map<String, String> styles;

  const BadgeStyle._(this.styles);

  /// Create a custom badge style
  const BadgeStyle.custom(this.styles);

  /// Merge with additional styles
  Map<String, String> withOverrides(Map<String, String> overrides) {
    return {...styles, ...overrides};
  }

  /// Default badge (neutral)
  static const BadgeStyle standard = BadgeStyle._({
    'background-color': ArcaneColors.surfaceVariant,
    'color': ArcaneColors.onSurface,
  });

  /// Primary badge (accent colored)
  static const BadgeStyle primary = BadgeStyle._({
    'background-color': ArcaneColors.accentContainer,
    'color': ArcaneColors.accent,
  });

  /// Secondary badge
  static const BadgeStyle secondary = BadgeStyle._({
    'background-color': ArcaneColors.secondaryContainer,
    'color': ArcaneColors.onSecondaryContainer,
  });

  /// Success badge (green)
  static const BadgeStyle success = BadgeStyle._({
    'background-color': ArcaneColors.success,
    'color': ArcaneColors.successForeground,
  });

  /// Warning badge (amber)
  static const BadgeStyle warning = BadgeStyle._({
    'background-color': ArcaneColors.warning,
    'color': ArcaneColors.warningForeground,
  });

  /// Error/destructive badge (red)
  static const BadgeStyle error = BadgeStyle._({
    'background-color': ArcaneColors.error,
    'color': ArcaneColors.errorForeground,
  });

  /// Alias for error
  static const BadgeStyle destructive = error;

  /// Info badge (blue)
  static const BadgeStyle info = BadgeStyle._({
    'background-color': ArcaneColors.info,
    'color': ArcaneColors.infoForeground,
  });

  /// Outline badge
  static const BadgeStyle outline = BadgeStyle._({
    'background-color': ArcaneColors.transparent,
    'color': ArcaneColors.onSurface,
    'border': '1px solid ${ArcaneColors.border}',
  });
}
