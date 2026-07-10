import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/props/pricing_card_props.dart';
import 'package:arcane_jaspr/core/rendering/base/pricing_card_render_base.dart';

import 'decoration_styles.dart';

/// Neon pricing-card renderer.
class NeonPricingCard extends PricingCardRenderBase {
  const NeonPricingCard(super.props, {super.key});

  @override
  String get cssClass => 'neon-pricing-card';

  @override
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      neonDecorationStyles(decoration);
}

/// Neon pricing-grid renderer.
class NeonPricingGrid extends PricingGridRenderBase {
  const NeonPricingGrid(super.props, {super.key});

  @override
  String get cssClass => 'neon-pricing-grid';

  @override
  Component tierCard(PricingCardProps props) => NeonPricingCard(props);
}
