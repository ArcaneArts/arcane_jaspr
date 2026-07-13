import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/props/pricing_card_props.dart';
import 'package:arcane_jaspr/core/rendering/base/pricing_card_render_base.dart';

import 'decoration_styles.dart';

/// Win95 pricing-card renderer.
class Win95PricingCard extends PricingCardRenderBase {
  const Win95PricingCard(super.props, {super.key});

  @override
  String get cssClass => 'win95-pricing-card';

  @override
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      win95DecorationStyles(decoration);
}

/// Win95 pricing-grid renderer.
class Win95PricingGrid extends PricingGridRenderBase {
  const Win95PricingGrid(super.props, {super.key});

  @override
  String get cssClass => 'win95-pricing-grid';

  @override
  Component tierCard(PricingCardProps props) => Win95PricingCard(props);
}
