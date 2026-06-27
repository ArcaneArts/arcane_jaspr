import 'package:arcane_jaspr/flutter.dart';
import '../shared/shared.dart';

export '../shared/shared.dart' show ColorVariant;

/// Alert visual style variant.
enum AlertStyle {
  subtle,
  solid,
  outline,
  accent,
}

/// Alert component properties.
class AlertProps {
  final ColorVariant color;
  final String? title;
  final String? message;
  final Widget? child;
  final AlertStyle style;
  final Widget? icon;
  final bool showIcon;
  final bool dismissible;
  final void Function()? onDismiss;
  final Widget? action;

  const AlertProps({
    required this.color,
    this.title,
    this.message,
    this.child,
    this.style = AlertStyle.subtle,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    this.action,
  });

  AlertProps copyWith({
    ColorVariant? color,
    String? title,
    String? message,
    Widget? child,
    AlertStyle? style,
    Widget? icon,
    bool? showIcon,
    bool? dismissible,
    void Function()? onDismiss,
    Widget? action,
  }) {
    return AlertProps(
      color: color ?? this.color,
      title: title ?? this.title,
      message: message ?? this.message,
      child: child ?? this.child,
      style: style ?? this.style,
      icon: icon ?? this.icon,
      showIcon: showIcon ?? this.showIcon,
      dismissible: dismissible ?? this.dismissible,
      onDismiss: onDismiss ?? this.onDismiss,
      action: action ?? this.action,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for alert components.
mixin AlertRendererContract {
  /// Renders an alert notification component.
  Widget alert(AlertProps props);
}
