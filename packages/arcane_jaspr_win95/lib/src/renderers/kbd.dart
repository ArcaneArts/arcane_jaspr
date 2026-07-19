import 'package:arcane_jaspr/core/rendering/base/kbd_render_base.dart';

/// Win95 keyboard shortcut display component.
class Win95Kbd extends KbdRenderBase {
  const Win95Kbd(super.props, {super.key});

  @override
  String? get kbdClasses => 'win95-kbd';

  @override
  String get keysWrapperGap => '6px';

  @override
  Map<String, String> get styleMap => const <String, String>{};
}
