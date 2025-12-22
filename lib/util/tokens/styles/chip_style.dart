import '../tokens.dart';

// =============================================================================
// CHIP STYLE PRESETS
// =============================================================================

/// Chip styling presets
/// Use like: ArcaneChip(style: ChipStyle.primary)
class ChipStyle {
  final Map<String, String> styles;

  const ChipStyle._(this.styles);

  /// Create a custom chip style
  const ChipStyle.custom(this.styles);

  /// Default chip
  static const ChipStyle standard = ChipStyle._({
    'background-color': ArcaneColors.surfaceVariant,
    'color': ArcaneColors.onSurface,
    'border': 'none',
  });

  /// Primary chip
  static const ChipStyle primary = ChipStyle._({
    'background-color': ArcaneColors.accentContainer,
    'color': ArcaneColors.accent,
    'border': 'none',
  });

  /// Outlined chip
  static const ChipStyle outline = ChipStyle._({
    'background-color': ArcaneColors.transparent,
    'color': ArcaneColors.onSurface,
    'border': '1px solid ${ArcaneColors.border}',
  });

  /// Success chip
  static const ChipStyle success = ChipStyle._({
    'background-color': ArcaneColors.successAlpha15,
    'color': ArcaneColors.success,
    'border': 'none',
  });

  /// Warning chip
  static const ChipStyle warning = ChipStyle._({
    'background-color': ArcaneColors.warningAlpha15,
    'color': ArcaneColors.warning,
    'border': 'none',
  });

  /// Error chip
  static const ChipStyle error = ChipStyle._({
    'background-color': ArcaneColors.errorAlpha15,
    'color': ArcaneColors.error,
    'border': 'none',
  });
}
