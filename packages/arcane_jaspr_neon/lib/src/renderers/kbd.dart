import 'package:arcane_jaspr/core/rendering/base/kbd_render_base.dart';

/// Neon keyboard shortcut display component.
class NeonKbd extends KbdRenderBase {
  const NeonKbd(super.props, {super.key});

  @override
  String? get kbdClasses => 'neon-kbd';

  @override
  String get keysWrapperGap => '6px';

  @override
  Map<String, String> get styleMap => const <String, String>{};
}
