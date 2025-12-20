import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/tokens/tokens.dart';
import '../../util/tokens/style_presets.dart';
import 'button.dart';

/// A button that cycles through a list of values on each click.
///
/// Use style presets for cleaner code:
/// ```dart
/// CycleButton(
///   options: [CycleOption(value: 1, label: 'One'), ...],
///   value: 1,
///   style: ButtonStyle.outline,
/// )
/// ```
class CycleButton<T> extends StatefulComponent {
  /// The available options
  final List<CycleOption<T>> options;

  /// The current value
  final T value;

  /// Callback when value changes
  final void Function(T value)? onChanged;

  /// Button style preset (preferred)
  final ButtonStyle? style;

  /// Button size
  final ButtonSize size;

  /// Whether the button is disabled
  final bool disabled;

  const CycleButton({
    required this.options,
    required this.value,
    this.onChanged,
    this.style,
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

    final currentIndex = component.options.indexWhere((opt) => opt.value == component.value);
    final nextIndex = (currentIndex + 1) % component.options.length;
    component.onChanged!(component.options[nextIndex].value);
  }

  @override
  Component build(BuildContext context) {
    final effectiveStyle = component.style ?? ButtonStyle.outline;
    final currentOption = component.options.firstWhere(
      (opt) => opt.value == component.value,
      orElse: () => component.options.first,
    );

    // Get size-specific styles
    final sizeStyle = switch (component.size) {
      ButtonSize.small => ButtonSizeStyle.sm,
      ButtonSize.medium => ButtonSizeStyle.md,
      ButtonSize.large => ButtonSizeStyle.lg,
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
        'gap': ArcaneSpacing.sm,
        ...sizeStyle.styles,
        'font-weight': ArcaneTypography.weightMedium,
        'border-radius': ArcaneRadius.md,
        ...effectiveStyle.base,
        'cursor': component.disabled ? 'not-allowed' : 'pointer',
        'opacity': component.disabled ? '0.5' : '1',
        'transition': ArcaneEffects.transitionFast,
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
          styles: const Styles(raw: {
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
    final sizeStyle = switch (size) {
      ButtonSize.small => ButtonSizeStyle.sm,
      ButtonSize.medium => ButtonSizeStyle.md,
      ButtonSize.large => ButtonSizeStyle.lg,
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
        'gap': ArcaneSpacing.sm,
        ...sizeStyle.styles,
        'font-weight': ArcaneTypography.weightMedium,
        'border-radius': ArcaneRadius.md,
        'background-color': value ? ArcaneColors.accent : ArcaneColors.transparent,
        'color': value ? ArcaneColors.accentForeground : ArcaneColors.onSurface,
        'border': value ? 'none' : '1px solid ${ArcaneColors.border}',
        'cursor': disabled ? 'not-allowed' : 'pointer',
        'opacity': disabled ? '0.5' : '1',
        'transition': ArcaneEffects.transitionFast,
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