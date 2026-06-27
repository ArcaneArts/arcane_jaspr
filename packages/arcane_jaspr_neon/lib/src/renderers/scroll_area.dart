import 'package:arcane_jaspr/core/rendering/base/scroll_area_render_base.dart';

/// Neon Scroll Area renderer (neutralized skeleton).
class NeonScrollArea extends ScrollAreaRenderBase {
  const NeonScrollArea(super.props, {super.key});

  @override
  String get cssPrefix => 'neon';

  @override
  String get scrollShadowSize => '32px';

  @override
  Map<String, String> scrollbarTrackStyles() => const <String, String>{};
}

/// Neon Virtual Scroll renderer (neutralized skeleton).
class NeonVirtualScroll<T> extends VirtualScrollRenderBase<T> {
  const NeonVirtualScroll(super.props, {super.key});

  @override
  String get cssPrefix => 'neon';

  @override
  Map<String, String> virtualScrollbarStyles() => const <String, String>{};
}
