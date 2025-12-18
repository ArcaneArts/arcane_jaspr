import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';

/// Input variants
enum InputVariant {
  default_,
  filled,
  ghost,
}

/// Input sizes
enum InputSize {
  sm,
  md,
  lg,
}

/// A styled text input component (Supabase-style)
class TextInput extends StatelessComponent {
  /// Input placeholder
  final String? placeholder;

  /// Input type
  final InputType type;

  /// Input variant
  final InputVariant variant;

  /// Input size
  final InputSize size;

  /// Whether input is disabled
  final bool disabled;

  /// Whether input is required
  final bool required;

  /// Whether input is read-only
  final bool readOnly;

  /// Input value
  final String? value;

  /// Input name (for forms)
  final String? name;

  /// Input ID
  final String? id;

  /// Prefix icon/text
  final Component? prefix;

  /// Suffix icon/text
  final Component? suffix;

  /// Error message
  final String? error;

  /// Helper text
  final String? helperText;

  /// Label text
  final String? label;

  /// Change callback
  final void Function(String)? onChange;

  /// Focus callback
  final void Function()? onFocus;

  /// Blur callback
  final void Function()? onBlur;

  /// Full width
  final bool fullWidth;

  const TextInput({
    this.placeholder,
    this.type = InputType.text,
    this.variant = InputVariant.default_,
    this.size = InputSize.md,
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
    this.onChange,
    this.onFocus,
    this.onBlur,
    this.fullWidth = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final (height, fontSize, padding) = switch (size) {
      InputSize.sm => ('32px', '0.8125rem', '8px 10px'),
      InputSize.md => ('40px', '0.875rem', '10px 14px'),
      InputSize.lg => ('48px', '1rem', '12px 16px'),
    };

    final (bgColor, borderColor) = switch (variant) {
      InputVariant.default_ => (
          'var(--arcane-surface)',
          error != null ? 'var(--arcane-destructive)' : 'var(--arcane-border)',
        ),
      InputVariant.filled => (
          'var(--arcane-surface-variant)',
          error != null ? 'var(--arcane-destructive)' : 'transparent',
        ),
      InputVariant.ghost => (
          'transparent',
          error != null ? 'var(--arcane-destructive)' : 'transparent',
        ),
    };

    final inputStyles = Styles(raw: {
      'flex': '1',
      'height': height,
      'padding': padding,
      'font-size': fontSize,
      'font-family': 'inherit',
      'background-color': bgColor,
      'border': '1px solid $borderColor',
      'border-radius': 'var(--arcane-radius)',
      'color': 'var(--arcane-on-surface)',
      'outline': 'none',
      'transition': 'border-color var(--arcane-transition-fast), box-shadow var(--arcane-transition-fast)',
      if (disabled) 'opacity': '0.5',
      if (disabled) 'cursor': 'not-allowed',
      if (fullWidth) 'width': '100%',
    });

    final inputElement = input(
      type: type,
      id: id,
      name: name,
      classes: 'arcane-text-input',
      attributes: {
        if (placeholder != null) 'placeholder': placeholder!,
        if (value != null) 'value': value!,
        if (disabled) 'disabled': 'true',
        if (required) 'required': 'true',
        if (readOnly) 'readonly': 'true',
      },
      styles: inputStyles,
      events: {
        if (onChange != null) 'input': (e) {
          final target = e.target as dynamic;
          onChange!(target.value as String);
        },
        if (onFocus != null) 'focus': (e) => onFocus!(),
        if (onBlur != null) 'blur': (e) => onBlur!(),
      },
    );

    // Build with wrapper if prefix/suffix or label
    if (prefix != null || suffix != null || label != null || error != null || helperText != null) {
      return div(
        classes: 'arcane-text-input-wrapper',
        styles: Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '6px',
          if (fullWidth) 'width': '100%',
        }),
        [
          // Label
          if (label != null)
            Component.element(
              tag: 'label',
              attributes: id != null ? {'for': id!} : null,
              styles: Styles(raw: {
                'font-size': '0.875rem',
                'font-weight': '500',
                'color': 'var(--arcane-on-surface)',
              }),
              children: [
                text(label!),
                if (required)
                  span(
                    [text('*')],
                    styles: Styles(raw: {
                      'color': 'var(--arcane-destructive)',
                      'margin-left': '4px',
                    }),
                  ),
              ],
            ),

          // Input with prefix/suffix
          if (prefix != null || suffix != null)
            div(
              classes: 'arcane-text-input-container',
              styles: Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'background-color': bgColor,
                'border': '1px solid $borderColor',
                'border-radius': 'var(--arcane-radius)',
                'overflow': 'hidden',
                'transition': 'border-color var(--arcane-transition-fast)',
              }),
              [
                if (prefix != null)
                  span(
                    [prefix!],
                    classes: 'arcane-text-input-prefix',
                    styles: Styles(raw: {
                      'display': 'flex',
                      'align-items': 'center',
                      'padding-left': '12px',
                      'color': 'var(--arcane-muted)',
                    }),
                  ),
                input(
                  type: type,
                  id: id,
                  name: name,
                  classes: 'arcane-text-input',
                  attributes: {
                    if (placeholder != null) 'placeholder': placeholder!,
                    if (value != null) 'value': value!,
                    if (disabled) 'disabled': 'true',
                    if (required) 'required': 'true',
                    if (readOnly) 'readonly': 'true',
                  },
                  styles: Styles(raw: {
                    'flex': '1',
                    'height': height,
                    'padding': padding,
                    'font-size': fontSize,
                    'font-family': 'inherit',
                    'background': 'transparent',
                    'border': 'none',
                    'color': 'var(--arcane-on-surface)',
                    'outline': 'none',
                  }),
                  events: {
                    if (onChange != null) 'input': (e) {
                      final target = e.target as dynamic;
                      onChange!(target.value as String);
                    },
                    if (onFocus != null) 'focus': (e) => onFocus!(),
                    if (onBlur != null) 'blur': (e) => onBlur!(),
                  },
                ),
                if (suffix != null)
                  span(
                    [suffix!],
                    classes: 'arcane-text-input-suffix',
                    styles: Styles(raw: {
                      'display': 'flex',
                      'align-items': 'center',
                      'padding-right': '12px',
                      'color': 'var(--arcane-muted)',
                    }),
                  ),
              ],
            )
          else
            inputElement,

          // Error or helper text
          if (error != null)
            span(
              [text(error!)],
              classes: 'arcane-text-input-error',
              styles: Styles(raw: {
                'font-size': '0.8125rem',
                'color': 'var(--arcane-destructive)',
              }),
            )
          else if (helperText != null)
            span(
              [text(helperText!)],
              classes: 'arcane-text-input-helper',
              styles: Styles(raw: {
                'font-size': '0.8125rem',
                'color': 'var(--arcane-muted)',
              }),
            ),
        ],
      );
    }

    return inputElement;
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-text-input:focus').styles(raw: {
      'border-color': 'var(--arcane-accent)',
      'box-shadow': '0 0 0 2px var(--arcane-accent-container)',
    }),
    css('.arcane-text-input::placeholder').styles(raw: {
      'color': 'var(--arcane-muted)',
    }),
    css('.arcane-text-input-container:focus-within').styles(raw: {
      'border-color': 'var(--arcane-accent)',
      'box-shadow': '0 0 0 2px var(--arcane-accent-container)',
    }),
  ];
}

/// A textarea component
class TextArea extends StatelessComponent {
  /// Placeholder text
  final String? placeholder;

  /// Number of rows
  final int rows;

  /// Input variant
  final InputVariant variant;

  /// Whether disabled
  final bool disabled;

  /// Whether required
  final bool required;

  /// Whether resizable
  final bool resizable;

  /// Value
  final String? value;

  /// Name
  final String? name;

  /// ID
  final String? id;

  /// Label
  final String? label;

  /// Error
  final String? error;

  /// Helper text
  final String? helperText;

  /// Change callback
  final void Function(String)? onChange;

  /// Full width
  final bool fullWidth;

  const TextArea({
    this.placeholder,
    this.rows = 4,
    this.variant = InputVariant.default_,
    this.disabled = false,
    this.required = false,
    this.resizable = true,
    this.value,
    this.name,
    this.id,
    this.label,
    this.error,
    this.helperText,
    this.onChange,
    this.fullWidth = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final (bgColor, borderColor) = switch (variant) {
      InputVariant.default_ => (
          'var(--arcane-surface)',
          error != null ? 'var(--arcane-destructive)' : 'var(--arcane-border)',
        ),
      InputVariant.filled => (
          'var(--arcane-surface-variant)',
          error != null ? 'var(--arcane-destructive)' : 'transparent',
        ),
      InputVariant.ghost => (
          'transparent',
          error != null ? 'var(--arcane-destructive)' : 'transparent',
        ),
    };

    final textareaElement = Component.element(
      tag: 'textarea',
      id: id,
      classes: 'arcane-textarea',
      attributes: {
        if (name != null) 'name': name!,
        if (placeholder != null) 'placeholder': placeholder!,
        'rows': rows.toString(),
        if (disabled) 'disabled': 'true',
        if (required) 'required': 'true',
      },
      styles: Styles(raw: {
        'width': '100%',
        'padding': '10px 14px',
        'font-size': '0.875rem',
        'font-family': 'inherit',
        'line-height': '1.5',
        'background-color': bgColor,
        'border': '1px solid $borderColor',
        'border-radius': 'var(--arcane-radius)',
        'color': 'var(--arcane-on-surface)',
        'outline': 'none',
        'resize': resizable ? 'vertical' : 'none',
        'transition': 'border-color var(--arcane-transition-fast)',
        if (disabled) 'opacity': '0.5',
        if (disabled) 'cursor': 'not-allowed',
      }),
      events: {
        if (onChange != null) 'input': (e) {
          final target = e.target as dynamic;
          onChange!(target.value as String);
        },
      },
      children: value != null ? [text(value!)] : [],
    );

    if (label != null || error != null || helperText != null) {
      return div(
        classes: 'arcane-textarea-wrapper',
        styles: Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '6px',
          if (fullWidth) 'width': '100%',
        }),
        [
          if (label != null)
            Component.element(
              tag: 'label',
              attributes: id != null ? {'for': id!} : null,
              styles: Styles(raw: {
                'font-size': '0.875rem',
                'font-weight': '500',
                'color': 'var(--arcane-on-surface)',
              }),
              children: [
                text(label!),
                if (required)
                  span(
                    [text('*')],
                    styles: Styles(raw: {
                      'color': 'var(--arcane-destructive)',
                      'margin-left': '4px',
                    }),
                  ),
              ],
            ),
          textareaElement,
          if (error != null)
            span(
              [text(error!)],
              styles: Styles(raw: {
                'font-size': '0.8125rem',
                'color': 'var(--arcane-destructive)',
              }),
            )
          else if (helperText != null)
            span(
              [text(helperText!)],
              styles: Styles(raw: {
                'font-size': '0.8125rem',
                'color': 'var(--arcane-muted)',
              }),
            ),
        ],
      );
    }

    return textareaElement;
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-textarea:focus').styles(raw: {
      'border-color': 'var(--arcane-accent)',
      'box-shadow': '0 0 0 2px var(--arcane-accent-container)',
    }),
    css('.arcane-textarea::placeholder').styles(raw: {
      'color': 'var(--arcane-muted)',
    }),
  ];
}

/// A select/dropdown input component
class SelectInput extends StatelessComponent {
  /// Options list
  final List<SelectOption> options;

  /// Selected value
  final String? value;

  /// Placeholder text
  final String? placeholder;

  /// Input size
  final InputSize size;

  /// Whether disabled
  final bool disabled;

  /// Whether required
  final bool required;

  /// Name
  final String? name;

  /// ID
  final String? id;

  /// Label
  final String? label;

  /// Error
  final String? error;

  /// Change callback
  final void Function(String)? onChange;

  /// Full width
  final bool fullWidth;

  const SelectInput({
    required this.options,
    this.value,
    this.placeholder,
    this.size = InputSize.md,
    this.disabled = false,
    this.required = false,
    this.name,
    this.id,
    this.label,
    this.error,
    this.onChange,
    this.fullWidth = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final (height, fontSize, padding) = switch (size) {
      InputSize.sm => ('32px', '0.8125rem', '8px 10px'),
      InputSize.md => ('40px', '0.875rem', '10px 14px'),
      InputSize.lg => ('48px', '1rem', '12px 16px'),
    };

    final selectElement = Component.element(
      tag: 'select',
      id: id,
      classes: 'arcane-select',
      attributes: {
        if (name != null) 'name': name!,
        if (disabled) 'disabled': 'true',
        if (required) 'required': 'true',
      },
      styles: Styles(raw: {
        'height': height,
        'padding': padding,
        'padding-right': '36px',
        'font-size': fontSize,
        'font-family': 'inherit',
        'background-color': 'var(--arcane-surface)',
        'border': '1px solid ${error != null ? 'var(--arcane-destructive)' : 'var(--arcane-border)'}',
        'border-radius': 'var(--arcane-radius)',
        'color': 'var(--arcane-on-surface)',
        'outline': 'none',
        'cursor': 'pointer',
        'appearance': 'none',
        'background-image': 'url("data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'12\' height=\'12\' viewBox=\'0 0 12 12\'%3E%3Cpath fill=\'%2371717A\' d=\'M2.5 4.5L6 8l3.5-3.5\'/%3E%3C/svg%3E")',
        'background-repeat': 'no-repeat',
        'background-position': 'right 12px center',
        'transition': 'border-color var(--arcane-transition-fast)',
        if (fullWidth) 'width': '100%',
        if (disabled) 'opacity': '0.5',
        if (disabled) 'cursor': 'not-allowed',
      }),
      events: {
        if (onChange != null) 'change': (e) {
          final target = e.target as dynamic;
          onChange!(target.value as String);
        },
      },
      children: [
        if (placeholder != null)
          Component.element(
            tag: 'option',
            attributes: {'value': '', 'disabled': 'true', 'selected': 'true'},
            children: [text(placeholder!)],
          ),
        for (final opt in options)
          Component.element(
            tag: 'option',
            attributes: {
              'value': opt.value,
              if (opt.disabled) 'disabled': 'true',
              if (value == opt.value) 'selected': 'true',
            },
            children: [text(opt.label)],
          ),
      ],
    );

    if (label != null || error != null) {
      return div(
        classes: 'arcane-select-wrapper',
        styles: Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '6px',
          if (fullWidth) 'width': '100%',
        }),
        [
          if (label != null)
            Component.element(
              tag: 'label',
              attributes: id != null ? {'for': id!} : null,
              styles: Styles(raw: {
                'font-size': '0.875rem',
                'font-weight': '500',
                'color': 'var(--arcane-on-surface)',
              }),
              children: [
                text(label!),
                if (required)
                  span(
                    [text('*')],
                    styles: Styles(raw: {
                      'color': 'var(--arcane-destructive)',
                      'margin-left': '4px',
                    }),
                  ),
              ],
            ),
          selectElement,
          if (error != null)
            span(
              [text(error!)],
              styles: Styles(raw: {
                'font-size': '0.8125rem',
                'color': 'var(--arcane-destructive)',
              }),
            ),
        ],
      );
    }

    return selectElement;
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-select:focus').styles(raw: {
      'border-color': 'var(--arcane-accent)',
      'box-shadow': '0 0 0 2px var(--arcane-accent-container)',
    }),
  ];
}

/// Select option model
class SelectOption {
  final String label;
  final String value;
  final bool disabled;

  const SelectOption({
    required this.label,
    required this.value,
    this.disabled = false,
  });
}
