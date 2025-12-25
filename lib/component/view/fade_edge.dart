import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Direction of the fade effect
enum FadeDirection {
  /// Fades from left edge to transparent
  left,

  /// Fades from right edge to transparent
  right,

  /// Fades from top edge to transparent
  top,

  /// Fades from bottom edge to transparent
  bottom,
}

/// An overlay that creates a fade-to-transparent effect at an edge.
///
/// Commonly used for carousels, scrolling content, or overflow containers
/// to create a smooth visual transition at the edges.
///
/// ```dart
/// Stack([
///   // Scrolling content
///   HorizontalScrollView(...),
///   // Fade edges
///   ArcaneFadeEdge.left(color: '#09090b'),
///   ArcaneFadeEdge.right(color: '#09090b'),
/// ])
/// ```
class ArcaneFadeEdge extends StatelessComponent {
  /// The direction of the fade
  final FadeDirection direction;

  /// The color to fade from (typically the background color)
  /// Defaults to arcane background color
  final String? color;

  /// The width of the fade area (for left/right)
  final String? width;

  /// The height of the fade area (for top/bottom)
  final String? height;

  /// Z-index for stacking
  final String? zIndex;

  const ArcaneFadeEdge({
    required this.direction,
    this.color,
    this.width,
    this.height,
    this.zIndex,
    super.key,
  });

  /// Create a left fade edge
  const ArcaneFadeEdge.left({
    this.color,
    this.width,
    this.height,
    this.zIndex,
    super.key,
  }) : direction = FadeDirection.left;

  /// Create a right fade edge
  const ArcaneFadeEdge.right({
    this.color,
    this.width,
    this.height,
    this.zIndex,
    super.key,
  }) : direction = FadeDirection.right;

  /// Create a top fade edge
  const ArcaneFadeEdge.top({
    this.color,
    this.width,
    this.height,
    this.zIndex,
    super.key,
  }) : direction = FadeDirection.top;

  /// Create a bottom fade edge
  const ArcaneFadeEdge.bottom({
    this.color,
    this.width,
    this.height,
    this.zIndex,
    super.key,
  }) : direction = FadeDirection.bottom;

  @override
  Component build(BuildContext context) {
    final effectiveColor = color ?? ArcaneColors.background;
    final isHorizontal =
        direction == FadeDirection.left || direction == FadeDirection.right;

    final effectiveWidth = isHorizontal ? (width ?? '150px') : '100%';
    final effectiveHeight = !isHorizontal ? (height ?? '100px') : '100%';
    final effectiveZIndex = zIndex ?? '10';

    final gradient = _getGradient(effectiveColor);
    final positioning = _getPositioning();

    return div(
      styles: Styles(raw: {
        'position': 'absolute',
        'width': effectiveWidth,
        'height': effectiveHeight,
        'z-index': effectiveZIndex,
        'pointer-events': 'none',
        'background': gradient,
        ...positioning,
      }),
      [],
    );
  }

  String _getGradient(String color) {
    switch (direction) {
      case FadeDirection.left:
        return 'linear-gradient(to right, $color, transparent)';
      case FadeDirection.right:
        return 'linear-gradient(to left, $color, transparent)';
      case FadeDirection.top:
        return 'linear-gradient(to bottom, $color, transparent)';
      case FadeDirection.bottom:
        return 'linear-gradient(to top, $color, transparent)';
    }
  }

  Map<String, String> _getPositioning() {
    switch (direction) {
      case FadeDirection.left:
        return {'left': '0', 'top': '0', 'bottom': '0'};
      case FadeDirection.right:
        return {'right': '0', 'top': '0', 'bottom': '0'};
      case FadeDirection.top:
        return {'top': '0', 'left': '0', 'right': '0'};
      case FadeDirection.bottom:
        return {'bottom': '0', 'left': '0', 'right': '0'};
    }
  }
}
