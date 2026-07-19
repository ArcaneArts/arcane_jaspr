import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/rendering/base/cta_card_render_base.dart';

import 'decoration_styles.dart';

/// Neon CTA-card renderer.
class NeonCtaCard extends CtaCardRenderBase {
  const NeonCtaCard(super.props, {super.key});

  @override
  String get cssClass => 'neon-cta-card';

  @override
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      neonDecorationStyles(decoration);
}
