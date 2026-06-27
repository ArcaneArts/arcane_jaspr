import 'package:arcane_jaspr/flutter.dart';

/// Bottom navigation item data.
class BottomNavItem {
  final String label;
  final Widget icon;
  final Widget? activeIcon;
  final String? badge;

  const BottomNavItem({
    required this.label,
    required this.icon,
    this.activeIcon,
    this.badge,
  });
}

/// Bottom navigation bar component properties.
class BottomNavigationBarProps {
  final List<BottomNavItem> items;
  final int selectedIndex;
  final void Function(int index)? onChanged;
  final bool showLabels;
  final bool showSelectedLabels;
  final double height;

  const BottomNavigationBarProps({
    required this.items,
    required this.selectedIndex,
    this.onChanged,
    this.showLabels = true,
    this.showSelectedLabels = false,
    this.height = 64,
  });
}

/// Bottom bar container component properties.
class BottomBarProps {
  final Widget child;
  final bool safeArea;

  const BottomBarProps({
    required this.child,
    this.safeArea = true,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for bottom navigation components.
mixin BottomNavigationRendererContract {
  /// Renders a bottom navigation bar with items.
  Widget bottomNavigationBar(BottomNavigationBarProps props);

  /// Renders a bottom bar container.
  Widget bottomBar(BottomBarProps props);
}
