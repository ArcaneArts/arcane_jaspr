import 'package:arcane_jaspr/core/rendering/base/fade_edge_render_base.dart';

/// Win95 Fade Edge renderer.
class Win95FadeEdge extends FadeEdgeRenderBase {
  const Win95FadeEdge(super.props, {super.key});

  @override
  String get cssClass => 'win95-fade-edge';
}
