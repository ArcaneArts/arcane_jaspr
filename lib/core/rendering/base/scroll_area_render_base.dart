import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/scroll_area_props.dart';

/// Shared structural base for themed scroll-area renderers.
///
/// Every theme's scroll area produces the same positioned scroll container.
///
/// This base lives in core and depends only on core props; it must never
/// depend on a theme package.
abstract class ScrollAreaRenderBase extends StatelessComponent {
  const ScrollAreaRenderBase(this.props, {super.key});

  final ScrollAreaProps props;

  /// CSS class prefix (e.g. `'arcane'`, `'neon'`). The root and instance
  /// classes are derived as `'$cssPrefix-scroll-area'` and
  /// `'$cssPrefix-scroll-area-<instanceId>'`.
  String get cssPrefix;

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
      <Component>[props.child],
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
