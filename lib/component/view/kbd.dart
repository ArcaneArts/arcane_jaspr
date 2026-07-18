import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

export '../../core/props/kbd_props.dart' show KbdStyle, ComponentSize;

/// Keyboard shortcut display component.
class ArcaneKbd extends StatelessWidget {
  final String? keyText;
  final List<String>? keys;
  final String separator;
  final KbdStyle variant;
  final ComponentSize size;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const ArcaneKbd(
    this.keyText, {
    this.variant = KbdStyle.raised,
    this.size = ComponentSize.md,
    this.styles,
    this.decoration,
    super.key,
  })  : keys = null,
        separator = '+';

  const ArcaneKbd.combo(
    this.keys, {
    this.separator = '+',
    this.variant = KbdStyle.raised,
    this.size = ComponentSize.md,
    this.styles,
    this.decoration,
    super.key,
  }) : keyText = null;

  factory ArcaneKbd.shortcut(
    String shortcut, {
    KbdStyle variant = KbdStyle.raised,
    ComponentSize size = ComponentSize.md,
    ArcaneStyleData? styles,
    ArcaneDecoration? decoration,
  }) {
    final parts = shortcut.split('+').map((s) => s.trim()).toList();
    return ArcaneKbd.combo(
      parts,
      separator: '+',
      variant: variant,
      size: size,
      styles: styles,
      decoration: decoration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return context.renderers.kbd(KbdProps(
      keyText: keyText,
      keys: keys,
      separator: separator,
      variant: variant,
      size: size,
      styles: styles,
      decoration: decoration,
    ));
  }
}
