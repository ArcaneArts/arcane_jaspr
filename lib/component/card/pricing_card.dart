import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';
import '../view/icon.dart';

/// A plan surface: an optional icon, a title, a price row, an optional
/// subtitle, an included/excluded feature list, an optional spec table, and a
/// call-to-action button. Themed automatically by the active stylesheet.
class PricingCard extends StatelessWidget {
  final PricingTier? tier;
  final void Function()? onCtaPressed;
  final String? title;
  final String? subtitle;
  final String? price;
  final String period;
  final List<String> features;
  final List<String> excludedFeatures;
  final List<SpecEntry>? specs;
  final String buttonText;
  final String? buttonLink;
  final void Function()? onButtonClick;
  final PricingCardVariant variant;
  final ArcaneGlyph? icon;

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
    this.features = const <String>[],
    this.excludedFeatures = const <String>[],
    this.specs,
    this.buttonText = 'Get Started',
    this.buttonLink,
    this.onButtonClick,
    this.variant = PricingCardVariant.standard,
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
    this.features = const <String>[],
    this.excludedFeatures = const <String>[],
    this.specs,
    this.buttonText = 'Get Started',
    this.buttonLink,
    this.onButtonClick,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  }) : tier = null,
       onCtaPressed = null,
       variant = PricingCardVariant.compact;

  @override
  Widget build(BuildContext context) => context.renderers.pricingCard(
    PricingCardProps(
      tier: tier,
      onCtaPressed: onCtaPressed,
      title: title,
      subtitle: subtitle,
      price: price,
      period: period,
      features: features,
      excludedFeatures: excludedFeatures,
      specs: specs,
      buttonText: buttonText,
      buttonLink: buttonLink,
      onButtonClick: onButtonClick,
      variant: variant,
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
