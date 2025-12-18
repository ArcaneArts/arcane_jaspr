import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;
import '../../util/tools/styles.dart';

/// Call-to-action banner with gradient background
class ArcaneCtaBanner extends StatelessComponent {
  final String title;
  final String? subtitle;
  final Component? primaryAction;
  final Component? secondaryAction;
  final String? gradientStart;
  final String? gradientEnd;
  final String? backgroundImage;

  const ArcaneCtaBanner({
    required this.title,
    this.subtitle,
    this.primaryAction,
    this.secondaryAction,
    this.gradientStart,
    this.gradientEnd,
    this.backgroundImage,
  });

  @override
  Component build(BuildContext context) {
    final start = gradientStart ?? '#10B981';
    final end = gradientEnd ?? '#059669';

    return div(
      styles: Styles(raw: {
        'position': 'relative',
        'padding': '64px 32px',
        'border-radius': '24px',
        'background': backgroundImage != null
            ? 'url($backgroundImage) center/cover no-repeat'
            : 'linear-gradient(135deg, $start 0%, $end 100%)',
        'overflow': 'hidden',
        'text-align': 'center',
      }),
      [
        // Overlay for background image
        if (backgroundImage != null)
          div(
            styles: Styles(raw: {
              'position': 'absolute',
              'inset': '0',
              'background':
                  'linear-gradient(135deg, rgba(0,0,0,0.7) 0%, rgba(0,0,0,0.5) 100%)',
            }),
            [],
          ),
        // Content
        div(
          styles: Styles(raw: {
            'position': 'relative',
            'z-index': '1',
            'max-width': '600px',
            'margin': '0 auto',
          }),
          [
            // Title
            h2(
              styles: Styles(raw: {
                'font-size': '36px',
                'font-weight': '700',
                'color': '#FFFFFF',
                'margin': '0 0 16px 0',
              }),
              [text(title)],
            ),
            // Subtitle
            if (subtitle != null)
              p(
                styles: Styles(raw: {
                  'font-size': '18px',
                  'color': 'rgba(255, 255, 255, 0.9)',
                  'margin': '0 0 32px 0',
                  'line-height': '1.6',
                }),
                [text(subtitle!)],
              ),
            // Actions
            if (primaryAction != null || secondaryAction != null)
              div(
                styles: Styles(raw: {
                  'display': 'flex',
                  'justify-content': 'center',
                  'gap': '16px',
                  'flex-wrap': 'wrap',
                }),
                [
                  if (primaryAction != null) primaryAction!,
                  if (secondaryAction != null) secondaryAction!,
                ],
              ),
          ],
        ),
      ],
    );
  }
}
