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
    'background-color': 'rgba(59, 130, 246, 0.1)',
    'border': '1px solid rgba(59, 130, 246, 0.3)',
    'color': ArcaneColors.info,
  }, iconColor: ArcaneColors.info);

  /// Success alert (green)
  static const AlertStyle success = AlertStyle._({
    'background-color': 'rgba(16, 185, 129, 0.1)',
    'border': '1px solid rgba(16, 185, 129, 0.3)',
    'color': ArcaneColors.success,
  }, iconColor: ArcaneColors.success);

  /// Warning alert (amber)
  static const AlertStyle warning = AlertStyle._({
    'background-color': 'rgba(245, 158, 11, 0.1)',
    'border': '1px solid rgba(245, 158, 11, 0.3)',
    'color': ArcaneColors.warning,
  }, iconColor: ArcaneColors.warning);

  /// Error alert (red)
  static const AlertStyle error = AlertStyle._({
    'background-color': 'rgba(239, 68, 68, 0.1)',
    'border': '1px solid rgba(239, 68, 68, 0.3)',
    'color': ArcaneColors.error,
  }, iconColor: ArcaneColors.error);

  /// Alias for error
  static const AlertStyle destructive = error;
}
