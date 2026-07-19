import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/dropdown_menu_props.dart';
import 'package:arcane_jaspr/core/rendering/base/dropdown_menu_render_base.dart';

/// Neon DropdownMenu renderer.
class NeonDropdownMenu extends DropdownMenuRenderBase {
  const NeonDropdownMenu(super.props, {super.key});

  @override
  String get rootClass => 'neon-dropdown';

  @override
  String get triggerClass => 'neon-dropdown-trigger';

  @override
  String get menuClass => 'neon-dropdown-menu neon-popover';

  @override
  String get itemClass => 'neon-dropdown-item';

  @override
  String get submenuClass => 'neon-dropdown-submenu neon-popover';

  @override
  String get anchorOffset => '8';

  @override
  String get itemGap => '10px';

  @override
  String get itemPadding => '8px 12px';

  @override
  String get itemColor => 'var(--foreground)';

  @override
  String get itemBorderRadius => 'var(--radius)';

  @override
  String get transitionToken => 'var(--arcane-transition)';

  @override
  String get shortcutLetterSpacing => '0';

  @override
  String get selectablePaddingLeft => '36px';

  @override
  String get indicatorLeft => '12px';

  @override
  String get indicatorColor => 'var(--foreground)';

  @override
  Map<String, String> menuStyles(DropdownMenuProps props) =>
      const <String, String>{};

  @override
  Map<String, String> get submenuMenuStyles => const <String, String>{};

  @override
  Component buildSeparator() => const dom.div(
    classes: 'neon-dropdown-divider',
    <Component>[],
  );

  @override
  Component buildLabel(String label) => dom.div(
    classes: 'neon-dropdown-label',
    <Component>[Component.text(label)],
  );
}
