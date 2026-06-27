import 'package:arcane_jaspr/flutter.dart';

import '../../core/theme_provider.dart';

export '../../core/props/kbd_props.dart' show KbdStyle, ComponentSize;

/// Keyboard shortcut display component.
class ArcaneKbd extends StatelessWidget {
  final String? keyText;
  final List<String>? keys;
  final String separator;
  final KbdStyle style;
  final ComponentSize size;

  const ArcaneKbd(
    this.keyText, {
    this.style = KbdStyle.raised,
    this.size = ComponentSize.md,
    super.key,
  })  : keys = null,
        separator = '+';

  const ArcaneKbd.combo(
    this.keys, {
    this.separator = '+',
    this.style = KbdStyle.raised,
    this.size = ComponentSize.md,
    super.key,
  }) : keyText = null;

  factory ArcaneKbd.shortcut(
    String shortcut, {
    KbdStyle style = KbdStyle.raised,
    ComponentSize size = ComponentSize.md,
  }) {
    final parts = shortcut.split('+').map((s) => s.trim()).toList();
    return ArcaneKbd.combo(
      parts,
      separator: '+',
      style: style,
      size: size,
    );
  }

  @override
  Widget build(BuildContext context) {
    return context.renderers.kbd(KbdProps(
      keyText: keyText,
      keys: keys,
      separator: separator,
      style: style,
      size: size,
    ));
  }
}
