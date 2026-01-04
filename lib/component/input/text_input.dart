import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';
import '../../util/tokens/style_presets.dart';

/// A styled text input component
///
/// Use style presets for cleaner code:
/// ```dart
/// ArcaneTextInput(
///   style: InputStyle.standard,
///   size: InputSizeStyle.md,
///   onInput: (value) => print(value),  // or use onChange
/// )
/// ```
class ArcaneTextInput extends StatelessComponent {
  /// Input placeholder
  final String? placeholder;

  /// Input type
  final InputType type;

  /// Style preset (preferred)
  final InputStyle? style;

  /// Size preset
  final InputSizeStyle size;

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
  final void Function(String)? _onChange;

  /// Focus callback
  final void Function()? onFocus;

  /// Blur callback
  final void Function()? onBlur;

  /// Submit callback
  final void Function(String)? onSubmit;

  /// Full width
  final bool fullWidth;

  /// Creates a text input.
  ///
  /// Use [onChange] or [onInput] for value change handling.
  const ArcaneTextInput({
    this.placeholder,
    this.type = InputType.text,
    this.style,
    this.size = InputSizeStyle.md,
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
    this.fullWidth = false,
    super.key,
  }) : _onChange = onChange ?? onInput;

  @override
  Component build(BuildContext context) {
    final effectiveStyle = style ?? InputStyle.standard;
    final hasError = error != null;

    // Build input styles
    final Map<String, String> inputStyles = {
      'flex': '1',
      'font-family': 'inherit',
      'outline': 'none',
      ...size.styles,
      ...effectiveStyle.base,
      if (hasError) ...effectiveStyle.error,
      if (disabled) ...effectiveStyle.disabled,
      if (fullWidth) 'width': '100%',
    };

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
      styles: Styles(raw: inputStyles),
      events: {
        if (_onChange != null)
          'input': (e) {
            final target = e.target as dynamic;
            _onChange!(target.value as String);
          },
        if (onFocus != null) 'focus': (e) => onFocus!(),
        if (onBlur != null) 'blur': (e) => onBlur!(),
        if (onSubmit != null)
          'keydown': (e) {
            if ((e as dynamic).key == 'Enter') {
              final target = e.target as dynamic;
              onSubmit!(target.value as String);
            }
          },
      },
    );

    // Build with wrapper if prefix/suffix or label
    if (prefix != null ||
        suffix != null ||
        label != null ||
        error != null ||
        helperText != null) {
      return div(
        classes: 'arcane-text-input-wrapper',
        styles: Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': ArcaneSpacing.xs,
          if (fullWidth) 'width': '100%',
        }),
        [
          // Label
          if (label != null)
            Component.element(
              tag: 'label',
              attributes: id != null ? {'for': id!} : null,
              styles: const Styles(raw: {
                'font-size': ArcaneTypography.fontMd,
                'font-weight': ArcaneTypography.weightMedium,
                'color': ArcaneColors.onSurface,
              }),
              children: [
                text(label!),
                if (required)
                  span(
                    [text('*')],
                    styles: const Styles(raw: {
                      'color': ArcaneColors.error,
                      'margin-left': ArcaneSpacing.xs,
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
                ...effectiveStyle.base,
                if (hasError) ...effectiveStyle.error,
                'overflow': 'hidden',
              }),
              [
                if (prefix != null)
                  span(
                    [prefix!],
                    classes: 'arcane-text-input-prefix',
                    styles: const Styles(raw: {
                      'display': 'flex',
                      'align-items': 'center',
                      'padding-left': ArcaneSpacing.sm,
                      'color': ArcaneColors.muted,
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
                    ...size.styles,
                    'background': ArcaneColors.transparent,
                    'border': 'none',
                    'color': ArcaneColors.onSurface,
                    'outline': 'none',
                  }),
                  events: {
                    if (_onChange != null)
                      'input': (e) {
                        final target = e.target as dynamic;
                        _onChange!(target.value as String);
                      },
                    if (onFocus != null) 'focus': (e) => onFocus!(),
                    if (onBlur != null) 'blur': (e) => onBlur!(),
                  },
                ),
                if (suffix != null)
                  span(
                    [suffix!],
                    classes: 'arcane-text-input-suffix',
                    styles: const Styles(raw: {
                      'display': 'flex',
                      'align-items': 'center',
                      'padding-right': ArcaneSpacing.sm,
                      'color': ArcaneColors.muted,
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
              styles: const Styles(raw: {
                'font-size': ArcaneTypography.fontSm,
                'color': ArcaneColors.error,
              }),
            )
          else if (helperText != null)
            span(
              [text(helperText!)],
              classes: 'arcane-text-input-helper',
              styles: const Styles(raw: {
                'font-size': ArcaneTypography.fontSm,
                'color': ArcaneColors.muted,
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
      'border-color': ArcaneColors.accent,
      'box-shadow': '0 0 0 2px ${ArcaneColors.accentContainer}',
    }),
    css('.arcane-text-input::placeholder').styles(raw: {
      'color': ArcaneColors.muted,
    }),
    css('.arcane-text-input-container:focus-within').styles(raw: {
      'border-color': ArcaneColors.accent,
      'box-shadow': '0 0 0 2px ${ArcaneColors.accentContainer}',
    }),
  ];
}

/// Resize direction for textarea
enum TextAreaResize {
  /// No resizing allowed
  none,

  /// Vertical resizing only (default)
  vertical,

  /// Horizontal resizing only
  horizontal,

  /// Both directions
  both,
}

/// A textarea component
class ArcaneTextArea extends StatelessComponent {
  /// Placeholder text
  final String? placeholder;

  /// Number of rows
  final int rows;

  /// Number of columns (affects initial width)
  final int? cols;

  /// Style preset
  final InputStyle? style;

  /// Whether disabled
  final bool disabled;

  /// Whether required
  final bool required;

  /// Resize direction (default: vertical)
  final TextAreaResize resize;

  /// Minimum width constraint (e.g., '200px', '50%')
  final String? minWidth;

  /// Maximum width constraint (e.g., '600px', '100%')
  final String? maxWidth;

  /// Minimum height constraint (e.g., '100px')
  final String? minHeight;

  /// Maximum height constraint (e.g., '400px')
  final String? maxHeight;

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
  final void Function(String)? _onChange;

  /// Full width
  final bool fullWidth;

  /// Creates a textarea.
  ///
  /// Use [onChange] or [onInput] for value change handling.
  const ArcaneTextArea({
    this.placeholder,
    this.rows = 4,
    this.cols,
    this.style,
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
  Component build(BuildContext context) {
    final effectiveStyle = style ?? InputStyle.standard;
    final hasError = error != null;

    // Map resize enum to CSS value
    final resizeValue = switch (resize) {
      TextAreaResize.none => 'none',
      TextAreaResize.vertical => 'vertical',
      TextAreaResize.horizontal => 'horizontal',
      TextAreaResize.both => 'both',
    };

    final textareaElement = Component.element(
      tag: 'textarea',
      id: id,
      classes: 'arcane-textarea',
      attributes: {
        if (name != null) 'name': name!,
        if (placeholder != null) 'placeholder': placeholder!,
        'rows': rows.toString(),
        if (cols != null) 'cols': cols.toString(),
        if (disabled) 'disabled': 'true',
        if (required) 'required': 'true',
      },
      styles: Styles(raw: {
        if (fullWidth) 'width': '100%',
        'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
        'font-size': ArcaneTypography.fontMd,
        'font-family': 'inherit',
        'line-height': ArcaneTypography.lineHeightRelaxed,
        ...effectiveStyle.base,
        if (hasError) ...effectiveStyle.error,
        'outline': 'none',
        'resize': resizeValue,
        if (minWidth != null) 'min-width': minWidth!,
        if (maxWidth != null) 'max-width': maxWidth!,
        if (minHeight != null) 'min-height': minHeight!,
        if (maxHeight != null) 'max-height': maxHeight!,
        if (disabled) ...effectiveStyle.disabled,
      }),
      events: {
        if (_onChange != null)
          'input': (e) {
            final target = e.target as dynamic;
            _onChange!(target.value as String);
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
          'gap': ArcaneSpacing.xs,
          if (fullWidth) 'width': '100%',
        }),
        [
          if (label != null)
            Component.element(
              tag: 'label',
              attributes: id != null ? {'for': id!} : null,
              styles: const Styles(raw: {
                'font-size': ArcaneTypography.fontMd,
                'font-weight': ArcaneTypography.weightMedium,
                'color': ArcaneColors.onSurface,
              }),
              children: [
                text(label!),
                if (required)
                  span(
                    [text('*')],
                    styles: const Styles(raw: {
                      'color': ArcaneColors.error,
                      'margin-left': ArcaneSpacing.xs,
                    }),
                  ),
              ],
            ),
          textareaElement,
          if (error != null)
            span(
              [text(error!)],
              styles: const Styles(raw: {
                'font-size': ArcaneTypography.fontSm,
                'color': ArcaneColors.error,
              }),
            )
          else if (helperText != null)
            span(
              [text(helperText!)],
              styles: const Styles(raw: {
                'font-size': ArcaneTypography.fontSm,
                'color': ArcaneColors.muted,
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
      'border-color': ArcaneColors.accent,
      'box-shadow': '0 0 0 2px ${ArcaneColors.accentContainer}',
    }),
    css('.arcane-textarea::placeholder').styles(raw: {
      'color': ArcaneColors.muted,
    }),
  ];
}

/// A select/dropdown input component
class ArcaneSelect extends StatelessComponent {
  /// Options list
  final List<ArcaneSelectOption> options;

  /// Selected value
  final String? value;

  /// Placeholder text
  final String? placeholder;

  /// Size preset
  final InputSizeStyle size;

  /// Style preset
  final InputStyle? style;

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
  final void Function(String)? _onChange;

  /// Full width
  final bool fullWidth;

  /// Creates a select input.
  ///
  /// Use [onChange], [onInput], or [onSelect] for value change handling.
  const ArcaneSelect({
    required this.options,
    this.value,
    this.placeholder,
    this.size = InputSizeStyle.md,
    this.style,
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
  Component build(BuildContext context) {
    final effectiveStyle = style ?? InputStyle.standard;
    final hasError = error != null;

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
        ...size.styles,
        'padding-right': '36px',
        'font-family': 'inherit',
        ...effectiveStyle.base,
        if (hasError) ...effectiveStyle.error,
        'cursor': 'pointer',
        'appearance': 'none',
        'background-image':
            'url("data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'12\' height=\'12\' viewBox=\'0 0 12 12\'%3E%3Cpath fill=\'%2371717A\' d=\'M2.5 4.5L6 8l3.5-3.5\'/%3E%3C/svg%3E")',
        'background-repeat': 'no-repeat',
        'background-position': 'right 12px center',
        if (fullWidth) 'width': '100%',
        if (disabled) ...effectiveStyle.disabled,
      }),
      events: {
        if (_onChange != null)
          'change': (e) {
            final target = e.target as dynamic;
            _onChange!(target.value as String);
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
          'gap': ArcaneSpacing.xs,
          if (fullWidth) 'width': '100%',
        }),
        [
          if (label != null)
            Component.element(
              tag: 'label',
              attributes: id != null ? {'for': id!} : null,
              styles: const Styles(raw: {
                'font-size': ArcaneTypography.fontMd,
                'font-weight': ArcaneTypography.weightMedium,
                'color': ArcaneColors.onSurface,
              }),
              children: [
                text(label!),
                if (required)
                  span(
                    [text('*')],
                    styles: const Styles(raw: {
                      'color': ArcaneColors.error,
                      'margin-left': ArcaneSpacing.xs,
                    }),
                  ),
              ],
            ),
          selectElement,
          if (error != null)
            span(
              [text(error!)],
              styles: const Styles(raw: {
                'font-size': ArcaneTypography.fontSm,
                'color': ArcaneColors.error,
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
      'border-color': ArcaneColors.accent,
      'box-shadow': '0 0 0 2px ${ArcaneColors.accentContainer}',
    }),
  ];
}

/// Select option model
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

// Type aliases for backward compatibility
typedef TextInput = ArcaneTextInput;
typedef TextArea = ArcaneTextArea;
typedef SelectInput = ArcaneSelect;