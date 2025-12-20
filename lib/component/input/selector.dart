import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/tokens/tokens.dart';
import '../../util/tokens/style_presets.dart';

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

  /// Style preset
  final InputStyle? style;

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
    this.style,
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
    final effectiveStyle = component.style ?? InputStyle.standard;
    final hasError = component.error != null;

    final selectedOption = component.value != null
        ? component.options.cast<SelectorOption<T>?>().firstWhere(
              (opt) => opt?.value == component.value,
              orElse: () => null,
            )
        : null;

    return div(
      classes: 'arcane-selector-wrapper',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.xs,
        'position': 'relative',
      }),
      [
        // Label
        if (component.label != null)
          label(
            classes: 'arcane-selector-label',
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontMd,
              'font-weight': ArcaneTypography.weightMedium,
              'color': ArcaneColors.onSurface,
            }),
            [text(component.label!)],
          ),

        // Trigger button
        button(
          classes:
              'arcane-selector ${hasError ? 'error' : ''} ${component.disabled ? 'disabled' : ''} ${_isOpen ? 'open' : ''}',
          attributes: {
            'type': 'button',
            if (component.disabled) 'disabled': 'true',
          },
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'gap': ArcaneSpacing.sm,
            'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
            'min-height': ArcaneLayout.inputHeightMd,
            ...effectiveStyle.base,
            if (hasError) ...effectiveStyle.error,
            'cursor': component.disabled ? 'not-allowed' : 'pointer',
            if (component.disabled) ...effectiveStyle.disabled,
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
                'color':
                    selectedOption != null ? ArcaneColors.onSurface : ArcaneColors.muted,
                'font-size': ArcaneTypography.fontMd,
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
                styles: const Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'color': ArcaneColors.muted,
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
                'color': ArcaneColors.muted,
                'transition': ArcaneEffects.transitionFast,
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
            styles: const Styles(raw: {
              'position': 'absolute',
              'top': '100%',
              'left': '0',
              'right': '0',
              'z-index': '${ArcaneZIndex.dropdown}',
              'margin-top': ArcaneSpacing.xs,
              'background-color': ArcaneColors.surface,
              'border': '1px solid ${ArcaneColors.border}',
              'border-radius': ArcaneRadius.md,
              'box-shadow': ArcaneEffects.shadowLg,
              'max-height': '300px',
              'overflow-y': 'auto',
            }),
            [
              // Search input
              if (component.searchable)
                div(
                  classes: 'arcane-selector-search',
                  styles: const Styles(raw: {
                    'padding': ArcaneSpacing.sm,
                    'border-bottom': '1px solid ${ArcaneColors.border}',
                  }),
                  [
                    input(
                      type: InputType.text,
                      attributes: {
                        'placeholder': 'Search...',
                        'autofocus': 'true',
                      },
                      styles: const Styles(raw: {
                        'width': '100%',
                        'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
                        'border': '1px solid ${ArcaneColors.border}',
                        'border-radius': ArcaneRadius.sm,
                        'background': ArcaneColors.transparent,
                        'color': ArcaneColors.onSurface,
                        'font-size': ArcaneTypography.fontMd,
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
                styles: const Styles(raw: {
                  'padding': ArcaneSpacing.xs,
                }),
                [
                  if (_filteredOptions.isEmpty)
                    div(
                      styles: const Styles(raw: {
                        'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
                        'color': ArcaneColors.muted,
                        'font-size': ArcaneTypography.fontMd,
                        'text-align': 'center',
                      }),
                      [text('No options found')],
                    )
                  else
                    for (final option in _filteredOptions)
                      _buildOption(context, option),
                ],
              ),
            ],
          ),

        // Error message
        if (component.error != null)
          span(
            classes: 'arcane-selector-error',
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'color': ArcaneColors.error,
            }),
            [text(component.error!)],
          ),
      ],
    );
  }

  Component _buildOption(BuildContext context, SelectorOption<T> option) {
    final isSelected = option.value == component.value;
    final isDisabled = option.disabled;

    return button(
      classes:
          'arcane-selector-option ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        if (isDisabled) 'disabled': 'true',
      },
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.sm,
        'width': '100%',
        'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
        'background-color':
            isSelected ? ArcaneColors.accentContainer : ArcaneColors.transparent,
        'color': isSelected ? ArcaneColors.accent : ArcaneColors.onSurface,
        'border': 'none',
        'border-radius': ArcaneRadius.sm,
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'opacity': isDisabled ? '0.5' : '1',
        'transition': ArcaneEffects.transitionFast,
        'text-align': 'left',
        'font-size': ArcaneTypography.fontMd,
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
          styles: const Styles(raw: {'flex': '1'}),
          [text(option.label)],
        ),
        if (option.subtitle != null)
          span(
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'color': ArcaneColors.muted,
            }),
            [text(option.subtitle!)],
          ),
        if (isSelected)
          span(
            styles: const Styles(raw: {
              'color': ArcaneColors.accent,
            }),
            [text('✓')],
          ),
      ],
    );
  }
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