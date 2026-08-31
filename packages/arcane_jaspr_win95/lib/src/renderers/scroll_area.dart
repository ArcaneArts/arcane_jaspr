import 'package:arcane_jaspr/core/rendering/base/scroll_area_render_base.dart';

/// Win95 Scroll Area renderer (neutralized skeleton).
class Win95ScrollArea extends ScrollAreaRenderBase {
  const Win95ScrollArea(super.props, {super.key});

  @override
  String get cssPrefix => 'win95';

  @override
  Map<String, String> scrollbarTrackStyles() => const <String, String>{};
}

/// Win95 Virtual Scroll renderer (neutralized skeleton).
class Win95VirtualScroll<T> extends VirtualScrollRenderBase<T> {
  const Win95VirtualScroll(super.props, {super.key});

  @override
  String get cssPrefix => 'win95';

  @override
  Map<String, String> virtualScrollbarStyles() => const <String, String>{};
}
