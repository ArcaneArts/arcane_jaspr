import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';
import 'fade_edge.dart';

/// Scroll direction for the marquee
enum MarqueeDirection {
  /// Scroll from right to left (default)
  left,

  /// Scroll from left to right
  right,
}

/// An infinite scrolling marquee/carousel component.
///
/// Automatically duplicates content for seamless infinite scrolling.
/// Includes optional fade edges for smooth visual transitions.
///
/// ```dart
/// ArcaneMarquee(
///   children: [
///     for (final item in items) ItemCard(item),
///   ],
///   showFadeEdges: true,
///   duration: '30s',
/// )
/// ```
class ArcaneMarquee extends StatelessComponent {
  /// The content to scroll (will be duplicated for seamless looping)
  final List<Component> children;

  /// Animation duration (CSS time value, e.g., '20s', '30s')
  final String duration;

  /// Scroll direction
  final MarqueeDirection direction;

  /// Gap between items
  final String? gap;

  /// Whether to show fade edges
  final bool showFadeEdges;

  /// Fade edge width
  final String? fadeWidth;

  /// Background color for fade edges
  final String? fadeColor;

  /// Whether to pause animation on hover
  final bool pauseOnHover;

  /// Unique ID for the animation (required if multiple marquees on same page)
  final String? id;

  const ArcaneMarquee({
    required this.children,
    this.duration = '30s',
    this.direction = MarqueeDirection.left,
    this.gap,
    this.showFadeEdges = true,
    this.fadeWidth,
    this.fadeColor,
    this.pauseOnHover = true,
    this.id,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final effectiveGap = gap ?? ArcaneSpacing.lg;
    final marqueeId = id ?? 'arcane-marquee-${hashCode}';
    final animationName = 'arcane-marquee-scroll-$marqueeId';

    return div(
      styles: const Styles(raw: {
        'position': 'relative',
        'overflow': 'hidden',
        'width': '100%',
      }),
      [
        // Fade edges
        if (showFadeEdges) ...[
          ArcaneFadeEdge.left(
            color: fadeColor,
            width: fadeWidth,
          ),
          ArcaneFadeEdge.right(
            color: fadeColor,
            width: fadeWidth,
          ),
        ],
        // Scrolling track
        div(
          classes: 'arcane-marquee-track $marqueeId',
          styles: Styles(raw: {
            'display': 'flex',
            'width': 'max-content',
            'animation': '$animationName $duration linear infinite',
            if (pauseOnHover) '--pause-on-hover': 'paused',
          }),
          [
            // First set of items
            div(
              styles: Styles(raw: {
                'display': 'flex',
                'gap': effectiveGap,
                'padding': '0 ${ArcaneSpacing.sm}',
              }),
              children,
            ),
            // Duplicate for seamless loop
            div(
              styles: Styles(raw: {
                'display': 'flex',
                'gap': effectiveGap,
                'padding': '0 ${ArcaneSpacing.sm}',
              }),
              children,
            ),
          ],
        ),
        // Inject animation keyframes
        Component.element(
          tag: 'style',
          children: [
            text('''
@keyframes $animationName {
  from {
    transform: translateX(0);
  }
  to {
    transform: translateX(-50%);
  }
}
${pauseOnHover ? '''
.$marqueeId:hover {
  animation-play-state: var(--pause-on-hover, running);
}
''' : ''}
'''),
          ],
        ),
      ],
    );
  }
}

/// A reverse marquee that scrolls in the opposite direction
class ArcaneMarqueeReverse extends StatelessComponent {
  /// The content to scroll (will be duplicated for seamless looping)
  final List<Component> children;

  /// Animation duration (CSS time value)
  final String duration;

  /// Gap between items
  final String? gap;

  /// Whether to show fade edges
  final bool showFadeEdges;

  /// Fade edge width
  final String? fadeWidth;

  /// Background color for fade edges
  final String? fadeColor;

  /// Whether to pause animation on hover
  final bool pauseOnHover;

  /// Unique ID for the animation
  final String? id;

  const ArcaneMarqueeReverse({
    required this.children,
    this.duration = '30s',
    this.gap,
    this.showFadeEdges = true,
    this.fadeWidth,
    this.fadeColor,
    this.pauseOnHover = true,
    this.id,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final effectiveGap = gap ?? ArcaneSpacing.lg;
    final marqueeId = id ?? 'arcane-marquee-reverse-${hashCode}';
    final animationName = 'arcane-marquee-scroll-reverse-$marqueeId';

    return div(
      styles: const Styles(raw: {
        'position': 'relative',
        'overflow': 'hidden',
        'width': '100%',
      }),
      [
        // Fade edges
        if (showFadeEdges) ...[
          ArcaneFadeEdge.left(
            color: fadeColor,
            width: fadeWidth,
          ),
          ArcaneFadeEdge.right(
            color: fadeColor,
            width: fadeWidth,
          ),
        ],
        // Scrolling track
        div(
          classes: 'arcane-marquee-track $marqueeId',
          styles: Styles(raw: {
            'display': 'flex',
            'width': 'max-content',
            'animation': '$animationName $duration linear infinite',
            if (pauseOnHover) '--pause-on-hover': 'paused',
          }),
          [
            // First set of items
            div(
              styles: Styles(raw: {
                'display': 'flex',
                'gap': effectiveGap,
                'padding': '0 ${ArcaneSpacing.sm}',
              }),
              children,
            ),
            // Duplicate for seamless loop
            div(
              styles: Styles(raw: {
                'display': 'flex',
                'gap': effectiveGap,
                'padding': '0 ${ArcaneSpacing.sm}',
              }),
              children,
            ),
          ],
        ),
        // Inject animation keyframes (reverse direction)
        Component.element(
          tag: 'style',
          children: [
            text('''
@keyframes $animationName {
  from {
    transform: translateX(-50%);
  }
  to {
    transform: translateX(0);
  }
}
${pauseOnHover ? '''
.$marqueeId:hover {
  animation-play-state: var(--pause-on-hover, running);
}
''' : ''}
'''),
          ],
        ),
      ],
    );
  }
}