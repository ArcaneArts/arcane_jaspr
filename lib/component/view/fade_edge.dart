import 'package:arcane_jaspr/flutter.dart';

import '../../core/theme_provider.dart';

export '../../core/props/fade_edge_props.dart';

/// An overlay that creates a fade-to-transparent effect at an edge.
class ArcaneFadeEdge extends StatelessWidget {
  final FadeDirection direction;
  final String? color;
  final String? width;
  final String? height;
  final String? zIndex;

  const ArcaneFadeEdge({
    required this.direction,
    this.color,
    this.width,
    this.height,
    this.zIndex,
    super.key,
  });

  const ArcaneFadeEdge.left({
    this.color,
    this.width,
    this.height,
    this.zIndex,
    super.key,
  }) : direction = FadeDirection.left;

  const ArcaneFadeEdge.right({
    this.color,
    this.width,
    this.height,
    this.zIndex,
    super.key,
  }) : direction = FadeDirection.right;

  const ArcaneFadeEdge.top({
    this.color,
    this.width,
    this.height,
    this.zIndex,
    super.key,
  }) : direction = FadeDirection.top;

  const ArcaneFadeEdge.bottom({
    this.color,
    this.width,
    this.height,
    this.zIndex,
    super.key,
  }) : direction = FadeDirection.bottom;

  @override
  Widget build(BuildContext context) {
    return context.renderers.fadeEdge(FadeEdgeProps(
      direction: direction,
      color: color,
      width: width,
      height: height,
      zIndex: zIndex,
    ));
  }
}
