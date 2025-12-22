import '../tokens.dart';

// =============================================================================
// ALERT STYLE PRESETS
// =============================================================================

/// Alert/banner styling presets
/// Use like: ArcaneAlert(style: AlertStyle.warning)
class AlertStyle {
  final Map<String, String> styles;
  final String? iconColor;

  const AlertStyle._(this.styles, {this.iconColor});

  /// Create a custom alert style
  const AlertStyle.custom(this.styles, {this.iconColor});

  /// Info alert (blue)
  static const AlertStyle info = AlertStyle._({
    'background-color': ArcaneColors.infoAlpha10,
    'border': '1px solid ${ArcaneColors.infoAlpha30}',
    'color': ArcaneColors.info,
  }, iconColor: ArcaneColors.info);

  /// Success alert (green)
  static const AlertStyle success = AlertStyle._({
    'background-color': ArcaneColors.successAlpha10,
    'border': '1px solid ${ArcaneColors.successAlpha30}',
    'color': ArcaneColors.success,
  }, iconColor: ArcaneColors.success);

  /// Warning alert (amber)
  static const AlertStyle warning = AlertStyle._({
    'background-color': ArcaneColors.warningAlpha10,
    'border': '1px solid ${ArcaneColors.warningAlpha30}',
    'color': ArcaneColors.warning,
  }, iconColor: ArcaneColors.warning);

  /// Error alert (red)
  static const AlertStyle error = AlertStyle._({
    'background-color': ArcaneColors.errorAlpha10,
    'border': '1px solid ${ArcaneColors.errorAlpha30}',
    'color': ArcaneColors.error,
  }, iconColor: ArcaneColors.error);

  /// Alias for error
  static const AlertStyle destructive = error;
}
