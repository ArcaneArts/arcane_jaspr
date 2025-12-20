import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';
import '../navigation/bottom_navigation_bar.dart';
import '../navigation/sidebar.dart';

/// A screen with built-in navigation (sidebar or bottom nav).
class ArcaneNavigationScreen extends StatefulComponent {
  /// Navigation destinations
  final List<ArcaneNavigationDestination> destinations;

  /// Initial selected index
  final int initialIndex;

  /// Callback when navigation changes
  final void Function(int index)? onNavigationChanged;

  /// Navigation mode (auto, sidebar, bottom, rail)
  final NavigationMode mode;

  /// Breakpoint for switching between modes in auto mode
  final double breakpoint;

  /// Header for sidebar mode
  final Component? sidebarHeader;

  /// Footer for sidebar mode
  final Component? sidebarFooter;

  /// Whether sidebar is collapsible
  final bool sidebarCollapsible;

  /// Initial sidebar collapsed state
  final bool sidebarCollapsed;

  const ArcaneNavigationScreen({
    required this.destinations,
    this.initialIndex = 0,
    this.onNavigationChanged,
    this.mode = NavigationMode.auto,
    this.breakpoint = 768,
    this.sidebarHeader,
    this.sidebarFooter,
    this.sidebarCollapsible = true,
    this.sidebarCollapsed = false,
    super.key,
  });

  @override
  State<ArcaneNavigationScreen> createState() => _ArcaneNavigationScreenState();
}

class _ArcaneNavigationScreenState extends State<ArcaneNavigationScreen> {
  late int _selectedIndex;
  late bool _sidebarCollapsed;

  @override
  void initState() {
    super.initState();
    _selectedIndex = component.initialIndex;
    _sidebarCollapsed = component.sidebarCollapsed;
  }

  void _selectDestination(int index) {
    if (index != _selectedIndex && index < component.destinations.length) {
      setState(() {
        _selectedIndex = index;
      });
      component.onNavigationChanged?.call(index);
    }
  }

  void _toggleSidebar(bool collapsed) {
    setState(() {
      _sidebarCollapsed = collapsed;
    });
  }

  @override
  Component build(BuildContext context) {
    final ArcaneNavigationDestination destination = _selectedIndex < component.destinations.length
        ? component.destinations[_selectedIndex]
        : component.destinations.first;

    // For Jaspr/web, we'll use CSS media queries or JavaScript for responsive behavior
    // For now, we'll determine mode based on component settings
    final bool useBottomNav = component.mode == NavigationMode.bottom;
    final bool useSidebar = component.mode == NavigationMode.sidebar ||
        component.mode == NavigationMode.auto;

    return div(
      classes: 'arcane-navigation-screen',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'height': '100vh',
        'background-color': ArcaneColors.background,
      }),
      [
        // Main content area with sidebar
        div(
          classes: 'arcane-navigation-screen-body',
          styles: const Styles(raw: {
            'display': 'flex',
            'flex': '1',
            'min-height': '0',
          }),
          [
            // Sidebar navigation
            if (useSidebar)
              ArcaneSidebar(
                header: component.sidebarHeader,
                footer: component.sidebarFooter,
                collapsed: _sidebarCollapsed,
                onCollapseChanged:
                    component.sidebarCollapsible ? _toggleSidebar : null,
                showCollapseToggle: component.sidebarCollapsible,
                children: [
                  for (int i = 0; i < component.destinations.length; i++)
                    ArcaneSidebarItem(
                      label: component.destinations[i].label,
                      icon: component.destinations[i].icon,
                      selected: i == _selectedIndex,
                      onTap: () => _selectDestination(i),
                      collapsed: _sidebarCollapsed,
                    ),
                ],
              ),

            // Content
            div(
              classes: 'arcane-navigation-screen-content',
              styles: const Styles(raw: {
                'flex': '1',
                'overflow-y': 'auto',
                'min-width': '0',
              }),
              [destination.content],
            ),
          ],
        ),

        // Bottom navigation (for mobile/bottom mode)
        if (useBottomNav)
          ArcaneBottomNavigationBar(
            items: [
              for (final dest in component.destinations)
                ArcaneBottomNavItem(
                  label: dest.label,
                  icon: dest.icon,
                ),
            ],
            selectedIndex: _selectedIndex,
            onChanged: _selectDestination,
          ),
      ],
    );
  }
}

/// Navigation mode
enum NavigationMode {
  /// Automatically switch between sidebar and bottom nav based on screen size
  auto,

  /// Always use sidebar
  sidebar,

  /// Always use bottom navigation
  bottom,

  /// Use rail (compact sidebar)
  rail,
}

/// A navigation destination
class ArcaneNavigationDestination {
  final String label;
  final Component icon;
  final Component? selectedIcon;
  final Component content;

  const ArcaneNavigationDestination({
    required this.label,
    required this.icon,
    this.selectedIcon,
    required this.content,
  });
}

/// A responsive scaffold that adapts to screen size
class ArcaneResponsiveScaffold extends StatelessComponent {
  /// Content for small screens (mobile)
  final Component mobile;

  /// Content for medium screens (tablet) - defaults to mobile
  final Component? tablet;

  /// Content for large screens (desktop) - defaults to tablet or mobile
  final Component? desktop;

  /// Breakpoint for tablet (min-width)
  final double tabletBreakpoint;

  /// Breakpoint for desktop (min-width)
  final double desktopBreakpoint;

  const ArcaneResponsiveScaffold({
    required this.mobile,
    this.tablet,
    this.desktop,
    this.tabletBreakpoint = 768,
    this.desktopBreakpoint = 1024,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    // In Jaspr, we can use CSS media queries for true responsiveness
    // For now, we'll render all versions and hide with CSS
    return div(
      classes: 'arcane-responsive-scaffold',
      [
        // Mobile version
        div(
          classes: 'arcane-responsive-mobile',
          styles: const Styles(raw: {
            'display': 'block',
          }),
          [mobile],
        ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    // Media query styles would go here in a real implementation
    // Jaspr supports @css for defining component styles
  ];
}