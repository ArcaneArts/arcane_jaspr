import 'package:arcane_jaspr/flutter.dart';
import '../../component/view/icon.dart';
import '../interaction/interaction.dart';
import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';

enum RadioGroupLayout { vertical, horizontal, grid }

enum RadioGroupVariant { standard, cards, buttons }

/// Radio option data.
class RadioOptionProps<T> {
  final T value;
  final String label;
  final String? description;
  final bool disabled;
  final ArcaneGlyph? icon;
  final String? id;

  const RadioOptionProps({
    required this.value,
    required this.label,
    this.description,
    this.disabled = false,
    this.icon,
    this.id,
  });
}

/// Radio group component properties.
class RadioGroupProps<T> {
  final String? id;
  final T? value;
  final List<RadioOptionProps<T>> options;
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

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const RadioGroupProps({
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
    this.styles,
    this.decoration,
  });

  RadioGroupProps<T> copyWith({
    String? id,
    T? value,
    List<RadioOptionProps<T>>? options,
    void Function(T value)? onChanged,
    ArcaneInteraction? onChangeAction,
    String? name,
    RadioGroupLayout? layout,
    RadioGroupVariant? variant,
    bool? disabled,
    String? label,
    String? helperText,
    String? error,
    bool? required,
    String? gap,
    int? gridColumns,
    ArcaneStyleData? styles,
    ArcaneDecoration? decoration,
  }) {
    return RadioGroupProps<T>(
      id: id ?? this.id,
      value: value ?? this.value,
      options: options ?? this.options,
      onChanged: onChanged ?? this.onChanged,
      onChangeAction: onChangeAction ?? this.onChangeAction,
      name: name ?? this.name,
      layout: layout ?? this.layout,
      variant: variant ?? this.variant,
      disabled: disabled ?? this.disabled,
      label: label ?? this.label,
      helperText: helperText ?? this.helperText,
      error: error ?? this.error,
      required: required ?? this.required,
      gap: gap ?? this.gap,
      gridColumns: gridColumns ?? this.gridColumns,
      styles: styles ?? this.styles,
      decoration: decoration ?? this.decoration,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer method for radio group components.
mixin RadioGroupRendererContract {
  /// Render a radio group component.
  Widget radioGroup<T>(RadioGroupProps<T> props);
}
