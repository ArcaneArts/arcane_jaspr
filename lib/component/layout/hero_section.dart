import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';
import '../typography/headline.dart';

/// Simple edge insets for padding
class EdgeInsets {
  final double top;
  final double right;
  final double bottom;
  final double left;

  const EdgeInsets.all(double value)
      : top = value,
        right = value,
        bottom = value,
        left = value;

  const EdgeInsets.symmetric({double vertical = 0, double horizontal = 0})
      : top = vertical,
        bottom = vertical,
        left = horizontal,
        right = horizontal;

  const EdgeInsets.only({
    this.top = 0,
    this.right = 0,
    this.bottom = 0,
    this.left = 0,
  });

  String get padding => '${top}px ${right}px ${bottom}px ${left}px';
}

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
        'padding': '${verticalPadding}px 24px',
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
            'gap': '24px',
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
                  'gap': '12px',
                  'margin-top': '8px',
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
              'margin-top': '48px',
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

/// A CTA banner with gradient background
class CtaBanner extends StatelessComponent {
  /// Banner headline
  final String headline;

  /// Banner description
  final String? description;

  /// CTA button
  final Component? cta;

  /// Whether to use gradient background
  final bool gradient;

  /// Padding
  final EdgeInsets padding;

  const CtaBanner({
    required this.headline,
    this.description,
    this.cta,
    this.gradient = true,
    this.padding = const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return section(
      classes: 'arcane-cta-banner',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'text-align': 'center',
        'padding': padding.padding,
        'border-radius': 'var(--arcane-radius-xl)',
        if (gradient)
          'background': 'linear-gradient(135deg, var(--arcane-accent-container) 0%, var(--arcane-surface-variant) 100%)'
        else
          'background-color': 'var(--arcane-surface-variant)',
        'border': '1px solid var(--arcane-border)',
      }),
      [
        Headline.h2(
          headline,
          align: 'center',
        ),
        if (description != null)
          div(
            styles: Styles(raw: {'margin-top': '12px'}),
            [
              Subheadline(
                description!,
                size: 'md',
                align: 'center',
              ),
            ],
          ),
        if (cta != null)
          div(
            styles: Styles(raw: {'margin-top': '24px'}),
            [cta!],
          ),
      ],
    );
  }
}
