import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/jaspr.dart'
    hide
        BuildContext,
        InheritedComponent,
        Key,
        State,
        StatefulComponent,
        StatelessComponent,
        UniqueKey,
        ValueKey,
        runApp;
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

/// Infinite scrolling carousel that auto-scrolls horizontally.
///
/// Features:
/// - Click and drag to manually scroll
/// - Infinite looping in both directions
/// - Auto-resume scrolling after inactivity
/// - Touch support for mobile devices
/// - Pauses on hover
class ArcaneInfiniteCarousel extends StatelessWidget {
  final List<Widget> children;
  final String gap;
  final int animationDuration;
  final String? trackClass;

  /// Delay in seconds before resuming auto-scroll after user interaction.
  /// Default: 5 seconds.
  final int resumeDelay;

  const ArcaneInfiniteCarousel({
    super.key,
    required this.children,
    this.gap = '1.5rem',
    this.animationDuration = 60,
    this.resumeDelay = 5,
  }) : trackClass = null;

  const ArcaneInfiniteCarousel.withClass({
    super.key,
    required this.children,
    required this.trackClass,
    this.gap = '1.5rem',
    this.animationDuration = 60,
    this.resumeDelay = 5,
  });

  @override
  Widget build(BuildContext context) {
    return div(
      classes: 'arcane-carousel',
      attributes: {
        'data-animation-duration': animationDuration.toString(),
        'data-resume-delay': (resumeDelay * 1000).toString(),
      },
      styles: const Styles(raw: {'position': 'relative', 'overflow': 'hidden'}),
      [
        div(
          classes:
              '${trackClass ?? 'arcane-infinite-carousel-track'} arcane-carousel-track',
          styles: Styles(
            raw: {
              'display': 'flex',
              'width': 'max-content',
              // Routed through the theme seam that .arcane-carousel-track.dragging
              // already uses, so a theme without a grab hand (Windows 95) can
              // retarget it; unset it still resolves to the modern open hand.
              'cursor': 'var(--arcane-drag-cursor, grab)',
              'user-select': 'none',
              if (trackClass == null)
                'animation':
                    'scroll-carousel ${animationDuration}s linear infinite',
            },
          ),
          [
            div(
              attributes: const <String, String>{
                'data-arcane-carousel-content': 'original',
              },
              styles: Styles(
                raw: {'display': 'flex', 'gap': gap, 'padding': '0 0.5rem'},
              ),
              children,
            ),
            div(
              attributes: const <String, String>{
                'data-arcane-carousel-content': 'clone',
                'aria-hidden': 'true',
                'inert': 'true',
              },
              styles: Styles(
                raw: {
                  'display': 'flex',
                  'gap': gap,
                  'padding': '0 0.5rem',
                  'pointer-events': 'none',
                },
              ),
              children,
            ),
          ],
        ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css(
      '.arcane-carousel-track:hover, .arcane-carousel:focus-within .arcane-carousel-track',
    ).styles(raw: {'animation-play-state': 'paused'}),
  ];
}

/// Marketing section with an infinite carousel.
class ArcaneCarouselSection extends StatelessWidget {
  final String? label;
  final String title;
  final String? subtitle;
  final Widget carousel;
  final String backgroundColor;
  final String padding;

  const ArcaneCarouselSection({
    super.key,
    this.label,
    required this.title,
    this.subtitle,
    required this.carousel,
    this.backgroundColor = 'var(--card)',
    this.padding = '4rem',
  });

  @override
  Widget build(BuildContext context) {
    return section(
      classes: 'arcane-carousel-section',
      styles: Styles(
        raw: {
          'padding': '$padding 0',
          'background': backgroundColor,
          'overflow': 'hidden',
        },
      ),
      [
        div(
          styles: const Styles(
            raw: {
              'max-width': '72rem',
              'margin': '0 auto',
              'margin-bottom': '3rem',
              'padding': '0 1.5rem',
              'text-align': 'center',
            },
          ),
          [
            if (label != null)
              span(
                styles: const Styles(
                  raw: {
                    'display': 'inline-block',
                    'font-size': '0.875rem',
                    'font-weight': '500',
                    'color': 'var(--accent)',
                    'text-transform': 'uppercase',
                    'letter-spacing': '0.05em',
                    'margin-bottom': '1rem',
                  },
                ),
                [Component.text(label!)],
              ),
            h2(
              styles: const Styles(
                raw: {
                  'font-size': '2.25rem',
                  'font-weight': '700',
                  'color': 'var(--foreground)',
                  'margin': '0 0 1rem 0',
                },
              ),
              [Component.text(title)],
            ),
            if (subtitle != null)
              p(
                styles: const Styles(
                  raw: {
                    'font-size': '1.125rem',
                    'color': 'var(--muted-foreground)',
                    'max-width': '40rem',
                    'margin': '0 auto',
                  },
                ),
                [Component.text(subtitle!)],
              ),
          ],
        ),
        carousel,
      ],
    );
  }
}
