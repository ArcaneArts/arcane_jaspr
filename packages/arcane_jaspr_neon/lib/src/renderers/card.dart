import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/props/card_props.dart';
import 'package:arcane_jaspr/core/rendering/base/card_render_base.dart';

import 'decoration_styles.dart';

/// Neon Card renderer (neutralized skeleton).
class NeonCard extends CardRenderBase {
  const NeonCard(super.props, {super.key});

  @override
  String get cssClass => 'neon-card';

  @override
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      neonDecorationStyles(decoration);

  @override
  Map<String, String> baseStyles(CardProps props) => const <String, String>{};

  @override
  Map<String, String> variantStyles(CardProps props) =>
      const <String, String>{};
}
