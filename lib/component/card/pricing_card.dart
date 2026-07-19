import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/props/pricing_card_props.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

/// A plan surface: an optional badge and icon, a title, a price row (optional
/// struck-through original price + large price + muted period), an optional
/// subtitle, an included/excluded feature list, an optional spec table, and a
/// call-to-action button. Themed automatically by the active stylesheet.
class PricingCard extends StatelessWidget {
  final PricingTier? tier;
  final void Function()? onCtaPressed;
  final String? title;
  final String? subtitle;
  final String? price;
  final String period;
  final String? originalPrice;
  final String? badge;
  final PricingBadgeVariant badgeVariant;
  final List<String> features;
  final List<String> excludedFeatures;
  final List<SpecEntry>? specs;
  final String buttonText;
  final String? buttonLink;
  final void Function()? onButtonClick;
  final PricingCardVariant variant;
  final bool highlighted;
  final String? accentColor;
  final Widget? icon;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const PricingCard({
    this.tier,
    this.onCtaPressed,
    this.title,
    this.subtitle,
    this.price,
    this.period = '/month',
    this.originalPrice,
    this.badge,
    this.badgeVariant = PricingBadgeVariant.popular,
    this.features = const <String>[],
    this.excludedFeatures = const <String>[],
    this.specs,
    this.buttonText = 'Get Started',
    this.buttonLink,
    this.onButtonClick,
    this.variant = PricingCardVariant.standard,
    this.highlighted = false,
    this.accentColor,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  });

  /// Creates a compact pricing card for grids.
  const PricingCard.compact({
    required String this.title,
    required String this.price,
    this.subtitle,
    this.period = '/month',
    this.originalPrice,
    this.badge,
    this.badgeVariant = PricingBadgeVariant.popular,
    this.features = const <String>[],
    this.excludedFeatures = const <String>[],
    this.specs,
    this.buttonText = 'Get Started',
    this.buttonLink,
    this.onButtonClick,
    this.highlighted = false,
    this.accentColor,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  })  : tier = null,
        onCtaPressed = null,
        variant = PricingCardVariant.compact;

  /// Creates a hero pricing card for landing pages.
  const PricingCard.hero({
    required String this.title,
    required String this.price,
    this.subtitle,
    this.period = '/month',
    this.originalPrice,
    this.badge,
    this.badgeVariant = PricingBadgeVariant.popular,
    this.features = const <String>[],
    this.excludedFeatures = const <String>[],
    this.specs,
    this.buttonText = 'Get Started',
    this.buttonLink,
    this.onButtonClick,
    this.highlighted = false,
    this.accentColor,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  })  : tier = null,
        onCtaPressed = null,
        variant = PricingCardVariant.hero;

  @override
  Widget build(BuildContext context) => context.renderers.pricingCard(
        PricingCardProps(
          tier: tier,
          onCtaPressed: onCtaPressed,
          title: title,
          subtitle: subtitle,
          price: price,
          period: period,
          originalPrice: originalPrice,
          badge: badge,
          badgeVariant: badgeVariant,
          features: features,
          excludedFeatures: excludedFeatures,
          specs: specs,
          buttonText: buttonText,
          buttonLink: buttonLink,
          onButtonClick: onButtonClick,
          variant: variant,
          highlighted: highlighted,
          accentColor: accentColor,
          icon: icon,
          styles: styles,
          decoration: decoration,
        ),
      );
}

/// A responsive grid of pricing cards, one per [tiers] entry, laid out in
/// [columns] equal columns (defaulting to one column per tier). Themed
/// automatically by the active stylesheet.
class PricingGrid extends StatelessWidget {
  final List<PricingTier> tiers;
  final void Function(PricingTier tier)? onTierSelected;
  final int? columns;

  const PricingGrid({
    required this.tiers,
    this.onTierSelected,
    this.columns,
    super.key,
  });

  @override
  Widget build(BuildContext context) => context.renderers.pricingGrid(
        PricingGridProps(
          tiers: tiers,
          onTierSelected: onTierSelected,
          columns: columns,
        ),
      );
}
