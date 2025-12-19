import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../../util/tokens/tokens.dart';

/// An infinite scrolling carousel that auto-scrolls horizontally.
///
/// Duplicates content for seamless looping and pauses on hover.
/// Define the CSS animation in your styles.css:
/// ```css
/// @keyframes scroll-carousel {
///   0% { transform: translateX(0); }
///   100% { transform: translateX(-50%); }
/// }
/// .arcane-infinite-carousel-track {
///   animation: scroll-carousel 60s linear infinite;
/// }
/// .arcane-infinite-carousel-track:hover {
///   animation-play-state: paused;
/// }
/// ```
class ArcaneInfiniteCarousel extends StatelessComponent {
  /// The items to display (will be duplicated for seamless loop)
  final List<Component> children;

  /// Gap between items
  final String gap;

  /// Animation duration in seconds
  final int animationDuration;

  /// Whether to show fade gradients on edges
  final bool showFadeEdges;

  /// Fade edge width
  final String fadeWidth;

  /// Background color for fade gradient
  final String backgroundColor;

  /// CSS class for the track (for custom animation)
  final String? trackClass;

  const ArcaneInfiniteCarousel({
    super.key,
    required this.children,
    this.gap = ArcaneSpacing.lg,
    this.animationDuration = 60,
    this.showFadeEdges = true,
    this.fadeWidth = '150px',
    this.backgroundColor = ArcaneColors.surface,
  }) : trackClass = null;

  /// Creates a carousel with a custom track class for CSS animation
  const ArcaneInfiniteCarousel.withClass({
    super.key,
    required this.children,
    required this.trackClass,
    this.gap = ArcaneSpacing.lg,
    this.animationDuration = 60,
    this.showFadeEdges = true,
    this.fadeWidth = '150px',
    this.backgroundColor = ArcaneColors.surface,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-infinite-carousel',
      styles: const Styles(raw: {
        'position': 'relative',
        'overflow': 'hidden',
      }),
      [
        // Left fade gradient
        if (showFadeEdges)
          div(
            classes: 'arcane-infinite-carousel-fade-left',
            styles: Styles(raw: {
              'position': 'absolute',
              'left': '0',
              'top': '0',
              'bottom': '0',
              'width': fadeWidth,
              'background': 'linear-gradient(to right, $backgroundColor, transparent)',
              'z-index': '10',
              'pointer-events': 'none',
            }),
            [],
          ),
        // Right fade gradient
        if (showFadeEdges)
          div(
            classes: 'arcane-infinite-carousel-fade-right',
            styles: Styles(raw: {
              'position': 'absolute',
              'right': '0',
              'top': '0',
              'bottom': '0',
              'width': fadeWidth,
              'background': 'linear-gradient(to left, $backgroundColor, transparent)',
              'z-index': '10',
              'pointer-events': 'none',
            }),
            [],
          ),
        // Scrolling track
        div(
          classes: trackClass ?? 'arcane-infinite-carousel-track',
          styles: Styles(raw: {
            'display': 'flex',
            'width': 'max-content',
            if (trackClass == null)
              'animation': 'scroll-carousel ${animationDuration}s linear infinite',
          }),
          [
            // First set of items
            div(
              styles: Styles(raw: {
                'display': 'flex',
                'gap': gap,
                'padding': '0 ${ArcaneSpacing.sm}',
              }),
              children,
            ),
            // Duplicate for seamless infinite loop
            div(
              styles: Styles(raw: {
                'display': 'flex',
                'gap': gap,
                'padding': '0 ${ArcaneSpacing.sm}',
              }),
              children,
            ),
          ],
        ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-infinite-carousel-track:hover').styles(raw: {
      'animation-play-state': 'paused',
    }),
  ];
}

/// A marketing section with an infinite carousel.
///
/// Combines a section header with label/title/subtitle and a carousel.
class ArcaneCarouselSection extends StatelessComponent {
  /// Section label (small uppercase text above title)
  final String? label;

  /// Section title
  final String title;

  /// Section subtitle
  final String? subtitle;

  /// The carousel content
  final Component carousel;

  /// Background color
  final String backgroundColor;

  /// Section padding
  final String padding;

  const ArcaneCarouselSection({
    super.key,
    this.label,
    required this.title,
    this.subtitle,
    required this.carousel,
    this.backgroundColor = ArcaneColors.surface,
    this.padding = ArcaneSpacing.huge,
  });

  @override
  Component build(BuildContext context) {
    return section(
      classes: 'arcane-carousel-section',
      styles: Styles(raw: {
        'padding': '$padding 0',
        'background': backgroundColor,
        'overflow': 'hidden',
      }),
      [
        // Section header
        div(
          styles: Styles(raw: {
            'max-width': ArcaneLayout.maxWidthContent,
            'margin': '0 auto',
            'margin-bottom': ArcaneSpacing.xxl,
            'padding': '0 ${ArcaneSpacing.lg}',
            'text-align': 'center',
          }),
          [
            // Label
            if (label != null)
              span(
                styles: Styles(raw: {
                  'display': 'inline-block',
                  'font-size': ArcaneTypography.fontSm,
                  'font-weight': ArcaneTypography.weightMedium,
                  'color': ArcaneColors.accent,
                  'text-transform': 'uppercase',
                  'letter-spacing': '0.05em',
                  'margin-bottom': ArcaneSpacing.md,
                }),
                [Component.text(label!)],
              ),
            // Title
            h2(
              styles: Styles(raw: {
                'font-size': ArcaneTypography.font4xl,
                'font-weight': ArcaneTypography.weightBold,
                'color': ArcaneColors.onBackground,
                'margin': '0 0 ${ArcaneSpacing.md} 0',
              }),
              [Component.text(title)],
            ),
            // Subtitle
            if (subtitle != null)
              p(
                styles: Styles(raw: {
                  'font-size': ArcaneTypography.fontLg,
                  'color': ArcaneColors.muted,
                  'max-width': ArcaneLayout.maxWidthText,
                  'margin': '0 auto',
                }),
                [Component.text(subtitle!)],
              ),
          ],
        ),
        // Carousel
        carousel,
      ],
    );
  }
}
