import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/appearance/theme.dart';
import '../../util/arcane.dart';
import '../../util/tools/styles.dart';

/// A search input component with optional icon and clear button.
class Search extends StatefulComponent {
  /// Placeholder text
  final String placeholder;

  /// The current value
  final String? value;

  /// Callback when value changes
  final void Function(String value)? onChanged;

  /// Callback when search is submitted
  final void Function(String value)? onSubmitted;

  /// Whether to show the clear button
  final bool showClear;

  /// Whether the search is loading
  final bool loading;

  /// Custom leading icon
  final Component? icon;

  /// Whether to autofocus
  final bool autofocus;

  /// Whether the input is disabled
  final bool disabled;

  const Search({
    this.placeholder = 'Search...',
    this.value,
    this.onChanged,
    this.onSubmitted,
    this.showClear = true,
    this.loading = false,
    this.icon,
    this.autofocus = false,
    this.disabled = false,
    super.key,
  });

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late String _value;

  @override
  void initState() {
    super.initState();
    _value = component.value ?? '';
  }

  @override
  void didUpdateComponent(Search oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (component.value != null && component.value != _value) {
      _value = component.value!;
    }
  }

  void _handleChange(String value) {
    setState(() {
      _value = value;
    });
    component.onChanged?.call(value);
  }

  void _handleClear() {
    setState(() {
      _value = '';
    });
    component.onChanged?.call('');
  }

  void _handleSubmit() {
    component.onSubmitted?.call(_value);
  }

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);

    return div(
      classes: 'arcane-search ${component.disabled ? 'disabled' : ''}',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '8px',
        'padding': '8px 12px',
        'background-color': 'var(--arcane-surface)',
        'border': '1px solid var(--arcane-outline-variant)',
        'border-radius': theme.borderRadiusCss,
        'transition': 'all 150ms ease',
        'opacity': component.disabled ? '0.5' : '1',
      }),
      [
        // Search icon
        if (component.loading)
          _buildSpinner()
        else
          component.icon ?? _buildSearchIcon(),

        // Input field
        input(
          type: InputType.text,
          classes: 'arcane-search-input',
          attributes: {
            'placeholder': component.placeholder,
            'value': _value,
            if (component.autofocus) 'autofocus': 'true',
            if (component.disabled) 'disabled': 'true',
          },
          styles: Styles(raw: {
            'flex': '1',
            'border': 'none',
            'background': 'transparent',
            'color': 'var(--arcane-on-surface)',
            'font-size': '0.875rem',
            'outline': 'none',
            'min-width': '0',
          }),
          events: {
            'input': (event) {
              final target = event.target;
              if (target != null) {
                // Get value from input element
                _handleChange((target as dynamic).value ?? '');
              }
            },
            'keydown': (event) {
              if ((event as dynamic).key == 'Enter') {
                _handleSubmit();
              }
            },
          },
        ),

        // Clear button
        if (component.showClear && _value.isNotEmpty)
          button(
            classes: 'arcane-search-clear',
            attributes: {'type': 'button'},
            styles: Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': '20px',
              'height': '20px',
              'border-radius': '50%',
              'background': 'var(--arcane-surface-variant)',
              'color': 'var(--arcane-on-surface-variant)',
              'cursor': 'pointer',
              'transition': 'all 150ms ease',
            }),
            events: {
              'click': (event) => _handleClear(),
            },
            [text('×')],
          ),
      ],
    );
  }

  Component _buildSearchIcon() {
    return span(
      classes: 'arcane-search-icon',
      styles: Styles(raw: {
        'color': 'var(--arcane-on-surface-variant)',
        'font-size': '1rem',
      }),
      [text('🔍')],
    );
  }

  Component _buildSpinner() {
    return span(
      classes: 'arcane-search-spinner',
      styles: Styles(raw: {
        'display': 'inline-block',
        'width': '16px',
        'height': '16px',
        'border': '2px solid var(--arcane-outline-variant)',
        'border-right-color': 'var(--arcane-primary)',
        'border-radius': '50%',
        'animation': 'arcane-spin 0.75s linear infinite',
      }),
      [],
    );
  }

  // TODO: Fix @css section for Jaspr 0.22.0
  // @css
  // static final List<StyleRule> styles = [...];
}

/// A text input component
class TextInput extends StatefulComponent {
  final String? value;
  final String? placeholder;
  final String? label;
  final String? hint;
  final String? error;
  final void Function(String value)? onChanged;
  final void Function(String value)? onSubmitted;
  final bool obscureText;
  final bool autofocus;
  final bool disabled;
  final bool readOnly;
  final int? maxLength;
  final int? maxLines;
  final Component? prefix;
  final Component? suffix;

  const TextInput({
    this.value,
    this.placeholder,
    this.label,
    this.hint,
    this.error,
    this.onChanged,
    this.onSubmitted,
    this.obscureText = false,
    this.autofocus = false,
    this.disabled = false,
    this.readOnly = false,
    this.maxLength,
    this.maxLines = 1,
    this.prefix,
    this.suffix,
    super.key,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late String _value;

  @override
  void initState() {
    super.initState();
    _value = component.value ?? '';
  }

  @override
  void didUpdateComponent(TextInput oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (component.value != null && component.value != _value) {
      _value = component.value!;
    }
  }

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);
    final hasError = component.error != null;
    final isMultiline = (component.maxLines ?? 1) > 1;

    return div(
      classes: 'arcane-text-input-wrapper',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '4px',
      }),
      [
        // Label
        if (component.label != null)
          label(
            classes: 'arcane-text-input-label',
            styles: Styles(raw: {
              'font-size': '0.875rem',
              'font-weight': '500',
              'color': 'var(--arcane-on-surface)',
            }),
            [text(component.label!)],
          ),

        // Input container
        div(
          classes: 'arcane-text-input ${hasError ? 'error' : ''} ${component.disabled ? 'disabled' : ''}',
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '8px',
            'padding': '8px 12px',
            'background-color': 'var(--arcane-surface)',
            'border': hasError
                ? '1px solid var(--arcane-error)'
                : '1px solid var(--arcane-outline-variant)',
            'border-radius': theme.borderRadiusCss,
            'transition': 'all 150ms ease',
            'opacity': component.disabled ? '0.5' : '1',
          }),
          [
            if (component.prefix != null) component.prefix!,

            if (isMultiline)
              textarea(
                classes: 'arcane-text-input-field',
                attributes: {
                  if (component.placeholder != null)
                    'placeholder': component.placeholder!,
                  if (component.autofocus) 'autofocus': 'true',
                  if (component.disabled) 'disabled': 'true',
                  if (component.readOnly) 'readonly': 'true',
                  if (component.maxLength != null)
                    'maxlength': '${component.maxLength}',
                  'rows': '${component.maxLines}',
                },
                styles: Styles(raw: {
                  'flex': '1',
                  'border': 'none',
                  'background': 'transparent',
                  'color': 'var(--arcane-on-surface)',
                  'font-size': '0.875rem',
                  'outline': 'none',
                  'resize': 'vertical',
                  'min-width': '0',
                  'font-family': 'inherit',
                }),
                events: {
                  'input': (event) {
                    final target = event.target;
                    if (target != null) {
                      final value = (target as dynamic).value ?? '';
                      setState(() => _value = value);
                      component.onChanged?.call(value);
                    }
                  },
                },
                [text(_value)],
              )
            else
              input(
                type: component.obscureText
                    ? InputType.password
                    : InputType.text,
                classes: 'arcane-text-input-field',
                attributes: {
                  'value': _value,
                  if (component.placeholder != null)
                    'placeholder': component.placeholder!,
                  if (component.autofocus) 'autofocus': 'true',
                  if (component.disabled) 'disabled': 'true',
                  if (component.readOnly) 'readonly': 'true',
                  if (component.maxLength != null)
                    'maxlength': '${component.maxLength}',
                },
                styles: Styles(raw: {
                  'flex': '1',
                  'border': 'none',
                  'background': 'transparent',
                  'color': 'var(--arcane-on-surface)',
                  'font-size': '0.875rem',
                  'outline': 'none',
                  'min-width': '0',
                }),
                events: {
                  'input': (event) {
                    final target = event.target;
                    if (target != null) {
                      final value = (target as dynamic).value ?? '';
                      setState(() => _value = value);
                      component.onChanged?.call(value);
                    }
                  },
                  'keydown': (event) {
                    if ((event as dynamic).key == 'Enter' &&
                        component.onSubmitted != null) {
                      component.onSubmitted!(_value);
                    }
                  },
                },
              ),

            if (component.suffix != null) component.suffix!,
          ],
        ),

        // Hint or error
        if (component.hint != null || component.error != null)
          span(
            classes: 'arcane-text-input-hint',
            styles: Styles(raw: {
              'font-size': '0.75rem',
              'color': hasError
                  ? 'var(--arcane-error)'
                  : 'var(--arcane-on-surface-variant)',
            }),
            [text(component.error ?? component.hint!)],
          ),
      ],
    );
  }

  // TODO: Fix @css section for Jaspr 0.22.0
  // @css
  // static final List<StyleRule> styles = [...];
}
