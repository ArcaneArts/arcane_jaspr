import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';
import 'provider.dart';

/// Metadata class holding descriptive information for an [ArcaneField].
class ArcaneFieldMetadata {
  /// Unique identifier for the field.
  final String? key;

  /// Human-readable name for the field.
  final String? name;

  /// Descriptive text explaining the field's purpose.
  final String? description;

  /// Icon identifier for the field.
  final String? icon;

  /// Placeholder text for the field.
  final String? placeholder;

  const ArcaneFieldMetadata({
    this.name,
    this.key,
    this.icon,
    this.description,
    this.placeholder,
  });

  /// Computes an effective key for the field.
  String get effectiveKey =>
      key ??
      name?.toLowerCase().replaceAll(' ', '_').replaceAll("/", ".") ??
      "no_key";
}

/// A generic form field component in the Arcane UI component system.
class ArcaneField<T> extends StatefulComponent {
  /// Metadata associated with this field.
  final ArcaneFieldMetadata meta;

  /// Provider responsible for managing the field's data state.
  final ArcaneFieldProvider<T> provider;

  /// Custom builder function for the input widget.
  final Component Function(BuildContext context, T value, void Function(T) onChanged) builder;

  /// Returns the runtime type of the field's data [T].
  Type get dataRuntimeType => T;

  const ArcaneField({
    required this.meta,
    required this.provider,
    required this.builder,
    super.key,
  });

  @override
  State<ArcaneField<T>> createState() => _ArcaneFieldState<T>();
}

class _ArcaneFieldState<T> extends State<ArcaneField<T>> {
  late T _value;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _value = component.provider.defaultValue;
    _loadValue();
  }

  Future<void> _loadValue() async {
    final T value = await component.provider.getValue(component.meta.effectiveKey);
    setState(() {
      _value = value;
      _loading = false;
    });
  }

  void _handleChange(T newValue) {
    setState(() {
      _value = newValue;
    });
    component.provider.setValue(component.meta.effectiveKey, newValue);
  }

  @override
  Component build(BuildContext context) {
    if (_loading) {
      return div(
        styles: Styles(raw: {
          'opacity': '0.5',
        }),
        [Component.text('Loading...')],
      );
    }

    return component.builder(context, _value, _handleChange);
  }
}

/// Factory class for creating common field types.
class ArcaneInput {
  const ArcaneInput._();

  /// Creates a text input field.
  static ArcaneField<String> textField({
    String? name,
    String? description,
    String? icon,
    String? placeholder,
    int? minLines,
    int? maxLines,
    String defaultValue = "",
    required Future<String> Function() getter,
    required Future<void> Function(String) setter,
  }) =>
      ArcaneField<String>(
        meta: ArcaneFieldMetadata(
          name: name,
          description: description,
          icon: icon,
          placeholder: placeholder,
        ),
        provider: ArcaneFieldDirectProvider(
          defaultValue: defaultValue,
          getter: (_) => getter(),
          setter: (_, v) => setter(v),
        ),
        builder: (context, value, onChanged) => _StringFieldBuilder(
          value: value,
          onChanged: onChanged,
          placeholder: placeholder,
          minLines: minLines,
          maxLines: maxLines,
        ),
      );

  /// Creates a text area input field.
  static ArcaneField<String> textArea({
    String? name,
    String? description,
    String? icon,
    String? placeholder,
    int minLines = 3,
    int maxLines = 6,
    String defaultValue = "",
    required Future<String> Function() getter,
    required Future<void> Function(String) setter,
  }) =>
      textField(
        name: name,
        description: description,
        icon: icon,
        placeholder: placeholder,
        minLines: minLines,
        maxLines: maxLines,
        defaultValue: defaultValue,
        getter: getter,
        setter: setter,
      );

  /// Creates a checkbox input field.
  static ArcaneField<bool> checkbox({
    String? name,
    String? description,
    String? icon,
    bool defaultValue = false,
    required Future<bool> Function() getter,
    required Future<void> Function(bool) setter,
  }) =>
      ArcaneField<bool>(
        meta: ArcaneFieldMetadata(
          name: name,
          description: description,
          icon: icon,
        ),
        provider: ArcaneFieldDirectProvider(
          defaultValue: defaultValue,
          getter: (_) => getter(),
          setter: (_, v) => setter(v),
        ),
        builder: (context, value, onChanged) => _BoolFieldBuilder(
          value: value,
          onChanged: onChanged,
          labelText: name,
        ),
      );

  /// Creates a select/dropdown field.
  static ArcaneField<T> select<T>({
    String? name,
    String? description,
    String? icon,
    required T defaultValue,
    required List<T> options,
    required Future<T> Function() getter,
    required Future<void> Function(T) setter,
    String Function(T)? labelBuilder,
  }) =>
      ArcaneField<T>(
        meta: ArcaneFieldMetadata(
          name: name,
          description: description,
          icon: icon,
        ),
        provider: ArcaneFieldDirectProvider(
          defaultValue: defaultValue,
          getter: (_) => getter(),
          setter: (_, v) => setter(v),
        ),
        builder: (context, value, onChanged) => _SelectFieldBuilder<T>(
          value: value,
          options: options,
          onChanged: onChanged,
          labelBuilder: labelBuilder ?? (v) => v.toString(),
        ),
      );
}

/// Internal string field builder component.
class _StringFieldBuilder extends StatelessComponent {
  final String value;
  final void Function(String) onChanged;
  final String? placeholder;
  final int? minLines;
  final int? maxLines;

  const _StringFieldBuilder({
    required this.value,
    required this.onChanged,
    this.placeholder,
    this.minLines,
    this.maxLines,
  });

  @override
  Component build(BuildContext context) {
    final bool isMultiline = (maxLines ?? 1) > 1;

    if (isMultiline) {
      return textarea(
        classes: 'arcane-field-textarea',
        attributes: {
          'placeholder': placeholder ?? '',
          'rows': '${maxLines ?? 3}',
        },
        styles: Styles(raw: {
          'width': '100%',
          'padding': '10px ${ArcaneSpacing.md}',
          'border': '1px solid ${ArcaneColors.border}',
          'border-radius': ArcaneRadius.md,
          'background-color': ArcaneColors.surface,
          'color': ArcaneColors.onSurface,
          'font-size': ArcaneTypography.fontSm,
          'resize': 'vertical',
          'font-family': 'inherit',
          'outline': 'none',
        }),
        events: {
          'input': (event) {
            final dynamic target = event.target;
            if (target != null) {
              onChanged((target as dynamic).value ?? '');
            }
          },
        },
        [Component.text(value)],
      );
    }

    return input(
      type: InputType.text,
      classes: 'arcane-field-input',
      attributes: {
        'value': value,
        'placeholder': placeholder ?? '',
      },
      styles: Styles(raw: {
        'width': '100%',
        'padding': '10px ${ArcaneSpacing.md}',
        'border': '1px solid ${ArcaneColors.border}',
        'border-radius': ArcaneRadius.md,
        'background-color': ArcaneColors.surface,
        'color': ArcaneColors.onSurface,
        'font-size': ArcaneTypography.fontSm,
        'outline': 'none',
      }),
      events: {
        'input': (event) {
          final dynamic target = event.target;
          if (target != null) {
            onChanged((target as dynamic).value ?? '');
          }
        },
      },
    );
  }
}

/// Internal bool field builder component.
class _BoolFieldBuilder extends StatelessComponent {
  final bool value;
  final void Function(bool) onChanged;
  final String? labelText;

  const _BoolFieldBuilder({
    required this.value,
    required this.onChanged,
    this.labelText,
  });

  @override
  Component build(BuildContext context) {
    return label(
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.sm,
        'cursor': 'pointer',
      }),
      [
        input(
          type: InputType.checkbox,
          attributes: {
            if (value) 'checked': 'true',
          },
          styles: Styles(raw: {
            'width': '18px',
            'height': '18px',
            'accent-color': ArcaneColors.accent,
            'cursor': 'pointer',
          }),
          events: {
            'change': (event) {
              final dynamic target = event.target;
              if (target != null) {
                onChanged((target as dynamic).checked ?? false);
              }
            },
          },
        ),
        if (labelText != null)
          span(
            styles: Styles(raw: {
              'color': ArcaneColors.onSurface,
              'font-size': ArcaneTypography.fontSm,
            }),
            [Component.text(labelText!)],
          ),
      ],
    );
  }
}

/// Internal select field builder component.
class _SelectFieldBuilder<T> extends StatelessComponent {
  final T value;
  final List<T> options;
  final void Function(T) onChanged;
  final String Function(T) labelBuilder;

  const _SelectFieldBuilder({
    required this.value,
    required this.options,
    required this.onChanged,
    required this.labelBuilder,
  });

  @override
  Component build(BuildContext context) {
    return select(
      classes: 'arcane-field-select',
      styles: Styles(raw: {
        'width': '100%',
        'padding': '10px ${ArcaneSpacing.md}',
        'border': '1px solid ${ArcaneColors.border}',
        'border-radius': ArcaneRadius.md,
        'background-color': ArcaneColors.surface,
        'color': ArcaneColors.onSurface,
        'font-size': ArcaneTypography.fontSm,
        'outline': 'none',
        'cursor': 'pointer',
      }),
      events: {
        'change': (event) {
          final dynamic target = event.target;
          if (target != null) {
            final int selectedIndex = (target as dynamic).selectedIndex as int? ?? 0;
            if (selectedIndex >= 0 && selectedIndex < options.length) {
              onChanged(options[selectedIndex]);
            }
          }
        },
      },
      [
        for (int i = 0; i < options.length; i++)
          option(
            value: i.toString(),
            selected: options[i] == value,
            [Component.text(labelBuilder(options[i]))],
          ),
      ],
    );
  }
}

/// Static styles for ArcaneField components (public for @css annotation)
class ArcaneFieldStyles {
  ArcaneFieldStyles._();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-field-textarea:focus, .arcane-field-input:focus').styles(raw: {
      'border-color': ArcaneColors.accent,
      'box-shadow': '0 0 0 2px ${ArcaneColors.accentContainer}',
    }),
    css('.arcane-field-select:focus').styles(raw: {
      'border-color': ArcaneColors.accent,
      'box-shadow': '0 0 0 2px ${ArcaneColors.accentContainer}',
    }),
  ];
}
