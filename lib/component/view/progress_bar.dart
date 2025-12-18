import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;
import '../../util/tools/styles.dart';

/// Progress bar component with various styles
class ArcaneProgressBar extends StatelessComponent {
  final double value; // 0.0 to 1.0
  final String? label;
  final String height;
  final String? gradientStart;
  final String? gradientEnd;
  final bool showPercentage;
  final bool animated;
  final String? backgroundColor;

  const ArcaneProgressBar({
    required this.value,
    this.label,
    this.height = '8px',
    this.gradientStart,
    this.gradientEnd,
    this.showPercentage = false,
    this.animated = true,
    this.backgroundColor,
  });

  @override
  Component build(BuildContext context) {
    final percent = (value * 100).round();
    final start = gradientStart ?? '#10B981';
    final end = gradientEnd ?? '#059669';

    return div(
      styles: Styles(raw: {
        'width': '100%',
      }),
      [
        if (label != null || showPercentage)
          div(
            styles: Styles(raw: {
              'display': 'flex',
              'justify-content': 'space-between',
              'margin-bottom': '8px',
              'font-size': '14px',
            }),
            [
              if (label != null)
                span(styles: Styles(raw: {'color': '#FAFAFA'}), [text(label!)]),
              if (showPercentage)
                span(
                    styles: Styles(raw: {'color': '#A1A1AA'}),
                    [text('$percent%')]),
            ],
          ),
        div(
          styles: Styles(raw: {
            'width': '100%',
            'height': height,
            'background': backgroundColor ?? 'rgba(63, 63, 70, 0.5)',
            'border-radius': '999px',
            'overflow': 'hidden',
          }),
          [
            div(
              styles: Styles(raw: {
                'width': '${percent}%',
                'height': '100%',
                'background': 'linear-gradient(90deg, $start 0%, $end 100%)',
                'border-radius': '999px',
                'transition': animated ? 'width 0.5s ease-out' : 'none',
              }),
              [],
            ),
          ],
        ),
      ],
    );
  }
}

/// Circular progress indicator
class CircularProgress extends StatelessComponent {
  final double value; // 0.0 to 1.0
  final String size;
  final String strokeWidth;
  final String? color;
  final String? label;

  const CircularProgress({
    required this.value,
    this.size = '80px',
    this.strokeWidth = '8px',
    this.color,
    this.label,
  });

  @override
  Component build(BuildContext context) {
    final percent = (value * 100).round();
    final progressColor = color ?? '#10B981';

    return div(
      styles: Styles(raw: {
        'position': 'relative',
        'width': size,
        'height': size,
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
      }),
      [
        // Background circle using conic gradient
        div(
          styles: Styles(raw: {
            'position': 'absolute',
            'width': '100%',
            'height': '100%',
            'border-radius': '50%',
            'background':
                'conic-gradient($progressColor 0deg ${value * 360}deg, rgba(63, 63, 70, 0.5) ${value * 360}deg 360deg)',
            'mask':
                'radial-gradient(farthest-side, transparent calc(100% - $strokeWidth), #fff calc(100% - $strokeWidth))',
            '-webkit-mask':
                'radial-gradient(farthest-side, transparent calc(100% - $strokeWidth), #fff calc(100% - $strokeWidth))',
          }),
          [],
        ),
        // Center content
        div(
          styles: Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'align-items': 'center',
            'justify-content': 'center',
          }),
          [
            span(
              styles: Styles(raw: {
                'font-size': '20px',
                'font-weight': '700',
                'color': '#FAFAFA',
              }),
              [text('$percent%')],
            ),
            if (label != null)
              span(
                styles: Styles(raw: {
                  'font-size': '12px',
                  'color': '#A1A1AA',
                }),
                [text(label!)],
              ),
          ],
        ),
      ],
    );
  }
}
