import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/interaction/interaction.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

export '../../core/props/button_props.dart'
    show ButtonVariant, ButtonSize, ButtonType;

/// A styled button component.
///
/// Can render as either a `<button>` or `<a>` element depending on whether
/// [href] is provided. Use [href] for CTA buttons that navigate to other pages.
class Button extends StatelessWidget {
  final String? label;
  final Widget? child;
  final Widget? icon;
  final Widget? trailing;
  final void Function()? onPressed;
  final ArcaneInteraction? action;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool disabled;
  final bool loading;
  final bool fullWidth;
  final Map<String, String>? attributes;
  final String? id;

  /// Native `<button type>` used when this renders as a button.
  /// Ignored when [href] renders the control as an anchor.
  final ButtonType type;

  /// If provided, renders the button as an anchor tag (`<a>`) instead of `<button>`.
  /// Useful for CTA buttons that navigate to other pages.
  final String? href;

  /// Whether to show an arrow indicator after the label.
  /// Useful for CTA buttons to indicate navigation.
  final bool showArrow;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const Button({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.action,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    this.type = ButtonType.button,
    this.href,
    this.showArrow = false,
    this.styles,
    this.decoration,
    super.key,
  });

  const Button.primary({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.action,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    this.type = ButtonType.button,
    this.href,
    this.showArrow = false,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = ButtonVariant.primary;

  const Button.secondary({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.action,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    this.type = ButtonType.button,
    this.href,
    this.showArrow = false,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = ButtonVariant.secondary;

  const Button.outline({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.action,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    this.type = ButtonType.button,
    this.href,
    this.showArrow = false,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = ButtonVariant.outline;

  const Button.ghost({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.action,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    this.type = ButtonType.button,
    this.href,
    this.showArrow = false,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = ButtonVariant.ghost;

  const Button.destructive({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.action,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    this.type = ButtonType.button,
    this.href,
    this.showArrow = false,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = ButtonVariant.destructive;

  const Button.warning({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.action,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    this.type = ButtonType.button,
    this.href,
    this.showArrow = false,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = ButtonVariant.warning;

  const Button.success({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.action,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    this.type = ButtonType.button,
    this.href,
    this.showArrow = false,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = ButtonVariant.success;

  const Button.link({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.action,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    this.type = ButtonType.button,
    this.href,
    this.showArrow = false,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = ButtonVariant.link;

  const Button.info({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.action,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    this.type = ButtonType.button,
    this.href,
    this.showArrow = false,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = ButtonVariant.info;

  /// Accent variant with gradient background.
  /// Useful for prominent CTA buttons.
  const Button.accent({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.action,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    this.type = ButtonType.button,
    this.href,
    this.showArrow = false,
    this.styles,
    this.decoration,
    super.key,
  }) : variant = ButtonVariant.accent;

  @override
  Widget build(BuildContext context) {
    return context.renderers.button(
      ButtonProps(
        label: label,
        child: child,
        icon: icon,
        trailing: trailing,
        onPressed: onPressed,
        action: action,
        variant: variant,
        size: size,
        disabled: disabled,
        loading: loading,
        fullWidth: fullWidth,
        id: id,
        attributes: attributes,
        href: href,
        type: type,
        showArrow: showArrow,
        styles: styles,
        decoration: decoration,
      ),
    );
  }
}
