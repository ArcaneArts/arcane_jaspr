import 'package:arcane_jaspr/core/rendering/base/fade_edge_render_base.dart';

/// ShadCN Fade Edge renderer.
class ShadcnFadeEdge extends FadeEdgeRenderBase {
  const ShadcnFadeEdge(super.props, {super.key});

  @override
  String get cssClass => 'arcane-fade-edge';
}
