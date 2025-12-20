import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

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
    return nav(
      classes: 'arcane-bottom-nav',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'space-around',
        'height': '${height}px',
        'background-color': ArcaneColors.surface,
        'border-top': '1px solid ${ArcaneColors.border}',
        'padding': '0 ${ArcaneSpacing.sm}',
        'flex-shrink': '0',
      }),
      [
        for (var i = 0; i < items.length; i++)
          _buildItem(context, i, items[i]),
      ],
    );
  }

  Component _buildItem(BuildContext context, int index, BottomNavItem item) {
    final bool isSelected = index == selectedIndex;
    final bool shouldShowLabel = showLabels || (showSelectedLabels && isSelected);

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
        'gap': ArcaneSpacing.xs,
        'flex': '1',
        'height': '100%',
        'padding': ArcaneSpacing.sm,
        'background': ArcaneColors.transparent,
        'border': 'none',
        'color': isSelected ? ArcaneColors.accent : ArcaneColors.muted,
        'cursor': 'pointer',
        'transition': ArcaneEffects.transitionFast,
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
            'border-radius': ArcaneRadius.lg,
            'background-color': isSelected ? ArcaneColors.accentContainer : ArcaneColors.transparent,
            'transition': ArcaneEffects.transitionFast,
          }),
          [
            div(
              styles: const Styles(raw: {
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
                styles: const Styles(raw: {
                  'position': 'absolute',
                  'top': '0',
                  'right': ArcaneSpacing.xs,
                  'min-width': '16px',
                  'height': '16px',
                  'padding': '0 ${ArcaneSpacing.xs}',
                  'background-color': ArcaneColors.error,
                  'color': ArcaneColors.errorForeground,
                  'font-size': '0.625rem',
                  'font-weight': ArcaneTypography.weightSemibold,
                  'border-radius': ArcaneRadius.sm,
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
              'font-size': ArcaneTypography.fontXs,
              'font-weight': isSelected ? ArcaneTypography.weightSemibold : ArcaneTypography.weightMedium,
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
      'background-color': ArcaneColors.surfaceVariant,
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