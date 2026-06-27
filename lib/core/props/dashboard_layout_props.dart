import 'package:arcane_jaspr/flutter.dart';

/// Dashboard navigation item data.
class DashboardNavItem {
  final String label;
  final String href;
  final Widget? icon;
  final String? badge;

  const DashboardNavItem({
    required this.label,
    required this.href,
    this.icon,
    this.badge,
  });
}

/// Dashboard navigation group data.
class DashboardNavGroup {
  final String? label;
  final List<DashboardNavItem> items;

  const DashboardNavGroup({
    this.label,
    required this.items,
  });
}

/// Dashboard layout component properties.
class DashboardLayoutProps {
  final Widget child;
  final String currentRoute;
  final List<DashboardNavGroup> navigation;
  final Widget? sidebarHeader;
  final Widget? sidebarFooter;
  final Widget? topBar;
  final String sidebarWidth;
  final String backgroundColor;
  final String sidebarBackgroundColor;

  const DashboardLayoutProps({
    required this.child,
    required this.currentRoute,
    required this.navigation,
    this.sidebarHeader,
    this.sidebarFooter,
    this.topBar,
    this.sidebarWidth = '256px',
    this.backgroundColor = 'var(--background)',
    this.sidebarBackgroundColor = 'var(--card)',
  });
}

/// Dashboard top bar component properties.
class DashboardTopBarProps {
  final Widget? leading;
  final Widget? trailing;
  final String backgroundColor;

  const DashboardTopBarProps({
    this.leading,
    this.trailing,
    this.backgroundColor = 'var(--card)',
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for dashboard layout components.
mixin DashboardLayoutRendererContract {
  Widget dashboardLayout(DashboardLayoutProps props);
  Widget dashboardTopBar(DashboardTopBarProps props);
}
