import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/rendering/base/feature_card_render_base.dart';

import 'decoration_styles.dart';

/// Neon feature-card renderer.
class NeonFeatureCard extends FeatureCardRenderBase {
  const NeonFeatureCard(super.props, {super.key});

  @override
  String get cssClass => 'neon-feature-card';

  @override
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      neonDecorationStyles(decoration);
}

/// Neon icon-card renderer.
class NeonIconCard extends IconCardRenderBase {
  const NeonIconCard(super.props, {super.key});

  @override
  String get cssClass => 'neon-icon-card';
}
