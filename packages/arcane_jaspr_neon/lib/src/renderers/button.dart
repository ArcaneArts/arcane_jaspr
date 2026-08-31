import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/props/button_props.dart';
import 'package:arcane_jaspr/core/rendering/base/button_render_base.dart';

import 'decoration_styles.dart';

/// Neon Button renderer (neutralized skeleton).
class NeonButton extends ButtonRenderBase {
  const NeonButton(super.props, {super.key});

  @override
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      neonDecorationStyles(decoration);

  @override
  String get cssClass => 'neon-button';

  @override
  Map<String, String> baseStyles(bool isDisabled) => const <String, String>{};

  @override
  Map<String, String> variantStyles(ButtonVariant variant) =>
      const <String, String>{};

  @override
  Map<String, String> sizeStyles(ButtonSize size) => const <String, String>{};
}
