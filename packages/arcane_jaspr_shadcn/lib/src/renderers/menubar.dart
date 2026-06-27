import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/props/menubar_props.dart';

/// ShadCN-style menubar component
/// Reference: https://ui.shadcn.com/docs/components/menubar
class ShadcnMenubar extends StatelessComponent {
  final MenubarProps props;

  const ShadcnMenubar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // ShadCN Menubar: flex h-10 items-center space-x-1 rounded-md border bg-background p-1
    return dom.div(
      classes: 'arcane-menubar',
      attributes: {'role': 'menubar', 'data-state': 'open'},
      styles: const dom.Styles(
        raw: {
          'display': 'flex',
          'height': '40px',
          'align-items': 'center',
          'gap': 'var(--space-1)',
          'border-radius': 'var(--radius-sm)',
          'border': '1px solid var(--border)',
          'background-color': 'var(--background)',
          'padding': '4px',
        },
      ),
      [
        for (var i = 0; i < props.menus.length; i++)
          _buildMenu(props.menus[i], i),
      ],
    );
  }

  Component _buildMenu(MenubarMenuProps menu, int index) {
    final isOpen = props.openMenuIndex == index;

    return dom.div(
      classes: 'arcane-menubar-menu ${isOpen ? 'open' : ''}',
      attributes: {'data-state': isOpen ? 'open' : 'closed'},
      styles: const dom.Styles(raw: {'position': 'relative'}),
      [
        // ShadCN MenubarTrigger: flex cursor-default select-none items-center rounded-sm px-3 py-1.5 text-sm font-medium outline-none focus:bg-accent focus:text-accent-foreground data-[state=open]:bg-accent data-[state=open]:text-accent-foreground
        dom.button(
          classes: 'arcane-menubar-trigger',
          attributes: {
            'type': 'button',
            'aria-haspopup': 'true',
            'aria-expanded': '$isOpen',
            'data-state': isOpen ? 'open' : 'closed',
          },
          styles: dom.Styles(
            raw: {
              'display': 'flex',
              'cursor': 'default',
              'user-select': 'none',
              'align-items': 'center',
              'border-radius': 'var(--radius-xs)',
              'padding': '6px 12px',
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-medium)',
              'outline': 'none',
              'border': 'none',
              'background-color': isOpen ? 'var(--accent)' : 'transparent',
              'color': isOpen
                  ? 'var(--accent-foreground)'
                  : 'var(--foreground)',
              'transition':
                  'background-color var(--transition), color var(--transition)',
            },
          ),
          events: {
            'click': (_) => props.onMenuChange?.call(isOpen ? null : index),
          },
          [Component.text(menu.label)],
        ),

        // ShadCN MenubarContent
        if (isOpen)
          dom.div(
            classes: 'arcane-menubar-content',
            attributes: {'role': 'menu', 'data-state': 'open'},
            styles: const dom.Styles(
              raw: {
                'position': 'absolute',
                'top': '100%',
                'left': '0',
                'z-index': '50',
                'min-width': '192px',
                'overflow': 'hidden',
                'padding': '4px',
                'margin-top': '4px',
                'background-color': 'var(--popover)',
                'border': '1px solid var(--border)',
                'border-radius': 'var(--radius-sm)',
                'box-shadow':
                    '0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)',
                'color': 'var(--popover-foreground)',
              },
            ),
            [for (final item in menu.items) _buildMenuItem(item)],
          ),
      ],
    );
  }

  Component _buildMenuItem(ArcaneMenuItem item) {
    return switch (item) {
      MenuItemSeparator() => _buildSeparator(),
      MenuItemLabel(:final label) => _buildLabel(label),
      MenuItemAction() => _buildAction(item),
      MenuItemCheckbox() => _buildCheckbox(item),
      MenuItemRadio() => _buildRadio(item),
      MenuItemSubmenu() => _buildSubmenu(item),
    };
  }

  Component _buildSeparator() {
    // ShadCN MenubarSeparator
    return const dom.div(
      classes: 'arcane-menubar-separator',
      styles: dom.Styles(
        raw: {
          'height': '1px',
          'margin': '4px -4px',
          'background-color': 'var(--muted)',
        },
      ),
      [],
    );
  }

  Component _buildLabel(String label) {
    return dom.div(
      classes: 'arcane-menubar-label',
      styles: const dom.Styles(
        raw: {
          'padding': '6px 8px',
          'font-size': 'var(--font-size-xs)',
          'font-weight': 'var(--font-weight-semibold)',
          'color': 'var(--muted-foreground)',
          'user-select': 'none',
        },
      ),
      [Component.text(label)],
    );
  }

  Component _buildAction(MenuItemAction item) {
    // ShadCN MenubarItem
    return dom.div(
      classes: 'arcane-menubar-item ${item.disabled ? 'disabled' : ''}',
      attributes: {
        'role': 'menuitem',
        if (item.disabled) 'aria-disabled': 'true',
        'data-disabled': '${item.disabled}',
      },
      styles: dom.Styles(
        raw: {
          'position': 'relative',
          'display': 'flex',
          'cursor': item.disabled ? 'not-allowed' : 'default',
          'user-select': 'none',
          'align-items': 'center',
          'gap': 'var(--space-2)',
          'border-radius': 'var(--radius-xs)',
          'padding': '6px 8px',
          'font-size': 'var(--font-size-sm)',
          'outline': 'none',
          'transition':
              'background-color var(--transition), color var(--transition)',
          if (item.disabled) 'pointer-events': 'none',
          if (item.disabled) 'opacity': '0.5',
        },
      ),
      events: item.onSelect != null && !item.disabled
          ? {'click': (_) => item.onSelect!()}
          : null,
      [
        if (item.icon != null) item.icon!,
        dom.span(styles: const dom.Styles(raw: {'flex': '1'}), [
          Component.text(item.label),
        ]),
        if (item.shortcut != null)
          // ShadCN MenubarShortcut
          dom.span(
            styles: const dom.Styles(
              raw: {
                'margin-left': 'auto',
                'font-size': 'var(--font-size-xs)',
                'letter-spacing': '0.1em',
                'color': 'var(--muted-foreground)',
              },
            ),
            [Component.text(item.shortcut!)],
          ),
      ],
    );
  }

  Component _buildCheckbox(MenuItemCheckbox item) {
    return dom.div(
      classes:
          'arcane-menubar-item checkbox ${item.disabled ? 'disabled' : ''}',
      attributes: {
        'role': 'menuitemcheckbox',
        'aria-checked': '${item.checked}',
        if (item.disabled) 'aria-disabled': 'true',
        'data-state': item.checked ? 'checked' : 'unchecked',
        'data-disabled': '${item.disabled}',
      },
      styles: dom.Styles(
        raw: {
          'position': 'relative',
          'display': 'flex',
          'cursor': item.disabled ? 'not-allowed' : 'pointer',
          'user-select': 'none',
          'align-items': 'center',
          'gap': 'var(--space-2)',
          'border-radius': 'var(--radius-xs)',
          'padding': '6px 8px',
          'padding-left': '32px',
          'font-size': 'var(--font-size-sm)',
          'outline': 'none',
          'transition':
              'background-color var(--transition), color var(--transition)',
          if (item.disabled) 'pointer-events': 'none',
          if (item.disabled) 'opacity': '0.5',
        },
      ),
      events: item.onChanged != null && !item.disabled
          ? {'click': (_) => item.onChanged!(!item.checked)}
          : null,
      [
        // Checkbox indicator
        if (item.checked)
          dom.span(
            styles: const dom.Styles(
              raw: {
                'position': 'absolute',
                'left': '8px',
                'color': 'var(--foreground)',
              },
            ),
            [ArcaneIcon.check(size: IconSize.xs)],
          ),
        if (item.icon != null) item.icon!,
        dom.span(styles: const dom.Styles(raw: {'flex': '1'}), [
          Component.text(item.label),
        ]),
        if (item.shortcut != null)
          dom.span(
            styles: const dom.Styles(
              raw: {
                'margin-left': 'auto',
                'font-size': 'var(--font-size-xs)',
                'letter-spacing': '0.1em',
                'color': 'var(--muted-foreground)',
              },
            ),
            [Component.text(item.shortcut!)],
          ),
      ],
    );
  }

  Component _buildRadio(MenuItemRadio item) {
    return dom.div(
      classes: 'arcane-menubar-item radio ${item.disabled ? 'disabled' : ''}',
      attributes: {
        'role': 'menuitemradio',
        'aria-checked': '${item.selected}',
        if (item.disabled) 'aria-disabled': 'true',
        'data-state': item.selected ? 'checked' : 'unchecked',
        'data-disabled': '${item.disabled}',
      },
      styles: dom.Styles(
        raw: {
          'position': 'relative',
          'display': 'flex',
          'cursor': item.disabled ? 'not-allowed' : 'pointer',
          'user-select': 'none',
          'align-items': 'center',
          'gap': 'var(--space-2)',
          'border-radius': 'var(--radius-xs)',
          'padding': '6px 8px',
          'padding-left': '32px',
          'font-size': 'var(--font-size-sm)',
          'outline': 'none',
          'transition':
              'background-color var(--transition), color var(--transition)',
          if (item.disabled) 'pointer-events': 'none',
          if (item.disabled) 'opacity': '0.5',
        },
      ),
      events: item.onChanged != null && !item.disabled
          ? {'click': (_) => item.onChanged!(item.value)}
          : null,
      [
        // Radio indicator
        if (item.selected)
          dom.span(
            styles: const dom.Styles(
              raw: {
                'position': 'absolute',
                'left': '8px',
                'color': 'var(--foreground)',
              },
            ),
            [ArcaneIcon.dot(size: IconSize.sm)],
          ),
        if (item.icon != null) item.icon!,
        dom.span(styles: const dom.Styles(raw: {'flex': '1'}), [
          Component.text(item.label),
        ]),
      ],
    );
  }

  Component _buildSubmenu(MenuItemSubmenu item) {
    return dom.div(
      classes:
          'arcane-menubar-item submenu-trigger ${item.disabled ? 'disabled' : ''}',
      attributes: {
        'role': 'menuitem',
        'aria-haspopup': 'true',
        if (item.disabled) 'aria-disabled': 'true',
        'data-disabled': '${item.disabled}',
      },
      styles: dom.Styles(
        raw: {
          'position': 'relative',
          'display': 'flex',
          'cursor': item.disabled ? 'not-allowed' : 'default',
          'user-select': 'none',
          'align-items': 'center',
          'gap': 'var(--space-2)',
          'border-radius': 'var(--radius-xs)',
          'padding': '6px 8px',
          'font-size': 'var(--font-size-sm)',
          'outline': 'none',
          'transition':
              'background-color var(--transition), color var(--transition)',
          if (item.disabled) 'pointer-events': 'none',
          if (item.disabled) 'opacity': '0.5',
        },
      ),
      [
        if (item.icon != null) item.icon!,
        dom.span(styles: const dom.Styles(raw: {'flex': '1'}), [
          Component.text(item.label),
        ]),
        dom.span(
          styles: const dom.Styles(raw: {'color': 'var(--muted-foreground)'}),
          [ArcaneIcon.chevronRight(size: IconSize.sm)],
        ),
        // Submenu
        dom.div(
          classes: 'arcane-menubar-submenu',
          attributes: const {'data-state': 'closed'},
          styles: const dom.Styles(
            raw: {
              'display': 'none',
              'position': 'absolute',
              'left': '100%',
              'top': '0',
              'min-width': '128px',
              'padding': '4px',
              'background-color': 'var(--popover)',
              'border': '1px solid var(--border)',
              'border-radius': 'var(--radius-sm)',
              'box-shadow':
                  '0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)',
            },
          ),
          [for (final child in item.children) _buildMenuItem(child)],
        ),
      ],
    );
  }
}
