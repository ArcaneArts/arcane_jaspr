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

/// An autocomplete combobox with search filtering.
///
/// Combines a text input with a dropdown of filterable options.
///
/// Example:
/// ```dart
/// ArcaneCombobox<String>(
///   options: [
///     ComboboxOption(value: 'apple', label: 'Apple'),
///     ComboboxOption(value: 'banana', label: 'Banana'),
///     ComboboxOption(value: 'cherry', label: 'Cherry'),
///   ],
///   value: selectedFruit,
///   onChanged: (fruit) => setState(() => selectedFruit = fruit),
///   placeholder: 'Select a fruit...',
/// )
/// ```
class ArcaneCombobox<T> extends StatefulComponent {
  /// Available options
  final List<ComboboxOption<T>> options;

  /// Currently selected value
  final T? value;

  /// Called when selection changes
  final void Function(T?)? onChanged;

  /// Placeholder text when no selection
  final String? placeholder;

  /// Search input placeholder
  final String? searchPlaceholder;

  /// Whether to show the search input
  final bool searchable;

  /// Custom display function for selected value
  final String Function(T)? displayValue;

  /// Custom filter function
  final bool Function(ComboboxOption<T>, String)? filterFn;

  /// Empty state message
  final String emptyMessage;

  /// Whether the combobox is disabled
  final bool disabled;

  /// Error message
  final String? error;

  /// Label above the combobox
  final String? label;

  /// Size variant
  final ComboboxSize size;

  const ArcaneCombobox({
    required this.options,
    this.value,
    this.onChanged,
    this.placeholder,
    this.searchPlaceholder,
    this.searchable = true,
    this.displayValue,
    this.filterFn,
    this.emptyMessage = 'No results found',
    this.disabled = false,
    this.error,
    this.label,
    this.size = ComboboxSize.md,
    super.key,
  });

  @override
  State<ArcaneCombobox<T>> createState() => _ArcaneComboboxState<T>();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-combobox-trigger:hover:not(.disabled)').styles(raw: {
      'border-color': ArcaneColors.accent,
    }),
    css('.arcane-combobox-trigger:focus').styles(raw: {
      'border-color': ArcaneColors.accent,
      'box-shadow': '0 0 0 2px ${ArcaneColors.accentContainer}',
      'outline': 'none',
    }),
    css('.arcane-combobox-option:hover').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
    css('.arcane-combobox-option.selected').styles(raw: {
      'background-color': ArcaneColors.accentContainer,
      'color': ArcaneColors.accent,
    }),
    css('.arcane-combobox-search:focus').styles(raw: {
      'outline': 'none',
      'border-color': ArcaneColors.accent,
    }),
  ];
}

class _ArcaneComboboxState<T> extends State<ArcaneCombobox<T>> {
  bool _isOpen = false;
  String _searchQuery = '';

  List<ComboboxOption<T>> get _filteredOptions {
    if (_searchQuery.isEmpty) return component.options;

    final query = _searchQuery.toLowerCase();
    return component.options.where((option) {
      if (component.filterFn != null) {
        return component.filterFn!(option, _searchQuery);
      }
      return option.label.toLowerCase().contains(query) ||
          (option.keywords?.any((k) => k.toLowerCase().contains(query)) ??
              false);
    }).toList();
  }

  String get _displayText {
    if (component.value == null) return component.placeholder ?? 'Select...';
    if (component.displayValue != null) {
      return component.displayValue!(component.value as T);
    }
    final selected = component.options
        .where((o) => o.value == component.value)
        .firstOrNull;
    return selected?.label ?? component.placeholder ?? 'Select...';
  }

  void _toggleOpen() {
    if (component.disabled) return;
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _searchQuery = '';
      }
    });
  }

  void _selectOption(ComboboxOption<T> option) {
    if (option.disabled) return;
    component.onChanged?.call(option.value);
    setState(() {
      _isOpen = false;
      _searchQuery = '';
    });
  }

  void _handleSearch(String value) {
    setState(() {
      _searchQuery = value;
    });
  }

  @override
  Component build(BuildContext context) {
    final hasError = component.error != null;
    final sizeStyles = component.size.styles;
    final hasValue = component.value != null;

    return div(
      classes: 'arcane-combobox ${_isOpen ? 'open' : ''} ${component.disabled ? 'disabled' : ''} ${hasError ? 'error' : ''}',
      attributes: {
        'data-combobox': 'true',
      },
      styles: const Styles(raw: {
        'position': 'relative',
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.xs,
      }),
      [
        // Label
        if (component.label != null)
          span(
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'font-weight': ArcaneTypography.weightMedium,
              'color': ArcaneColors.onSurface,
            }),
            [Component.text(component.label!)],
          ),

        // Trigger button
        button(
          classes: 'arcane-combobox-trigger ${component.disabled ? 'disabled' : ''}',
          attributes: {
            'type': 'button',
            'role': 'combobox',
            'aria-expanded': '$_isOpen',
            'aria-haspopup': 'listbox',
            if (component.disabled) 'disabled': 'true',
          },
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'gap': ArcaneSpacing.sm,
            'width': '100%',
            'height': sizeStyles['height']!,
            'padding': '0 ${ArcaneSpacing.md}',
            'background-color': ArcaneColors.surface,
            'border': '1px solid ${hasError ? ArcaneColors.error : ArcaneColors.border}',
            'border-radius': ArcaneRadius.md,
            'font-size': sizeStyles['fontSize']!,
            'color': hasValue ? ArcaneColors.onSurface : ArcaneColors.muted,
            'cursor': component.disabled ? 'not-allowed' : 'pointer',
            'transition': ArcaneEffects.transitionFast,
            'text-align': 'left',
            if (component.disabled) 'opacity': '0.5',
          }),
          events: {
            'click': (e) => _toggleOpen(),
          },
          [
            span(
              styles: const Styles(raw: {
                'flex': '1',
                'overflow': 'hidden',
                'text-overflow': 'ellipsis',
                'white-space': 'nowrap',
              }),
              [Component.text(_displayText)],
            ),
            span(
              styles: Styles(raw: {
                'color': ArcaneColors.muted,
                'transition': ArcaneEffects.transitionFast,
                'transform': _isOpen ? 'rotate(180deg)' : 'rotate(0)',
              }),
              [Component.text('▼')],
            ),
          ],
        ),

        // Dropdown
        if (_isOpen)
          div(
            classes: 'arcane-combobox-dropdown',
            attributes: {
              'role': 'listbox',
            },
            styles: const Styles(raw: {
              'position': 'absolute',
              'top': '100%',
              'left': '0',
              'right': '0',
              'margin-top': ArcaneSpacing.xs,
              'background-color': ArcaneColors.surface,
              'border': '1px solid ${ArcaneColors.border}',
              'border-radius': ArcaneRadius.md,
              'box-shadow': ArcaneEffects.shadowLg,
              'z-index': '100',
              'overflow': 'hidden',
            }),
            [
              // Search input
              if (component.searchable)
                div(
                  styles: const Styles(raw: {
                    'padding': ArcaneSpacing.sm,
                    'border-bottom': '1px solid ${ArcaneColors.border}',
                  }),
                  [
                    input(
                      classes: 'arcane-combobox-search',
                      type: InputType.text,
                      attributes: {
                        'placeholder':
                            component.searchPlaceholder ?? 'Search...',
                        'autofocus': 'true',
                      },
                      styles: const Styles(raw: {
                        'width': '100%',
                        'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
                        'background-color': ArcaneColors.surfaceVariant,
                        'border': '1px solid ${ArcaneColors.border}',
                        'border-radius': ArcaneRadius.sm,
                        'font-size': ArcaneTypography.fontSm,
                        'color': ArcaneColors.onSurface,
                      }),
                      events: {
                        'input': (e) {
                          final target = e.target as dynamic;
                          _handleSearch(target.value as String);
                        },
                      },
                    ),
                  ],
                ),

              // Options list
              div(
                styles: const Styles(raw: {
                  'max-height': '200px',
                  'overflow-y': 'auto',
                }),
                [
                  if (_filteredOptions.isEmpty)
                    div(
                      styles: const Styles(raw: {
                        'padding': ArcaneSpacing.md,
                        'text-align': 'center',
                        'color': ArcaneColors.muted,
                        'font-size': ArcaneTypography.fontSm,
                      }),
                      [Component.text(component.emptyMessage)],
                    )
                  else
                    for (final option in _filteredOptions)
                      div(
                        classes: 'arcane-combobox-option ${option.value == component.value ? 'selected' : ''} ${option.disabled ? 'disabled' : ''}',
                        attributes: {
                          'role': 'option',
                          'aria-selected':
                              '${option.value == component.value}',
                          if (option.disabled) 'aria-disabled': 'true',
                        },
                        styles: Styles(raw: {
                          'display': 'flex',
                          'align-items': 'center',
                          'gap': ArcaneSpacing.sm,
                          'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
                          'cursor':
                              option.disabled ? 'not-allowed' : 'pointer',
                          'transition': ArcaneEffects.transitionFast,
                          if (option.disabled) 'opacity': '0.5',
                        }),
                        events: {
                          'click': (e) => _selectOption(option),
                        },
                        [
                          if (option.icon != null) option.icon!,
                          div(
                            styles: const Styles(raw: {
                              'flex': '1',
                            }),
                            [
                              div(
                                styles: const Styles(raw: {
                                  'font-size': ArcaneTypography.fontSm,
                                  'color': ArcaneColors.onSurface,
                                }),
                                [Component.text(option.label)],
                              ),
                              if (option.description != null)
                                div(
                                  styles: const Styles(raw: {
                                    'font-size': ArcaneTypography.fontXs,
                                    'color': ArcaneColors.muted,
                                  }),
                                  [Component.text(option.description!)],
                                ),
                            ],
                          ),
                          if (option.value == component.value)
                            span(
                              styles: const Styles(raw: {
                                'color': ArcaneColors.accent,
                              }),
                              [Component.text('✓')],
                            ),
                        ],
                      ),
                ],
              ),
            ],
          ),

        // Error message
        if (hasError)
          span(
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'color': ArcaneColors.error,
            }),
            [Component.text(component.error!)],
          ),
      ],
    );
  }
}

/// A combobox option
class ComboboxOption<T> {
  /// The option's value
  final T value;

  /// Display label
  final String label;

  /// Optional description
  final String? description;

  /// Optional icon
  final Component? icon;

  /// Whether this option is disabled
  final bool disabled;

  /// Additional keywords for searching
  final List<String>? keywords;

  const ComboboxOption({
    required this.value,
    required this.label,
    this.description,
    this.icon,
    this.disabled = false,
    this.keywords,
  });
}

/// Size variants for combobox
enum ComboboxSize {
  sm,
  md,
  lg,
}

extension ComboboxSizeExtension on ComboboxSize {
  Map<String, String> get styles => switch (this) {
        ComboboxSize.sm => {
            'height': ArcaneLayout.inputHeightSm,
            'fontSize': ArcaneTypography.fontSm,
          },
        ComboboxSize.md => {
            'height': ArcaneLayout.inputHeightMd,
            'fontSize': ArcaneTypography.fontSm,
          },
        ComboboxSize.lg => {
            'height': ArcaneLayout.inputHeightLg,
            'fontSize': ArcaneTypography.fontMd,
          },
      };
}
