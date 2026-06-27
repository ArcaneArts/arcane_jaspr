import 'package:arcane_jaspr/flutter.dart';
import '../interaction/interaction.dart';
import '../shared/shared.dart';

export '../shared/shared.dart' show ComponentSize, ColorVariant;

enum FABPosition {
  bottomRight,
  bottomLeft,
  bottomCenter,
  topRight,
  topLeft,
  relative,
}

class FABProps {
  final Widget icon;
  final String? label;
  final void Function()? onPressed;
  final ArcaneInteraction? action;
  final ColorVariant color;
  final ComponentSize size;
  final bool disabled;
  final FABPosition position;
  final String? tooltip;
  final String? id;
  final Map<String, String>? attributes;

  const FABProps({
    required this.icon,
    this.label,
    this.onPressed,
    this.action,
    this.color = ColorVariant.primary,
    this.size = ComponentSize.md,
    this.disabled = false,
    this.position = FABPosition.bottomRight,
    this.tooltip,
    this.id,
    this.attributes,
  });

  FABProps copyWith({
    Widget? icon,
    String? label,
    void Function()? onPressed,
    ArcaneInteraction? action,
    ColorVariant? color,
    ComponentSize? size,
    bool? disabled,
    FABPosition? position,
    String? tooltip,
    String? id,
    Map<String, String>? attributes,
  }) {
    return FABProps(
      icon: icon ?? this.icon,
      label: label ?? this.label,
      onPressed: onPressed ?? this.onPressed,
      action: action ?? this.action,
      color: color ?? this.color,
      size: size ?? this.size,
      disabled: disabled ?? this.disabled,
      position: position ?? this.position,
      tooltip: tooltip ?? this.tooltip,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer method for floating action button components.
mixin FabRendererContract {
  /// Render a floating action button component.
  Widget fab(FABProps props);
}
