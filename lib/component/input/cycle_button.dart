import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/interaction/interaction.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

export '../../core/props/cycle_button_props.dart'
    show CycleButtonSize, CycleButtonVariant, CycleOption;

/// A button that cycles through a list of values on each click.
class ArcaneCycleButton<T> extends StatelessWidget {
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

  const ArcaneCycleButton({
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return context.renderers.cycleButton<T>(CycleButtonProps<T>(
      options: options,
      value: value,
      onChanged: onChanged,
      onChangeAction: onChangeAction,
      variant: variant,
      size: size,
      disabled: disabled,
      id: id,
      attributes: attributes,
      styles: styles,
      decoration: decoration,
    ));
  }
}

/// A toggle button (on/off state).
class ArcaneToggleButton extends StatelessWidget {
  final bool value;
  final void Function(bool value)? onChanged;
  final ArcaneInteraction? onChangeAction;
  final String? label;
  final Widget? icon;
  final CycleButtonSize size;
  final bool disabled;
  final String? id;
  final Map<String, String>? attributes;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const ArcaneToggleButton({
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return context.renderers.toggleButton(ToggleButtonProps(
      value: value,
      onChanged: onChanged,
      onChangeAction: onChangeAction,
      label: label,
      icon: icon,
      size: size,
      disabled: disabled,
      id: id,
      attributes: attributes,
      styles: styles,
      decoration: decoration,
    ));
  }
}
