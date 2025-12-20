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

/// A navigation item for the dashboard sidebar
class ArcaneDashboardNavItem {
  /// The display label
  final String label;

  /// The route/href for navigation
  final String href;

  /// Optional icon component
  final Component? icon;

  /// Optional badge text (e.g., notification count)
  final String? badge;

  const ArcaneDashboardNavItem({
    required this.label,
    required this.href,
    this.icon,
    this.badge,
  });
}

/// A group of navigation items with an optional label
class ArcaneDashboardNavGroup {
  /// Optional group label (uppercase header)
  final String? label;

  /// The items in this group
  final List<ArcaneDashboardNavItem> items;

  const ArcaneDashboardNavGroup({
    this.label,
    required this.items,
  });
}

/// A reusable dashboard layout with sidebar navigation.
///
/// Use this for client dashboards, admin panels, or any authenticated area.
/// The sidebar includes navigation groups, a header slot, and a footer slot.
class ArcaneDashboardLayout extends StatelessComponent {
  /// The main content to display
  final Component child;

  /// The current route path for active state highlighting
  final String currentRoute;

  /// Navigation groups to display in the sidebar
  final List<ArcaneDashboardNavGroup> navigation;

  /// Header component for the sidebar (typically a logo)
  final Component? sidebarHeader;

  /// Footer component for the sidebar (typically settings/logout)
  final Component? sidebarFooter;

  /// Top bar component (typically user info/notifications)
  final Component? topBar;

  /// Sidebar width
  final String sidebarWidth;

  /// Background color for the main area
  final String backgroundColor;

  /// Background color for the sidebar
  final String sidebarBackgroundColor;

  const ArcaneDashboardLayout({
    super.key,
    required this.child,
    required this.currentRoute,
    required this.navigation,
    this.sidebarHeader,
    this.sidebarFooter,
    this.topBar,
    this.sidebarWidth = '256px',
    this.backgroundColor = ArcaneColors.background,
    this.sidebarBackgroundColor = ArcaneColors.surface,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-dashboard-layout',
      styles: Styles(raw: {
        'min-height': '100vh',
        'display': 'flex',
        'background': backgroundColor,
        'color': ArcaneColors.onBackground,
        'font-family': ArcaneTypography.fontFamily,
      }),
      [
        // Sidebar
        _buildSidebar(),
        // Main content area
        div(
          classes: 'arcane-dashboard-main',
          styles: const Styles(raw: {
            'flex': '1',
            'min-height': '100vh',
            'overflow-y': 'auto',
            'display': 'flex',
            'flex-direction': 'column',
          }),
          [
            // Optional top bar
            if (topBar != null) topBar!,
            // Content
            div(
              classes: 'arcane-dashboard-content',
              styles: const Styles(raw: {
                'flex': '1',
              }),
              [child],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildSidebar() {
    return aside(
      classes: 'arcane-dashboard-sidebar',
      styles: Styles(raw: {
        'width': sidebarWidth,
        'background': sidebarBackgroundColor,
        'border-right': '1px solid ${ArcaneColors.border}',
        'display': 'flex',
        'flex-direction': 'column',
        'min-height': '100vh',
        'flex-shrink': '0',
      }),
      [
        // Header (logo area)
        if (sidebarHeader != null)
          div(
            classes: 'arcane-dashboard-sidebar-header',
            styles: const Styles(raw: {
              'padding': ArcaneSpacing.lg,
              'border-bottom': '1px solid ${ArcaneColors.border}',
              'flex-shrink': '0',
            }),
            [sidebarHeader!],
          ),
        // Navigation
        nav(
          classes: 'arcane-dashboard-sidebar-nav',
          styles: const Styles(raw: {
            'flex': '1',
            'padding': ArcaneSpacing.md,
            'overflow-y': 'auto',
          }),
          navigation.map(_buildNavGroup).toList(),
        ),
        // Footer
        if (sidebarFooter != null)
          div(
            classes: 'arcane-dashboard-sidebar-footer',
            styles: const Styles(raw: {
              'padding': ArcaneSpacing.md,
              'border-top': '1px solid ${ArcaneColors.border}',
              'flex-shrink': '0',
            }),
            [sidebarFooter!],
          ),
      ],
    );
  }

  Component _buildNavGroup(ArcaneDashboardNavGroup group) {
    return div(
      classes: 'arcane-dashboard-nav-group',
      styles: const Styles(raw: {
        'margin-bottom': ArcaneSpacing.lg,
      }),
      [
        // Group label
        if (group.label != null)
          div(
            classes: 'arcane-dashboard-nav-group-label',
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontXs,
              'font-weight': ArcaneTypography.weightSemibold,
              'color': ArcaneColors.muted,
              'text-transform': 'uppercase',
              'letter-spacing': '0.05em',
              'padding': '0 ${ArcaneSpacing.md}',
              'margin-bottom': ArcaneSpacing.sm,
            }),
            [Component.text(group.label!)],
          ),
        // Items
        ...group.items.map(_buildNavItem),
      ],
    );
  }

  Component _buildNavItem(ArcaneDashboardNavItem item) {
    final bool isActive = currentRoute == item.href;
    return a(
      href: item.href,
      classes: 'arcane-dashboard-nav-item ${isActive ? 'active' : ''}',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.sm,
        'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
        'color': isActive ? ArcaneColors.accent : ArcaneColors.muted,
        'text-decoration': 'none',
        'font-size': ArcaneTypography.fontSm,
        'font-weight':
            isActive ? ArcaneTypography.weightSemibold : ArcaneTypography.weightMedium,
        'border-radius': ArcaneRadius.md,
        'background': isActive ? ArcaneColors.accentContainer : ArcaneColors.transparent,
        'border': isActive
            ? '1px solid ${ArcaneColors.accent}'
            : '1px solid transparent',
        'transition': ArcaneEffects.transitionFast,
        'margin-bottom': ArcaneSpacing.xs,
      }),
      [
        // Icon
        if (item.icon != null)
          div(
            styles: const Styles(raw: {
              'width': '20px',
              'height': '20px',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'flex-shrink': '0',
            }),
            [item.icon!],
          ),
        // Label
        span(
          styles: const Styles(raw: {
            'flex': '1',
          }),
          [Component.text(item.label)],
        ),
        // Badge
        if (item.badge != null)
          span(
            classes: 'arcane-dashboard-nav-badge',
            styles: const Styles(raw: {
              'background': ArcaneColors.accent,
              'color': ArcaneColors.accentForeground,
              'font-size': ArcaneTypography.fontXs,
              'padding': '2px 6px',
              'border-radius': ArcaneRadius.full,
              'font-weight': ArcaneTypography.weightMedium,
            }),
            [Component.text(item.badge!)],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-dashboard-nav-item:hover:not(.active)').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
      'color': ArcaneColors.onSurface,
    }),
  ];
}

/// A simple top bar component for dashboard layouts.
///
/// Displays breadcrumbs/title on the left and user actions on the right.
class ArcaneDashboardTopBar extends StatelessComponent {
  /// Left side content (e.g., breadcrumbs, page title)
  final Component? leading;

  /// Right side content (e.g., notifications, user menu)
  final Component? trailing;

  /// Background color
  final String backgroundColor;

  const ArcaneDashboardTopBar({
    super.key,
    this.leading,
    this.trailing,
    this.backgroundColor = ArcaneColors.surface,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-dashboard-topbar',
      styles: Styles(raw: {
        'display': 'flex',
        'justify-content': 'space-between',
        'align-items': 'center',
        'padding': '${ArcaneSpacing.md} ${ArcaneSpacing.xl}',
        'background': backgroundColor,
        'border-bottom': '1px solid ${ArcaneColors.border}',
        'flex-shrink': '0',
      }),
      [
        // Leading (breadcrumbs/title)
        div(
          classes: 'arcane-dashboard-topbar-leading',
          [if (leading != null) leading!],
        ),
        // Trailing (user menu)
        div(
          classes: 'arcane-dashboard-topbar-trailing',
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': ArcaneSpacing.md,
          }),
          [if (trailing != null) trailing!],
        ),
      ],
    );
  }
}

/// A user menu component for the dashboard top bar.
class ArcaneDashboardUserMenu extends StatelessComponent {
  /// User's display name
  final String? userName;

  /// User's subtitle (e.g., plan name, role)
  final String? userSubtitle;

  /// User's avatar URL
  final String? avatarUrl;

  /// Callback when user menu is clicked
  final void Function()? onTap;

  const ArcaneDashboardUserMenu({
    super.key,
    this.userName,
    this.userSubtitle,
    this.avatarUrl,
    this.onTap,
  });

  @override
  Component build(BuildContext context) {
    return button(
      classes: 'arcane-dashboard-user-menu',
      attributes: {'type': 'button'},
      styles: const Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.sm,
        'padding': ArcaneSpacing.sm,
        'background': ArcaneColors.transparent,
        'border': 'none',
        'border-radius': ArcaneRadius.md,
        'cursor': 'pointer',
        'transition': ArcaneEffects.transitionFast,
      }),
      events: {
        if (onTap != null) 'click': (e) => onTap!(),
      },
      [
        // Avatar
        div(
          styles: const Styles(raw: {
            'width': '36px',
            'height': '36px',
            'border-radius': ArcaneRadius.full,
            'overflow': 'hidden',
            'flex-shrink': '0',
            'background': ArcaneColors.surfaceVariant,
          }),
          [
            if (avatarUrl != null)
              img(
                src: avatarUrl!,
                alt: userName ?? 'User',
                styles: const Styles(raw: {
                  'width': '100%',
                  'height': '100%',
                  'object-fit': 'cover',
                }),
              ),
          ],
        ),
        // Name and subtitle
        if (userName != null || userSubtitle != null)
          div(
            styles: const Styles(raw: {
              'text-align': 'left',
            }),
            [
              if (userName != null)
                div(
                  styles: const Styles(raw: {
                    'font-size': ArcaneTypography.fontSm,
                    'font-weight': ArcaneTypography.weightMedium,
                    'color': ArcaneColors.onSurface,
                  }),
                  [Component.text(userName!)],
                ),
              if (userSubtitle != null)
                div(
                  styles: const Styles(raw: {
                    'font-size': ArcaneTypography.fontXs,
                    'color': ArcaneColors.muted,
                  }),
                  [Component.text(userSubtitle!)],
                ),
            ],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-dashboard-user-menu:hover').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
  ];
}