import 'package:arcane_jaspr/flutter.dart';

enum CalloutVariant {
  info,
  success,
  warning,
  error,
  neutral,
  tip,
  note,
}

/// Callout component properties.
class CalloutProps {
  final String? title;
  final String? content;
  final Widget? child;
  final CalloutVariant variant;
  final Widget? icon;
  final bool showIcon;
  final bool dismissible;
  final void Function()? onDismiss;

  const CalloutProps({
    this.title,
    this.content,
    this.child,
    this.variant = CalloutVariant.info,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for callout components.
mixin CalloutRendererContract {
  /// Renders a callout component.
  Widget callout(CalloutProps props);
}
