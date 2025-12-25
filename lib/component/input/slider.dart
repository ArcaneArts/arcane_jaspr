import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';
import '../../util/tokens/style_presets.dart';

/// Slider size variants
enum SliderSize {
  /// Small - 4px track, 14px thumb
  sm,

  /// Medium (default) - 6px track, 18px thumb
  md,

  /// Large - 8px track, 22px thumb
  lg,
}

/// Range slider input component with modern shadcn-inspired design.
///
/// Features:
/// - Clean, minimal track design
/// - Smooth thumb with hover/focus states
/// - Optional value tooltip
/// - Optional step markers
/// - Multiple size variants
///
/// ```dart
/// ArcaneSlider(
///   value: 50,
///   onChanged: (v) => setState(() => value = v),
/// )
/// ```
class ArcaneSlider extends StatelessComponent {
  /// Current value
  final double value;

  /// Minimum value
  final double min;

  /// Maximum value
  final double max;

  /// Step increment (null for continuous)
  final double? step;

  /// Label text displayed above the slider
  final String? label;

  /// Whether to show the current value
  final bool showValue;

  /// Prefix for the value display (e.g., "$")
  final String? valuePrefix;

  /// Suffix for the value display (e.g., "%")
  final String? valueSuffix;

  /// Number of decimal places for value display
  final int valueDecimals;

  /// Style preset
  final SliderStyle? style;

  /// Size variant
  final SliderSize size;

  /// Whether to show step markers on the track
  final bool showSteps;

  /// Whether the slider is disabled
  final bool disabled;

  /// Callback when value changes
  final void Function(double)? onChanged;

  const ArcaneSlider({
    required this.value,
    this.min = 0,
    this.max = 100,
    this.step,
    this.label,
    this.showValue = true,
    this.valuePrefix,
    this.valueSuffix,
    this.valueDecimals = 0,
    this.style,
    this.size = SliderSize.md,
    this.showSteps = false,
    this.disabled = false,
    this.onChanged,
    super.key,
  });

  /// Primary styled slider
  const ArcaneSlider.primary({
    required this.value,
    this.min = 0,
    this.max = 100,
    this.step,
    this.label,
    this.showValue = true,
    this.valuePrefix,
    this.valueSuffix,
    this.valueDecimals = 0,
    this.size = SliderSize.md,
    this.showSteps = false,
    this.disabled = false,
    this.onChanged,
    super.key,
  }) : style = SliderStyle.primary;

  /// Success styled slider
  const ArcaneSlider.success({
    required this.value,
    this.min = 0,
    this.max = 100,
    this.step,
    this.label,
    this.showValue = true,
    this.valuePrefix,
    this.valueSuffix,
    this.valueDecimals = 0,
    this.size = SliderSize.md,
    this.showSteps = false,
    this.disabled = false,
    this.onChanged,
    super.key,
  }) : style = SliderStyle.success;

  @override
  Component build(BuildContext context) {
    final effectiveStyle = style ?? SliderStyle.primary;
    final percentage = ((value - min) / (max - min) * 100).clamp(0.0, 100.0);

    // Size-specific dimensions
    final (trackHeight, thumbSize, hitAreaHeight) = switch (size) {
      SliderSize.sm => ('4px', '14px', '24px'),
      SliderSize.md => ('6px', '18px', '32px'),
      SliderSize.lg => ('8px', '22px', '40px'),
    };

    final thumbSizeNum = int.parse(thumbSize.replaceAll('px', ''));

    return div(
      classes: 'arcane-slider ${disabled ? 'disabled' : ''}',
      styles: Styles(raw: {
        'width': '100%',
        'opacity': disabled ? '0.5' : '1',
        'pointer-events': disabled ? 'none' : 'auto',
      }),
      [
        // Label row
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
                    'font-size': ArcaneTypography.fontSm,
                    'font-weight': ArcaneTypography.weightMedium,
                    'color': ArcaneColors.onSurface,
                  }),
                  [text(label!)],
                ),
              if (showValue)
                span(
                  classes: 'arcane-slider-value',
                  styles: const Styles(raw: {
                    'font-size': ArcaneTypography.fontSm,
                    'font-weight': ArcaneTypography.weightMedium,
                    'font-variant-numeric': 'tabular-nums',
                    'color': ArcaneColors.muted,
                    'min-width': '40px',
                    'text-align': 'right',
                  }),
                  [
                    text(
                      '${valuePrefix ?? ''}${value.toStringAsFixed(valueDecimals)}${valueSuffix ?? ''}',
                    ),
                  ],
                ),
            ],
          ),

        // Track container with hit area
        div(
          classes: 'arcane-slider-track-container',
          styles: Styles(raw: {
            'position': 'relative',
            'width': '100%',
            'height': hitAreaHeight,
            'display': 'flex',
            'align-items': 'center',
            'cursor': 'pointer',
          }),
          [
            // Track background
            div(
              classes: 'arcane-slider-track',
              styles: Styles(raw: {
                'position': 'absolute',
                'left': '0',
                'right': '0',
                'height': trackHeight,
                'background': ArcaneColors.surfaceVariant,
                'border-radius': ArcaneRadius.full,
                'overflow': 'visible',
              }),
              [
                // Start indicator - visible marker at 0%
                div(
                  classes: 'arcane-slider-start-indicator',
                  styles: Styles(raw: {
                    'position': 'absolute',
                    'left': '-1px',
                    'top': '50%',
                    'transform': 'translateY(-50%)',
                    'width': '3px',
                    'height': 'calc($trackHeight + 4px)',
                    'background': effectiveStyle.activeColor,
                    'border-radius': ArcaneRadius.full,
                    'opacity': '0.7',
                  }),
                  [],
                ),
                // End indicator - visible marker at 100%
                div(
                  classes: 'arcane-slider-end-indicator',
                  styles: Styles(raw: {
                    'position': 'absolute',
                    'right': '-1px',
                    'top': '50%',
                    'transform': 'translateY(-50%)',
                    'width': '3px',
                    'height': 'calc($trackHeight + 4px)',
                    'background': ArcaneColors.muted,
                    'border-radius': ArcaneRadius.full,
                    'opacity': '0.5',
                  }),
                  [],
                ),
                // Active/filled track
                div(
                  classes: 'arcane-slider-track-fill',
                  styles: Styles(raw: {
                    'position': 'absolute',
                    'left': '0',
                    'top': '0',
                    'width': '$percentage%',
                    'height': '100%',
                    'background': effectiveStyle.activeColor,
                    'border-radius': ArcaneRadius.full,
                    'transition': 'width 0.1s ease-out',
                  }),
                  [],
                ),
              ],
            ),

            // Step markers (if enabled)
            if (showSteps && step != null) _buildStepMarkers(trackHeight),

            // Thumb
            div(
              classes: 'arcane-slider-thumb',
              styles: Styles(raw: {
                'position': 'absolute',
                'left': 'calc($percentage% - ${thumbSizeNum / 2}px)',
                'top': '50%',
                'transform': 'translateY(-50%)',
                'width': thumbSize,
                'height': thumbSize,
                'background': ArcaneColors.background,
                'border': '2px solid ${effectiveStyle.activeColor}',
                'border-radius': ArcaneRadius.full,
                'box-shadow': '0 1px 3px ${ArcaneColors.onSurfaceAlpha20}',
                'transition': 'transform 0.15s ease, box-shadow 0.15s ease, border-color 0.15s ease',
                'pointer-events': 'none',
                'z-index': '2',
              }),
              [],
            ),

            // Hidden native range input for interaction
            input(
              type: InputType.range,
              classes: 'arcane-slider-input',
              attributes: {
                'min': min.toString(),
                'max': max.toString(),
                'value': value.toString(),
                'step': step?.toString() ?? 'any',
                if (disabled) 'disabled': 'true',
              },
              styles: const Styles(raw: {
                'position': 'absolute',
                'width': '100%',
                'height': '100%',
                'opacity': '0',
                'cursor': 'pointer',
                'margin': '0',
                'z-index': '3',
              }),
              events: onChanged == null
                  ? null
                  : {
                      'input': (e) {
                        final newValue =
                            double.tryParse((e.target as dynamic)?.value ?? '');
                        if (newValue != null) {
                          onChanged!(newValue);
                        }
                      },
                    },
            ),
          ],
        ),

        // Min/Max labels (optional, shown when no label is provided)
        if (label == null && !showValue)
          div(
            styles: const Styles(raw: {
              'display': 'flex',
              'justify-content': 'space-between',
              'margin-top': ArcaneSpacing.xs,
            }),
            [
              span(
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontXs,
                  'color': ArcaneColors.muted,
                }),
                [text(min.toStringAsFixed(0))],
              ),
              span(
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontXs,
                  'color': ArcaneColors.muted,
                }),
                [text(max.toStringAsFixed(0))],
              ),
            ],
          ),
      ],
    );
  }

  Component _buildStepMarkers(String trackHeight) {
    if (step == null || step! <= 0) return const div([], styles: Styles(raw: {}));

    final steps = ((max - min) / step!).floor();
    if (steps > 20) return const div([], styles: Styles(raw: {})); // Too many steps

    return div(
      styles: Styles(raw: {
        'position': 'absolute',
        'left': '0',
        'right': '0',
        'height': trackHeight,
        'display': 'flex',
        'justify-content': 'space-between',
        'align-items': 'center',
        'pointer-events': 'none',
      }),
      [
        for (var i = 0; i <= steps; i++)
          div(
            styles: const Styles(raw: {
              'width': '2px',
              'height': '2px',
              'background': ArcaneColors.muted,
              'border-radius': ArcaneRadius.full,
            }),
            [],
          ),
      ],
    );
  }
}

/// Range slider with two handles for selecting a range.
///
/// ```dart
/// ArcaneRangeSlider(
///   minValue: 20,
///   maxValue: 80,
///   onChanged: (min, max) => setState(() {
///     minValue = min;
///     maxValue = max;
///   }),
/// )
/// ```
class ArcaneRangeSlider extends StatelessComponent {
  /// Current minimum value
  final double minValue;

  /// Current maximum value
  final double maxValue;

  /// Minimum allowed value
  final double min;

  /// Maximum allowed value
  final double max;

  /// Step increment
  final double? step;

  /// Label text
  final String? label;

  /// Whether to show range values
  final bool showValues;

  /// Style preset
  final SliderStyle? style;

  /// Size variant
  final SliderSize size;

  /// Whether the slider is disabled
  final bool disabled;

  /// Callback when range changes
  final void Function(double min, double max)? onChanged;

  const ArcaneRangeSlider({
    required this.minValue,
    required this.maxValue,
    this.min = 0,
    this.max = 100,
    this.step,
    this.label,
    this.showValues = true,
    this.style,
    this.size = SliderSize.md,
    this.disabled = false,
    this.onChanged,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final effectiveStyle = style ?? SliderStyle.primary;
    final minPercent = ((minValue - min) / (max - min) * 100).clamp(0.0, 100.0);
    final maxPercent = ((maxValue - min) / (max - min) * 100).clamp(0.0, 100.0);

    final (trackHeight, thumbSize, hitAreaHeight) = switch (size) {
      SliderSize.sm => ('4px', '14px', '24px'),
      SliderSize.md => ('6px', '18px', '32px'),
      SliderSize.lg => ('8px', '22px', '40px'),
    };

    final thumbSizeNum = int.parse(thumbSize.replaceAll('px', ''));

    return div(
      classes: 'arcane-range-slider ${disabled ? 'disabled' : ''}',
      styles: Styles(raw: {
        'width': '100%',
        'opacity': disabled ? '0.5' : '1',
        'pointer-events': disabled ? 'none' : 'auto',
      }),
      [
        // Label row
        if (label != null || showValues)
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
                    'font-size': ArcaneTypography.fontSm,
                    'font-weight': ArcaneTypography.weightMedium,
                    'color': ArcaneColors.onSurface,
                  }),
                  [text(label!)],
                ),
              if (showValues)
                span(
                  classes: 'arcane-range-slider-values',
                  styles: const Styles(raw: {
                    'font-size': ArcaneTypography.fontSm,
                    'font-variant-numeric': 'tabular-nums',
                    'color': ArcaneColors.muted,
                  }),
                  [
                    text('${minValue.toStringAsFixed(0)} – ${maxValue.toStringAsFixed(0)}'),
                  ],
                ),
            ],
          ),

        // Track container
        div(
          classes: 'arcane-range-slider-track-container',
          styles: Styles(raw: {
            'position': 'relative',
            'width': '100%',
            'height': hitAreaHeight,
            'display': 'flex',
            'align-items': 'center',
            'cursor': 'pointer',
          }),
          [
            // Track background
            div(
              classes: 'arcane-range-slider-track',
              styles: Styles(raw: {
                'position': 'absolute',
                'left': '0',
                'right': '0',
                'height': trackHeight,
                'background': ArcaneColors.surfaceVariant,
                'border-radius': ArcaneRadius.full,
                'overflow': 'visible',
              }),
              [
                // Start indicator - visible marker at 0%
                div(
                  classes: 'arcane-range-slider-start-indicator',
                  styles: Styles(raw: {
                    'position': 'absolute',
                    'left': '-1px',
                    'top': '50%',
                    'transform': 'translateY(-50%)',
                    'width': '3px',
                    'height': 'calc($trackHeight + 4px)',
                    'background': effectiveStyle.activeColor,
                    'border-radius': ArcaneRadius.full,
                    'opacity': '0.7',
                  }),
                  [],
                ),
                // End indicator - visible marker at 100%
                div(
                  classes: 'arcane-range-slider-end-indicator',
                  styles: Styles(raw: {
                    'position': 'absolute',
                    'right': '-1px',
                    'top': '50%',
                    'transform': 'translateY(-50%)',
                    'width': '3px',
                    'height': 'calc($trackHeight + 4px)',
                    'background': effectiveStyle.activeColor,
                    'border-radius': ArcaneRadius.full,
                    'opacity': '0.7',
                  }),
                  [],
                ),
                // Active range
                div(
                  classes: 'arcane-range-slider-track-fill',
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
              ],
            ),

            // Min thumb
            div(
              classes: 'arcane-range-slider-thumb arcane-range-slider-thumb-min',
              styles: Styles(raw: {
                'position': 'absolute',
                'left': 'calc($minPercent% - ${thumbSizeNum / 2}px)',
                'top': '50%',
                'transform': 'translateY(-50%)',
                'width': thumbSize,
                'height': thumbSize,
                'background': ArcaneColors.background,
                'border': '2px solid ${effectiveStyle.activeColor}',
                'border-radius': ArcaneRadius.full,
                'box-shadow': '0 1px 3px ${ArcaneColors.onSurfaceAlpha20}',
                'transition': 'transform 0.15s ease, box-shadow 0.15s ease',
                'pointer-events': 'none',
                'z-index': '2',
              }),
              [],
            ),

            // Max thumb
            div(
              classes: 'arcane-range-slider-thumb arcane-range-slider-thumb-max',
              styles: Styles(raw: {
                'position': 'absolute',
                'left': 'calc($maxPercent% - ${thumbSizeNum / 2}px)',
                'top': '50%',
                'transform': 'translateY(-50%)',
                'width': thumbSize,
                'height': thumbSize,
                'background': ArcaneColors.background,
                'border': '2px solid ${effectiveStyle.activeColor}',
                'border-radius': ArcaneRadius.full,
                'box-shadow': '0 1px 3px ${ArcaneColors.onSurfaceAlpha20}',
                'transition': 'transform 0.15s ease, box-shadow 0.15s ease',
                'pointer-events': 'none',
                'z-index': '2',
              }),
              [],
            ),

            // Hidden min input
            input(
              type: InputType.range,
              classes: 'arcane-range-slider-input arcane-range-slider-input-min',
              attributes: {
                'min': min.toString(),
                'max': max.toString(),
                'value': minValue.toString(),
                'step': step?.toString() ?? 'any',
                if (disabled) 'disabled': 'true',
              },
              styles: const Styles(raw: {
                'position': 'absolute',
                'width': '100%',
                'height': '100%',
                'opacity': '0',
                'cursor': 'pointer',
                'margin': '0',
                'pointer-events': 'auto',
                'z-index': '3',
              }),
              events: onChanged == null
                  ? null
                  : {
                      'input': (e) {
                        final newMin =
                            double.tryParse((e.target as dynamic)?.value ?? '');
                        if (newMin != null && newMin < maxValue) {
                          onChanged!(newMin, maxValue);
                        }
                      },
                    },
            ),

            // Hidden max input - covers the right portion
            input(
              type: InputType.range,
              classes: 'arcane-range-slider-input arcane-range-slider-input-max',
              attributes: {
                'min': min.toString(),
                'max': max.toString(),
                'value': maxValue.toString(),
                'step': step?.toString() ?? 'any',
                if (disabled) 'disabled': 'true',
              },
              styles: Styles(raw: {
                'position': 'absolute',
                'left': '${(minPercent + maxPercent) / 2}%',
                'width': '${100 - (minPercent + maxPercent) / 2}%',
                'height': '100%',
                'opacity': '0',
                'cursor': 'pointer',
                'margin': '0',
                'pointer-events': 'auto',
                'z-index': '4',
              }),
              events: onChanged == null
                  ? null
                  : {
                      'input': (e) {
                        final newMax =
                            double.tryParse((e.target as dynamic)?.value ?? '');
                        if (newMax != null && newMax > minValue) {
                          onChanged!(minValue, newMax);
                        }
                      },
                    },
            ),
          ],
        ),
      ],
    );
  }
}
