import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/rendering/base/cta_card_render_base.dart';

import 'decoration_styles.dart';

/// Win95 CTA-card renderer.
class Win95CtaCard extends CtaCardRenderBase {
  const Win95CtaCard(super.props, {super.key});

  @override
  String get cssClass => 'win95-cta-card';

  @override
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      win95DecorationStyles(decoration);
}
