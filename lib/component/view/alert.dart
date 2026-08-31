import 'package:arcane_jaspr/flutter.dart';

import '../../core/theme_provider.dart';
import '../../core/decoration/arcane_decoration.dart';
import '../../util/style_types/arcane_style_data.dart';
import 'icon.dart';

/// Inline alert component for important messages that need user attention.
class ArcaneAlert extends StatelessWidget {
  final ColorVariant color;
  final String? title;
  final String? message;
  final Widget? child;
  final AlertStyle variant;
  final ArcaneGlyph? icon;
  final bool showIcon;
  final bool dismissible;
  final void Function()? onDismiss;
  final Widget? action;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const ArcaneAlert({
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
    super.key,
  });

  const ArcaneAlert.info({
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
    super.key,
  }) : color = ColorVariant.info;

  const ArcaneAlert.success({
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
    super.key,
  }) : color = ColorVariant.success;

  const ArcaneAlert.warning({
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
    super.key,
  }) : color = ColorVariant.warning;

  const ArcaneAlert.error({
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
    super.key,
  }) : color = ColorVariant.destructive;

  @override
  Widget build(BuildContext context) {
    return context.renderers.alert(
      AlertProps(
        color: color,
        title: title,
        message: message,
        child: child,
        variant: variant,
        icon: icon,
        showIcon: showIcon,
        dismissible: dismissible,
        onDismiss: onDismiss,
        action: action,
        styles: styles,
        decoration: decoration,
      ),
    );
  }
}
