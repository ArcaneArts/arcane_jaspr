import 'package:arcane_jaspr/core/props/button_props.dart';
import 'package:arcane_jaspr/core/rendering/base/button_render_base.dart';

/// Neon Button renderer (neutralized skeleton).
class NeonButton extends ButtonRenderBase {
  const NeonButton(super.props, {super.key});

  @override
  String get cssClass => 'neon-button';

  @override
  String get arrowTransition => 'transform 0.2s ease';

  @override
  Map<String, String> baseStyles(bool isDisabled) => const <String, String>{};

  @override
  Map<String, String> variantStyles(ButtonVariant variant) =>
      const <String, String>{};

  @override
  Map<String, String> sizeStyles(ButtonSize size) => const <String, String>{};
}
