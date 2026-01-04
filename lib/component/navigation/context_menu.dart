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

/// A context menu that appears on right-click.
///
/// Wrap any component with ArcaneContextMenu to add a right-click menu.
///
/// Example:
/// ```dart
/// ArcaneContextMenu(
///   trigger: ArcaneCard(child: content),
///   items: [
///     ContextMenuItem(label: 'Edit', onSelect: () => edit()),
///     ContextMenuItem(label: 'Copy', onSelect: () => copy()),
///     ContextMenuItem.separator(),
///     ContextMenuItem(label: 'Delete', onSelect: () => delete(), destructive: true),
///   ],
/// )
/// ```
class ArcaneContextMenu extends StatelessComponent {
  /// The element that triggers the context menu
  final Component trigger;

  /// Menu items
  final List<ContextMenuItem> items;

  const ArcaneContextMenu({
    required this.trigger,
    required this.items,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-context-menu-trigger',
      attributes: {
        'data-context-menu': 'true',
      },
      styles: const Styles(raw: {
        'display': 'contents',
      }),
      [
        trigger,
        // Hidden menu template
        div(
          classes: 'arcane-context-menu',
          attributes: {
            'role': 'menu',
            'aria-hidden': 'true',
          },
          styles: const Styles(raw: {
            'display': 'none',
            'position': 'fixed',
            'z-index': '9999',
            'min-width': '180px',
            'padding': ArcaneSpacing.xs,
            'background-color': ArcaneColors.surface,
            'border': '1px solid ${ArcaneColors.border}',
            'border-radius': ArcaneRadius.md,
            'box-shadow': ArcaneEffects.shadowLg,
          }),
          [
            for (final item in items) _buildMenuItem(item),
          ],
        ),
      ],
    );
  }

  Component _buildMenuItem(ContextMenuItem item) {
    if (item.isSeparator) {
      return const div(
        classes: 'arcane-context-menu-separator',
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
        classes: 'arcane-context-menu-item arcane-context-menu-submenu-trigger ${item.disabled ? 'disabled' : ''}',
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
            classes: 'arcane-context-menu-submenu',
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
      classes: 'arcane-context-menu-item ${item.disabled ? 'disabled' : ''} ${item.destructive ? 'destructive' : ''}',
      attributes: {
        'role': 'menuitem',
        if (item.disabled) 'aria-disabled': 'true',
        if (item.shortcut != null) 'data-shortcut': item.shortcut!,
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
    css('.arcane-context-menu-item:hover:not(.disabled)').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
    css('.arcane-context-menu-item.destructive:hover:not(.disabled)')
        .styles(raw: {
      'background-color': 'rgba(239, 68, 68, 0.1)',
    }),
    css('.arcane-context-menu-submenu-trigger:hover .arcane-context-menu-submenu')
        .styles(raw: {
      'display': 'block',
    }),
  ];
}

/// A context menu item
class ContextMenuItem {
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

  /// Keyboard shortcut hint (e.g., "⌘C")
  final String? shortcut;

  /// Submenu items
  final List<ContextMenuItem>? submenu;

  /// Whether this is a separator
  final bool isSeparator;

  const ContextMenuItem({
    required this.label,
    this.icon,
    this.onSelect,
    this.destructive = false,
    this.disabled = false,
    this.shortcut,
    this.submenu,
  }) : isSeparator = false;

  /// Creates a separator item
  const ContextMenuItem.separator()
      : label = '',
        icon = null,
        onSelect = null,
        destructive = false,
        disabled = false,
        shortcut = null,
        submenu = null,
        isSeparator = true;
}