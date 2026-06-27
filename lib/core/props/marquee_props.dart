import 'package:arcane_jaspr/flutter.dart';

enum MarqueeDirection {
  left,
  right,
}

/// Marquee component properties.
class MarqueeProps {
  final List<Widget> children;
  final String duration;
  final MarqueeDirection direction;
  final String? gap;
  final bool showFadeEdges;
  final String? fadeWidth;
  final String? fadeColor;
  final bool pauseOnHover;
  final String? id;

  const MarqueeProps({
    required this.children,
    this.duration = '30s',
    this.direction = MarqueeDirection.left,
    this.gap,
    this.showFadeEdges = true,
    this.fadeWidth,
    this.fadeColor,
    this.pauseOnHover = true,
    this.id,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for marquee components.
mixin MarqueeRendererContract {
  Widget marquee(MarqueeProps props);
}
