import 'package:arcane_jaspr/flutter.dart';
import '../shared/shared.dart';
import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';

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
  final AlertStyle variant;
  final Widget? icon;
  final bool showIcon;
  final bool dismissible;
  final void Function()? onDismiss;
  final Widget? action;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const AlertProps({
    required this.color,
    this.title,
    this.message,
    this.child,
    this.variant = AlertStyle.subtle,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    this.action,
    this.styles,
    this.decoration,
  });

  AlertProps copyWith({
    ColorVariant? color,
    String? title,
    String? message,
    Widget? child,
    AlertStyle? variant,
    Widget? icon,
    bool? showIcon,
    bool? dismissible,
    void Function()? onDismiss,
    Widget? action,
    ArcaneStyleData? styles,
    ArcaneDecoration? decoration,
  }) {
    return AlertProps(
      color: color ?? this.color,
      title: title ?? this.title,
      message: message ?? this.message,
      child: child ?? this.child,
      variant: variant ?? this.variant,
      icon: icon ?? this.icon,
      showIcon: showIcon ?? this.showIcon,
      dismissible: dismissible ?? this.dismissible,
      onDismiss: onDismiss ?? this.onDismiss,
      action: action ?? this.action,
      styles: styles ?? this.styles,
      decoration: decoration ?? this.decoration,
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
