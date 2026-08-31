import 'package:arcane_jaspr/flutter.dart';

import '../../core/theme_provider.dart';

export '../../core/props/scroll_rail_props.dart'
    show ScrollRailPosition, ScrollRailSize;

/// A scrollable sidebar rail that maintains position independently of page scroll.
class ArcaneScrollRail extends StatelessWidget {
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

  const ArcaneScrollRail({
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
    super.key,
  });

  const ArcaneScrollRail.left({
    required this.children,
    this.size = ScrollRailSize.md,
    this.width,
    this.topOffset = '0px',
    this.bottomOffset = '0px',
    this.showBorder = true,
    this.background,
    this.padding = '1rem',
    this.customScrollbar = true,
    this.scrollPersistenceId,
    super.key,
  }) : position = ScrollRailPosition.left;

  const ArcaneScrollRail.right({
    required this.children,
    this.size = ScrollRailSize.md,
    this.width,
    this.topOffset = '0px',
    this.bottomOffset = '0px',
    this.showBorder = true,
    this.background,
    this.padding = '1rem',
    this.customScrollbar = true,
    this.scrollPersistenceId,
    super.key,
  }) : position = ScrollRailPosition.right;

  @override
  Widget build(BuildContext context) {
    return context.renderers.scrollRail(
      ScrollRailProps(
        position: position,
        size: size,
        width: width,
        topOffset: topOffset,
        bottomOffset: bottomOffset,
        showBorder: showBorder,
        background: background,
        padding: padding,
        customScrollbar: customScrollbar,
        scrollPersistenceId: scrollPersistenceId,
        children: children,
      ),
    );
  }
}

/// A layout component that combines a scroll rail with main content.
class ArcaneScrollRailLayout extends StatelessWidget {
  final Widget rail;
  final Widget child;
  final ScrollRailPosition railPosition;
  final ScrollRailSize railSize;
  final String? railWidth;
  final String headerHeight;
  final bool showBorder;
  final String? railBackground;
  final String? contentBackground;

  const ArcaneScrollRailLayout({
    required this.rail,
    required this.child,
    this.railPosition = ScrollRailPosition.left,
    this.railSize = ScrollRailSize.md,
    this.railWidth,
    this.headerHeight = '0px',
    this.showBorder = true,
    this.railBackground,
    this.contentBackground,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return context.renderers.scrollRailLayout(
      ScrollRailLayoutProps(
        rail: rail,
        child: child,
        railPosition: railPosition,
        railSize: railSize,
        railWidth: railWidth,
        headerHeight: headerHeight,
        showBorder: showBorder,
        railBackground: railBackground,
        contentBackground: contentBackground,
      ),
    );
  }
}
