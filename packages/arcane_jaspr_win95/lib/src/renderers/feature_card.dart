import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/rendering/base/feature_card_render_base.dart';

import 'decoration_styles.dart';

/// Win95 feature-card renderer.
class Win95FeatureCard extends FeatureCardRenderBase {
  const Win95FeatureCard(super.props, {super.key});

  @override
  String get cssClass => 'win95-feature-card';

  @override
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      win95DecorationStyles(decoration);
}

/// Win95 icon-card renderer.
class Win95IconCard extends IconCardRenderBase {
  const Win95IconCard(super.props, {super.key});

  @override
  String get cssClass => 'win95-icon-card';
}
