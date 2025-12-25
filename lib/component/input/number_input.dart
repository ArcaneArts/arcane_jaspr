import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Number input size variants
enum NumberInputSize {
  sm,
  md,
  lg,
}

/// Numeric input with increment/decrement controls.
///
/// Clean stepper with +/- buttons and proper data attributes for static site support.
///
/// ```dart
/// ArcaneNumberInput(
///   value: 5,
///   min: 0,
///   max: 100,
///   onChanged: (value) => print(value),
/// )
/// ```
class ArcaneNumberInput extends StatelessComponent {
  /// Current value
  final num value;

  /// Minimum value
  final num min;

  /// Maximum value
  final num max;

  /// Step increment
  final num step;

  /// Callback when value changes
  final void Function(num)? onChanged;

  /// Size variant
  final NumberInputSize size;

  /// Whether the input is disabled
  final bool disabled;

  /// Label text
  final String? label;

  /// Prefix text (e.g., "$")
  final String? prefix;

  /// Suffix text (e.g., "kg")
  final String? suffix;

  /// Number of decimal places to display
  final int decimals;

  const ArcaneNumberInput({
    required this.value,
    this.min = 0,
    this.max = 100,
    this.step = 1,
    this.onChanged,
    this.size = NumberInputSize.md,
    this.disabled = false,
    this.label,
    this.prefix,
    this.suffix,
    this.decimals = 0,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final (height, fontSize, buttonWidth) = switch (size) {
      NumberInputSize.sm => ('32px', ArcaneTypography.fontSm, '32px'),
      NumberInputSize.md => ('40px', ArcaneTypography.fontMd, '40px'),
      NumberInputSize.lg => ('48px', ArcaneTypography.fontLg, '48px'),
    };

    final canDecrement = value > min;
    final canIncrement = value < max;
    final displayValue = decimals > 0
        ? value.toStringAsFixed(decimals)
        : value.toInt().toString();

    return div(
      classes: 'arcane-number-input',
      attributes: {
        'data-value': value.toString(),
        'data-min': min.toString(),
        'data-max': max.toString(),
        'data-step': step.toString(),
        'data-decimals': decimals.toString(),
        'data-disabled': disabled.toString(),
      },
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.sm,
      }),
      [
        // Label
        if (label != null)
          span(
            classes: 'arcane-number-input-label',
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'font-weight': ArcaneTypography.weightMedium,
              'color': ArcaneColors.onSurface,
            }),
            [text(label!)],
          ),

        // Input container
        div(
          classes: 'arcane-number-input-container',
          styles: Styles(raw: {
            'display': 'inline-flex',
            'align-items': 'stretch',
            'height': height,
            'border': '1px solid ${ArcaneColors.border}',
            'border-radius': ArcaneRadius.md,
            'overflow': 'hidden',
            'opacity': disabled ? '0.5' : '1',
          }),
          [
            // Decrement button
            button(
              type: ButtonType.button,
              classes: 'arcane-number-input-decrement',
              attributes: {
                if (!canDecrement || disabled) 'disabled': 'true',
              },
              styles: Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': buttonWidth,
                'height': '100%',
                'padding': '0',
                'border': 'none',
                'border-right': '1px solid ${ArcaneColors.border}',
                'background': (canDecrement && !disabled)
                    ? ArcaneColors.surfaceVariant
                    : ArcaneColors.surface,
                'color': (canDecrement && !disabled)
                    ? ArcaneColors.onSurface
                    : ArcaneColors.muted,
                'font-size': fontSize,
                'font-weight': ArcaneTypography.weightBold,
                'cursor': (canDecrement && !disabled) ? 'pointer' : 'not-allowed',
                'transition': ArcaneEffects.transitionFast,
                'user-select': 'none',
              }),
              events: (canDecrement && !disabled)
                  ? {
                      'click': (_) {
                        final newValue = (value - step).clamp(min, max);
                        onChanged?.call(decimals > 0 ? newValue : newValue.toInt());
                      },
                    }
                  : null,
              [text('-')],
            ),

            // Value display
            div(
              classes: 'arcane-number-input-value',
              styles: Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'gap': ArcaneSpacing.xs,
                'min-width': '60px',
                'padding': '0 ${ArcaneSpacing.sm}',
                'background': ArcaneColors.input,
                'font-size': fontSize,
                'font-weight': ArcaneTypography.weightMedium,
                'font-variant-numeric': 'tabular-nums',
                'color': ArcaneColors.onSurface,
              }),
              [
                if (prefix != null)
                  span(
                    classes: 'arcane-number-input-prefix',
                    styles: const Styles(raw: {'color': ArcaneColors.muted}),
                    [text(prefix!)],
                  ),
                span(
                  classes: 'arcane-number-input-display',
                  [text(displayValue)],
                ),
                if (suffix != null)
                  span(
                    classes: 'arcane-number-input-suffix',
                    styles: const Styles(raw: {'color': ArcaneColors.muted}),
                    [text(suffix!)],
                  ),
              ],
            ),

            // Increment button
            button(
              type: ButtonType.button,
              classes: 'arcane-number-input-increment',
              attributes: {
                if (!canIncrement || disabled) 'disabled': 'true',
              },
              styles: Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': buttonWidth,
                'height': '100%',
                'padding': '0',
                'border': 'none',
                'border-left': '1px solid ${ArcaneColors.border}',
                'background': (canIncrement && !disabled)
                    ? ArcaneColors.surfaceVariant
                    : ArcaneColors.surface,
                'color': (canIncrement && !disabled)
                    ? ArcaneColors.onSurface
                    : ArcaneColors.muted,
                'font-size': fontSize,
                'font-weight': ArcaneTypography.weightBold,
                'cursor': (canIncrement && !disabled) ? 'pointer' : 'not-allowed',
                'transition': ArcaneEffects.transitionFast,
                'user-select': 'none',
              }),
              events: (canIncrement && !disabled)
                  ? {
                      'click': (_) {
                        final newValue = (value + step).clamp(min, max);
                        onChanged?.call(decimals > 0 ? newValue : newValue.toInt());
                      },
                    }
                  : null,
              [text('+')],
            ),
          ],
        ),
      ],
    );
  }
}
