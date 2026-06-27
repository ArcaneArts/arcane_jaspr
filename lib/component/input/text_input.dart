import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/jaspr.dart' as jaspr;
import 'package:jaspr/dom.dart' as dom;

export '../../core/props/text_input_props.dart'
    show ComponentSize, TextInputVariant, TextInputType;

import '../../core/interaction/interaction.dart';
import '../../core/theme_provider.dart';

/// A styled text input component.
class TextInput extends StatelessWidget {
  final String? placeholder;
  final TextInputType type;
  final ComponentSize size;
  final bool disabled;
  final bool required;
  final bool readOnly;
  final String? value;
  final String? name;
  final String? id;
  final Widget? prefix;
  final Widget? suffix;
  final String? error;
  final String? helperText;
  final String? label;
  final void Function(String)? _onChange;
  final void Function()? onFocus;
  final void Function()? onBlur;
  final void Function(String)? onSubmit;
  final ArcaneInteraction? onChangeAction;
  final ArcaneInteraction? onSubmitAction;
  final String? formId;
  final String? fieldName;
  final Map<String, String>? attributes;
  final bool fullWidth;

  const TextInput({
    this.placeholder,
    this.type = TextInputType.text,
    this.size = ComponentSize.md,
    this.disabled = false,
    this.required = false,
    this.readOnly = false,
    this.value,
    this.name,
    this.id,
    this.prefix,
    this.suffix,
    this.error,
    this.helperText,
    this.label,
    void Function(String)? onChange,
    void Function(String)? onInput,
    this.onFocus,
    this.onBlur,
    this.onSubmit,
    this.onChangeAction,
    this.onSubmitAction,
    this.formId,
    this.fieldName,
    this.attributes,
    this.fullWidth = false,
    super.key,
  }) : _onChange = onChange ?? onInput;

  @override
  Widget build(BuildContext context) {
    return context.renderers.textInput(TextInputProps(
      placeholder: placeholder,
      type: type,
      value: value,
      name: name,
      id: id,
      size: size,
      disabled: disabled,
      required: required,
      readOnly: readOnly,
      fullWidth: fullWidth,
      label: label,
      helperText: helperText,
      error: error,
      prefix: prefix,
      suffix: suffix,
      onChanged: _onChange,
      onFocus: onFocus,
      onBlur: onBlur,
      onSubmit: onSubmit,
      onChangeAction: onChangeAction,
      onSubmitAction: onSubmitAction,
      formId: formId,
      fieldName: fieldName,
      attributes: attributes,
    ));
  }
}

/// Resize direction for textarea.
enum TextAreaResize {
  none,
  vertical,
  horizontal,
  both,
}

/// A textarea component.
class TextArea extends StatelessWidget {
  final String? placeholder;
  final int rows;
  final int? cols;
  final bool disabled;
  final bool required;
  final TextAreaResize resize;
  final String? minWidth;
  final String? maxWidth;
  final String? minHeight;
  final String? maxHeight;
  final String? value;
  final String? name;
  final String? id;
  final String? label;
  final String? error;
  final String? helperText;
  final void Function(String)? _onChange;
  final bool fullWidth;

  const TextArea({
    this.placeholder,
    this.rows = 4,
    this.cols,
    this.disabled = false,
    this.required = false,
    this.resize = TextAreaResize.vertical,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.value,
    this.name,
    this.id,
    this.label,
    this.error,
    this.helperText,
    void Function(String)? onChange,
    void Function(String)? onInput,
    this.fullWidth = true,
    super.key,
  }) : _onChange = onChange ?? onInput;

  @override
  Widget build(BuildContext context) {
    final hasError = error != null;

    final resizeValue = switch (resize) {
      TextAreaResize.none => 'none',
      TextAreaResize.vertical => 'vertical',
      TextAreaResize.horizontal => 'horizontal',
      TextAreaResize.both => 'both',
    };

    final Widget textareaElement = jaspr.Component.element(
      tag: 'textarea',
      id: id,
      classes: 'arcane-textarea',
      attributes: {
        'name': ?name,
        'placeholder': ?placeholder,
        'rows': rows.toString(),
        if (cols != null) 'cols': cols.toString(),
        if (disabled) 'disabled': 'true',
        if (required) 'required': 'true',
      },
      styles: dom.Styles(raw: {
        if (fullWidth) 'width': '100%',
        'padding': '0.5rem 1rem',
        'font-size': '1rem',
        'font-family': 'inherit',
        'line-height': '1.625',
        'background-color': 'var(--background)',
        'border': hasError ? '1px solid var(--destructive)' : '1px solid var(--input)',
        'border-radius': '0.375rem',
        'color': 'var(--foreground)',
        'transition': 'color 150ms ease, border-color 150ms ease, box-shadow 150ms ease',
        'outline': 'none',
        'resize': resizeValue,
        'min-width': ?minWidth,
        'max-width': ?maxWidth,
        'min-height': ?minHeight,
        'max-height': ?maxHeight,
        if (disabled) 'opacity': '0.5',
        if (disabled) 'cursor': 'not-allowed',
      }),
      events: {
        if (_onChange != null)
          'input': (e) {
            final target = e.target as dynamic;
            _onChange(target.value as String);
          },
      },
      children: value != null ? [jaspr.Component.text(value!)] : [],
    );

    if (label != null || error != null || helperText != null) {
      return dom.div(
        classes: 'arcane-textarea-wrapper',
        styles: dom.Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '0.25rem',
          if (fullWidth) 'width': '100%',
        }),
        [
          if (label != null)
            jaspr.Component.element(
              tag: 'label',
              attributes: id != null ? {'for': id!} : null,
              styles: const dom.Styles(raw: {
                'font-size': '1rem',
                'font-weight': '500',
                'color': 'var(--foreground)',
              }),
              children: [
                jaspr.Component.text(label!),
                if (required)
                  const dom.span(
                    styles: dom.Styles(raw: {
                      'color': 'var(--destructive)',
                      'margin-left': '0.25rem',
                    }),
                    [jaspr.Component.text('*')],
                  ),
              ],
            ),
          textareaElement,
          if (error != null)
            dom.span(
              classes: 'arcane-textarea-error',
              styles: const dom.Styles(raw: {
                'font-size': '0.875rem',
                'color': 'var(--destructive)',
              }),
              [jaspr.Component.text(error!)],
            )
          else if (helperText != null)
            dom.span(
              classes: 'arcane-textarea-helper',
              styles: const dom.Styles(raw: {
                'font-size': '0.875rem',
                'color': 'var(--muted-foreground)',
              }),
              [jaspr.Component.text(helperText!)],
            ),
        ],
      );
    }

    return textareaElement;
  }
}

/// A select/dropdown input component.
class ArcaneSelect extends StatelessWidget {
  final List<ArcaneSelectOption> options;
  final String? value;
  final String? placeholder;
  final ComponentSize size;
  final bool disabled;
  final bool required;
  final String? name;
  final String? id;
  final String? label;
  final String? error;
  final void Function(String)? _onChange;
  final bool fullWidth;

  const ArcaneSelect({
    required this.options,
    this.value,
    this.placeholder,
    this.size = ComponentSize.md,
    this.disabled = false,
    this.required = false,
    this.name,
    this.id,
    this.label,
    this.error,
    void Function(String)? onChange,
    void Function(String)? onInput,
    void Function(String)? onSelect,
    this.fullWidth = false,
    super.key,
  }) : _onChange = onChange ?? onInput ?? onSelect;

  @override
  Widget build(BuildContext context) {
    final hasError = error != null;

    final Map<String, String> sizeStyles = switch (size) {
      ComponentSize.sm => {
          'height': '36px',
          'padding': '0 12px',
          'font-size': '14px',
        },
      ComponentSize.md => {
          'height': '40px',
          'padding': '8px 12px',
          'font-size': '16px',
        },
      ComponentSize.lg => {
          'height': '44px',
          'padding': '0 16px',
          'font-size': '16px',
        },
    };

    final Widget selectElement = jaspr.Component.element(
      tag: 'select',
      id: id,
      classes: 'arcane-select',
      attributes: {
        'name': ?name,
        if (disabled) 'disabled': 'true',
        if (required) 'required': 'true',
      },
      styles: dom.Styles(raw: {
        ...sizeStyles,
        'padding-right': '36px',
        'font-family': 'inherit',
        'background-color': 'var(--background)',
        'border': hasError ? '1px solid var(--destructive)' : '1px solid var(--input)',
        'border-radius': '0.375rem',
        'color': 'var(--foreground)',
        'transition': 'color 150ms ease, border-color 150ms ease, box-shadow 150ms ease',
        'cursor': 'pointer',
        'appearance': 'none',
        'background-image':
            'url("data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'12\' height=\'12\' viewBox=\'0 0 12 12\'%3E%3Cpath fill=\'%2371717A\' d=\'M2.5 4.5L6 8l3.5-3.5\'/%3E%3C/svg%3E")',
        'background-repeat': 'no-repeat',
        'background-position': 'right 12px center',
        if (fullWidth) 'width': '100%',
        if (disabled) 'opacity': '0.5',
        if (disabled) 'cursor': 'not-allowed',
      }),
      events: {
        if (_onChange != null)
          'change': (e) {
            final target = e.target as dynamic;
            _onChange(target.value as String);
          },
      },
      children: [
        if (placeholder != null)
          jaspr.Component.element(
            tag: 'option',
            attributes: {'value': '', 'disabled': 'true', 'selected': 'true'},
            children: [jaspr.Component.text(placeholder!)],
          ),
        for (final opt in options)
          jaspr.Component.element(
            tag: 'option',
            attributes: {
              'value': opt.value,
              if (opt.disabled) 'disabled': 'true',
              if (value == opt.value) 'selected': 'true',
            },
            children: [jaspr.Component.text(opt.label)],
          ),
      ],
    );

    if (label != null || error != null) {
      return dom.div(
        classes: 'arcane-select-wrapper',
        styles: dom.Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '0.25rem',
          if (fullWidth) 'width': '100%',
        }),
        [
          if (label != null)
            jaspr.Component.element(
              tag: 'label',
              attributes: id != null ? {'for': id!} : null,
              styles: const dom.Styles(raw: {
                'font-size': '1rem',
                'font-weight': '500',
                'color': 'var(--foreground)',
              }),
              children: [
                jaspr.Component.text(label!),
                if (required)
                  const dom.span(
                    styles: dom.Styles(raw: {
                      'color': 'var(--destructive)',
                      'margin-left': '0.25rem',
                    }),
                    [jaspr.Component.text('*')],
                  ),
              ],
            ),
          selectElement,
          if (error != null)
            dom.span(
              classes: 'arcane-select-error',
              styles: const dom.Styles(raw: {
                'font-size': '0.875rem',
                'color': 'var(--destructive)',
              }),
              [jaspr.Component.text(error!)],
            ),
        ],
      );
    }

    return selectElement;
  }
}

/// Select option model.
class ArcaneSelectOption {
  final String label;
  final String value;
  final bool disabled;

  const ArcaneSelectOption({
    required this.label,
    required this.value,
    this.disabled = false,
  });
}

typedef SelectInput = ArcaneSelect;
