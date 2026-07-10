import 'package:arcane_jaspr/flutter.dart';
import 'menu_item_props.dart';

import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';

export 'menu_item_props.dart';

/// Context menu component properties.
class ContextMenuProps {
  final String id;
  final Widget trigger;
  final List<ArcaneMenuItem> items;
  final bool keepOpenOnAction;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const ContextMenuProps({
    required this.id,
    required this.trigger,
    required this.items,
    this.keepOpenOnAction = false,
    this.styles,
    this.decoration,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for context menu components.
mixin ContextMenuRendererContract {
  Widget contextMenu(ContextMenuProps props);
}
