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

/// Radio button option model
class RadioOption<T> {
  /// Unique value for this option
  final T value;

  /// Display label
  final String label;

  /// Optional description text
  final String? description;

  /// Whether this option is disabled
  final bool disabled;

  /// Optional icon
  final Component? icon;

  const RadioOption({
    required this.value,
    required this.label,
    this.description,
    this.disabled = false,
    this.icon,
  });
}

/// Radio group layout direction
enum RadioGroupLayout {
  /// Vertical stack
  vertical,

  /// Horizontal row
  horizontal,

  /// Grid layout
  grid,
}

/// Radio group visual variant
enum RadioGroupVariant {
  /// Standard radio buttons
  standard,

  /// Card-style selection (bordered cards)
  cards,

  /// Button group style (segmented control)
  buttons,

  /// Chip/pill style
  chips,
}

/// A radio button group component.
/// Allows single selection from a list of options.
///
/// Usage:
/// ```dart
/// ArcaneRadioGroup<String>(
///   value: selectedValue,
///   options: [
///     RadioOption(value: 'a', label: 'Option A'),
///     RadioOption(value: 'b', label: 'Option B'),
///     RadioOption(value: 'c', label: 'Option C'),
///   ],
///   onChanged: (value) => setState(() => selectedValue = value),
/// )
/// ```
class ArcaneRadioGroup<T> extends StatelessComponent {
  /// Currently selected value
  final T? value;

  /// List of radio options
  final List<RadioOption<T>> options;

  /// Called when selection changes
  final void Function(T value)? onChanged;

  /// Group name (for HTML form association)
  final String? name;

  /// Layout direction
  final RadioGroupLayout layout;

  /// Visual variant
  final RadioGroupVariant variant;

  /// Whether the entire group is disabled
  final bool disabled;

  /// Label text above the group
  final String? label;

  /// Helper text below the group
  final String? helperText;

  /// Error message
  final String? error;

  /// Whether selection is required
  final bool required;

  /// Gap between items
  final String gap;

  /// Number of columns for grid layout
  final int gridColumns;

  const ArcaneRadioGroup({
    required this.options,
    this.value,
    this.onChanged,
    this.name,
    this.layout = RadioGroupLayout.vertical,
    this.variant = RadioGroupVariant.standard,
    this.disabled = false,
    this.label,
    this.helperText,
    this.error,
    this.required = false,
    this.gap = ArcaneSpacing.sm,
    this.gridColumns = 2,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final hasError = error != null;
    final groupName = name ?? 'radio_${identityHashCode(this)}';

    return div(
      classes: 'arcane-radio-group',
      attributes: {
        'role': 'radiogroup',
        if (label != null) 'aria-labelledby': '${groupName}_label',
      },
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.sm,
      }),
      [
        // Label
        if (label != null)
          Component.element(
            tag: 'label',
            id: '${groupName}_label',
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontMd,
              'font-weight': ArcaneTypography.weightMedium,
              'color': ArcaneColors.onSurface,
            }),
            children: [
              text(label!),
              if (required)
                span(
                  [text(' *')],
                  styles: const Styles(raw: {
                    'color': ArcaneColors.error,
                  }),
                ),
            ],
          ),

        // Options container
        div(
          classes: 'arcane-radio-group-options',
          styles: Styles(raw: {
            'display': layout == RadioGroupLayout.grid ? 'grid' : 'flex',
            'flex-direction':
                layout == RadioGroupLayout.horizontal ? 'row' : 'column',
            'flex-wrap':
                layout == RadioGroupLayout.horizontal ? 'wrap' : 'nowrap',
            'gap': gap,
            if (layout == RadioGroupLayout.grid)
              'grid-template-columns': 'repeat($gridColumns, 1fr)',
          }),
          [
            for (final option in options) _buildOption(option, groupName, hasError),
          ],
        ),

        // Error or helper text
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

  Component _buildOption(RadioOption<T> option, String groupName, bool hasError) {
    final isSelected = value == option.value;
    final isDisabled = disabled || option.disabled;

    return switch (variant) {
      RadioGroupVariant.standard => _buildStandardRadio(option, groupName, isSelected, isDisabled, hasError),
      RadioGroupVariant.cards => _buildCardRadio(option, groupName, isSelected, isDisabled, hasError),
      RadioGroupVariant.buttons => _buildButtonRadio(option, groupName, isSelected, isDisabled),
      RadioGroupVariant.chips => _buildChipRadio(option, groupName, isSelected, isDisabled),
    };
  }

  Component _buildStandardRadio(
    RadioOption<T> option,
    String groupName,
    bool isSelected,
    bool isDisabled,
    bool hasError,
  ) {
    return Component.element(
      tag: 'label',
      classes: 'arcane-radio-item',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': option.description != null ? 'flex-start' : 'center',
        'gap': ArcaneSpacing.sm,
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'opacity': isDisabled ? '0.5' : '1',
      }),
      children: [
        // Radio input (hidden, for accessibility)
        input(
          type: InputType.radio,
          classes: 'arcane-radio-input',
          attributes: {
            'name': groupName,
            'value': option.value.toString(),
            if (isSelected) 'checked': 'true',
            if (isDisabled) 'disabled': 'true',
          },
          styles: const Styles(raw: {
            'position': 'absolute',
            'opacity': '0',
            'pointer-events': 'none',
          }),
          events: {
            if (!isDisabled && onChanged != null)
              'change': (e) => onChanged!(option.value),
          },
        ),

        // Custom radio circle
        div(
          classes: 'arcane-radio-circle',
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'width': '20px',
            'height': '20px',
            'border-radius': '50%',
            'border': isSelected
                ? '2px solid ${ArcaneColors.accent}'
                : hasError
                    ? '2px solid ${ArcaneColors.error}'
                    : '2px solid ${ArcaneColors.border}',
            'background': ArcaneColors.input,
            'flex-shrink': '0',
            'transition': ArcaneEffects.transitionFast,
          }),
          [
            // Inner dot when selected
            if (isSelected)
              const div(
                styles: Styles(raw: {
                  'width': '10px',
                  'height': '10px',
                  'border-radius': '50%',
                  'background': ArcaneColors.accent,
                }),
                [],
              ),
          ],
        ),

        // Label content
        div(
          classes: 'arcane-radio-content',
          styles: const Styles(raw: {
            'flex': '1',
          }),
          [
            // Icon + Label row
            div(
              styles: const Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'gap': ArcaneSpacing.xs,
              }),
              [
                if (option.icon != null) option.icon!,
                span(
                  [text(option.label)],
                  styles: const Styles(raw: {
                    'font-size': ArcaneTypography.fontMd,
                    'color': ArcaneColors.onSurface,
                  }),
                ),
              ],
            ),
            // Description
            if (option.description != null)
              span(
                [text(option.description!)],
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontSm,
                  'color': ArcaneColors.muted,
                  'margin-top': '2px',
                }),
              ),
          ],
        ),
      ],
    );
  }

  Component _buildCardRadio(
    RadioOption<T> option,
    String groupName,
    bool isSelected,
    bool isDisabled,
    bool hasError,
  ) {
    return Component.element(
      tag: 'label',
      classes: 'arcane-radio-card',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.xs,
        'padding': ArcaneSpacing.md,
        'border-radius': ArcaneRadius.lg,
        'border': isSelected
            ? '2px solid ${ArcaneColors.accent}'
            : hasError
                ? '2px solid ${ArcaneColors.error}'
                : '1px solid ${ArcaneColors.border}',
        'background': isSelected ? ArcaneColors.accentContainer : ArcaneColors.surface,
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'opacity': isDisabled ? '0.5' : '1',
        'transition': ArcaneEffects.transitionFast,
      }),
      children: [
        // Hidden input
        input(
          type: InputType.radio,
          attributes: {
            'name': groupName,
            'value': option.value.toString(),
            if (isSelected) 'checked': 'true',
            if (isDisabled) 'disabled': 'true',
          },
          styles: const Styles(raw: {
            'position': 'absolute',
            'opacity': '0',
            'pointer-events': 'none',
          }),
          events: {
            if (!isDisabled && onChanged != null)
              'change': (e) => onChanged!(option.value),
          },
        ),

        // Header with icon and indicator
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
          }),
          [
            if (option.icon != null)
              div(
                styles: Styles(raw: {
                  'color': isSelected ? ArcaneColors.accent : ArcaneColors.muted,
                }),
                [option.icon!],
              ),
            // Selection indicator
            div(
              styles: Styles(raw: {
                'width': '16px',
                'height': '16px',
                'border-radius': '50%',
                'border': isSelected
                    ? '5px solid ${ArcaneColors.accent}'
                    : '2px solid ${ArcaneColors.border}',
                'background': isSelected ? ArcaneColors.accentForeground : ArcaneColors.input,
              }),
              [],
            ),
          ],
        ),

        // Label
        span(
          [text(option.label)],
          styles: Styles(raw: {
            'font-size': ArcaneTypography.fontMd,
            'font-weight': ArcaneTypography.weightMedium,
            'color': isSelected ? ArcaneColors.accent : ArcaneColors.onSurface,
          }),
        ),

        // Description
        if (option.description != null)
          span(
            [text(option.description!)],
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'color': ArcaneColors.muted,
            }),
          ),
      ],
    );
  }

  Component _buildButtonRadio(
    RadioOption<T> option,
    String groupName,
    bool isSelected,
    bool isDisabled,
  ) {
    return Component.element(
      tag: 'label',
      classes: 'arcane-radio-button',
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': ArcaneSpacing.xs,
        'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
        'border': isSelected
            ? '1px solid ${ArcaneColors.accent}'
            : '1px solid ${ArcaneColors.border}',
        'background': isSelected ? ArcaneColors.accent : ArcaneColors.surface,
        'color': isSelected ? ArcaneColors.accentForeground : ArcaneColors.onSurface,
        'font-size': ArcaneTypography.fontSm,
        'font-weight': ArcaneTypography.weightMedium,
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'opacity': isDisabled ? '0.5' : '1',
        'transition': ArcaneEffects.transitionFast,
        // First item
        'border-radius': '0',
        'margin-left': '-1px',
      }),
      children: [
        input(
          type: InputType.radio,
          attributes: {
            'name': groupName,
            'value': option.value.toString(),
            if (isSelected) 'checked': 'true',
            if (isDisabled) 'disabled': 'true',
          },
          styles: const Styles(raw: {
            'position': 'absolute',
            'opacity': '0',
            'pointer-events': 'none',
          }),
          events: {
            if (!isDisabled && onChanged != null)
              'change': (e) => onChanged!(option.value),
          },
        ),
        if (option.icon != null) option.icon!,
        text(option.label),
      ],
    );
  }

  Component _buildChipRadio(
    RadioOption<T> option,
    String groupName,
    bool isSelected,
    bool isDisabled,
  ) {
    return Component.element(
      tag: 'label',
      classes: 'arcane-radio-chip',
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.xs,
        'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.md}',
        'border-radius': ArcaneRadius.full,
        'border': isSelected
            ? '1px solid ${ArcaneColors.accent}'
            : '1px solid ${ArcaneColors.border}',
        'background': isSelected ? ArcaneColors.accentContainer : ArcaneColors.surface,
        'color': isSelected ? ArcaneColors.accent : ArcaneColors.onSurface,
        'font-size': ArcaneTypography.fontSm,
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'opacity': isDisabled ? '0.5' : '1',
        'transition': ArcaneEffects.transitionFast,
      }),
      children: [
        input(
          type: InputType.radio,
          attributes: {
            'name': groupName,
            'value': option.value.toString(),
            if (isSelected) 'checked': 'true',
            if (isDisabled) 'disabled': 'true',
          },
          styles: const Styles(raw: {
            'position': 'absolute',
            'opacity': '0',
            'pointer-events': 'none',
          }),
          events: {
            if (!isDisabled && onChanged != null)
              'change': (e) => onChanged!(option.value),
          },
        ),
        if (option.icon != null) option.icon!,
        text(option.label),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    // Standard radio hover
    css('.arcane-radio-item:hover .arcane-radio-circle').styles(raw: {
      'border-color': ArcaneColors.accent,
    }),
    // Card hover
    css('.arcane-radio-card:hover').styles(raw: {
      'border-color': ArcaneColors.accent,
    }),
    // Button group styling
    css('.arcane-radio-button:first-of-type').styles(raw: {
      'border-radius': '${ArcaneRadius.md} 0 0 ${ArcaneRadius.md}',
      'margin-left': '0',
    }),
    css('.arcane-radio-button:last-of-type').styles(raw: {
      'border-radius': '0 ${ArcaneRadius.md} ${ArcaneRadius.md} 0',
    }),
    css('.arcane-radio-button:only-of-type').styles(raw: {
      'border-radius': ArcaneRadius.md,
    }),
    css('.arcane-radio-button:hover').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
    // Chip hover
    css('.arcane-radio-chip:hover').styles(raw: {
      'border-color': ArcaneColors.accent,
    }),
    // Focus states
    css('.arcane-radio-input:focus-visible + .arcane-radio-circle').styles(raw: {
      'box-shadow': '0 0 0 2px ${ArcaneColors.accentContainer}',
    }),
  ];
}