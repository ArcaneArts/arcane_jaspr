import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/props/button_props.dart';
import 'package:arcane_jaspr/core/rendering/base/button_render_base.dart';

import 'decoration_styles.dart';

/// Win95 Button renderer (neutralized skeleton).
class Win95Button extends ButtonRenderBase {
  const Win95Button(super.props, {super.key});

  @override
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      win95DecorationStyles(decoration);

  @override
  String get cssClass => 'win95-button';

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
