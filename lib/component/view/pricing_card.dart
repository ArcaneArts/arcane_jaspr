import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';
import '../../util/tokens/style_presets.dart';
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
        'padding': ArcaneSpacing.xxl,
        'background-color': tier.isHighlighted
            ? ArcaneColors.accentContainer
            : ArcaneColors.card,
        'border': tier.isHighlighted
            ? '2px solid ${ArcaneColors.accent}'
            : '1px solid ${ArcaneColors.border}',
        'border-radius': ArcaneRadius.xl,
        'position': 'relative',
        'transition': ArcaneEffects.transition,
      }),
      [
        // Popular badge
        if (tier.isPopular)
          const div(
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
          styles: const Styles(raw: {
            'font-size': ArcaneTypography.fontXl,
            'font-weight': ArcaneTypography.weightSemibold,
            'color': ArcaneColors.onSurface,
            'margin-bottom': ArcaneSpacing.sm,
          }),
          [text(tier.name)],
        ),

        // Price
        div(
          classes: 'arcane-pricing-price',
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'baseline',
            'gap': ArcaneSpacing.xs,
            'margin-bottom': ArcaneSpacing.sm,
          }),
          [
            if (tier.price != null) ...[
              span(
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontSm,
                  'color': ArcaneColors.muted,
                }),
                [text(tier.currency)],
              ),
              span(
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.font4xl,
                  'font-weight': ArcaneTypography.weightBold,
                  'color': ArcaneColors.onSurface,
                  'line-height': '1',
                  'letter-spacing': '-0.02em',
                }),
                [text(tier.price!.toStringAsFixed(tier.price! % 1 == 0 ? 0 : 2))],
              ),
              span(
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontSm,
                  'color': ArcaneColors.muted,
                }),
                [text('/${tier.period}')],
              ),
            ] else
              span(
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.font2xl,
                  'font-weight': ArcaneTypography.weightSemibold,
                  'color': ArcaneColors.onSurface,
                }),
                [text('Custom')],
              ),
          ],
        ),

        // Description
        p(
          classes: 'arcane-pricing-description',
          styles: const Styles(raw: {
            'font-size': ArcaneTypography.fontMd,
            'color': ArcaneColors.muted,
            'margin': '0 0 ${ArcaneSpacing.xl} 0',
            'line-height': ArcaneTypography.leadingNormal,
          }),
          [text(tier.description)],
        ),

        // CTA Button
        button(
          classes: 'arcane-pricing-cta',
          attributes: {'type': 'button'},
          styles: Styles(raw: {
            'width': '100%',
            'padding': '${ArcaneSpacing.md} ${ArcaneSpacing.lg}',
            'font-size': ArcaneTypography.fontMd,
            'font-weight': ArcaneTypography.weightMedium,
            'border-radius': ArcaneRadius.md,
            'border': tier.isHighlighted
                ? 'none'
                : '1px solid ${ArcaneColors.border}',
            'background-color': tier.isHighlighted
                ? ArcaneColors.accent
                : ArcaneColors.transparent,
            'color': tier.isHighlighted
                ? ArcaneColors.accentForeground
                : ArcaneColors.onSurface,
            'cursor': 'pointer',
            'transition': ArcaneEffects.transitionFast,
            'margin-bottom': ArcaneSpacing.xl,
          }),
          events: {
            'click': (e) => onCtaPressed?.call(),
          },
          [text(tier.ctaText)],
        ),

        // Features list
        div(
          classes: 'arcane-pricing-features',
          styles: const Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'gap': ArcaneSpacing.md,
          }),
          [
            for (final feature in tier.features)
              div(
                classes: 'arcane-pricing-feature',
                styles: const Styles(raw: {
                  'display': 'flex',
                  'align-items': 'flex-start',
                  'gap': ArcaneSpacing.md,
                  'font-size': ArcaneTypography.fontSm,
                  'color': ArcaneColors.onSurface,
                }),
                [
                  // Checkmark
                  span(
                    styles: const Styles(raw: {
                      'color': ArcaneColors.success,
                      'flex-shrink': '0',
                      'font-size': ArcaneTypography.fontMd,
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
      'transform': ArcaneEffects.hoverLift,
      'box-shadow': ArcaneEffects.shadowLg,
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
    final int cols = columns ?? tiers.length.clamp(1, 4);

    return div(
      classes: 'arcane-pricing-grid',
      styles: Styles(raw: {
        'display': 'grid',
        'grid-template-columns': 'repeat($cols, minmax(280px, 1fr))',
        'gap': ArcaneSpacing.xl,
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