import 'package:arcane_jaspr/flutter.dart';

export '../../core/props/radio_group_props.dart'
    show RadioGroupLayout, RadioGroupVariant, RadioOptionProps;

import '../../core/interaction/interaction.dart';
import '../../core/theme_provider.dart';

/// Radio button option model.
class RadioOption<T> {
  final T value;
  final String label;
  final String? description;
  final bool disabled;
  final Widget? icon;
  final String? id;

  const RadioOption({
    required this.value,
    required this.label,
    this.description,
    this.disabled = false,
    this.icon,
    this.id,
  });
}

/// A radio button group component.
class ArcaneRadioGroup<T> extends StatelessWidget {
  final String? id;
  final T? value;
  final List<RadioOption<T>> options;
  final void Function(T value)? onChanged;
  final ArcaneInteraction? onChangeAction;
  final String? name;
  final RadioGroupLayout layout;
  final RadioGroupVariant variant;
  final bool disabled;
  final String? label;
  final String? helperText;
  final String? error;
  final bool required;
  final String gap;
  final int gridColumns;

  const ArcaneRadioGroup({
    required this.options,
    this.id,
    this.value,
    this.onChanged,
    this.onChangeAction,
    this.name,
    this.layout = RadioGroupLayout.vertical,
    this.variant = RadioGroupVariant.standard,
    this.disabled = false,
    this.label,
    this.helperText,
    this.error,
    this.required = false,
    this.gap = '0.5rem',
    this.gridColumns = 2,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<RadioOptionProps<T>> optionProps = options
        .map((opt) => RadioOptionProps<T>(
              value: opt.value,
              label: opt.label,
              description: opt.description,
              disabled: opt.disabled,
              icon: opt.icon,
              id: opt.id,
            ))
        .toList();

    return context.renderers.radioGroup<T>(RadioGroupProps<T>(
      id: id,
      value: value,
      options: optionProps,
      onChanged: onChanged,
      onChangeAction: onChangeAction,
      name: name,
      layout: layout,
      variant: variant,
      disabled: disabled,
      label: label,
      helperText: helperText,
      error: error,
      required: required,
      gap: gap,
      gridColumns: gridColumns,
    ));
  }
}
