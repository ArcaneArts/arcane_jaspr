import 'package:jaspr/jaspr.dart';

import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';
import '../shared/shared.dart';

export '../shared/shared.dart' show ComponentSize;

enum KbdStyle {
  raised,
  flat,
  outline,
}

/// Keyboard shortcut display component properties.
class KbdProps {
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

  const KbdProps({
    this.keyText,
    this.keys,
    this.separator = '+',
    this.variant = KbdStyle.raised,
    this.size = ComponentSize.md,
    this.styles,
    this.decoration,
  }) : assert(keyText != null || keys != null,
            'Either keyText or keys must be provided');

  const KbdProps.key(
    String key, {
    this.variant = KbdStyle.raised,
    this.size = ComponentSize.md,
    this.styles,
    this.decoration,
  })  : keyText = key,
        keys = null,
        separator = '+';

  const KbdProps.combo(
    List<String> this.keys, {
    this.separator = '+',
    this.variant = KbdStyle.raised,
    this.size = ComponentSize.md,
    this.styles,
    this.decoration,
  }) : keyText = null;
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for keyboard shortcut components.
mixin KbdRendererContract {
  /// Renders a keyboard shortcut display component.
  Component kbd(KbdProps props);
}
