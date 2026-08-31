import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

export '../../core/props/context_menu_props.dart';
export '../../core/props/menu_item_props.dart';

/// Context menu that appears on right-click.
class ArcaneContextMenu extends StatelessWidget {
  final String? id;
  final Widget trigger;
  final List<ArcaneMenuItem> items;
  final bool keepOpenOnAction;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const ArcaneContextMenu({
    this.id,
    required this.trigger,
    required this.items,
    this.keepOpenOnAction = false,
    this.styles,
    this.decoration,
    super.key,
  });

  static int _autoCounter = 0;
  static String _autoId() {
    _autoCounter++;
    return 'arcane-context-menu-$_autoCounter';
  }

  @override
  Widget build(BuildContext context) {
    final String resolvedId = id ?? _autoId();
    return context.renderers.contextMenu(
      ContextMenuProps(
        id: resolvedId,
        trigger: trigger,
        items: items,
        keepOpenOnAction: keepOpenOnAction,
        styles: styles,
        decoration: decoration,
      ),
    );
  }
}
