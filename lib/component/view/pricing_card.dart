import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';
import 'badge.dart';

/// A pricing tier model
class PricingTier {
  /// Tier name (e.g., "Free", "Pro", "Team")
  final String name;

  /// Price amount (null for custom/enterprise)
  final double? price;

  /// Price period (e.g., "month", "year")
  final String period;

  /// Currency symbol
  final String currency;

  /// Short description/tagline
  final String description;

  /// List of features included
  final List<String> features;

  /// CTA button text
  final String ctaText;

  /// Whether this is the recommended/popular tier
  final bool isPopular;

  /// Whether this tier is highlighted
  final bool isHighlighted;

  const PricingTier({
    required this.name,
    this.price,
    this.period = 'month',
    this.currency = '\$',
    required this.description,
    required this.features,
    this.ctaText = 'Get Started',
    this.isPopular = false,
    this.isHighlighted = false,
  });
}

/// A pricing card component (Supabase-style)
class PricingCard extends StatelessComponent {
  /// The pricing tier data
  final PricingTier tier;

  /// Click handler for CTA
  final void Function()? onCtaPressed;

  const PricingCard({
    required this.tier,
    this.onCtaPressed,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-pricing-card ${tier.isHighlighted ? 'highlighted' : ''} ${tier.isPopular ? 'popular' : ''}',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'padding': '32px',
        'background-color': tier.isHighlighted
            ? 'var(--arcane-accent-container)'
            : 'var(--arcane-card)',
        'border': tier.isHighlighted
            ? '2px solid var(--arcane-accent)'
            : '1px solid var(--arcane-border)',
        'border-radius': 'var(--arcane-radius-xl)',
        'position': 'relative',
        'transition': 'var(--arcane-transition)',
      }),
      [
        // Popular badge
        if (tier.isPopular)
          div(
            styles: Styles(raw: {
              'position': 'absolute',
              'top': '-12px',
              'left': '50%',
              'transform': 'translateX(-50%)',
            }),
            [Badge.primary('Most Popular')],
          ),

        // Tier name
        div(
          classes: 'arcane-pricing-name',
          styles: Styles(raw: {
            'font-size': '1.25rem',
            'font-weight': '600',
            'color': 'var(--arcane-on-surface)',
            'margin-bottom': '8px',
          }),
          [text(tier.name)],
        ),

        // Price
        div(
          classes: 'arcane-pricing-price',
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'baseline',
            'gap': '4px',
            'margin-bottom': '8px',
          }),
          [
            if (tier.price != null) ...[
              span(
                styles: Styles(raw: {
                  'font-size': '0.875rem',
                  'color': 'var(--arcane-muted)',
                }),
                [text(tier.currency)],
              ),
              span(
                styles: Styles(raw: {
                  'font-size': '3rem',
                  'font-weight': '700',
                  'color': 'var(--arcane-on-surface)',
                  'line-height': '1',
                  'letter-spacing': '-0.02em',
                }),
                [text(tier.price!.toStringAsFixed(tier.price! % 1 == 0 ? 0 : 2))],
              ),
              span(
                styles: Styles(raw: {
                  'font-size': '0.875rem',
                  'color': 'var(--arcane-muted)',
                }),
                [text('/${tier.period}')],
              ),
            ] else
              span(
                styles: Styles(raw: {
                  'font-size': '2rem',
                  'font-weight': '600',
                  'color': 'var(--arcane-on-surface)',
                }),
                [text('Custom')],
              ),
          ],
        ),

        // Description
        p(
          classes: 'arcane-pricing-description',
          styles: Styles(raw: {
            'font-size': '0.9375rem',
            'color': 'var(--arcane-muted)',
            'margin': '0 0 24px 0',
            'line-height': '1.5',
          }),
          [text(tier.description)],
        ),

        // CTA Button
        button(
          classes: 'arcane-pricing-cta',
          attributes: {'type': 'button'},
          styles: Styles(raw: {
            'width': '100%',
            'padding': '12px 16px',
            'font-size': '0.9375rem',
            'font-weight': '500',
            'border-radius': 'var(--arcane-radius)',
            'border': tier.isHighlighted
                ? 'none'
                : '1px solid var(--arcane-border)',
            'background-color': tier.isHighlighted
                ? 'var(--arcane-accent)'
                : 'transparent',
            'color': tier.isHighlighted
                ? 'var(--arcane-accent-foreground)'
                : 'var(--arcane-on-surface)',
            'cursor': 'pointer',
            'transition': 'var(--arcane-transition-fast)',
            'margin-bottom': '24px',
          }),
          events: {
            'click': (e) => onCtaPressed?.call(),
          },
          [text(tier.ctaText)],
        ),

        // Features list
        div(
          classes: 'arcane-pricing-features',
          styles: Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '12px',
          }),
          [
            for (final feature in tier.features)
              div(
                classes: 'arcane-pricing-feature',
                styles: Styles(raw: {
                  'display': 'flex',
                  'align-items': 'flex-start',
                  'gap': '12px',
                  'font-size': '0.875rem',
                  'color': 'var(--arcane-on-surface)',
                }),
                [
                  // Checkmark
                  span(
                    styles: Styles(raw: {
                      'color': 'var(--arcane-success)',
                      'flex-shrink': '0',
                      'font-size': '1rem',
                    }),
                    [text('✓')],
                  ),
                  span([text(feature)]),
                ],
              ),
          ],
        ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-pricing-card:hover').styles(raw: {
      'transform': 'translateY(-4px)',
      'box-shadow': 'var(--arcane-shadow-lg)',
    }),
    css('.arcane-pricing-cta:hover').styles(raw: {
      'opacity': '0.9',
    }),
  ];
}

/// A pricing grid for displaying multiple tiers
class PricingGrid extends StatelessComponent {
  /// The pricing tiers to display
  final List<PricingTier> tiers;

  /// Callback when a tier's CTA is pressed
  final void Function(PricingTier tier)? onTierSelected;

  /// Number of columns (auto-calculated if null)
  final int? columns;

  const PricingGrid({
    required this.tiers,
    this.onTierSelected,
    this.columns,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final cols = columns ?? tiers.length.clamp(1, 4);

    return div(
      classes: 'arcane-pricing-grid',
      styles: Styles(raw: {
        'display': 'grid',
        'grid-template-columns': 'repeat($cols, minmax(280px, 1fr))',
        'gap': '24px',
        'align-items': 'start',
      }),
      [
        for (final tier in tiers)
          PricingCard(
            tier: tier,
            onCtaPressed: () => onTierSelected?.call(tier),
          ),
      ],
    );
  }
}
