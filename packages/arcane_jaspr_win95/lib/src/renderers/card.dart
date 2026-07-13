import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/props/card_props.dart';
import 'package:arcane_jaspr/core/rendering/base/card_render_base.dart';

import 'decoration_styles.dart';

/// Win95 Card renderer (neutralized skeleton).
class Win95Card extends CardRenderBase {
  const Win95Card(super.props, {super.key});

  @override
  String get cssClass => 'win95-card';

  @override
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      win95DecorationStyles(decoration);

  @override
  Map<String, String> baseStyles(CardProps props) => const <String, String>{};

  @override
  Map<String, String> variantStyles(CardProps props) =>
      const <String, String>{};
}
