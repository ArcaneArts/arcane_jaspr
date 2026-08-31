import 'package:jaspr/jaspr.dart';

import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';
import 'menu_item_props.dart';

export 'menu_item_props.dart';

/// Menubar menu data.
class MenubarMenuProps {
  final String label;
  final List<ArcaneMenuItem> items;

  const MenubarMenuProps({required this.label, required this.items});
}

/// Menubar component properties.
class MenubarProps {
  final List<MenubarMenuProps> menus;
  final int? openMenuIndex;
  final void Function(int? index)? onMenuChange;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const MenubarProps({
    required this.menus,
    this.openMenuIndex,
    this.onMenuChange,
    this.styles,
    this.decoration,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for menubar components.
mixin MenubarRendererContract {
  Component menubar(MenubarProps props);
}
