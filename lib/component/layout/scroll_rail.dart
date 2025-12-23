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

/// Scroll rail position
enum ScrollRailPosition {
  /// Rail on the left side
  left,

  /// Rail on the right side
  right,
}

/// Scroll rail sizing
enum ScrollRailSize {
  /// Narrow rail (200px)
  narrow,

  /// Small rail (240px)
  sm,

  /// Medium rail (280px)
  md,

  /// Large rail (320px)
  lg,

  /// Extra large rail (360px)
  xl,
}

/// A scrollable sidebar rail that maintains position independently of page scroll.
///
/// This component creates a sticky sidebar that:
/// - Stays fixed relative to the viewport
/// - Scrolls independently of the main content
/// - Maintains scroll position during page navigation
/// - Perfect for documentation sidebars and navigation menus
///
/// ```dart
/// ArcaneScrollRail(
///   width: '280px',
///   topOffset: '64px', // Below a fixed header
///   children: [
///     // Navigation items
///   ],
/// )
/// ```
class ArcaneScrollRail extends StatelessComponent {
  /// Children to render inside the rail
  final List<Component> children;

  /// Position of the rail (left or right)
  final ScrollRailPosition position;

  /// Size preset for the rail width
  final ScrollRailSize size;

  /// Custom width (overrides size)
  final String? width;

  /// Top offset (e.g., to account for fixed header)
  final String topOffset;

  /// Bottom offset
  final String bottomOffset;

  /// Whether to show border on the rail edge
  final bool showBorder;

  /// Background color (uses CSS variable if null)
  final String? background;

  /// Padding preset
  final String padding;

  /// Whether to show a custom scrollbar
  final bool customScrollbar;

  /// ID for scroll persistence (used to restore scroll position)
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
    this.padding = ArcaneSpacing.md,
    this.customScrollbar = true,
    this.scrollPersistenceId,
    super.key,
  });

  /// Constructor for left-positioned rail
  const ArcaneScrollRail.left({
    required this.children,
    this.size = ScrollRailSize.md,
    this.width,
    this.topOffset = '0px',
    this.bottomOffset = '0px',
    this.showBorder = true,
    this.background,
    this.padding = ArcaneSpacing.md,
    this.customScrollbar = true,
    this.scrollPersistenceId,
    super.key,
  }) : position = ScrollRailPosition.left;

  /// Constructor for right-positioned rail
  const ArcaneScrollRail.right({
    required this.children,
    this.size = ScrollRailSize.md,
    this.width,
    this.topOffset = '0px',
    this.bottomOffset = '0px',
    this.showBorder = true,
    this.background,
    this.padding = ArcaneSpacing.md,
    this.customScrollbar = true,
    this.scrollPersistenceId,
    super.key,
  }) : position = ScrollRailPosition.right;

  String get _widthValue =>
      width ??
      switch (size) {
        ScrollRailSize.narrow => '200px',
        ScrollRailSize.sm => '240px',
        ScrollRailSize.md => '280px',
        ScrollRailSize.lg => '320px',
        ScrollRailSize.xl => '360px',
      };

  String get _borderStyle {
    if (!showBorder) return 'none';
    return position == ScrollRailPosition.left
        ? '1px solid ${ArcaneColors.borderSubtle}'
        : '1px solid ${ArcaneColors.borderSubtle}';
  }

  @override
  Component build(BuildContext context) {
    final String heightCalc = 'calc(100vh - $topOffset - $bottomOffset)';
    final String scrollbarId =
        scrollPersistenceId ?? 'scroll-rail-${position.name}';

    return div(
      id: scrollbarId,
      styles: Styles(raw: {
        'position': 'sticky',
        'top': topOffset,
        'width': _widthValue,
        'height': heightCalc,
        'max-height': heightCalc,
        'flex-shrink': '0',
        'overflow-y': 'auto',
        'overflow-x': 'hidden',
        'background': background ?? ArcaneColors.surface,
        if (position == ScrollRailPosition.left)
          'border-right': _borderStyle
        else
          'border-left': _borderStyle,
        // Custom scrollbar styling
        if (customScrollbar) ...{
          'scrollbar-width': 'thin',
          'scrollbar-color':
              '${ArcaneColors.borderMedium} ${ArcaneColors.transparent}',
        },
      }),
      [
        // Inner container with padding
        div(
          styles: Styles(raw: {
            'padding': padding,
            'min-height': '100%',
          }),
          children,
        ),
        // Script for scroll persistence
        if (scrollPersistenceId != null)
          script(content: '''
            (function() {
              var rail = document.getElementById('$scrollbarId');
              if (!rail) return;

              var storageKey = 'scroll-rail-$scrollbarId';

              // Restore scroll position
              var savedPos = sessionStorage.getItem(storageKey);
              if (savedPos) {
                rail.scrollTop = parseInt(savedPos, 10);
              }

              // Save scroll position on scroll
              var saveTimeout;
              rail.addEventListener('scroll', function() {
                clearTimeout(saveTimeout);
                saveTimeout = setTimeout(function() {
                  sessionStorage.setItem(storageKey, rail.scrollTop.toString());
                }, 100);
              });
            })();
          '''),
      ],
    );
  }
}

/// A layout component that combines a scroll rail with main content.
///
/// This provides a complete two-column layout with a sticky scrollable
/// sidebar and main content area.
///
/// ```dart
/// ArcaneScrollRailLayout(
///   headerHeight: '64px',
///   rail: DocsSidebar(),
///   child: DocsContent(),
/// )
/// ```
class ArcaneScrollRailLayout extends StatelessComponent {
  /// The rail/sidebar content
  final Component rail;

  /// The main content
  final Component child;

  /// Position of the rail
  final ScrollRailPosition railPosition;

  /// Size of the rail
  final ScrollRailSize railSize;

  /// Custom rail width
  final String? railWidth;

  /// Height of fixed header (used to calculate rail offset)
  final String headerHeight;

  /// Whether to show border between rail and content
  final bool showBorder;

  /// Rail background color
  final String? railBackground;

  /// Main content background color
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
  Component build(BuildContext context) {
    final railComponent = ArcaneScrollRail(
      position: railPosition,
      size: railSize,
      width: railWidth,
      topOffset: headerHeight,
      showBorder: showBorder,
      background: railBackground,
      scrollPersistenceId: 'main-rail',
      children: [rail],
    );

    final mainContent = div(
      styles: Styles(raw: {
        'flex': '1',
        'min-width': '0',
        'background': contentBackground ?? ArcaneColors.surface,
      }),
      [child],
    );

    return div(
      styles: const Styles(raw: {
        'display': 'flex',
        'min-height': '100vh',
        'width': '100%',
      }),
      railPosition == ScrollRailPosition.left
          ? [railComponent, mainContent]
          : [mainContent, railComponent],
    );
  }
}
