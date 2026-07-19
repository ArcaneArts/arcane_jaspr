import 'package:arcane_jaspr/core/rendering/base/fade_edge_render_base.dart';

/// Neubrutalism Fade Edge renderer.
class NeubrutalismFadeEdge extends FadeEdgeRenderBase {
  const NeubrutalismFadeEdge(super.props, {super.key});

  @override
  String get cssClass => 'neubrutalism-fade-edge';
}
