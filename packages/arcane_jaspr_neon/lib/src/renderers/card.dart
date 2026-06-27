import 'package:arcane_jaspr/core/props/card_props.dart';
import 'package:arcane_jaspr/core/rendering/base/card_render_base.dart';

/// Neon Card renderer (neutralized skeleton).
class NeonCard extends CardRenderBase {
  const NeonCard(super.props, {super.key});

  @override
  String get cssClass => 'neon-card';

  @override
  Map<String, String> baseStyles(CardProps props) => const <String, String>{};

  @override
  Map<String, String> variantStyles(CardProps props) =>
      const <String, String>{};
}
