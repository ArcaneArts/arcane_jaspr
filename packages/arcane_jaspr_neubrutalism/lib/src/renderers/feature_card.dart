import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/rendering/base/feature_card_render_base.dart';

import 'decoration_styles.dart';

/// Neubrutalism feature-card renderer.
class NeubrutalismFeatureCard extends FeatureCardRenderBase {
  const NeubrutalismFeatureCard(super.props, {super.key});

  @override
  String get cssClass => 'neubrutalism-feature-card';

  @override
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      neubrutalismDecorationStyles(decoration);
}

/// Neubrutalism icon-card renderer.
class NeubrutalismIconCard extends IconCardRenderBase {
  const NeubrutalismIconCard(super.props, {super.key});

  @override
  String get cssClass => 'neubrutalism-icon-card';
}
