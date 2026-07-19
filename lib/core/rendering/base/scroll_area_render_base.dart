import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/scroll_area_props.dart';

/// Shared structural base for themed scroll-area renderers.
///
/// Every theme's scroll area produces the same structure (a positioned `div`
/// with optional sticky scroll shadows around the content). Themes differ only
/// in the CSS class prefix, the trailing scrollbar track styles, and the scroll
/// shadow size. This base factors the shared layout, overflow and shadow logic,
/// leaving those few values to the concrete renderer.
///
/// This base lives in core and depends only on core props; it must never
/// depend on a theme package.
abstract class ScrollAreaRenderBase extends StatelessComponent {
  const ScrollAreaRenderBase(this.props, {super.key});

  final ScrollAreaProps props;

  /// CSS class prefix (e.g. `'arcane'`, `'neon'`). The root and instance
  /// classes are derived as `'$cssPrefix-scroll-area'` and
  /// `'$cssPrefix-scroll-area-<instanceId>'`; shadows use
  /// `'$cssPrefix-scroll-shadow'`.
  String get cssPrefix;

  /// Size (height for vertical / width for horizontal) of a scroll shadow.
  String get scrollShadowSize;

  /// Trailing scrollbar track styles appended to the root element's styles
  /// (e.g. `scrollbar-color` / `scrollbar-width`).
  Map<String, String> scrollbarTrackStyles();

  @override
  Component build(BuildContext context) {
    final (String overflowX, String overflowY) = switch (props.direction) {
      ScrollDirectionVariant.vertical => ('hidden', 'auto'),
      ScrollDirectionVariant.horizontal => ('auto', 'hidden'),
      ScrollDirectionVariant.both => ('auto', 'auto'),
    };

    final Map<String, String> scrollbarVisibilityStyles = switch (props
        .scrollbar) {
      ScrollbarVisibilityVariant.always => <String, String>{},
      ScrollbarVisibilityVariant.hover => <String, String>{
        'scrollbar-width': 'none',
      },
      ScrollbarVisibilityVariant.auto_ => <String, String>{},
      ScrollbarVisibilityVariant.hidden => <String, String>{
        'scrollbar-width': 'none',
        '-ms-overflow-style': 'none',
      },
    };

    final String scrollClassName = '$cssPrefix-scroll-area-${props.instanceId}';

    return dom.div(
      classes: '$cssPrefix-scroll-area $scrollClassName ${props.className ?? ""}',
      styles: dom.Styles(
        raw: <String, String>{
          'position': 'relative',
          if (props.height != null) 'height': props.height!,
          if (props.width != null) 'width': props.width!,
          if (props.maxHeight != null) 'max-height': props.maxHeight!,
          if (props.maxWidth != null) 'max-width': props.maxWidth!,
          'overflow-x': overflowX,
          'overflow-y': overflowY,
          if (props.padding != null) 'padding': props.padding!,
          ...scrollbarVisibilityStyles,
          'scroll-behavior': 'smooth',
          '-webkit-overflow-scrolling': 'touch',
          ...scrollbarTrackStyles(),
        },
      ),
      <Component>[
        if (props.showScrollShadows) ...<Component>[
          _buildScrollShadow(props.direction, isStart: true),
          _buildScrollShadow(props.direction, isStart: false),
        ],
        props.child,
      ],
    );
  }

  Component _buildScrollShadow(
    ScrollDirectionVariant direction, {
    required bool isStart,
  }) {
    final bool isVertical =
        direction == ScrollDirectionVariant.vertical ||
        direction == ScrollDirectionVariant.both;
    final bool isHorizontal =
        direction == ScrollDirectionVariant.horizontal ||
        direction == ScrollDirectionVariant.both;

    if (isVertical && !isHorizontal) {
      return dom.div(
        classes: '$cssPrefix-scroll-shadow ${isStart ? "top" : "bottom"}',
        styles: dom.Styles(
          raw: <String, String>{
            'position': 'sticky',
            if (isStart) 'top': '0',
            if (!isStart) 'bottom': '0',
            'left': '0',
            'right': '0',
            'height': scrollShadowSize,
            'background': isStart
                ? 'linear-gradient(to bottom, var(--background), transparent)'
                : 'linear-gradient(to top, var(--background), transparent)',
            'pointer-events': 'none',
            'z-index': '1',
          },
        ),
        const <Component>[],
      );
    }

    if (isHorizontal) {
      return dom.div(
        classes: '$cssPrefix-scroll-shadow ${isStart ? "left" : "right"}',
        styles: dom.Styles(
          raw: <String, String>{
            'position': 'sticky',
            if (isStart) 'left': '0',
            if (!isStart) 'right': '0',
            'top': '0',
            'bottom': '0',
            'width': scrollShadowSize,
            'background': isStart
                ? 'linear-gradient(to right, var(--background), transparent)'
                : 'linear-gradient(to left, var(--background), transparent)',
            'pointer-events': 'none',
            'z-index': '1',
          },
        ),
        const <Component>[],
      );
    }

    return const dom.span(
      styles: dom.Styles(raw: <String, String>{'display': 'none'}),
      <Component>[],
    );
  }
}

/// Shared structural base for themed virtual-scroll renderers.
///
/// The visible-range math and the absolute-positioned item layout are identical
/// across themes; only the CSS class prefix and the trailing scrollbar styles
/// differ.
///
/// This base lives in core and depends only on core props; it must never
/// depend on a theme package.
abstract class VirtualScrollRenderBase<T> extends StatelessComponent {
  const VirtualScrollRenderBase(this.props, {super.key});

  final VirtualScrollProps<T> props;

  /// CSS class prefix; the root class is `'$cssPrefix-virtual-scroll'`.
  String get cssPrefix;

  /// Trailing scrollbar styles appended to the root element's styles.
  Map<String, String> virtualScrollbarStyles();

  @override
  Component build(BuildContext context) {
    final List<T> items = props.items;
    final double itemHeight = props.itemHeight;
    final int overscan = props.overscan;

    final double containerHeight =
        double.tryParse(props.height.replaceAll('px', '')) ?? 400;

    final int startIndex = ((props.scrollTop / itemHeight).floor() - overscan)
        .clamp(0, items.length);
    final int visibleCount = ((containerHeight / itemHeight).ceil() + overscan * 2)
        .clamp(0, items.length - startIndex);
    final int endIndex = (startIndex + visibleCount).clamp(0, items.length);

    final double totalHeight = items.length * itemHeight;

    return dom.div(
      classes: '$cssPrefix-virtual-scroll',
      styles: dom.Styles(
        raw: <String, String>{
          'height': props.height,
          'overflow-y': 'auto',
          'position': 'relative',
          ...virtualScrollbarStyles(),
        },
      ),
      events: props.onScroll != null
          ? <String, EventCallback>{
              'scroll': (e) {
                final target = e.target as dynamic;
                props.onScroll!((target.scrollTop as num).toDouble());
              },
            }
          : null,
      <Component>[
        dom.div(
          styles: dom.Styles(
            raw: <String, String>{
              'height': '${totalHeight}px',
              'position': 'relative',
            },
          ),
          <Component>[
            for (int i = startIndex; i < endIndex; i++)
              dom.div(
                styles: dom.Styles(
                  raw: <String, String>{
                    'position': 'absolute',
                    'top': '${i * itemHeight}px',
                    'left': '0',
                    'right': '0',
                    'height': '${itemHeight}px',
                  },
                ),
                <Component>[props.itemBuilder(context, items[i], i)],
              ),
          ],
        ),
      ],
    );
  }
}
