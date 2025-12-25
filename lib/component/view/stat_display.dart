import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Layout direction for stat display
enum StatDisplayLayout {
  /// Value on top, label below (default)
  vertical,

  /// Value and label side by side
  horizontal,
}

/// A metric/stat display with large value and label.
///
/// Common for trust indicators, hero stats, and dashboard metrics.
///
/// ```dart
/// ArcaneStatDisplay(
///   value: '99.9%',
///   label: 'Uptime SLA',
/// )
///
/// ArcaneStatDisplay.accent(
///   value: '10K+',
///   label: 'Active Servers',
/// )
/// ```
class ArcaneStatDisplay extends StatelessComponent {
  /// The main value (e.g., '99.9%', '10K+', '<60s')
  final String value;

  /// The label describing the value
  final String label;

  /// Layout direction
  final StatDisplayLayout layout;

  /// Value text color
  final String? valueColor;

  /// Label text color
  final String? labelColor;

  /// Value font size
  final String? valueFontSize;

  /// Label font size
  final String? labelFontSize;

  /// Text alignment
  final String? textAlign;

  const ArcaneStatDisplay({
    required this.value,
    required this.label,
    this.layout = StatDisplayLayout.vertical,
    this.valueColor,
    this.labelColor,
    this.valueFontSize,
    this.labelFontSize,
    this.textAlign,
    super.key,
  });

  /// Create with accent-colored value
  const ArcaneStatDisplay.accent({
    required this.value,
    required this.label,
    this.layout = StatDisplayLayout.vertical,
    this.labelColor,
    this.valueFontSize,
    this.labelFontSize,
    this.textAlign,
    super.key,
  }) : valueColor = ArcaneColors.accent;

  /// Create with brand-colored value
  const ArcaneStatDisplay.brand({
    required this.value,
    required this.label,
    this.layout = StatDisplayLayout.vertical,
    this.labelColor,
    this.valueFontSize,
    this.labelFontSize,
    this.textAlign,
    super.key,
  }) : valueColor = ArcaneColors.accent;

  @override
  Component build(BuildContext context) {
    final effectiveValueColor = valueColor ?? ArcaneColors.accent;
    final effectiveLabelColor = labelColor ?? ArcaneColors.muted;
    final effectiveValueSize = valueFontSize ?? ArcaneTypography.fontSize2xl;
    final effectiveLabelSize = labelFontSize ?? ArcaneTypography.fontSizeSm;
    final effectiveAlign = textAlign ?? 'center';

    if (layout == StatDisplayLayout.horizontal) {
      return div(
        styles: Styles(raw: {
          'display': 'flex',
          'align-items': 'baseline',
          'gap': ArcaneSpacing.sm,
          'text-align': effectiveAlign,
        }),
        [
          span(
            styles: Styles(raw: {
              'font-size': effectiveValueSize,
              'font-weight': '700',
              'color': effectiveValueColor,
            }),
            [text(value)],
          ),
          span(
            styles: Styles(raw: {
              'font-size': effectiveLabelSize,
              'color': effectiveLabelColor,
            }),
            [text(label)],
          ),
        ],
      );
    }

    return div(
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': effectiveAlign == 'center' ? 'center' : 'flex-start',
        'text-align': effectiveAlign,
      }),
      [
        div(
          styles: Styles(raw: {
            'font-size': effectiveValueSize,
            'font-weight': '700',
            'color': effectiveValueColor,
            'margin-bottom': ArcaneSpacing.xs,
          }),
          [text(value)],
        ),
        div(
          styles: Styles(raw: {
            'font-size': effectiveLabelSize,
            'color': effectiveLabelColor,
          }),
          [text(label)],
        ),
      ],
    );
  }
}

/// A row of stat displays for trust indicators.
///
/// ```dart
/// ArcaneStatRow(
///   stats: [
///     ArcaneStatDisplay(value: '99.9%', label: 'Uptime'),
///     ArcaneStatDisplay(value: '10K+', label: 'Servers'),
///     ArcaneStatDisplay(value: '<60s', label: 'Deploy'),
///   ],
/// )
/// ```
class ArcaneStatRow extends StatelessComponent {
  /// List of stat displays
  final List<Component> stats;

  /// Gap between stats
  final String? gap;

  /// Whether to wrap on smaller screens
  final bool wrap;

  /// Alignment
  final String? justifyContent;

  const ArcaneStatRow({
    required this.stats,
    this.gap,
    this.wrap = true,
    this.justifyContent,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(raw: {
        'display': 'flex',
        'gap': gap ?? ArcaneSpacing.xxl,
        'justify-content': justifyContent ?? 'center',
        'align-items': 'flex-start',
        if (wrap) 'flex-wrap': 'wrap',
      }),
      stats,
    );
  }
}
