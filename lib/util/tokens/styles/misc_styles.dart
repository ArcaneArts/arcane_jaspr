import '../tokens.dart';

// =============================================================================
// DIVIDER STYLE PRESETS
// =============================================================================

/// Divider styling presets
class DividerStyle {
  final Map<String, String> styles;

  const DividerStyle._(this.styles);

  /// Default divider
  static const DividerStyle standard = DividerStyle._({
    'background-color': ArcaneColors.border,
    'height': '1px',
  });

  /// Subtle divider
  static const DividerStyle subtle = DividerStyle._({
    'background-color': ArcaneColors.borderSubtle,
    'height': '1px',
  });

  /// Bold divider
  static const DividerStyle bold = DividerStyle._({
    'background-color': ArcaneColors.border,
    'height': '2px',
  });
}

// =============================================================================
// AVATAR STYLE PRESETS
// =============================================================================

/// Avatar styling presets
class AvatarStyle {
  final Map<String, String> styles;

  const AvatarStyle._(this.styles);

  /// Circle avatar
  static const AvatarStyle circle = AvatarStyle._({
    'border-radius': ArcaneRadius.full,
    'overflow': 'hidden',
  });

  /// Rounded square avatar
  static const AvatarStyle rounded = AvatarStyle._({
    'border-radius': ArcaneRadius.lg,
    'overflow': 'hidden',
  });

  /// Square avatar
  static const AvatarStyle square = AvatarStyle._({
    'border-radius': ArcaneRadius.md,
    'overflow': 'hidden',
  });
}

// =============================================================================
// TOOLTIP STYLE PRESETS
// =============================================================================

/// Tooltip styling presets
class TooltipStyle {
  final Map<String, String> styles;

  const TooltipStyle._(this.styles);

  /// Dark tooltip (default)
  static const TooltipStyle dark = TooltipStyle._({
    'background-color': ArcaneColors.inverseSurface,
    'color': ArcaneColors.onInverseSurface,
    'border-radius': ArcaneRadius.sm,
    'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
    'font-size': ArcaneTypography.fontXs,
  });

  /// Light tooltip
  static const TooltipStyle light = TooltipStyle._({
    'background-color': ArcaneColors.surface,
    'color': ArcaneColors.onSurface,
    'border': '1px solid ${ArcaneColors.border}',
    'border-radius': ArcaneRadius.sm,
    'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
    'font-size': ArcaneTypography.fontXs,
    'box-shadow': ArcaneEffects.shadowMd,
  });
}
