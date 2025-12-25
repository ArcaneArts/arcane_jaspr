import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../../util/tokens/tokens.dart';

/// Edit trigger mode for mutable text
enum MutableTextTrigger {
  /// Click on text to edit
  click,

  /// Double-click on text to edit
  doubleClick,

  /// Hover shows edit icon, click to edit
  hover,

  /// Always in edit mode
  always,
}

/// Input type for mutable text
enum MutableTextInputType {
  /// Single line text input
  text,

  /// Multi-line textarea
  multiline,

  /// Number input
  number,

  /// Email input
  email,

  /// URL input
  url,
}

/// Display style when not editing
enum MutableTextStyle {
  /// Inline text with no decoration
  inline,

  /// Shows subtle border/background on hover
  subtle,

  /// Shows underline indicating editability
  underline,

  /// Shows dashed underline
  dashed,

  /// Looks like a text input (with border)
  input,
}

/// A text component that can be clicked to edit inline.
/// Similar to shadcn's inline editable patterns.
///
/// Usage:
/// ```dart
/// ArcaneMutableText(
///   value: 'Click to edit',
///   onSave: (newValue) => print('Saved: $newValue'),
/// )
/// ```
class ArcaneMutableText extends StatefulComponent {
  /// Current text value
  final String value;

  /// Placeholder when value is empty
  final String? placeholder;

  /// Called when value is saved (Enter key or blur)
  final void Function(String value)? onSave;

  /// Called when editing is cancelled (Escape key)
  final void Function()? onCancel;

  /// Called on every keystroke while editing
  final void Function(String value)? onChange;

  /// How to trigger edit mode
  final MutableTextTrigger trigger;

  /// Input type when editing
  final MutableTextInputType inputType;

  /// Display style when not editing
  final MutableTextStyle displayStyle;

  /// Whether editing is disabled
  final bool disabled;

  /// Whether the field is required (shows * indicator)
  final bool required;

  /// Validation function - return error message or null if valid
  final String? Function(String value)? validator;

  /// Maximum length (0 = no limit)
  final int maxLength;

  /// Minimum length for validation
  final int minLength;

  /// Number of rows for multiline (default: 3)
  final int multilineRows;

  /// Whether to save on blur (default: true)
  final bool saveOnBlur;

  /// Whether to show character count
  final bool showCharCount;

  /// Custom text style (font size, weight, etc.)
  final Map<String, String>? textStyles;

  /// Label text shown above
  final String? label;

  /// Helper text shown below
  final String? helperText;

  /// Whether to start in edit mode
  final bool startEditing;

  /// Prefix content (shown before text)
  final Component? prefix;

  /// Suffix content (shown after text)
  final Component? suffix;

  /// Whether to select all text when entering edit mode
  final bool selectAllOnEdit;

  const ArcaneMutableText({
    required this.value,
    this.placeholder,
    this.onSave,
    this.onCancel,
    this.onChange,
    this.trigger = MutableTextTrigger.click,
    this.inputType = MutableTextInputType.text,
    this.displayStyle = MutableTextStyle.subtle,
    this.disabled = false,
    this.required = false,
    this.validator,
    this.maxLength = 0,
    this.minLength = 0,
    this.multilineRows = 3,
    this.saveOnBlur = true,
    this.showCharCount = false,
    this.textStyles,
    this.label,
    this.helperText,
    this.startEditing = false,
    this.prefix,
    this.suffix,
    this.selectAllOnEdit = false,
    super.key,
  });

  @override
  State<ArcaneMutableText> createState() => _ArcaneMutableTextState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-mutable-text-input:focus').styles(raw: {
      'border-color': ArcaneColors.accent,
      'box-shadow': '0 0 0 2px ${ArcaneColors.accentContainer}',
    }),
  ];
}

class _ArcaneMutableTextState extends State<ArcaneMutableText> {
  late bool _isEditing;
  late String _editValue;
  String? _error;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _isEditing =
        component.startEditing || component.trigger == MutableTextTrigger.always;
    _editValue = component.value;
  }

  void _startEditing() {
    if (component.disabled) return;
    setState(() {
      _isEditing = true;
      _editValue = component.value;
      _error = null;
    });
  }

  void _save() {
    // Validate
    if (component.required && _editValue.isEmpty) {
      setState(() => _error = 'This field is required');
      return;
    }
    if (component.minLength > 0 && _editValue.length < component.minLength) {
      setState(() => _error = 'Minimum ${component.minLength} characters');
      return;
    }
    if (component.validator != null) {
      final validationError = component.validator!(_editValue);
      if (validationError != null) {
        setState(() => _error = validationError);
        return;
      }
    }

    setState(() {
      _isEditing = component.trigger == MutableTextTrigger.always;
      _error = null;
    });
    component.onSave?.call(_editValue);
  }

  void _cancel() {
    setState(() {
      _isEditing = component.trigger == MutableTextTrigger.always;
      _editValue = component.value;
      _error = null;
    });
    component.onCancel?.call();
  }

  void _handleKeyDown(dynamic event) {
    final key = event.key as String;
    if (key == 'Enter' && component.inputType != MutableTextInputType.multiline) {
      event.preventDefault();
      _save();
    } else if (key == 'Escape') {
      event.preventDefault();
      _cancel();
    }
  }

  @override
  Component build(BuildContext context) {
    final hasError = _error != null;
    final isEmpty = component.value.isEmpty;
    final showPlaceholder = isEmpty && component.placeholder != null;

    // Base text styles
    final Map<String, String> baseTextStyles = {
      'font-size': ArcaneTypography.fontMd,
      'color': ArcaneColors.onSurface,
      'line-height': '1.5',
      ...?component.textStyles,
    };

    return div(
      classes: 'arcane-mutable-text',
      styles: Styles(raw: {
        'display': 'inline-flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.xs,
        'width': '100%',
      }),
      [
        // Label
        if (component.label != null)
          Component.element(
            tag: 'label',
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'font-weight': ArcaneTypography.weightMedium,
              'color': ArcaneColors.onSurface,
            }),
            children: [
              text(component.label!),
              if (component.required)
                span(
                  [text(' *')],
                  styles: const Styles(raw: {
                    'color': ArcaneColors.error,
                  }),
                ),
            ],
          ),

        // Main content
        if (_isEditing) ...[
          // Edit mode
          _buildEditMode(baseTextStyles, hasError),
        ] else ...[
          // Display mode
          _buildDisplayMode(baseTextStyles, showPlaceholder),
        ],

        // Helper text or error
        if (_error != null)
          span(
            [text(_error!)],
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'color': ArcaneColors.error,
            }),
          )
        else if (component.helperText != null)
          span(
            [text(component.helperText!)],
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'color': ArcaneColors.muted,
            }),
          ),
      ],
    );
  }

  Component _buildEditMode(Map<String, String> baseTextStyles, bool hasError) {
    final isMultiline = component.inputType == MutableTextInputType.multiline;

    return div(
      classes: 'arcane-mutable-text-edit',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.xs,
      }),
      [
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'flex-start',
            'gap': ArcaneSpacing.xs,
          }),
          [
            // Prefix
            if (component.prefix != null)
              span(
                [component.prefix!],
                styles: const Styles(raw: {
                  'color': ArcaneColors.muted,
                  'padding': '${ArcaneSpacing.xs} 0',
                }),
              ),

            // Input/Textarea
            if (isMultiline)
              Component.element(
                tag: 'textarea',
                classes: 'arcane-mutable-text-input',
                attributes: {
                  'rows': component.multilineRows.toString(),
                  if (component.maxLength > 0)
                    'maxlength': component.maxLength.toString(),
                  if (component.placeholder != null)
                    'placeholder': component.placeholder!,
                  'autofocus': 'true',
                },
                styles: Styles(raw: {
                  ...baseTextStyles,
                  'flex': '1',
                  'min-width': '0',
                  'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
                  'background': ArcaneColors.input,
                  'border': hasError
                      ? '1px solid ${ArcaneColors.error}'
                      : '1px solid ${ArcaneColors.border}',
                  'border-radius': ArcaneRadius.md,
                  'outline': 'none',
                  'resize': 'vertical',
                  'font-family': 'inherit',
                }),
                events: {
                  'input': (e) {
                    final target = e.target as dynamic;
                    setState(() => _editValue = target.value as String);
                    component.onChange?.call(_editValue);
                  },
                  'keydown': _handleKeyDown,
                  'blur': (e) {
                    if (component.saveOnBlur) _save();
                  },
                },
                children: [text(_editValue)],
              )
            else
              input(
                type: _getInputType(),
                classes: 'arcane-mutable-text-input',
                attributes: {
                  'value': _editValue,
                  if (component.maxLength > 0)
                    'maxlength': component.maxLength.toString(),
                  if (component.placeholder != null)
                    'placeholder': component.placeholder!,
                  'autofocus': 'true',
                },
                styles: Styles(raw: {
                  ...baseTextStyles,
                  'flex': '1',
                  'min-width': '0',
                  'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
                  'background': ArcaneColors.input,
                  'border': hasError
                      ? '1px solid ${ArcaneColors.error}'
                      : '1px solid ${ArcaneColors.border}',
                  'border-radius': ArcaneRadius.md,
                  'outline': 'none',
                }),
                events: {
                  'input': (e) {
                    final target = e.target as dynamic;
                    setState(() => _editValue = target.value as String);
                    component.onChange?.call(_editValue);
                  },
                  'keydown': _handleKeyDown,
                  'blur': (e) {
                    if (component.saveOnBlur) _save();
                  },
                },
              ),

            // Suffix
            if (component.suffix != null)
              span(
                [component.suffix!],
                styles: const Styles(raw: {
                  'color': ArcaneColors.muted,
                  'padding': '${ArcaneSpacing.xs} 0',
                }),
              ),

            // Action buttons (for multiline or when saveOnBlur is false)
            if (isMultiline || !component.saveOnBlur) ...[
              button(
                attributes: {'type': 'button', 'aria-label': 'Save'},
                styles: Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': '28px',
                  'height': '28px',
                  'background': ArcaneColors.accent,
                  'color': ArcaneColors.accentForeground,
                  'border': 'none',
                  'border-radius': ArcaneRadius.sm,
                  'cursor': 'pointer',
                  'font-size': '14px',
                }),
                events: {'click': (e) => _save()},
                [text('✓')],
              ),
              button(
                attributes: {'type': 'button', 'aria-label': 'Cancel'},
                styles: const Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': '28px',
                  'height': '28px',
                  'background': ArcaneColors.surfaceVariant,
                  'color': ArcaneColors.muted,
                  'border': 'none',
                  'border-radius': ArcaneRadius.sm,
                  'cursor': 'pointer',
                  'font-size': '14px',
                }),
                events: {'click': (e) => _cancel()},
                [text('✕')],
              ),
            ],
          ],
        ),

        // Character count
        if (component.showCharCount && component.maxLength > 0)
          span(
            [text('${_editValue.length}/${component.maxLength}')],
            styles: Styles(raw: {
              'font-size': ArcaneTypography.fontXs,
              'color': _editValue.length >= component.maxLength
                  ? ArcaneColors.error
                  : ArcaneColors.muted,
              'text-align': 'right',
            }),
          ),
      ],
    );
  }

  Component _buildDisplayMode(
      Map<String, String> baseTextStyles, bool showPlaceholder) {
    // Style based on displayStyle
    final Map<String, String> styleVariant = switch (component.displayStyle) {
      MutableTextStyle.inline => {},
      MutableTextStyle.subtle => {
          'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
          'border-radius': ArcaneRadius.sm,
          'margin': '-${ArcaneSpacing.xs} -${ArcaneSpacing.sm}',
        },
      MutableTextStyle.underline => {
          'border-bottom': '1px solid ${ArcaneColors.border}',
          'padding-bottom': '2px',
        },
      MutableTextStyle.dashed => {
          'border-bottom': '1px dashed ${ArcaneColors.muted}',
          'padding-bottom': '2px',
        },
      MutableTextStyle.input => {
          'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
          'border': '1px solid ${ArcaneColors.border}',
          'border-radius': ArcaneRadius.md,
          'background': ArcaneColors.transparent,
        },
    };

    // Hover styles for subtle mode
    final Map<String, String> hoverStyles = switch (component.displayStyle) {
      MutableTextStyle.subtle when _isHovered && !component.disabled => {
          'background': ArcaneColors.surfaceVariant,
        },
      MutableTextStyle.input when _isHovered && !component.disabled => {
          'border-color': ArcaneColors.accent,
        },
      _ => {},
    };

    final events = <String, void Function(dynamic)>{};
    if (!component.disabled) {
      events['mouseenter'] = (e) => setState(() => _isHovered = true);
      events['mouseleave'] = (e) => setState(() => _isHovered = false);

      switch (component.trigger) {
        case MutableTextTrigger.click:
        case MutableTextTrigger.hover:
          events['click'] = (e) => _startEditing();
        case MutableTextTrigger.doubleClick:
          events['dblclick'] = (e) => _startEditing();
        case MutableTextTrigger.always:
          break;
      }
    }

    return div(
      classes: 'arcane-mutable-text-display',
      attributes: {
        'role': 'button',
        'tabindex': component.disabled ? '-1' : '0',
        if (!component.disabled) 'aria-label': 'Click to edit',
      },
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.xs,
        ...baseTextStyles,
        ...styleVariant,
        ...hoverStyles,
        'cursor': component.disabled ? 'default' : 'pointer',
        'transition': ArcaneEffects.transitionFast,
        if (component.disabled) 'opacity': '0.5',
      }),
      events: {
        ...events,
        if (!component.disabled)
          'keydown': (e) {
            final key = (e as dynamic).key as String;
            if (key == 'Enter' || key == ' ') {
              e.preventDefault();
              _startEditing();
            }
          },
      },
      [
        // Prefix
        if (component.prefix != null) component.prefix!,

        // Text content
        span(
          [
            text(showPlaceholder ? component.placeholder! : component.value),
          ],
          styles: Styles(raw: {
            if (showPlaceholder) 'color': ArcaneColors.muted,
            if (showPlaceholder) 'font-style': 'italic',
          }),
        ),

        // Suffix
        if (component.suffix != null) component.suffix!,

        // Edit icon on hover (for hover trigger)
        if (_isHovered &&
            !component.disabled &&
            component.trigger == MutableTextTrigger.hover)
          span(
            [text('✎')],
            styles: const Styles(raw: {
              'color': ArcaneColors.muted,
              'font-size': '14px',
              'margin-left': ArcaneSpacing.xs,
            }),
          ),
      ],
    );
  }

  InputType _getInputType() {
    return switch (component.inputType) {
      MutableTextInputType.text => InputType.text,
      MutableTextInputType.multiline => InputType.text, // Not used for multiline
      MutableTextInputType.number => InputType.number,
      MutableTextInputType.email => InputType.email,
      MutableTextInputType.url => InputType.url,
    };
  }
}

/// Convenience constructors for common mutable text patterns
extension ArcaneMutableTextFactories on ArcaneMutableText {
  /// Creates a heading-style mutable text
  static ArcaneMutableText heading({
    required String value,
    void Function(String)? onSave,
    String? placeholder,
  }) {
    return ArcaneMutableText(
      value: value,
      onSave: onSave,
      placeholder: placeholder,
      displayStyle: MutableTextStyle.inline,
      textStyles: {
        'font-size': ArcaneTypography.font2xl,
        'font-weight': ArcaneTypography.weightBold,
      },
    );
  }

  /// Creates a paragraph-style mutable text
  static ArcaneMutableText paragraph({
    required String value,
    void Function(String)? onSave,
    String? placeholder,
  }) {
    return ArcaneMutableText(
      value: value,
      onSave: onSave,
      placeholder: placeholder,
      inputType: MutableTextInputType.multiline,
      displayStyle: MutableTextStyle.subtle,
    );
  }

  /// Creates a label-style mutable text (smaller, muted)
  static ArcaneMutableText label({
    required String value,
    void Function(String)? onSave,
    String? placeholder,
  }) {
    return ArcaneMutableText(
      value: value,
      onSave: onSave,
      placeholder: placeholder,
      displayStyle: MutableTextStyle.dashed,
      textStyles: {
        'font-size': ArcaneTypography.fontSm,
        'color': ArcaneColors.muted,
      },
    );
  }
}
