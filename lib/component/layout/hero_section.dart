import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';
import '../typography/headline.dart';

/// A hero section component (Supabase-style)
class HeroSection extends StatelessComponent {
  /// Main headline text
  final String headline;

  /// Subheadline/description text
  final String? subheadline;

  /// Primary CTA component
  final Component? primaryCta;

  /// Secondary CTA component
  final Component? secondaryCta;

  /// Optional badge/pill above headline
  final Component? badge;

  /// Optional media (video, image, etc.)
  final Component? media;

  /// Whether to center content
  final bool centered;

  /// Vertical padding
  final double verticalPadding;

  /// Maximum content width
  final double maxWidth;

  const HeroSection({
    required this.headline,
    this.subheadline,
    this.primaryCta,
    this.secondaryCta,
    this.badge,
    this.media,
    this.centered = true,
    this.verticalPadding = 80,
    this.maxWidth = 800,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return section(
      classes: 'arcane-hero-section',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': centered ? 'center' : 'flex-start',
        'text-align': centered ? 'center' : 'left',
        'padding': '${verticalPadding}px ${ArcaneSpacing.lg}',
      }),
      [
        // Content wrapper
        div(
          classes: 'arcane-hero-content',
          styles: Styles(raw: {
            'max-width': '${maxWidth}px',
            'display': 'flex',
            'flex-direction': 'column',
            'align-items': centered ? 'center' : 'flex-start',
            'gap': ArcaneSpacing.lg,
          }),
          [
            // Badge
            if (badge != null) badge!,

            // Headline
            Headline.h1(
              headline,
              align: centered ? 'center' : 'left',
            ),

            // Subheadline
            if (subheadline != null)
              Subheadline(
                subheadline!,
                size: 'lg',
                align: centered ? 'center' : 'left',
              ),

            // CTA buttons
            if (primaryCta != null || secondaryCta != null)
              div(
                classes: 'arcane-hero-ctas',
                styles: Styles(raw: {
                  'display': 'flex',
                  'flex-wrap': 'wrap',
                  'gap': ArcaneSpacing.sm,
                  'margin-top': ArcaneSpacing.sm,
                  if (centered) 'justify-content': 'center',
                }),
                [
                  if (primaryCta != null) primaryCta!,
                  if (secondaryCta != null) secondaryCta!,
                ],
              ),
          ],
        ),

        // Media
        if (media != null)
          div(
            classes: 'arcane-hero-media',
            styles: Styles(raw: {
              'margin-top': ArcaneSpacing.xxl,
              'width': '100%',
              'max-width': '1200px',
            }),
            [media!],
          ),
      ],
    );
  }
}

/// A CTA button group component
class CtaGroup extends StatelessComponent {
  /// Primary CTA component
  final Component primaryCta;

  /// Secondary CTA component
  final Component? secondaryCta;

  /// Whether to center the CTAs
  final bool centered;

  /// Gap between buttons
  final double gap;

  const CtaGroup({
    required this.primaryCta,
    this.secondaryCta,
    this.centered = false,
    this.gap = 12,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-cta-group',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-wrap': 'wrap',
        'gap': '${gap}px',
        if (centered) 'justify-content': 'center',
      }),
      [
        primaryCta,
        if (secondaryCta != null) secondaryCta!,
      ],
    );
  }
}
