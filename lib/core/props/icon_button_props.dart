import 'package:arcane_jaspr/flutter.dart';
import '../interaction/interaction.dart';
import '../shared/shared.dart';

export '../shared/shared.dart' show ComponentSize, ColorVariant, StyleVariant;

class IconButtonProps {
  final Widget icon;
  final void Function()? onPressed;
  final ArcaneInteraction? action;
  final ColorVariant color;
  final StyleVariant style;
  final ComponentSize size;
  final bool disabled;
  final bool loading;
  final String? tooltip;

  const IconButtonProps({
    required this.icon,
    this.onPressed,
    this.action,
    this.color = ColorVariant.secondary,
    this.style = StyleVariant.ghost,
    this.size = ComponentSize.md,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
  });

  IconButtonProps copyWith({
    Widget? icon,
    void Function()? onPressed,
    ArcaneInteraction? action,
    ColorVariant? color,
    StyleVariant? style,
    ComponentSize? size,
    bool? disabled,
    bool? loading,
    String? tooltip,
  }) {
    return IconButtonProps(
      icon: icon ?? this.icon,
      onPressed: onPressed ?? this.onPressed,
      action: action ?? this.action,
      color: color ?? this.color,
      style: style ?? this.style,
      size: size ?? this.size,
      disabled: disabled ?? this.disabled,
      loading: loading ?? this.loading,
      tooltip: tooltip ?? this.tooltip,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer method for icon button components.
mixin IconButtonRendererContract {
  /// Render an icon button component.
  Widget iconButton(IconButtonProps props);
}
