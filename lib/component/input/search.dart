import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/tokens/tokens.dart';
import '../../util/tokens/style_presets.dart';

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

  /// Size preset
  final InputSizeStyle size;

  /// Style preset
  final InputStyle? style;

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
    this.size = InputSizeStyle.md,
    this.style,
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
    final effectiveStyle = component.style ?? InputStyle.standard;

    return div(
      classes: 'arcane-search ${component.disabled ? 'disabled' : ''}',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.sm,
        'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
        ...effectiveStyle.base,
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
          styles: const Styles(raw: {
            'flex': '1',
            'border': 'none',
            'background': ArcaneColors.transparent,
            'color': ArcaneColors.onSurface,
            'font-size': ArcaneTypography.fontMd,
            'outline': 'none',
            'min-width': '0',
          }),
          events: {
            'input': (event) {
              final target = event.target;
              if (target != null) {
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
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': '20px',
              'height': '20px',
              'border-radius': ArcaneRadius.full,
              'background': ArcaneColors.surfaceVariant,
              'color': ArcaneColors.muted,
              'border': 'none',
              'cursor': 'pointer',
              'transition': ArcaneEffects.transitionFast,
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
      styles: const Styles(raw: {
        'color': ArcaneColors.muted,
        'font-size': ArcaneTypography.fontReg,
      }),
      [text('🔍')],
    );
  }

  Component _buildSpinner() {
    return const span(
      classes: 'arcane-search-spinner',
      styles: Styles(raw: {
        'display': 'inline-block',
        'width': '16px',
        'height': '16px',
        'border': '2px solid ${ArcaneColors.border}',
        'border-right-color': ArcaneColors.accent,
        'border-radius': ArcaneRadius.full,
        'animation': 'arcane-spin 0.75s linear infinite',
      }),
      [],
    );
  }
}