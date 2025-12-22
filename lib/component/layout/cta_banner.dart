import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

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
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final String start = gradientStart ?? ArcaneColors.success;
    final String end = gradientEnd ?? ArcaneColors.successHover;

    return div(
      classes: 'arcane-cta-banner',
      styles: Styles(raw: {
        'position': 'relative',
        'padding': '64px 32px',
        'border-radius': ArcaneRadius.xl,
        'background': backgroundImage != null
            ? 'url($backgroundImage) center/cover no-repeat'
            : 'linear-gradient(135deg, $start 0%, $end 100%)',
        'overflow': 'hidden',
        'text-align': 'center',
      }),
      [
        // Overlay for background image
        if (backgroundImage != null)
          const div(
            styles: Styles(raw: {
              'position': 'absolute',
              'inset': '0',
              'background':
                  'linear-gradient(135deg, ${ArcaneColors.overlayStrong} 0%, ${ArcaneColors.overlay} 100%)',
            }),
            [],
          ),
        // Content
        div(
          styles: const Styles(raw: {
            'position': 'relative',
            'z-index': '1',
            'max-width': '600px',
            'margin': '0 auto',
          }),
          [
            // Title
            h2(
              styles: const Styles(raw: {
                'font-size': ArcaneTypography.font3xl,
                'font-weight': ArcaneTypography.weightBold,
                'color': ArcaneColors.onSurface,
                'margin': '0 0 ${ArcaneSpacing.md} 0',
              }),
              [text(title)],
            ),
            // Subtitle
            if (subtitle != null)
              p(
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontLg,
                  'color': ArcaneColors.onSurfaceAlpha70,
                  'margin': '0 0 ${ArcaneSpacing.xl} 0',
                  'line-height': ArcaneTypography.lineHeightRelaxed,
                }),
                [text(subtitle!)],
              ),
            // Actions
            if (primaryAction != null || secondaryAction != null)
              div(
                styles: const Styles(raw: {
                  'display': 'flex',
                  'justify-content': 'center',
                  'gap': ArcaneSpacing.md,
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
