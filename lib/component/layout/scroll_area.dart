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

/// Scroll direction
enum ScrollDirection {
  /// Vertical scrolling only
  vertical,

  /// Horizontal scrolling only
  horizontal,

  /// Both directions
  both,
}

/// Scrollbar visibility
enum ScrollbarVisibility {
  /// Always visible
  always,

  /// Visible on hover
  hover,

  /// Auto (browser default)
  auto_,

  /// Hidden (still scrollable)
  hidden,
}

/// Scrollbar style
enum ScrollbarStyle {
  /// Default browser scrollbar
  default_,

  /// Thin scrollbar
  thin,

  /// Minimal (very thin, mostly transparent)
  minimal,

  /// Custom styled scrollbar
  custom,
}

/// A scrollable area with custom styled scrollbars.
/// Similar to shadcn's ScrollArea component.
///
/// Usage:
/// ```dart
/// ArcaneScrollArea(
///   height: '400px',
///   child: LongContent(),
/// )
/// ```
class ArcaneScrollArea extends StatelessComponent {
  /// Content to scroll
  final Component child;

  /// Fixed height (required for vertical scroll)
  final String? height;

  /// Fixed width (required for horizontal scroll)
  final String? width;

  /// Maximum height
  final String? maxHeight;

  /// Maximum width
  final String? maxWidth;

  /// Scroll direction
  final ScrollDirection direction;

  /// Scrollbar visibility
  final ScrollbarVisibility scrollbar;

  /// Scrollbar style
  final ScrollbarStyle scrollbarStyle;

  /// Scrollbar track color
  final String? trackColor;

  /// Scrollbar thumb color
  final String? thumbColor;

  /// Scrollbar size (width for vertical, height for horizontal)
  final String scrollbarSize;

  /// Whether to show scroll shadows (gradient fade at edges)
  final bool showScrollShadows;

  /// Padding inside scroll area
  final String? padding;

  /// Additional CSS classes
  final String? className;

  const ArcaneScrollArea({
    required this.child,
    this.height,
    this.width,
    this.maxHeight,
    this.maxWidth,
    this.direction = ScrollDirection.vertical,
    this.scrollbar = ScrollbarVisibility.hover,
    this.scrollbarStyle = ScrollbarStyle.thin,
    this.trackColor,
    this.thumbColor,
    this.scrollbarSize = '8px',
    this.showScrollShadows = false,
    this.padding,
    this.className,
    super.key,
  });

  /// Creates a vertical scroll area with fixed height
  const ArcaneScrollArea.vertical({
    required this.child,
    required String this.height,
    this.maxHeight,
    this.scrollbar = ScrollbarVisibility.hover,
    this.scrollbarStyle = ScrollbarStyle.thin,
    this.thumbColor,
    this.trackColor,
    this.showScrollShadows = false,
    this.padding,
    this.className,
    super.key,
  })  : width = null,
        maxWidth = null,
        direction = ScrollDirection.vertical,
        scrollbarSize = '8px';

  /// Creates a horizontal scroll area with fixed width
  const ArcaneScrollArea.horizontal({
    required this.child,
    required String this.width,
    this.maxWidth,
    this.scrollbar = ScrollbarVisibility.hover,
    this.scrollbarStyle = ScrollbarStyle.thin,
    this.thumbColor,
    this.trackColor,
    this.showScrollShadows = false,
    this.padding,
    this.className,
    super.key,
  })  : height = null,
        maxHeight = null,
        direction = ScrollDirection.horizontal,
        scrollbarSize = '8px';

  @override
  Component build(BuildContext context) {
    // Overflow values based on direction
    final (String overflowX, String overflowY) = switch (direction) {
      ScrollDirection.vertical => ('hidden', 'auto'),
      ScrollDirection.horizontal => ('auto', 'hidden'),
      ScrollDirection.both => ('auto', 'auto'),
    };

    // Scrollbar visibility styles
    final Map<String, String> scrollbarVisibilityStyles =
        switch (scrollbar) {
      ScrollbarVisibility.always => {},
      ScrollbarVisibility.hover => {
          'scrollbar-width': 'none', // Firefox
        },
      ScrollbarVisibility.auto_ => {},
      ScrollbarVisibility.hidden => {
          'scrollbar-width': 'none',
          '-ms-overflow-style': 'none',
        },
    };

    // Generate unique class for this instance
    final scrollClassName =
        'arcane-scroll-area-${identityHashCode(this)}';

    return div(
      classes: 'arcane-scroll-area $scrollClassName ${className ?? ""}',
      styles: Styles(raw: {
        'position': 'relative',
        if (height != null) 'height': height!,
        if (width != null) 'width': width!,
        if (maxHeight != null) 'max-height': maxHeight!,
        if (maxWidth != null) 'max-width': maxWidth!,
        'overflow-x': overflowX,
        'overflow-y': overflowY,
        if (padding != null) 'padding': padding!,
        ...scrollbarVisibilityStyles,
        // Smooth scrolling
        'scroll-behavior': 'smooth',
        // Touch scrolling
        '-webkit-overflow-scrolling': 'touch',
      }),
      [
        // Scroll shadows (top/bottom or left/right gradients)
        if (showScrollShadows) ...[
          _buildScrollShadow(direction, isStart: true),
          _buildScrollShadow(direction, isStart: false),
        ],

        // Content
        child,
      ],
    );
  }

  Component _buildScrollShadow(ScrollDirection direction, {required bool isStart}) {
    final isVertical = direction == ScrollDirection.vertical ||
        direction == ScrollDirection.both;
    final isHorizontal = direction == ScrollDirection.horizontal ||
        direction == ScrollDirection.both;

    if (isVertical && !isHorizontal) {
      return div(
        classes: 'arcane-scroll-shadow ${isStart ? "top" : "bottom"}',
        styles: Styles(raw: {
          'position': 'sticky',
          if (isStart) 'top': '0',
          if (!isStart) 'bottom': '0',
          'left': '0',
          'right': '0',
          'height': '24px',
          'background': isStart
              ? 'linear-gradient(to bottom, ${ArcaneColors.background}, transparent)'
              : 'linear-gradient(to top, ${ArcaneColors.background}, transparent)',
          'pointer-events': 'none',
          'z-index': '1',
        }),
        [],
      );
    }

    if (isHorizontal) {
      return div(
        classes: 'arcane-scroll-shadow ${isStart ? "left" : "right"}',
        styles: Styles(raw: {
          'position': 'sticky',
          if (isStart) 'left': '0',
          if (!isStart) 'right': '0',
          'top': '0',
          'bottom': '0',
          'width': '24px',
          'background': isStart
              ? 'linear-gradient(to right, ${ArcaneColors.background}, transparent)'
              : 'linear-gradient(to left, ${ArcaneColors.background}, transparent)',
          'pointer-events': 'none',
          'z-index': '1',
        }),
        [],
      );
    }

    return const span([], styles: Styles(raw: {'display': 'none'}));
  }

  @css
  static final List<StyleRule> styles = [
    // Thin scrollbar (webkit)
    css('.arcane-scroll-area::-webkit-scrollbar').styles(raw: {
      'width': '8px',
      'height': '8px',
    }),
    css('.arcane-scroll-area::-webkit-scrollbar-track').styles(raw: {
      'background': ArcaneColors.transparent,
    }),
    css('.arcane-scroll-area::-webkit-scrollbar-thumb').styles(raw: {
      'background': ArcaneColors.muted,
      'border-radius': ArcaneRadius.full,
      'border': '2px solid transparent',
      'background-clip': 'padding-box',
    }),
    css('.arcane-scroll-area::-webkit-scrollbar-thumb:hover').styles(raw: {
      'background': ArcaneColors.onSurface,
      'background-clip': 'padding-box',
    }),
    // Hover to show scrollbar
    css('.arcane-scroll-area:hover').styles(raw: {
      'scrollbar-width': 'thin', // Firefox
    }),
    css('.arcane-scroll-area:hover::-webkit-scrollbar').styles(raw: {
      'width': '8px',
      'height': '8px',
    }),
    // Firefox thin scrollbar
    css('.arcane-scroll-area').styles(raw: {
      'scrollbar-color': '${ArcaneColors.muted} transparent',
    }),
  ];
}

/// A virtualized scroll list for large datasets.
/// Only renders visible items for performance.
class ArcaneVirtualScroll<T> extends StatefulComponent {
  /// List of items
  final List<T> items;

  /// Item builder
  final Component Function(BuildContext context, T item, int index) itemBuilder;

  /// Fixed item height (required for virtualization)
  final double itemHeight;

  /// Container height
  final String height;

  /// Overscan count (items to render outside viewport)
  final int overscan;

  const ArcaneVirtualScroll({
    required this.items,
    required this.itemBuilder,
    required this.itemHeight,
    required this.height,
    this.overscan = 3,
    super.key,
  });

  @override
  State<ArcaneVirtualScroll<T>> createState() => _ArcaneVirtualScrollState<T>();
}

class _ArcaneVirtualScrollState<T> extends State<ArcaneVirtualScroll<T>> {
  double _scrollTop = 0;

  @override
  Component build(BuildContext context) {
    final items = component.items;
    final itemHeight = component.itemHeight;
    final overscan = component.overscan;

    // Parse height to get container size (simplified - assumes px)
    final containerHeight =
        double.tryParse(component.height.replaceAll('px', '')) ?? 400;

    // Calculate visible range
    final startIndex =
        ((_scrollTop / itemHeight).floor() - overscan).clamp(0, items.length);
    final visibleCount = ((containerHeight / itemHeight).ceil() + overscan * 2)
        .clamp(0, items.length - startIndex);
    final endIndex = (startIndex + visibleCount).clamp(0, items.length);

    final totalHeight = items.length * itemHeight;

    return div(
      classes: 'arcane-virtual-scroll',
      styles: Styles(raw: {
        'height': component.height,
        'overflow-y': 'auto',
        'position': 'relative',
      }),
      events: {
        'scroll': (e) {
          final target = e.target as dynamic;
          setState(() => _scrollTop = (target.scrollTop as num).toDouble());
        },
      },
      [
        // Total height spacer
        div(
          styles: Styles(raw: {
            'height': '${totalHeight}px',
            'position': 'relative',
          }),
          [
            // Visible items
            for (var i = startIndex; i < endIndex; i++)
              div(
                styles: Styles(raw: {
                  'position': 'absolute',
                  'top': '${i * itemHeight}px',
                  'left': '0',
                  'right': '0',
                  'height': '${itemHeight}px',
                }),
                [component.itemBuilder(context, items[i], i)],
              ),
          ],
        ),
      ],
    );
  }
}