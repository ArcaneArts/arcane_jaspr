import '../tokens.dart';

// =============================================================================
// PROGRESS STYLE PRESETS
// =============================================================================

/// Progress bar styling presets
class ProgressStyle {
  final String trackColor;
  final String fillColor;
  final String? gradientValue;

  const ProgressStyle._({
    required this.trackColor,
    required this.fillColor,
    this.gradientValue,
  });

  /// Default progress (accent color)
  static const ProgressStyle standard = ProgressStyle._(
    trackColor: ArcaneColors.surfaceVariant,
    fillColor: ArcaneColors.accent,
  );

  /// Success progress (green)
  static const ProgressStyle success = ProgressStyle._(
    trackColor: ArcaneColors.surfaceVariant,
    fillColor: ArcaneColors.success,
  );

  /// Warning progress (amber)
  static const ProgressStyle warning = ProgressStyle._(
    trackColor: ArcaneColors.surfaceVariant,
    fillColor: ArcaneColors.warning,
  );

  /// Error progress (red)
  static const ProgressStyle error = ProgressStyle._(
    trackColor: ArcaneColors.surfaceVariant,
    fillColor: ArcaneColors.error,
  );

  /// Gradient progress
  static const ProgressStyle gradient = ProgressStyle._(
    trackColor: ArcaneColors.surfaceVariant,
    fillColor: ArcaneColors.accent,
    gradientValue: 'linear-gradient(90deg, ${ArcaneColors.accent}, ${ArcaneColors.accentHover})',
  );
}
