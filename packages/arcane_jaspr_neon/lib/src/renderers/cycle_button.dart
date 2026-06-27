import 'package:arcane_jaspr/core/props/cycle_button_props.dart';
import 'package:arcane_jaspr/core/rendering/base/cycle_button_render_base.dart';

/// Neon cycle button renderer (neutralized skeleton).
class NeonCycleButton<T> extends CycleButtonRenderBase<T> {
  const NeonCycleButton(super.props);

  @override
  String get classPrefix => 'neon';

  @override
  Map<String, String> get clipStyles => const <String, String>{};

  @override
  String get indicatorColor => 'currentColor';

  @override
  Map<String, String> variantStyles(CycleButtonVariant variant) =>
      const <String, String>{};
}

/// Neon toggle button renderer (neutralized skeleton).
class NeonToggleButton extends ToggleButtonRenderBase {
  const NeonToggleButton(super.props);

  @override
  String get classPrefix => 'neon';

  @override
  Map<String, String> toggleStyles(Map<String, String> sizeStyles) =>
      const <String, String>{};
}
