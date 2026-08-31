import 'package:arcane_jaspr/flutter.dart';

enum ScrollRailPosition { left, right }

enum ScrollRailSize { narrow, sm, md, lg, xl }

/// Scroll rail component properties.
class ScrollRailProps {
  final List<Widget> children;
  final ScrollRailPosition position;
  final ScrollRailSize size;
  final String? width;
  final String topOffset;
  final String bottomOffset;
  final bool showBorder;
  final String? background;
  final String padding;
  final bool customScrollbar;
  final String? scrollPersistenceId;

  const ScrollRailProps({
    required this.children,
    this.position = ScrollRailPosition.left,
    this.size = ScrollRailSize.md,
    this.width,
    this.topOffset = '0px',
    this.bottomOffset = '0px',
    this.showBorder = true,
    this.background,
    this.padding = '1rem',
    this.customScrollbar = true,
    this.scrollPersistenceId,
  });
}

/// Scroll rail layout component properties.
class ScrollRailLayoutProps {
  final Widget rail;
  final Widget child;
  final ScrollRailPosition railPosition;
  final ScrollRailSize railSize;
  final String? railWidth;
  final String headerHeight;
  final bool showBorder;
  final String? railBackground;
  final String? contentBackground;

  const ScrollRailLayoutProps({
    required this.rail,
    required this.child,
    this.railPosition = ScrollRailPosition.left,
    this.railSize = ScrollRailSize.md,
    this.railWidth,
    this.headerHeight = '0px',
    this.showBorder = true,
    this.railBackground,
    this.contentBackground,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for scroll rail components.
mixin ScrollRailRendererContract {
  Widget scrollRail(ScrollRailProps props);
  Widget scrollRailLayout(ScrollRailLayoutProps props);
}
