import 'package:arcane_jaspr/flutter.dart';

enum AlertBannerVariant {
  info,
  success,
  warning,
  error,
  neutral,
}

/// Alert banner component properties.
class AlertBannerProps {
  final String message;
  final String? title;
  final AlertBannerVariant variant;
  final Widget? icon;
  final Widget? action;
  final bool dismissible;
  final void Function()? onDismiss;
  final bool filled;

  const AlertBannerProps({
    required this.message,
    this.title,
    this.variant = AlertBannerVariant.info,
    this.icon,
    this.action,
    this.dismissible = false,
    this.onDismiss,
    this.filled = false,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for alert banner components.
mixin AlertBannerRendererContract {
  Widget alertBanner(AlertBannerProps props);
}
