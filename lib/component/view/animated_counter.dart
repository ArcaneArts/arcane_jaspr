import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;
import '../../util/tools/styles.dart';

/// Animated counter display for statistics
class AnimatedCounter extends StatelessComponent {
  final String value;
  final String? prefix;
  final String? suffix;
  final String? label;
  final String fontSize;
  final String? color;
  final String? gradientStart;
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
  });

  @override
  Component build(BuildContext context) {
    final hasGradient = gradientStart != null && gradientEnd != null;

    return div(
      styles: Styles(raw: {
        'text-align': 'center',
      }),
      [
        div(
          styles: Styles(raw: {
            'font-size': fontSize,
            'font-weight': '700',
            'color': hasGradient ? 'transparent' : (color ?? '#FAFAFA'),
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
              'font-size': '16px',
              'color': '#A1A1AA',
              'margin-top': '8px',
            }),
            [text(label!)],
          ),
      ],
    );
  }
}

/// Counter row for displaying multiple stats
class CounterRow extends StatelessComponent {
  final List<AnimatedCounter> counters;
  final String gap;

  const CounterRow({
    required this.counters,
    this.gap = '48px',
  });

  @override
  Component build(BuildContext context) {
    return div(
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
