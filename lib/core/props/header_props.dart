import 'package:arcane_jaspr/flutter.dart';

/// Navigation item data.
class NavItemProps {
  final String label;
  final String? href;
  final void Function()? onTap;
  final List<NavItemProps>? children;
  final bool isActive;

  const NavItemProps({
    required this.label,
    this.href,
    this.onTap,
    this.children,
    this.isActive = false,
  });
}

/// Header/navbar component properties.
class HeaderProps {
  final Widget logo;

  /// Simple navigation items (rendered by the header renderer).
  final List<NavItemProps> navItems;

  /// Custom navigation content (takes precedence over navItems if provided).
  /// Use this to pass complex navigation components like dropdowns.
  final Widget? customNav;

  final List<Widget>? actions;
  final bool showSearch;
  final String searchPlaceholder;
  final void Function(String)? onSearch;
  final bool sticky;
  final bool transparent;
  final bool bordered;

  /// Header height in pixels. Defaults to 72 for Neon, 64 for Shadcn.
  final double? height;

  const HeaderProps({
    required this.logo,
    this.navItems = const [],
    this.customNav,
    this.actions,
    this.showSearch = false,
    this.searchPlaceholder = 'Search...',
    this.onSearch,
    this.sticky = true,
    this.transparent = false,
    this.bordered = true,
    this.height,
  });
}

/// Navigation link component properties.
class NavLinkProps {
  final String label;
  final String? href;
  final void Function()? onTap;
  final bool isActive;
  final bool showArrow;

  const NavLinkProps({
    required this.label,
    this.href,
    this.onTap,
    this.isActive = false,
    this.showArrow = false,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for header components.
mixin HeaderRendererContract {
  /// Renders the main header/navbar component.
  Widget header(HeaderProps props);

  /// Renders a navigation link.
  Widget navLink(NavLinkProps props);
}
