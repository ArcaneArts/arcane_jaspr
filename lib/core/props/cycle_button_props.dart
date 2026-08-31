import 'package:arcane_jaspr/flutter.dart';
import '../../component/view/icon.dart';

import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';
import '../interaction/interaction.dart';

enum CycleButtonSize { small, medium, large, icon, iconSmall, iconLarge }

enum CycleButtonVariant { outline, primary, secondary, ghost, destructive }

/// Cycle option data.
class CycleOption<T> {
  final T value;
  final String? label;
  final ArcaneGlyph? icon;

  const CycleOption({required this.value, this.label, this.icon});
}

/// Cycle button component properties.
class CycleButtonProps<T> {
  final List<CycleOption<T>> options;
  final T value;
  final void Function(T value)? onChanged;
  final ArcaneInteraction? onChangeAction;
  final CycleButtonVariant variant;
  final CycleButtonSize size;
  final bool disabled;
  final String? id;
  final Map<String, String>? attributes;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const CycleButtonProps({
    required this.options,
    required this.value,
    this.onChanged,
    this.onChangeAction,
    this.variant = CycleButtonVariant.outline,
    this.size = CycleButtonSize.medium,
    this.disabled = false,
    this.id,
    this.attributes,
    this.styles,
    this.decoration,
  });

  CycleButtonProps<T> copyWith({
    List<CycleOption<T>>? options,
    T? value,
    void Function(T value)? onChanged,
    ArcaneInteraction? onChangeAction,
    CycleButtonVariant? variant,
    CycleButtonSize? size,
    bool? disabled,
    String? id,
    Map<String, String>? attributes,
    ArcaneStyleData? styles,
    ArcaneDecoration? decoration,
  }) {
    return CycleButtonProps<T>(
      options: options ?? this.options,
      value: value ?? this.value,
      onChanged: onChanged ?? this.onChanged,
      onChangeAction: onChangeAction ?? this.onChangeAction,
      variant: variant ?? this.variant,
      size: size ?? this.size,
      disabled: disabled ?? this.disabled,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
      styles: styles ?? this.styles,
      decoration: decoration ?? this.decoration,
    );
  }
}

/// Toggle button component properties.
class ToggleButtonProps {
  final bool value;
  final void Function(bool value)? onChanged;
  final ArcaneInteraction? onChangeAction;
  final String? label;
  final ArcaneGlyph? icon;
  final CycleButtonSize size;
  final bool disabled;
  final String? id;
  final Map<String, String>? attributes;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const ToggleButtonProps({
    required this.value,
    this.onChanged,
    this.onChangeAction,
    this.label,
    this.icon,
    this.size = CycleButtonSize.medium,
    this.disabled = false,
    this.id,
    this.attributes,
    this.styles,
    this.decoration,
  });

  ToggleButtonProps copyWith({
    bool? value,
    void Function(bool value)? onChanged,
    ArcaneInteraction? onChangeAction,
    String? label,
    ArcaneGlyph? icon,
    CycleButtonSize? size,
    bool? disabled,
    String? id,
    Map<String, String>? attributes,
    ArcaneStyleData? styles,
    ArcaneDecoration? decoration,
  }) {
    return ToggleButtonProps(
      value: value ?? this.value,
      onChanged: onChanged ?? this.onChanged,
      onChangeAction: onChangeAction ?? this.onChangeAction,
      label: label ?? this.label,
      icon: icon ?? this.icon,
      size: size ?? this.size,
      disabled: disabled ?? this.disabled,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
      styles: styles ?? this.styles,
      decoration: decoration ?? this.decoration,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for cycle button and toggle button components.
mixin CycleButtonRendererContract {
  /// Render a cycle button component.
  Widget cycleButton<T>(CycleButtonProps<T> props);

  /// Render a toggle button component.
  Widget toggleButton(ToggleButtonProps props);
}
