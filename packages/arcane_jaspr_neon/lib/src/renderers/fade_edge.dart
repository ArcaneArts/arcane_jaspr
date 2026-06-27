import 'package:arcane_jaspr/core/rendering/base/fade_edge_render_base.dart';

/// Neon Fade Edge renderer.
class NeonFadeEdge extends FadeEdgeRenderBase {
  const NeonFadeEdge(super.props, {super.key});

  @override
  String get cssClass => 'neon-fade-edge';
}
