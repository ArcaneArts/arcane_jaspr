import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/arcane.dart';
import '../../util/tools/styles.dart';

/// A bottom navigation bar component.
class BottomNavigationBar extends StatelessComponent {
  /// The navigation items
  final List<BottomNavItem> items;

  /// The currently selected index
  final int selectedIndex;

  /// Callback when selection changes
  final void Function(int index)? onChanged;

  /// Whether to show labels
  final bool showLabels;

  /// Whether to show labels only when selected
  final bool showSelectedLabels;

  /// Height of the navigation bar
  final double height;

  const BottomNavigationBar({
    required this.items,
    required this.selectedIndex,
    this.onChanged,
    this.showLabels = true,
    this.showSelectedLabels = false,
    this.height = 64,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);

    return nav(
      classes: 'arcane-bottom-nav',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'space-around',
        'height': '${height}px',
        'background-color': 'var(--arcane-surface)',
        'border-top': '1px solid var(--arcane-outline-variant)',
        'padding': '0 8px',
        'flex-shrink': '0',
      }),
      [
        for (var i = 0; i < items.length; i++)
          _buildItem(context, theme, i, items[i]),
      ],
    );
  }

  Component _buildItem(
      BuildContext context, ArcaneTheme theme, int index, BottomNavItem item) {
    final isSelected = index == selectedIndex;
    final shouldShowLabel =
        showLabels || (showSelectedLabels && isSelected);

    return button(
      classes: 'arcane-bottom-nav-item ${isSelected ? 'selected' : ''}',
      attributes: {
        'type': 'button',
        'aria-selected': '$isSelected',
      },
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': '4px',
        'flex': '1',
        'height': '100%',
        'padding': '8px',
        'background': 'transparent',
        'color': isSelected
            ? 'var(--arcane-primary)'
            : 'var(--arcane-on-surface-variant)',
        'cursor': 'pointer',
        'transition': 'all 150ms ease',
        'position': 'relative',
      }),
      events: {
        'click': (event) {
          if (onChanged != null) {
            onChanged!(index);
          }
        },
      },
      [
        // Icon container with indicator
        div(
          classes: 'arcane-bottom-nav-icon',
          styles: Styles(raw: {
            'position': 'relative',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'width': '48px',
            'height': '32px',
            'border-radius': '16px',
            'background-color':
                isSelected ? 'var(--arcane-primary-container)' : 'transparent',
            'transition': 'background-color 150ms ease',
          }),
          [
            div(
              styles: Styles(raw: {
                'width': '24px',
                'height': '24px',
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
              }),
              [item.icon],
            ),
            if (item.badge != null)
              span(
                classes: 'arcane-bottom-nav-badge',
                styles: Styles(raw: {
                  'position': 'absolute',
                  'top': '0',
                  'right': '4px',
                  'min-width': '16px',
                  'height': '16px',
                  'padding': '0 4px',
                  'background-color': 'var(--arcane-error)',
                  'color': 'var(--arcane-on-error)',
                  'font-size': '0.625rem',
                  'font-weight': '600',
                  'border-radius': '8px',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                }),
                [text(item.badge!)],
              ),
          ],
        ),

        // Label
        if (shouldShowLabel)
          span(
            classes: 'arcane-bottom-nav-label',
            styles: Styles(raw: {
              'font-size': '0.75rem',
              'font-weight': isSelected ? '600' : '500',
              'white-space': 'nowrap',
              'overflow': 'hidden',
              'text-overflow': 'ellipsis',
              'max-width': '100%',
            }),
            [text(item.label)],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-bottom-nav-item:hover:not(.selected) .arcane-bottom-nav-icon')
        .styles(raw: {
      'background-color': 'var(--arcane-surface-variant)',
    }),
  ];
}

/// A bottom navigation item
class BottomNavItem {
  final String label;
  final Component icon;
  final Component? activeIcon;
  final String? badge;

  const BottomNavItem({
    required this.label,
    required this.icon,
    this.activeIcon,
    this.badge,
  });
}

/// A fixed position bottom bar container
class BottomBar extends StatelessComponent {
  final Component child;
  final bool safeArea;

  const BottomBar({
    required this.child,
    this.safeArea = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-bottom-bar',
      styles: Styles(raw: {
        'position': 'fixed',
        'bottom': '0',
        'left': '0',
        'right': '0',
        'z-index': '40',
        if (safeArea) 'padding-bottom': 'env(safe-area-inset-bottom)',
      }),
      [child],
    );
  }
}
