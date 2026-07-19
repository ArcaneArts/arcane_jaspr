import 'package:arcane_jaspr/core/rendering/base/scroll_area_render_base.dart';

/// Neubrutalism Scroll Area renderer.
class NeubrutalismScrollArea extends ScrollAreaRenderBase {
  const NeubrutalismScrollArea(super.props, {super.key});

  @override
  String get cssPrefix => 'neubrutalism';

  @override
  String get scrollShadowSize => '32px';

  @override
  Map<String, String> scrollbarTrackStyles() => <String, String>{
    'scrollbar-color': 'var(--nb-ink, #000) var(--nb-paper-soft, #f1f1f1)',
    'scrollbar-width': 'thin',
  };
}

/// Neubrutalism Virtual Scroll renderer.
class NeubrutalismVirtualScroll<T> extends VirtualScrollRenderBase<T> {
  const NeubrutalismVirtualScroll(super.props, {super.key});

  @override
  String get cssPrefix => 'neubrutalism';

  @override
  Map<String, String> virtualScrollbarStyles() => <String, String>{
    'scrollbar-color': 'var(--nb-ink, #000) var(--nb-paper-soft, #f1f1f1)',
    'scrollbar-width': 'thin',
  };
}
