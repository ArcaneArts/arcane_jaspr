import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/props/pricing_card_props.dart';
import 'package:arcane_jaspr/core/rendering/base/pricing_card_render_base.dart';

import 'decoration_styles.dart';

/// Neubrutalism pricing-card renderer.
class NeubrutalismPricingCard extends PricingCardRenderBase {
  const NeubrutalismPricingCard(super.props, {super.key});

  @override
  String get cssClass => 'neubrutalism-pricing-card';

  @override
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      neubrutalismDecorationStyles(decoration);
}

/// Neubrutalism pricing-grid renderer.
class NeubrutalismPricingGrid extends PricingGridRenderBase {
  const NeubrutalismPricingGrid(super.props, {super.key});

  @override
  String get cssClass => 'neubrutalism-pricing-grid';

  @override
  Component tierCard(PricingCardProps props) => NeubrutalismPricingCard(props);
}
