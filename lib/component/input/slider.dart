import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';
import '../../util/tokens/style_presets.dart';

/// Range slider input component
///
/// Use style presets for cleaner code:
/// ```dart
/// Slider(
///   value: 50,
///   style: SliderStyle.success,
/// )
/// ```
class ArcaneSlider extends StatelessComponent {
  final double value;
  final double min;
  final double max;
  final String? label;
  final bool showValue;
  final String? valuePrefix;
  final String? valueSuffix;
  final SliderStyle? style;
  final void Function(double)? onChanged;

  const ArcaneSlider({
    required this.value,
    this.min = 0,
    this.max = 100,
    this.label,
    this.showValue = true,
    this.valuePrefix,
    this.valueSuffix,
    this.style,
    this.onChanged,
    super.key,
  });

  /// Primary slider
  const ArcaneSlider.primary({
    required this.value,
    this.min = 0,
    this.max = 100,
    this.label,
    this.showValue = true,
    this.valuePrefix,
    this.valueSuffix,
    this.onChanged,
    super.key,
  }) : style = SliderStyle.primary;

  /// Success slider
  const ArcaneSlider.success({
    required this.value,
    this.min = 0,
    this.max = 100,
    this.label,
    this.showValue = true,
    this.valuePrefix,
    this.valueSuffix,
    this.onChanged,
    super.key,
  }) : style = SliderStyle.success;

  @override
  Component build(BuildContext context) {
    final effectiveStyle = style ?? SliderStyle.primary;
    final percentage = ((value - min) / (max - min) * 100).clamp(0, 100);

    return div(
      styles: const Styles(raw: {
        'width': '100%',
      }),
      [
        if (label != null || showValue)
          div(
            styles: const Styles(raw: {
              'display': 'flex',
              'justify-content': 'space-between',
              'align-items': 'center',
              'margin-bottom': ArcaneSpacing.sm,
            }),
            [
              if (label != null)
                span(
                  styles: const Styles(raw: {
                    'font-size': ArcaneTypography.fontMd,
                    'font-weight': ArcaneTypography.weightMedium,
                    'color': ArcaneColors.onSurface,
                  }),
                  [text(label!)],
                ),
              if (showValue)
                span(
                  styles: Styles(raw: {
                    'font-size': ArcaneTypography.fontMd,
                    'color': effectiveStyle.activeColor,
                    'font-weight': ArcaneTypography.weightSemibold,
                  }),
                  [
                    text(
                        '${valuePrefix ?? ''}${value.toStringAsFixed(0)}${valueSuffix ?? ''}'),
                  ],
                ),
            ],
          ),
        // Track
        div(
          styles: Styles(raw: {
            'position': 'relative',
            'width': '100%',
            'height': '8px',
            'background': effectiveStyle.trackColor,
            'border-radius': ArcaneRadius.full,
          }),
          [
            // Active track
            div(
              styles: Styles(raw: {
                'position': 'absolute',
                'left': '0',
                'top': '0',
                'width': '$percentage%',
                'height': '100%',
                'background': effectiveStyle.activeColor,
                'border-radius': ArcaneRadius.full,
              }),
              [],
            ),
            // Thumb
            div(
              styles: Styles(raw: {
                'position': 'absolute',
                'left': 'calc($percentage% - 10px)',
                'top': '50%',
                'transform': 'translateY(-50%)',
                'width': '20px',
                'height': '20px',
                'background': effectiveStyle.thumbColor,
                'border-radius': ArcaneRadius.full,
                'box-shadow': ArcaneEffects.shadowMd,
                'cursor': 'pointer',
              }),
              [],
            ),
          ],
        ),
      ],
    );
  }
}

/// Range slider with two handles
class ArcaneRangeSlider extends StatelessComponent {
  final double minValue;
  final double maxValue;
  final double min;
  final double max;
  final String? label;
  final SliderStyle? style;
  final void Function(double, double)? onChanged;

  const ArcaneRangeSlider({
    required this.minValue,
    required this.maxValue,
    this.min = 0,
    this.max = 100,
    this.label,
    this.style,
    this.onChanged,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final effectiveStyle = style ?? SliderStyle.primary;
    final minPercent = ((minValue - min) / (max - min) * 100).clamp(0, 100);
    final maxPercent = ((maxValue - min) / (max - min) * 100).clamp(0, 100);

    return div(
      styles: const Styles(raw: {
        'width': '100%',
      }),
      [
        if (label != null)
          div(
            styles: const Styles(raw: {
              'display': 'flex',
              'justify-content': 'space-between',
              'align-items': 'center',
              'margin-bottom': ArcaneSpacing.sm,
            }),
            [
              span(
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontMd,
                  'font-weight': ArcaneTypography.weightMedium,
                  'color': ArcaneColors.onSurface,
                }),
                [text(label!)],
              ),
              span(
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontMd,
                  'color': ArcaneColors.muted,
                }),
                [
                  text(
                      '${minValue.toStringAsFixed(0)} - ${maxValue.toStringAsFixed(0)}'),
                ],
              ),
            ],
          ),
        // Track
        div(
          styles: Styles(raw: {
            'position': 'relative',
            'width': '100%',
            'height': '8px',
            'background': effectiveStyle.trackColor,
            'border-radius': ArcaneRadius.full,
          }),
          [
            // Active range
            div(
              styles: Styles(raw: {
                'position': 'absolute',
                'left': '$minPercent%',
                'width': '${maxPercent - minPercent}%',
                'height': '100%',
                'background': effectiveStyle.activeColor,
                'border-radius': ArcaneRadius.full,
              }),
              [],
            ),
            // Min thumb
            div(
              styles: Styles(raw: {
                'position': 'absolute',
                'left': 'calc($minPercent% - 10px)',
                'top': '50%',
                'transform': 'translateY(-50%)',
                'width': '20px',
                'height': '20px',
                'background': effectiveStyle.thumbColor,
                'border-radius': ArcaneRadius.full,
                'box-shadow': ArcaneEffects.shadowMd,
                'cursor': 'pointer',
                'z-index': '2',
              }),
              [],
            ),
            // Max thumb
            div(
              styles: Styles(raw: {
                'position': 'absolute',
                'left': 'calc($maxPercent% - 10px)',
                'top': '50%',
                'transform': 'translateY(-50%)',
                'width': '20px',
                'height': '20px',
                'background': effectiveStyle.thumbColor,
                'border-radius': ArcaneRadius.full,
                'box-shadow': ArcaneEffects.shadowMd,
                'cursor': 'pointer',
                'z-index': '2',
              }),
              [],
            ),
          ],
        ),
      ],
    );
  }
}