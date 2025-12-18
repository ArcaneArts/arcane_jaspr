import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';

/// A dropdown selector component.
class Selector<T> extends StatefulComponent {
  /// The available options
  final List<SelectorOption<T>> options;

  /// The currently selected value
  final T? value;

  /// Callback when selection changes
  final void Function(T value)? onChanged;

  /// Placeholder text when no selection
  final String placeholder;

  /// Whether the selector is disabled
  final bool disabled;

  /// Whether to allow clearing the selection
  final bool clearable;

  /// Whether the dropdown is searchable
  final bool searchable;

  /// Label for the field
  final String? label;

  /// Error message
  final String? error;

  const Selector({
    required this.options,
    this.value,
    this.onChanged,
    this.placeholder = 'Select...',
    this.disabled = false,
    this.clearable = false,
    this.searchable = false,
    this.label,
    this.error,
    super.key,
  });

  @override
  State<Selector<T>> createState() => _SelectorState<T>();
}

class _SelectorState<T> extends State<Selector<T>> {
  bool _isOpen = false;
  String _searchQuery = '';

  void _toggleOpen() {
    if (component.disabled) return;
    setState(() {
      _isOpen = !_isOpen;
      if (!_isOpen) _searchQuery = '';
    });
  }

  void _selectOption(SelectorOption<T> option) {
    setState(() {
      _isOpen = false;
      _searchQuery = '';
    });
    component.onChanged?.call(option.value);
  }

  void _clear() {
    setState(() {
      _isOpen = false;
    });
    // Note: Can't set to null with generic, caller needs to handle
  }

  List<SelectorOption<T>> get _filteredOptions {
    if (_searchQuery.isEmpty) return component.options;
    final query = _searchQuery.toLowerCase();
    return component.options.where((opt) {
      return opt.label.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);
    final hasError = component.error != null;

    final selectedOption = component.value != null
        ? component.options.cast<SelectorOption<T>?>().firstWhere(
              (opt) => opt?.value == component.value,
              orElse: () => null,
            )
        : null;

    return div(
      classes: 'arcane-selector-wrapper',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '4px',
        'position': 'relative',
      }),
      [
        // Label
        if (component.label != null)
          label(
            classes: 'arcane-selector-label',
            styles: Styles(raw: {
              'font-size': '0.875rem',
              'font-weight': '500',
              'color': 'var(--arcane-on-surface)',
            }),
            [text(component.label!)],
          ),

        // Trigger button
        button(
          classes: 'arcane-selector ${hasError ? 'error' : ''} ${component.disabled ? 'disabled' : ''} ${_isOpen ? 'open' : ''}',
          attributes: {
            'type': 'button',
            if (component.disabled) 'disabled': 'true',
          },
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'gap': '8px',
            'padding': '8px 12px',
            'min-height': '40px',
            'background-color': 'var(--arcane-surface)',
            'border': hasError
                ? '1px solid var(--arcane-error)'
                : '1px solid var(--arcane-outline-variant)',
            'border-radius': theme.borderRadiusCss,
            'cursor': component.disabled ? 'not-allowed' : 'pointer',
            'opacity': component.disabled ? '0.5' : '1',
            'transition': 'all 150ms ease',
            'text-align': 'left',
            'width': '100%',
          }),
          events: {
            'click': (event) => _toggleOpen(),
          },
          [
            // Selected value or placeholder
            span(
              styles: Styles(raw: {
                'flex': '1',
                'color': selectedOption != null
                    ? 'var(--arcane-on-surface)'
                    : 'var(--arcane-on-surface-variant)',
                'font-size': '0.875rem',
                'overflow': 'hidden',
                'text-overflow': 'ellipsis',
                'white-space': 'nowrap',
              }),
              [
                if (selectedOption != null)
                  text(selectedOption.label)
                else
                  text(component.placeholder),
              ],
            ),

            // Clear button
            if (component.clearable && selectedOption != null)
              span(
                classes: 'arcane-selector-clear',
                styles: Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'color': 'var(--arcane-on-surface-variant)',
                }),
                events: {
                  'click': (event) {
                    event.stopPropagation();
                    _clear();
                  },
                },
                [text('×')],
              ),

            // Arrow indicator
            span(
              styles: Styles(raw: {
                'color': 'var(--arcane-on-surface-variant)',
                'transition': 'transform 150ms ease',
                'transform': _isOpen ? 'rotate(180deg)' : 'rotate(0)',
              }),
              [text('▼')],
            ),
          ],
        ),

        // Dropdown panel
        if (_isOpen)
          div(
            classes: 'arcane-selector-dropdown',
            styles: Styles(raw: {
              'position': 'absolute',
              'top': '100%',
              'left': '0',
              'right': '0',
              'z-index': '100',
              'margin-top': '4px',
              'background-color': 'var(--arcane-surface)',
              'border': '1px solid var(--arcane-outline-variant)',
              'border-radius': theme.borderRadiusCss,
              'box-shadow':
                  '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)',
              'max-height': '300px',
              'overflow-y': 'auto',
            }),
            [
              // Search input
              if (component.searchable)
                div(
                  classes: 'arcane-selector-search',
                  styles: Styles(raw: {
                    'padding': '8px',
                    'border-bottom': '1px solid var(--arcane-outline-variant)',
                  }),
                  [
                    input(
                      type: InputType.text,
                      attributes: {
                        'placeholder': 'Search...',
                        'autofocus': 'true',
                      },
                      styles: Styles(raw: {
                        'width': '100%',
                        'padding': '6px 8px',
                        'border': '1px solid var(--arcane-outline-variant)',
                        'border-radius': '${theme.borderRadiusPx * 0.5}px',
                        'background': 'transparent',
                        'color': 'var(--arcane-on-surface)',
                        'font-size': '0.875rem',
                        'outline': 'none',
                      }),
                      events: {
                        'input': (event) {
                          final target = event.target;
                          if (target != null) {
                            setState(() {
                              _searchQuery = (target as dynamic).value ?? '';
                            });
                          }
                        },
                        'click': (event) => event.stopPropagation(),
                      },
                    ),
                  ],
                ),

              // Options
              div(
                classes: 'arcane-selector-options',
                styles: Styles(raw: {
                  'padding': '4px',
                }),
                [
                  if (_filteredOptions.isEmpty)
                    div(
                      styles: Styles(raw: {
                        'padding': '8px 12px',
                        'color': 'var(--arcane-on-surface-variant)',
                        'font-size': '0.875rem',
                        'text-align': 'center',
                      }),
                      [text('No options found')],
                    )
                  else
                    for (final option in _filteredOptions)
                      _buildOption(context, theme, option),
                ],
              ),
            ],
          ),

        // Error message
        if (component.error != null)
          span(
            classes: 'arcane-selector-error',
            styles: Styles(raw: {
              'font-size': '0.75rem',
              'color': 'var(--arcane-error)',
            }),
            [text(component.error!)],
          ),
      ],
    );
  }

  Component _buildOption(
      BuildContext context, ArcaneTheme theme, SelectorOption<T> option) {
    final isSelected = option.value == component.value;
    final isDisabled = option.disabled;

    return button(
      classes: 'arcane-selector-option ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        if (isDisabled) 'disabled': 'true',
      },
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '8px',
        'width': '100%',
        'padding': '8px 12px',
        'background-color': isSelected
            ? 'var(--arcane-primary-container)'
            : 'transparent',
        'color': isSelected
            ? 'var(--arcane-on-primary-container)'
            : 'var(--arcane-on-surface)',
        'border-radius': '${theme.borderRadiusPx * 0.5}px',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'opacity': isDisabled ? '0.5' : '1',
        'transition': 'background-color 100ms ease',
        'text-align': 'left',
        'font-size': '0.875rem',
      }),
      events: {
        'click': (event) {
          if (!isDisabled) {
            _selectOption(option);
          }
        },
      },
      [
        if (option.icon != null) option.icon!,
        span(
          styles: Styles(raw: {'flex': '1'}),
          [text(option.label)],
        ),
        if (option.subtitle != null)
          span(
            styles: Styles(raw: {
              'font-size': '0.75rem',
              'color': 'var(--arcane-on-surface-variant)',
            }),
            [text(option.subtitle!)],
          ),
        if (isSelected)
          span(
            styles: Styles(raw: {
              'color': 'var(--arcane-primary)',
            }),
            [text('✓')],
          ),
      ],
    );
  }

  // TODO: Fix @css section for Jaspr 0.22.0
  // @css
  // static final List<StyleRule> styles = [...];
}

/// An option for Selector
class SelectorOption<T> {
  final T value;
  final String label;
  final String? subtitle;
  final Component? icon;
  final bool disabled;

  const SelectorOption({
    required this.value,
    required this.label,
    this.subtitle,
    this.icon,
    this.disabled = false,
  });
}
