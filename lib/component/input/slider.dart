import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;
import '../../util/tools/styles.dart';

/// Range slider input component
class Slider extends StatelessComponent {
  final double value;
  final double min;
  final double max;
  final String? label;
  final bool showValue;
  final String? valuePrefix;
  final String? valueSuffix;
  final String trackColor;
  final String activeColor;

  const Slider({
    required this.value,
    this.min = 0,
    this.max = 100,
    this.label,
    this.showValue = true,
    this.valuePrefix,
    this.valueSuffix,
    this.trackColor = '#27272A',
    this.activeColor = '#10B981',
  });

  @override
  Component build(BuildContext context) {
    final percentage = ((value - min) / (max - min) * 100).clamp(0, 100);

    return div(
      styles: Styles(raw: {
        'width': '100%',
      }),
      [
        if (label != null || showValue)
          div(
            styles: Styles(raw: {
              'display': 'flex',
              'justify-content': 'space-between',
              'align-items': 'center',
              'margin-bottom': '12px',
            }),
            [
              if (label != null)
                span(
                  styles: Styles(raw: {
                    'font-size': '14px',
                    'font-weight': '500',
                    'color': '#FAFAFA',
                  }),
                  [text(label!)],
                ),
              if (showValue)
                span(
                  styles: Styles(raw: {
                    'font-size': '14px',
                    'color': activeColor,
                    'font-weight': '600',
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
            'background': trackColor,
            'border-radius': '999px',
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
                'background': activeColor,
                'border-radius': '999px',
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
                'background': '#FAFAFA',
                'border-radius': '50%',
                'box-shadow': '0 2px 8px rgba(0,0,0,0.3)',
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
class RangeSlider extends StatelessComponent {
  final double minValue;
  final double maxValue;
  final double min;
  final double max;
  final String? label;
  final String trackColor;
  final String activeColor;

  const RangeSlider({
    required this.minValue,
    required this.maxValue,
    this.min = 0,
    this.max = 100,
    this.label,
    this.trackColor = '#27272A',
    this.activeColor = '#10B981',
  });

  @override
  Component build(BuildContext context) {
    final minPercent = ((minValue - min) / (max - min) * 100).clamp(0, 100);
    final maxPercent = ((maxValue - min) / (max - min) * 100).clamp(0, 100);

    return div(
      styles: Styles(raw: {
        'width': '100%',
      }),
      [
        if (label != null)
          div(
            styles: Styles(raw: {
              'display': 'flex',
              'justify-content': 'space-between',
              'align-items': 'center',
              'margin-bottom': '12px',
            }),
            [
              span(
                styles: Styles(raw: {
                  'font-size': '14px',
                  'font-weight': '500',
                  'color': '#FAFAFA',
                }),
                [text(label!)],
              ),
              span(
                styles: Styles(raw: {
                  'font-size': '14px',
                  'color': '#A1A1AA',
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
            'background': trackColor,
            'border-radius': '999px',
          }),
          [
            // Active range
            div(
              styles: Styles(raw: {
                'position': 'absolute',
                'left': '$minPercent%',
                'width': '${maxPercent - minPercent}%',
                'height': '100%',
                'background': activeColor,
                'border-radius': '999px',
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
                'background': '#FAFAFA',
                'border-radius': '50%',
                'box-shadow': '0 2px 8px rgba(0,0,0,0.3)',
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
                'background': '#FAFAFA',
                'border-radius': '50%',
                'box-shadow': '0 2px 8px rgba(0,0,0,0.3)',
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
