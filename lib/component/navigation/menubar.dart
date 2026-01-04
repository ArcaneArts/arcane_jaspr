import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../../util/tokens/tokens.dart';

/// A horizontal menu bar like in desktop applications.
///
/// Example:
/// ```dart
/// ArcaneMenubar(
///   items: [
///     MenubarItem(
///       label: 'File',
///       menu: [
///         MenuItem(label: 'New', onSelect: () => newFile()),
///         MenuItem(label: 'Open', shortcut: '⌘O', onSelect: () => open()),
///         MenuItem.separator(),
///         MenuItem(label: 'Save', shortcut: '⌘S', onSelect: () => save()),
///       ],
///     ),
///     MenubarItem(
///       label: 'Edit',
///       menu: [
///         MenuItem(label: 'Undo', shortcut: '⌘Z', onSelect: () => undo()),
///         MenuItem(label: 'Redo', shortcut: '⇧⌘Z', onSelect: () => redo()),
///       ],
///     ),
///   ],
/// )
/// ```
class ArcaneMenubar extends StatelessComponent {
  /// Menu items
  final List<MenubarItem> items;

  const ArcaneMenubar({
    required this.items,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-menubar',
      attributes: {
        'role': 'menubar',
        'data-menubar': 'true',
      },
      styles: const Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.xs,
        'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
        'background-color': ArcaneColors.surface,
        'border-bottom': '1px solid ${ArcaneColors.border}',
      }),
      [
        for (final item in items) _buildMenubarItem(item),
      ],
    );
  }

  Component _buildMenubarItem(MenubarItem item) {
    return div(
      classes: 'arcane-menubar-item',
      attributes: {
        'role': 'menuitem',
        'aria-haspopup': 'true',
      },
      styles: const Styles(raw: {
        'position': 'relative',
      }),
      [
        // Trigger button
        button(
          classes: 'arcane-menubar-trigger',
          attributes: {
            'type': 'button',
          },
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': ArcaneSpacing.xs,
            'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
            'background': 'transparent',
            'border': 'none',
            'border-radius': ArcaneRadius.sm,
            'font-size': ArcaneTypography.fontSm,
            'font-weight': ArcaneTypography.weightMedium,
            'color': ArcaneColors.onSurface,
            'cursor': 'pointer',
            'transition': ArcaneEffects.transitionFast,
          }),
          [
            if (item.icon != null) item.icon!,
            Component.text(item.label),
          ],
        ),
        // Dropdown menu
        div(
          classes: 'arcane-menubar-dropdown',
          attributes: {
            'role': 'menu',
          },
          styles: const Styles(raw: {
            'display': 'none',
            'position': 'absolute',
            'top': '100%',
            'left': '0',
            'min-width': '180px',
            'padding': ArcaneSpacing.xs,
            'background-color': ArcaneColors.surface,
            'border': '1px solid ${ArcaneColors.border}',
            'border-radius': ArcaneRadius.md,
            'box-shadow': ArcaneEffects.shadowLg,
            'z-index': '100',
          }),
          [
            for (final menuItem in item.menu) _buildMenuItem(menuItem),
          ],
        ),
      ],
    );
  }

  Component _buildMenuItem(MenuItem item) {
    if (item.isSeparator) {
      return const div(
        classes: 'arcane-menubar-separator',
        styles: Styles(raw: {
          'height': '1px',
          'margin': '${ArcaneSpacing.xs} 0',
          'background-color': ArcaneColors.border,
        }),
        [],
      );
    }

    if (item.submenu != null && item.submenu!.isNotEmpty) {
      return div(
        classes: 'arcane-menubar-menu-item arcane-menubar-submenu-trigger ${item.disabled ? 'disabled' : ''}',
        attributes: {
          'role': 'menuitem',
          'aria-haspopup': 'true',
          if (item.disabled) 'aria-disabled': 'true',
        },
        styles: Styles(raw: {
          'display': 'flex',
          'align-items': 'center',
          'gap': ArcaneSpacing.sm,
          'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
          'border-radius': ArcaneRadius.sm,
          'cursor': item.disabled ? 'not-allowed' : 'pointer',
          'transition': ArcaneEffects.transitionFast,
          'position': 'relative',
          if (item.disabled) 'opacity': '0.5',
        }),
        [
          if (item.icon != null) item.icon!,
          span(
            styles: Styles(raw: {
              'flex': '1',
              'font-size': ArcaneTypography.fontSm,
              'color': item.destructive
                  ? ArcaneColors.error
                  : ArcaneColors.onSurface,
            }),
            [Component.text(item.label)],
          ),
          const span(
            styles: Styles(raw: {
              'color': ArcaneColors.muted,
              'font-size': ArcaneTypography.fontXs,
            }),
            [Component.text('▶')],
          ),
          // Submenu
          div(
            classes: 'arcane-menubar-submenu',
            styles: const Styles(raw: {
              'display': 'none',
              'position': 'absolute',
              'left': '100%',
              'top': '0',
              'min-width': '160px',
              'padding': ArcaneSpacing.xs,
              'background-color': ArcaneColors.surface,
              'border': '1px solid ${ArcaneColors.border}',
              'border-radius': ArcaneRadius.md,
              'box-shadow': ArcaneEffects.shadowLg,
            }),
            [
              for (final subitem in item.submenu!) _buildMenuItem(subitem),
            ],
          ),
        ],
      );
    }

    return div(
      classes: 'arcane-menubar-menu-item ${item.disabled ? 'disabled' : ''} ${item.destructive ? 'destructive' : ''}',
      attributes: {
        'role': 'menuitem',
        if (item.disabled) 'aria-disabled': 'true',
      },
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.sm,
        'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
        'border-radius': ArcaneRadius.sm,
        'cursor': item.disabled ? 'not-allowed' : 'pointer',
        'transition': ArcaneEffects.transitionFast,
        if (item.disabled) 'opacity': '0.5',
      }),
      [
        if (item.icon != null) item.icon!,
        span(
          styles: Styles(raw: {
            'flex': '1',
            'font-size': ArcaneTypography.fontSm,
            'color':
                item.destructive ? ArcaneColors.error : ArcaneColors.onSurface,
          }),
          [Component.text(item.label)],
        ),
        if (item.shortcut != null)
          span(
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontXs,
              'color': ArcaneColors.muted,
            }),
            [Component.text(item.shortcut!)],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-menubar-trigger:hover').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
    css('.arcane-menubar-item:hover .arcane-menubar-dropdown').styles(raw: {
      'display': 'block',
    }),
    css('.arcane-menubar-item:focus-within .arcane-menubar-dropdown')
        .styles(raw: {
      'display': 'block',
    }),
    css('.arcane-menubar-menu-item:hover:not(.disabled)').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
    css('.arcane-menubar-menu-item.destructive:hover:not(.disabled)')
        .styles(raw: {
      'background-color': 'rgba(239, 68, 68, 0.1)',
    }),
    css('.arcane-menubar-submenu-trigger:hover .arcane-menubar-submenu')
        .styles(raw: {
      'display': 'block',
    }),
  ];
}

/// A menubar top-level item
class MenubarItem {
  /// Display label
  final String label;

  /// Optional icon
  final Component? icon;

  /// Dropdown menu items
  final List<MenuItem> menu;

  const MenubarItem({
    required this.label,
    required this.menu,
    this.icon,
  });
}

/// A menu item in a menubar dropdown
class MenuItem {
  /// Display label
  final String label;

  /// Optional icon
  final Component? icon;

  /// Called when item is selected
  final void Function()? onSelect;

  /// Whether this is a destructive action
  final bool destructive;

  /// Whether this item is disabled
  final bool disabled;

  /// Keyboard shortcut hint
  final String? shortcut;

  /// Submenu items
  final List<MenuItem>? submenu;

  /// Whether this is a separator
  final bool isSeparator;

  const MenuItem({
    required this.label,
    this.icon,
    this.onSelect,
    this.destructive = false,
    this.disabled = false,
    this.shortcut,
    this.submenu,
  }) : isSeparator = false;

  /// Creates a separator item
  const MenuItem.separator()
      : label = '',
        icon = null,
        onSelect = null,
        destructive = false,
        disabled = false,
        shortcut = null,
        submenu = null,
        isSeparator = true;
}