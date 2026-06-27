import 'package:arcane_jaspr/flutter.dart';

import '../interaction/interaction.dart';

enum ButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
  destructive,
  link,
  success,
  warning,
  info,
  accent,
}

/// Button size enum with icon variants.
/// Supports both abbreviated (sm/md/lg) and spelled-out (small/medium/large) styles.
enum ButtonSize {
  sm,
  md,
  lg,
  iconSm,
  iconMd,
  iconLg;

  static const ButtonSize small = sm;
  static const ButtonSize medium = md;
  static const ButtonSize large = lg;
  static const ButtonSize icon = iconMd;
  static const ButtonSize iconSmall = iconSm;
  static const ButtonSize iconMedium = iconMd;
  static const ButtonSize iconLarge = iconLg;
}

class ButtonProps {
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
  final String? id;
  final Map<String, String>? attributes;
  final String? href;
  final bool showArrow;

  const ButtonProps({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.action,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.md,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.id,
    this.attributes,
    this.href,
    this.showArrow = false,
  });

  ButtonProps copyWith({
    String? label,
    Widget? child,
    Widget? icon,
    Widget? trailing,
    void Function()? onPressed,
    ArcaneInteraction? action,
    ButtonVariant? variant,
    ButtonSize? size,
    bool? disabled,
    bool? loading,
    bool? fullWidth,
    String? id,
    Map<String, String>? attributes,
    String? href,
    bool? showArrow,
  }) {
    return ButtonProps(
      label: label ?? this.label,
      child: child ?? this.child,
      icon: icon ?? this.icon,
      trailing: trailing ?? this.trailing,
      onPressed: onPressed ?? this.onPressed,
      action: action ?? this.action,
      variant: variant ?? this.variant,
      size: size ?? this.size,
      disabled: disabled ?? this.disabled,
      loading: loading ?? this.loading,
      fullWidth: fullWidth ?? this.fullWidth,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
      href: href ?? this.href,
      showArrow: showArrow ?? this.showArrow,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer method for button components.
mixin ButtonRendererContract {
  /// Render a button component.
  Widget button(ButtonProps props);
}
