import 'package:arcane_jaspr/core/props/cycle_button_props.dart';
import 'package:arcane_jaspr/core/rendering/base/cycle_button_render_base.dart';

/// Win95 cycle button renderer (neutralized skeleton).
class Win95CycleButton<T> extends CycleButtonRenderBase<T> {
  const Win95CycleButton(super.props);

  @override
  String get classPrefix => 'win95';

  @override
  Map<String, String> get clipStyles => const <String, String>{};

  @override
  String get indicatorColor => 'currentColor';

  @override
  Map<String, String> variantStyles(CycleButtonVariant variant) =>
      const <String, String>{};
}

/// Win95 toggle button renderer (neutralized skeleton).
class Win95ToggleButton extends ToggleButtonRenderBase {
  const Win95ToggleButton(super.props);

  @override
  String get classPrefix => 'win95';

  @override
  Map<String, String> toggleStyles(Map<String, String> sizeStyles) =>
      const <String, String>{};
}
