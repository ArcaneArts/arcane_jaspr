import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';
import 'button.dart';

/// A button that cycles through a list of values on each click.
class CycleButton<T> extends StatefulComponent {
  /// The available options
  final List<CycleOption<T>> options;

  /// The current value
  final T value;

  /// Callback when value changes
  final void Function(T value)? onChanged;

  /// Button variant
  final ButtonVariant variant;

  /// Button size
  final ButtonSize size;

  /// Whether the button is disabled
  final bool disabled;

  const CycleButton({
    required this.options,
    required this.value,
    this.onChanged,
    this.variant = ButtonVariant.outline,
    this.size = ButtonSize.medium,
    this.disabled = false,
    super.key,
  });

  @override
  State<CycleButton<T>> createState() => _CycleButtonState<T>();
}

class _CycleButtonState<T> extends State<CycleButton<T>> {
  void _cycle() {
    if (component.disabled || component.onChanged == null) return;

    final currentIndex = component.options
        .indexWhere((opt) => opt.value == component.value);
    final nextIndex = (currentIndex + 1) % component.options.length;
    component.onChanged!(component.options[nextIndex].value);
  }

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);
    final currentOption = component.options.firstWhere(
      (opt) => opt.value == component.value,
      orElse: () => component.options.first,
    );

    // Get size-specific styles
    final (paddingH, paddingV, fontSize, height) = switch (component.size) {
      ButtonSize.small => (12.0, 6.0, 0.75, 32.0),
      ButtonSize.medium => (16.0, 8.0, 0.875, 40.0),
      ButtonSize.large => (24.0, 12.0, 1.0, 48.0),
    };

    // Get variant-specific styles
    final (bgColor, textColor, borderColor) = switch (component.variant) {
      ButtonVariant.primary => (
          'var(--arcane-primary)',
          'var(--arcane-on-primary)',
          'transparent',
        ),
      ButtonVariant.secondary => (
          'var(--arcane-secondary)',
          'var(--arcane-on-secondary)',
          'transparent',
        ),
      ButtonVariant.outline => (
          'transparent',
          'var(--arcane-on-surface)',
          'var(--arcane-outline)',
        ),
      ButtonVariant.ghost => (
          'transparent',
          'var(--arcane-on-surface)',
          'transparent',
        ),
      ButtonVariant.destructive => (
          'var(--arcane-error)',
          'var(--arcane-on-error)',
          'transparent',
        ),
      ButtonVariant.link => (
          'transparent',
          'var(--arcane-primary)',
          'transparent',
        ),
      ButtonVariant.success => (
          'rgb(34, 197, 94)',
          'rgb(255, 255, 255)',
          'transparent',
        ),
      ButtonVariant.warning => (
          'rgb(251, 191, 36)',
          'rgb(0, 0, 0)',
          'transparent',
        ),
    };

    return button(
      classes: 'arcane-cycle-button ${component.disabled ? 'disabled' : ''}',
      attributes: {
        if (component.disabled) 'disabled': 'true',
        'type': 'button',
      },
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': '8px',
        'padding': '${paddingV}px ${paddingH}px',
        'height': '${height}px',
        'font-size': '${fontSize}rem',
        'font-weight': '500',
        'border-radius': theme.borderRadiusCss,
        'background-color': bgColor,
        'color': textColor,
        'border': borderColor == 'transparent'
            ? 'none'
            : '1px solid $borderColor',
        'cursor': component.disabled ? 'not-allowed' : 'pointer',
        'opacity': component.disabled ? '0.5' : '1',
        'transition': 'all 150ms ease',
        'white-space': 'nowrap',
      }),
      events: {
        'click': (event) => _cycle(),
      },
      [
        if (currentOption.icon != null) currentOption.icon!,
        if (currentOption.label != null) text(currentOption.label!),
        // Cycle indicator
        span(
          styles: Styles(raw: {
            'font-size': '0.75em',
            'opacity': '0.7',
          }),
          [text('⟳')],
        ),
      ],
    );
  }
}

/// An option for CycleButton
class CycleOption<T> {
  final T value;
  final String? label;
  final Component? icon;

  const CycleOption({
    required this.value,
    this.label,
    this.icon,
  });
}

/// A toggle button (on/off state)
class ToggleButton extends StatelessComponent {
  final bool value;
  final void Function(bool value)? onChanged;
  final String? label;
  final Component? icon;
  final ButtonSize size;
  final bool disabled;

  const ToggleButton({
    required this.value,
    this.onChanged,
    this.label,
    this.icon,
    this.size = ButtonSize.medium,
    this.disabled = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);

    final (paddingH, paddingV, fontSize, height) = switch (size) {
      ButtonSize.small => (12.0, 6.0, 0.75, 32.0),
      ButtonSize.medium => (16.0, 8.0, 0.875, 40.0),
      ButtonSize.large => (24.0, 12.0, 1.0, 48.0),
    };

    return button(
      classes: 'arcane-toggle-button ${value ? 'active' : ''} ${disabled ? 'disabled' : ''}',
      attributes: {
        if (disabled) 'disabled': 'true',
        'type': 'button',
        'aria-pressed': '$value',
      },
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': '8px',
        'padding': '${paddingV}px ${paddingH}px',
        'height': '${height}px',
        'font-size': '${fontSize}rem',
        'font-weight': '500',
        'border-radius': theme.borderRadiusCss,
        'background-color': value
            ? 'var(--arcane-primary)'
            : 'transparent',
        'color': value
            ? 'var(--arcane-on-primary)'
            : 'var(--arcane-on-surface)',
        'border': value
            ? 'none'
            : '1px solid var(--arcane-outline)',
        'cursor': disabled ? 'not-allowed' : 'pointer',
        'opacity': disabled ? '0.5' : '1',
        'transition': 'all 150ms ease',
      }),
      events: {
        'click': (event) {
          if (!disabled && onChanged != null) {
            onChanged!(!value);
          }
        },
      },
      [
        if (icon != null) icon!,
        if (label != null) text(label!),
      ],
    );
  }
}
