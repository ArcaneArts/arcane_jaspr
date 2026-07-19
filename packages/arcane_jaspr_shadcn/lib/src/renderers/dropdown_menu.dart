import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/dropdown_menu_props.dart';
import 'package:arcane_jaspr/core/rendering/base/dropdown_menu_render_base.dart';

/// ShadCN DropdownMenu renderer.
///
/// Outputs the exact HTML structure and CSS from ui.shadcn.com.
/// Reference: https://ui.shadcn.com/docs/components/dropdown-menu
///
/// ShadCN DropdownMenuContent:
/// - z-50 min-w-[8rem] overflow-hidden rounded-md border bg-popover p-1 text-popover-foreground shadow-md
///
/// ShadCN DropdownMenuItem:
/// - relative flex cursor-default select-none items-center rounded-sm px-2 py-1.5 text-sm
/// - outline-none transition-colors
/// - focus:bg-accent focus:text-accent-foreground
/// - data-[disabled]:pointer-events-none data-[disabled]:opacity-50
class ShadcnDropdownMenu extends DropdownMenuRenderBase {
  const ShadcnDropdownMenu(super.props, {super.key});

  @override
  String get rootClass => 'arcane-dropdown';

  @override
  String get triggerClass => 'arcane-dropdown-trigger';

  @override
  String get menuClass => 'arcane-dropdown-menu';

  @override
  String get itemClass => 'arcane-dropdown-item';

  @override
  String get submenuClass => 'arcane-dropdown-submenu';

  @override
  String get anchorOffset => '4';

  @override
  String get itemGap => 'var(--space-2)';

  @override
  String get itemPadding => '6px 8px';

  @override
  String get itemColor => 'var(--popover-foreground)';

  @override
  String get itemBorderRadius => 'var(--radius-xs)';

  @override
  String get transitionToken => 'var(--transition)';

  @override
  String get shortcutLetterSpacing => '0.1em';

  @override
  String get selectablePaddingLeft => '32px';

  @override
  String get indicatorLeft => '8px';

  @override
  String get indicatorColor => 'var(--foreground)';

  @override
  Map<String, String> menuStyles(DropdownMenuProps props) => <String, String>{
    'z-index': '100',
    if (props.width != null)
      'width': '${props.width}px'
    else
      'min-width': '128px',
    'padding': '4px',
    'background-color': 'var(--popover)',
    'border': '1px solid var(--border)',
    'border-radius': 'var(--radius-sm)',
    'box-shadow': 'var(--shadow-md)',
    'overflow': 'hidden',
    'color': 'var(--popover-foreground)',
    'animation': 'arcane-dropdown-fade var(--transition)',
  };

  @override
  Map<String, String> get submenuMenuStyles => const <String, String>{
    'min-width': '128px',
    'padding': '4px',
    'background-color': 'var(--popover)',
    'border': '1px solid var(--border)',
    'border-radius': 'var(--radius-sm)',
    'box-shadow': 'var(--shadow-md)',
    'z-index': '101',
  };

  @override
  Component buildSeparator() => const dom.div(
    classes: 'arcane-dropdown-divider',
    styles: dom.Styles(
      raw: <String, String>{
        'height': '1px',
        'margin': '4px -4px',
        'background-color': 'var(--muted)',
      },
    ),
    <Component>[],
  );

  @override
  Component buildLabel(String label) => dom.div(
    classes: 'arcane-dropdown-label',
    styles: const dom.Styles(
      raw: <String, String>{
        'padding': '6px 8px',
        'font-size': 'var(--font-size-xs)',
        'font-weight': 'var(--font-weight-semibold)',
        'color': 'var(--muted-foreground)',
        'user-select': 'none',
      },
    ),
    <Component>[Component.text(label)],
  );
}
