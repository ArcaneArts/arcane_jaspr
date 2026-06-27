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
  String get indicatorColor => 'var(--neon-accent)';

  @override
  Map<String, String> menuStyles(DropdownMenuProps props) => <String, String>{
    'z-index': '100',
    if (props.width != null)
      'width': '${props.width}px'
    else
      'min-width': '160px',
    'padding': '6px',
    'overflow': 'hidden',
    'color': 'var(--popover-foreground)',
    'animation': 'arcane-dropdown-fade 0.16s ease-out',
  };

  @override
  Map<String, String> get submenuMenuStyles => const <String, String>{
    'min-width': '160px',
    'padding': '6px',
    'z-index': '101',
  };

  @override
  Component buildSeparator() => const dom.div(
    classes: 'neon-dropdown-divider',
    styles: dom.Styles(
      raw: <String, String>{
        'height': '1px',
        'margin': '6px -6px',
        'background': 'var(--neon-panel-border)',
        'opacity': '0.6',
      },
    ),
    <Component>[],
  );

  @override
  Component buildLabel(String label) => dom.div(
    classes: 'neon-dropdown-label',
    styles: const dom.Styles(
      raw: <String, String>{
        'padding': '8px 10px 4px',
        'font-family': 'var(--font-heading)',
        'font-size': '0.6875rem',
        'font-weight': '600',
        'letter-spacing': '0.12em',
        'text-transform': 'uppercase',
        'color': 'var(--muted-foreground)',
        'user-select': 'none',
      },
    ),
    <Component>[Component.text(label)],
  );
}
