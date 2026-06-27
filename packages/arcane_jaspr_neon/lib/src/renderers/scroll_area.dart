import 'package:arcane_jaspr/core/rendering/base/scroll_area_render_base.dart';

/// Neon Scroll Area renderer.
class NeonScrollArea extends ScrollAreaRenderBase {
  const NeonScrollArea(super.props, {super.key});

  @override
  String get cssPrefix => 'neon';

  @override
  String get scrollShadowSize => '32px';

  @override
  Map<String, String> scrollbarTrackStyles() => <String, String>{
    'scrollbar-color':
        'color-mix(in srgb, var(--neon-accent) 38%, transparent) transparent',
    'scrollbar-width': 'thin',
  };
}

/// Neon Virtual Scroll renderer.
class NeonVirtualScroll<T> extends VirtualScrollRenderBase<T> {
  const NeonVirtualScroll(super.props, {super.key});

  @override
  String get cssPrefix => 'neon';

  @override
  Map<String, String> virtualScrollbarStyles() => <String, String>{
    'scrollbar-color':
        'color-mix(in srgb, var(--neon-accent) 38%, transparent) transparent',
    'scrollbar-width': 'thin',
  };
}
