import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Animated counter display for statistics
class AnimatedCounter extends StatelessComponent {
  /// The value to display
  final String value;

  /// Prefix (e.g., "$")
  final String? prefix;

  /// Suffix (e.g., "+", "%")
  final String? suffix;

  /// Label text
  final String? label;

  /// Font size
  final String fontSize;

  /// Custom color
  final String? color;

  /// Gradient start color (use with gradientEnd)
  final String? gradientStart;

  /// Gradient end color (use with gradientStart)
  final String? gradientEnd;

  const AnimatedCounter({
    required this.value,
    this.prefix,
    this.suffix,
    this.label,
    this.fontSize = '48px',
    this.color,
    this.gradientStart,
    this.gradientEnd,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final bool hasGradient = gradientStart != null && gradientEnd != null;

    return div(
      classes: 'arcane-animated-counter',
      styles: Styles(raw: {
        'text-align': 'center',
      }),
      [
        div(
          styles: Styles(raw: {
            'font-size': fontSize,
            'font-weight': ArcaneTypography.weightBold,
            'color': hasGradient ? ArcaneColors.transparent : (color ?? ArcaneColors.onSurface),
            'background': hasGradient
                ? 'linear-gradient(135deg, $gradientStart 0%, $gradientEnd 100%)'
                : 'none',
            '-webkit-background-clip': hasGradient ? 'text' : 'none',
            'background-clip': hasGradient ? 'text' : 'none',
            'line-height': '1.1',
          }),
          [
            if (prefix != null)
              span(
                styles: Styles(raw: {'font-size': 'calc($fontSize * 0.6)'}),
                [text(prefix!)],
              ),
            text(value),
            if (suffix != null)
              span(
                styles: Styles(raw: {'font-size': 'calc($fontSize * 0.6)'}),
                [text(suffix!)],
              ),
          ],
        ),
        if (label != null)
          div(
            styles: Styles(raw: {
              'font-size': ArcaneTypography.fontMd,
              'color': ArcaneColors.muted,
              'margin-top': ArcaneSpacing.sm,
            }),
            [text(label!)],
          ),
      ],
    );
  }
}

/// Counter row for displaying multiple stats
class CounterRow extends StatelessComponent {
  /// Counters to display
  final List<AnimatedCounter> counters;

  /// Gap between counters
  final String gap;

  const CounterRow({
    required this.counters,
    this.gap = '48px',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-counter-row',
      styles: Styles(raw: {
        'display': 'flex',
        'justify-content': 'center',
        'align-items': 'flex-start',
        'gap': gap,
        'flex-wrap': 'wrap',
      }),
      counters,
    );
  }
}

/// A metric display with label
class MetricDisplay extends StatelessComponent {
  /// Metric value
  final String value;

  /// Metric label
  final String label;

  /// Optional icon
  final String? icon;

  /// Optional trend indicator
  final String? trend;

  /// Whether trend is positive
  final bool trendPositive;

  const MetricDisplay({
    required this.value,
    required this.label,
    this.icon,
    this.trend,
    this.trendPositive = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-metric-display',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'text-align': 'center',
        'gap': ArcaneSpacing.sm,
      }),
      [
        if (icon != null)
          div(
            styles: Styles(raw: {
              'font-size': ArcaneTypography.font2xl,
              'color': ArcaneColors.accent,
              'margin-bottom': ArcaneSpacing.xs,
            }),
            [text(icon!)],
          ),
        div(
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'baseline',
            'gap': ArcaneSpacing.sm,
          }),
          [
            span(
              styles: Styles(raw: {
                'font-size': ArcaneTypography.font3xl,
                'font-weight': ArcaneTypography.weightBold,
                'color': ArcaneColors.onSurface,
              }),
              [text(value)],
            ),
            if (trend != null)
              span(
                styles: Styles(raw: {
                  'font-size': ArcaneTypography.fontSm,
                  'font-weight': ArcaneTypography.weightMedium,
                  'color': trendPositive ? ArcaneColors.success : ArcaneColors.error,
                }),
                [text('${trendPositive ? '↑' : '↓'}$trend')],
              ),
          ],
        ),
        div(
          styles: Styles(raw: {
            'font-size': ArcaneTypography.fontSm,
            'color': ArcaneColors.muted,
          }),
          [text(label)],
        ),
      ],
    );
  }
}
