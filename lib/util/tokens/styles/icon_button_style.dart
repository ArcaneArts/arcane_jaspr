import '../tokens.dart';

// =============================================================================
// ICON BUTTON STYLE PRESETS
// =============================================================================

/// Icon button styling presets
/// Use like: ArcaneIconButton(style: IconButtonStyle.primary)
class IconButtonStyle {
  final Map<String, String> base;
  final Map<String, String> hover;

  const IconButtonStyle._({
    required this.base,
    this.hover = const {},
  });

  /// Primary icon button
  static const IconButtonStyle primary = IconButtonStyle._(
    base: {
      'background-color': ArcaneColors.accent,
      'color': ArcaneColors.accentForeground,
      'border': 'none',
    },
    hover: {
      'background-color': ArcaneColors.accentHover,
    },
  );

  /// Secondary icon button
  static const IconButtonStyle secondary = IconButtonStyle._(
    base: {
      'background-color': ArcaneColors.surfaceVariant,
      'color': ArcaneColors.onSurface,
      'border': '1px solid ${ArcaneColors.border}',
    },
    hover: {
      'background-color': ArcaneColors.surface,
    },
  );

  /// Outline icon button
  static const IconButtonStyle outline = IconButtonStyle._(
    base: {
      'background-color': ArcaneColors.transparent,
      'color': ArcaneColors.onSurface,
      'border': '1px solid ${ArcaneColors.border}',
    },
    hover: {
      'background-color': ArcaneColors.surfaceVariant,
    },
  );

  /// Ghost icon button (default)
  static const IconButtonStyle ghost = IconButtonStyle._(
    base: {
      'background-color': ArcaneColors.transparent,
      'color': ArcaneColors.muted,
      'border': 'none',
    },
    hover: {
      'background-color': ArcaneColors.surfaceVariant,
      'color': ArcaneColors.onSurface,
    },
  );

  /// Destructive icon button
  static const IconButtonStyle destructive = IconButtonStyle._(
    base: {
      'background-color': ArcaneColors.error,
      'color': ArcaneColors.errorForeground,
      'border': 'none',
    },
    hover: {
      'filter': 'brightness(1.1)',
    },
  );

  /// Success icon button
  static const IconButtonStyle success = IconButtonStyle._(
    base: {
      'background-color': ArcaneColors.success,
      'color': ArcaneColors.successForeground,
      'border': 'none',
    },
    hover: {
      'filter': 'brightness(1.1)',
    },
  );

  /// Warning icon button
  static const IconButtonStyle warning = IconButtonStyle._(
    base: {
      'background-color': ArcaneColors.warning,
      'color': ArcaneColors.warningForeground,
      'border': 'none',
    },
    hover: {
      'filter': 'brightness(1.1)',
    },
  );
}
