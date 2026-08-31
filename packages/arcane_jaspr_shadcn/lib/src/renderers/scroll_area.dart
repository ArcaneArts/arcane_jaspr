import 'package:arcane_jaspr/core/rendering/base/scroll_area_render_base.dart';

/// ShadCN Scroll Area renderer.
///
/// Reference: https://ui.shadcn.com/docs/components/scroll-area
/// ShadCN: relative overflow-hidden
/// ShadCN ScrollBar: flex touch-none select-none transition-colors h-full w-2.5 / w-full h-2.5
class ShadcnScrollArea extends ScrollAreaRenderBase {
  const ShadcnScrollArea(super.props, {super.key});

  @override
  String get cssPrefix => 'arcane';

  @override
  Map<String, String> scrollbarTrackStyles() => <String, String>{
    'scrollbar-color': 'var(--border) transparent',
  };
}

/// ShadCN Virtual Scroll renderer.
///
/// A virtualized scroll list for large datasets.
/// Only renders visible items for performance.
class ShadcnVirtualScroll<T> extends VirtualScrollRenderBase<T> {
  const ShadcnVirtualScroll(super.props, {super.key});

  @override
  String get cssPrefix => 'arcane';

  @override
  Map<String, String> virtualScrollbarStyles() => const <String, String>{};
}
