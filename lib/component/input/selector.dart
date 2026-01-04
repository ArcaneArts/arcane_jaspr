import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/tokens/tokens.dart';
import '../../util/tokens/style_presets.dart';
import 'selector_types.dart';

export 'selector_types.dart';

/// A dropdown selector component with extensive customization options.
class ArcaneSelector<T> extends StatefulComponent {
  /// The available options
  final List<ArcaneSelectorOption<T>> options;

  /// The currently selected value (for single select)
  final T? value;

  /// The currently selected values (for multi-select)
  final List<T>? values;

  /// Callback when selection changes (single select)
  final void Function(T value)? onChanged;

  /// Callback when selection changes (multi-select)
  final void Function(List<T> values)? onMultiChanged;

  /// Placeholder text when no selection
  final String placeholder;

  /// Whether the selector is disabled
  final bool disabled;

  /// Whether to allow clearing the selection
  final bool clearable;

  /// Whether the dropdown is searchable
  final bool searchable;

  /// Whether multiple selections are allowed
  final bool multiSelect;

  /// Label for the field
  final String? label;

  /// Helper text below the selector
  final String? helperText;

  /// Error message
  final String? error;

  /// Style preset
  final InputStyle? style;

  /// Size variant
  final SelectorSize size;

  /// Whether the field is required (shows asterisk)
  final bool required;

  /// Maximum height of the dropdown
  final String? maxDropdownHeight;

  /// Loading state - shows spinner instead of options
  final bool loading;

  /// Custom loading text
  final String loadingText;

  /// Custom empty state message
  final String emptyMessage;

  /// Custom search placeholder
  final String searchPlaceholder;

  /// Direction for dropdown to open
  final DropdownDirection dropdownDirection;

  /// Whether to close dropdown after selection (multi-select)
  final bool closeOnSelect;

  /// Show selected count badge for multi-select
  final bool showSelectedCount;

  /// Prefix component (icon/text before value)
  final Component? prefix;

  /// Custom filter function for search
  final bool Function(ArcaneSelectorOption<T> option, String query)? filterFn;

  /// Max number of selections (multi-select, null = unlimited)
  final int? maxSelections;

  /// Show checkboxes for multi-select options
  final bool showCheckboxes;

  const ArcaneSelector({
    required this.options,
    this.value,
    this.values,
    this.onChanged,
    this.onMultiChanged,
    this.placeholder = 'Select...',
    this.disabled = false,
    this.clearable = false,
    this.searchable = false,
    this.multiSelect = false,
    this.label,
    this.helperText,
    this.error,
    this.style,
    this.size = SelectorSize.md,
    this.required = false,
    this.maxDropdownHeight,
    this.loading = false,
    this.loadingText = 'Loading...',
    this.emptyMessage = 'No options found',
    this.searchPlaceholder = 'Search...',
    this.dropdownDirection = DropdownDirection.down,
    this.closeOnSelect = true,
    this.showSelectedCount = true,
    this.prefix,
    this.filterFn,
    this.maxSelections,
    this.showCheckboxes = true,
    super.key,
  });

  @override
  State<ArcaneSelector<T>> createState() => _ArcaneSelectorState<T>();
}

class _ArcaneSelectorState<T> extends State<ArcaneSelector<T>> {
  bool _isOpen = false;
  String _searchQuery = '';

  // Size configurations
  static const _sizeConfig = {
    SelectorSize.sm: {
      'height': '32px',
      'padding': '4px 8px',
      'fontSize': '0.8125rem',
      'iconSize': '12px',
    },
    SelectorSize.md: {
      'height': '40px',
      'padding': '8px 12px',
      'fontSize': '0.875rem',
      'iconSize': '14px',
    },
    SelectorSize.lg: {
      'height': '48px',
      'padding': '12px 16px',
      'fontSize': '1rem',
      'iconSize': '16px',
    },
  };

  Map<String, String> get _currentSize => _sizeConfig[component.size]!;

  void _toggleOpen() {
    if (component.disabled || component.loading) return;
    setState(() {
      _isOpen = !_isOpen;
      if (!_isOpen) _searchQuery = '';
    });
  }

  void _selectOption(ArcaneSelectorOption<T> option) {
    if (component.multiSelect) {
      final currentValues = List<T>.from(component.values ?? []);

      if (currentValues.contains(option.value)) {
        currentValues.remove(option.value);
      } else {
        // Check max selections
        if (component.maxSelections != null &&
            currentValues.length >= component.maxSelections!) {
          return;
        }
        currentValues.add(option.value);
      }

      component.onMultiChanged?.call(currentValues);

      if (component.closeOnSelect) {
        setState(() {
          _isOpen = false;
          _searchQuery = '';
        });
      } else {
        setState(() {});
      }
    } else {
      setState(() {
        _isOpen = false;
        _searchQuery = '';
      });
      component.onChanged?.call(option.value);
    }
  }

  void _clear() {
    setState(() {
      _isOpen = false;
    });
    if (component.multiSelect) {
      component.onMultiChanged?.call([]);
    }
  }

  List<ArcaneSelectorOption<T>> get _filteredOptions {
    if (_searchQuery.isEmpty) return component.options;

    if (component.filterFn != null) {
      return component.options
          .where((opt) => component.filterFn!(opt, _searchQuery))
          .toList();
    }

    final query = _searchQuery.toLowerCase();
    return component.options.where((opt) {
      return opt.label.toLowerCase().contains(query) ||
          (opt.subtitle?.toLowerCase().contains(query) ?? false) ||
          (opt.searchKeywords?.any((k) => k.toLowerCase().contains(query)) ??
              false);
    }).toList();
  }

  bool _isSelected(T value) {
    if (component.multiSelect) {
      return component.values?.contains(value) ?? false;
    }
    return component.value == value;
  }

  String _getDisplayText() {
    if (component.multiSelect) {
      final values = component.values ?? [];
      if (values.isEmpty) return component.placeholder;

      if (component.showSelectedCount && values.length > 1) {
        return '${values.length} selected';
      }

      final selectedLabels = component.options
          .where((opt) => values.contains(opt.value))
          .map((opt) => opt.label)
          .toList();
      return selectedLabels.join(', ');
    } else {
      final selectedOption = component.value != null
          ? component.options.cast<ArcaneSelectorOption<T>?>().firstWhere(
                (opt) => opt?.value == component.value,
                orElse: () => null,
              )
          : null;
      return selectedOption?.label ?? component.placeholder;
    }
  }

  bool get _hasSelection {
    if (component.multiSelect) {
      return (component.values ?? []).isNotEmpty;
    }
    return component.value != null;
  }

  @override
  Component build(BuildContext context) {
    final effectiveStyle = component.style ?? InputStyle.standard;
    final hasError = component.error != null;
    final displayText = _getDisplayText();
    final dropdownMaxHeight =
        component.maxDropdownHeight ?? '300px';

    // Dropdown position styles
    final dropdownPositionStyles = component.dropdownDirection == DropdownDirection.up
        ? {
            'bottom': '100%',
            'top': 'auto',
            'margin-bottom': ArcaneSpacing.xs,
          }
        : {
            'top': '100%',
            'margin-top': ArcaneSpacing.xs,
          };

    return div(
      classes: 'arcane-selector-wrapper',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.xs,
        'position': 'relative',
      }),
      [
        // Label with required indicator
        if (component.label != null)
          label(
            classes: 'arcane-selector-label',
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontMd,
              'font-weight': ArcaneTypography.weightMedium,
              'color': ArcaneColors.onSurface,
              'display': 'flex',
              'align-items': 'center',
              'gap': '4px',
            }),
            [
              text(component.label!),
              if (component.required)
                span(
                  styles: const Styles(raw: {'color': ArcaneColors.error}),
                  [text('*')],
                ),
            ],
          ),

        // Trigger button
        button(
          classes:
              'arcane-selector ${hasError ? 'error' : ''} ${component.disabled ? 'disabled' : ''} ${_isOpen ? 'open' : ''} ${component.loading ? 'loading' : ''}',
          attributes: {
            'type': 'button',
            if (component.disabled) 'disabled': 'true',
          },
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'gap': ArcaneSpacing.sm,
            'padding': _currentSize['padding']!,
            'min-height': _currentSize['height']!,
            ...effectiveStyle.base,
            if (hasError) ...effectiveStyle.error,
            'cursor': component.disabled || component.loading
                ? 'not-allowed'
                : 'pointer',
            if (component.disabled) ...effectiveStyle.disabled,
            'text-align': 'left',
            'width': '100%',
          }),
          events: {
            'click': (event) => _toggleOpen(),
          },
          [
            // Prefix
            if (component.prefix != null)
              span(
                styles: const Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'color': ArcaneColors.muted,
                }),
                [component.prefix!],
              ),

            // Selected value or placeholder
            span(
              styles: Styles(raw: {
                'flex': '1',
                'color': _hasSelection ? ArcaneColors.onSurface : ArcaneColors.muted,
                'font-size': _currentSize['fontSize']!,
                'overflow': 'hidden',
                'text-overflow': 'ellipsis',
                'white-space': 'nowrap',
              }),
              [text(displayText)],
            ),

            // Loading spinner
            if (component.loading)
              const span(
                classes: 'arcane-selector-spinner',
                styles: Styles(raw: {
                  'display': 'inline-block',
                  'width': '16px',
                  'height': '16px',
                  'border': '2px solid ${ArcaneColors.border}',
                  'border-top-color': ArcaneColors.accent,
                  'border-radius': '50%',
                  'animation': 'arcane-spin 0.8s linear infinite',
                }),
                [],
              ),

            // Clear button
            if (!component.loading &&
                component.clearable &&
                _hasSelection)
              span(
                classes: 'arcane-selector-clear',
                styles: const Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'padding': '2px',
                  'color': ArcaneColors.muted,
                  'cursor': 'pointer',
                  'border-radius': ArcaneRadius.sm,
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
            if (!component.loading)
              span(
                styles: Styles(raw: {
                  'color': ArcaneColors.muted,
                  'transition': ArcaneEffects.transitionFast,
                  'transform': _isOpen ? 'rotate(180deg)' : 'rotate(0)',
                  'font-size': _currentSize['iconSize']!,
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
              'left': '0',
              'right': '0',
              'z-index': '${ArcaneZIndex.dropdown}',
              'background-color': ArcaneColors.surface,
              'border': '1px solid ${ArcaneColors.border}',
              'border-radius': ArcaneRadius.md,
              'box-shadow': ArcaneEffects.shadowLg,
              'max-height': dropdownMaxHeight,
              'overflow-y': 'auto',
              ...dropdownPositionStyles,
            }),
            [
              // Search input
              if (component.searchable)
                div(
                  classes: 'arcane-selector-search',
                  styles: const Styles(raw: {
                    'padding': ArcaneSpacing.sm,
                    'border-bottom': '1px solid ${ArcaneColors.border}',
                    'position': 'sticky',
                    'top': '0',
                    'background': ArcaneColors.surface,
                    'z-index': '1',
                  }),
                  [
                    input(
                      type: InputType.text,
                      attributes: {
                        'placeholder': component.searchPlaceholder,
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

              // Loading state
              if (component.loading)
                div(
                  styles: const Styles(raw: {
                    'padding': '${ArcaneSpacing.lg} ${ArcaneSpacing.md}',
                    'color': ArcaneColors.muted,
                    'font-size': ArcaneTypography.fontMd,
                    'text-align': 'center',
                  }),
                  [text(component.loadingText)],
                )
              // Options
              else
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
                        [text(component.emptyMessage)],
                      )
                    else
                      for (final option in _filteredOptions)
                        _buildOption(context, option),
                  ],
                ),

              // Multi-select footer with selection count
              if (component.multiSelect && !component.loading && (component.values ?? []).isNotEmpty)
                div(
                  classes: 'arcane-selector-footer',
                  styles: const Styles(raw: {
                    'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
                    'border-top': '1px solid ${ArcaneColors.border}',
                    'display': 'flex',
                    'justify-content': 'space-between',
                    'align-items': 'center',
                    'font-size': ArcaneTypography.fontSm,
                    'color': ArcaneColors.muted,
                    'background': ArcaneColors.surfaceVariant,
                  }),
                  [
                    span([
                      text('${component.values!.length} selected'),
                      if (component.maxSelections != null)
                        text(' / ${component.maxSelections}'),
                    ]),
                    if (component.clearable)
                      button(
                        attributes: {'type': 'button'},
                        styles: const Styles(raw: {
                          'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
                          'border': 'none',
                          'background': 'transparent',
                          'color': ArcaneColors.accent,
                          'cursor': 'pointer',
                          'font-size': ArcaneTypography.fontSm,
                        }),
                        events: {
                          'click': (event) {
                            event.stopPropagation();
                            _clear();
                          },
                        },
                        [text('Clear all')],
                      ),
                  ],
                ),
            ],
          ),

        // Helper text
        if (component.helperText != null && component.error == null)
          span(
            classes: 'arcane-selector-helper',
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'color': ArcaneColors.muted,
            }),
            [text(component.helperText!)],
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

  Component _buildOption(BuildContext context, ArcaneSelectorOption<T> option) {
    final isSelected = _isSelected(option.value);
    final isDisabled = option.disabled;

    // Check if max selections reached (for multi-select)
    final maxReached = component.multiSelect &&
        component.maxSelections != null &&
        !isSelected &&
        (component.values?.length ?? 0) >= component.maxSelections!;

    return button(
      classes:
          'arcane-selector-option ${isSelected ? 'selected' : ''} ${isDisabled || maxReached ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        if (isDisabled || maxReached) 'disabled': 'true',
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
        'cursor': (isDisabled || maxReached) ? 'not-allowed' : 'pointer',
        'opacity': (isDisabled || maxReached) ? '0.5' : '1',
        'transition': ArcaneEffects.transitionFast,
        'text-align': 'left',
        'font-size': _currentSize['fontSize']!,
      }),
      events: {
        'click': (event) {
          if (!isDisabled && !maxReached) {
            _selectOption(option);
          }
        },
      },
      [
        // Checkbox for multi-select
        if (component.multiSelect && component.showCheckboxes)
          div(
            styles: Styles(raw: {
              'width': '16px',
              'height': '16px',
              'border': isSelected
                  ? '2px solid ${ArcaneColors.accent}'
                  : '2px solid ${ArcaneColors.border}',
              'border-radius': ArcaneRadius.sm,
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'background': isSelected ? ArcaneColors.accent : 'transparent',
              'flex-shrink': '0',
            }),
            [
              if (isSelected)
                span(
                  styles: const Styles(raw: {
                    'color': ArcaneColors.accentForeground,
                    'font-size': '10px',
                    'font-weight': ArcaneTypography.weightBold,
                  }),
                  [text('✓')],
                ),
            ],
          ),

        // Icon
        if (option.icon != null) option.icon!,

        // Label and subtitle
        div(
          styles: const Styles(raw: {
            'flex': '1',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '2px',
            'overflow': 'hidden',
          }),
          [
            span(
              styles: const Styles(raw: {
                'overflow': 'hidden',
                'text-overflow': 'ellipsis',
                'white-space': 'nowrap',
              }),
              [text(option.label)],
            ),
            if (option.subtitle != null)
              span(
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontSm,
                  'color': ArcaneColors.muted,
                  'overflow': 'hidden',
                  'text-overflow': 'ellipsis',
                  'white-space': 'nowrap',
                }),
                [text(option.subtitle!)],
              ),
          ],
        ),

        // Description on right (if provided)
        if (option.description != null)
          span(
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'color': ArcaneColors.muted,
              'flex-shrink': '0',
            }),
            [text(option.description!)],
          ),

        // Checkmark for single select
        if (!component.multiSelect && isSelected)
          span(
            styles: const Styles(raw: {
              'color': ArcaneColors.accent,
              'flex-shrink': '0',
            }),
            [text('✓')],
          ),
      ],
    );
  }
}