import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';

/// Theme configuration for [CardCarousel] widgets.
class CardCarouselTheme {
  /// The intensity level for the edge gradient fade effect (1-12).
  final int sharpness;

  const CardCarouselTheme({this.sharpness = 9});

  CardCarouselTheme copyWith({int? sharpness}) =>
      CardCarouselTheme(sharpness: sharpness ?? this.sharpness);
}

/// A horizontally scrollable widget container with edge fading.
///
/// [CardCarousel] displays a sequence of widgets in a compact horizontal layout
/// with smooth scrolling and edge gradient overlays to indicate additional content.
class CardCarousel extends StatelessComponent {
  /// The collection of widgets to render within the carousel.
  final List<Component> children;

  /// Optional override for the edge gradient fade intensity (1-12).
  final int? sharpness;

  /// Optional color for the edge fade overlay gradient.
  final String? featherColor;

  /// Gap between carousel items.
  final double gap;

  /// Padding around the carousel content.
  final String? padding;

  /// Height constraint for the carousel.
  final String? height;

  const CardCarousel({
    super.key,
    this.children = const [],
    this.sharpness,
    this.featherColor,
    this.gap = 16,
    this.padding,
    this.height,
  });

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);
    final effectiveSharpness = (sharpness ?? 9).clamp(1, 12);
    final effectiveFeatherColor =
        featherColor ?? 'var(--arcane-background)';

    // Generate gradient stops based on sharpness
    final transparentStops = List.generate(effectiveSharpness, (_) => 'transparent');
    final leftGradient = [effectiveFeatherColor, ...transparentStops].join(', ');
    final rightGradient = [...transparentStops, effectiveFeatherColor].join(', ');

    return div(
      classes: 'arcane-card-carousel',
      styles: Styles(raw: {
        'position': 'relative',
        'width': '100%',
        if (height != null) 'height': height!,
      }),
      [
        // Scrollable content
        div(
          classes: 'arcane-card-carousel-content',
          styles: Styles(raw: {
            'display': 'flex',
            'gap': '${gap}px',
            'overflow-x': 'auto',
            'overflow-y': 'hidden',
            'scroll-behavior': 'smooth',
            'scrollbar-width': 'none',
            '-ms-overflow-style': 'none',
            if (padding != null) 'padding': padding!,
          }),
          children,
        ),

        // Left fade overlay
        div(
          classes: 'arcane-card-carousel-fade-left',
          styles: Styles(raw: {
            'position': 'absolute',
            'top': '0',
            'left': '0',
            'bottom': '0',
            'width': '40px',
            'background': 'linear-gradient(to right, $leftGradient)',
            'pointer-events': 'none',
            'opacity': '0',
            'transition': 'opacity 300ms ease',
          }),
          [],
        ),

        // Right fade overlay
        div(
          classes: 'arcane-card-carousel-fade-right',
          styles: Styles(raw: {
            'position': 'absolute',
            'top': '0',
            'right': '0',
            'bottom': '0',
            'width': '40px',
            'background': 'linear-gradient(to left, $rightGradient)',
            'pointer-events': 'none',
            'opacity': '1',
            'transition': 'opacity 300ms ease',
          }),
          [],
        ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    // Hide scrollbar
    css('.arcane-card-carousel-content::-webkit-scrollbar').styles(raw: {
      'display': 'none',
    }),
  ];
}

/// A carousel with navigation arrows.
class NavigableCarousel extends StatefulComponent {
  /// The collection of widgets to render.
  final List<Component> children;

  /// Gap between items.
  final double gap;

  /// Whether to show navigation arrows.
  final bool showArrows;

  /// Whether to show dot indicators.
  final bool showIndicators;

  /// Items visible at once (for snapping).
  final int visibleItems;

  /// Height constraint.
  final String? height;

  const NavigableCarousel({
    super.key,
    required this.children,
    this.gap = 16,
    this.showArrows = true,
    this.showIndicators = true,
    this.visibleItems = 1,
    this.height,
  });

  @override
  State<NavigableCarousel> createState() => _NavigableCarouselState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-carousel-prev:hover:not([disabled]), .arcane-carousel-next:hover:not([disabled])')
        .styles(raw: {
      'background-color': 'var(--arcane-surface-variant)',
    }),
    css('.arcane-carousel-indicators button:hover').styles(raw: {
      'background-color': 'var(--arcane-primary)',
      'opacity': '0.7',
    }),
  ];
}

class _NavigableCarouselState extends State<NavigableCarousel> {
  int _currentIndex = 0;

  int get _maxIndex =>
      (component.children.length / component.visibleItems).ceil() - 1;

  void _goToPrevious() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  void _goToNext() {
    if (_currentIndex < _maxIndex) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  void _goToIndex(int index) {
    if (index >= 0 && index <= _maxIndex) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);
    final translatePercent = -_currentIndex * 100;

    return div(
      classes: 'arcane-navigable-carousel',
      styles: Styles(raw: {
        'position': 'relative',
        'width': '100%',
        if (component.height != null) 'height': component.height!,
      }),
      [
        // Carousel viewport
        div(
          classes: 'arcane-carousel-viewport',
          styles: Styles(raw: {
            'overflow': 'hidden',
            'width': '100%',
          }),
          [
            // Carousel track
            div(
              classes: 'arcane-carousel-track',
              styles: Styles(raw: {
                'display': 'flex',
                'gap': '${component.gap}px',
                'transform': 'translateX($translatePercent%)',
                'transition': 'transform 300ms ease',
              }),
              [
                for (final child in component.children)
                  div(
                    styles: Styles(raw: {
                      'flex': '0 0 calc(${100 / component.visibleItems}% - ${component.gap * (component.visibleItems - 1) / component.visibleItems}px)',
                      'min-width': '0',
                    }),
                    [child],
                  ),
              ],
            ),
          ],
        ),

        // Navigation arrows
        if (component.showArrows) ...[
          // Previous button
          button(
            classes: 'arcane-carousel-prev',
            attributes: {
              'type': 'button',
              'aria-label': 'Previous',
              if (_currentIndex == 0) 'disabled': 'true',
            },
            styles: Styles(raw: {
              'position': 'absolute',
              'left': '8px',
              'top': '50%',
              'transform': 'translateY(-50%)',
              'width': '36px',
              'height': '36px',
              'border-radius': '50%',
              'border': 'none',
              'background-color': 'var(--arcane-surface)',
              'color': 'var(--arcane-on-surface)',
              'cursor': _currentIndex == 0 ? 'not-allowed' : 'pointer',
              'opacity': _currentIndex == 0 ? '0.5' : '1',
              'box-shadow': '0 2px 4px rgba(0, 0, 0, 0.1)',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'z-index': '10',
              'transition': 'all 150ms ease',
            }),
            events: {
              'click': (_) => _goToPrevious(),
            },
            [Component.text('<')],
          ),

          // Next button
          button(
            classes: 'arcane-carousel-next',
            attributes: {
              'type': 'button',
              'aria-label': 'Next',
              if (_currentIndex >= _maxIndex) 'disabled': 'true',
            },
            styles: Styles(raw: {
              'position': 'absolute',
              'right': '8px',
              'top': '50%',
              'transform': 'translateY(-50%)',
              'width': '36px',
              'height': '36px',
              'border-radius': '50%',
              'border': 'none',
              'background-color': 'var(--arcane-surface)',
              'color': 'var(--arcane-on-surface)',
              'cursor': _currentIndex >= _maxIndex ? 'not-allowed' : 'pointer',
              'opacity': _currentIndex >= _maxIndex ? '0.5' : '1',
              'box-shadow': '0 2px 4px rgba(0, 0, 0, 0.1)',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'z-index': '10',
              'transition': 'all 150ms ease',
            }),
            events: {
              'click': (_) => _goToNext(),
            },
            [Component.text('>')],
          ),
        ],

        // Dot indicators
        if (component.showIndicators && _maxIndex > 0)
          div(
            classes: 'arcane-carousel-indicators',
            styles: Styles(raw: {
              'display': 'flex',
              'justify-content': 'center',
              'gap': '8px',
              'margin-top': '16px',
            }),
            [
              for (var i = 0; i <= _maxIndex; i++)
                button(
                  attributes: {
                    'type': 'button',
                    'aria-label': 'Go to slide ${i + 1}',
                  },
                  styles: Styles(raw: {
                    'width': i == _currentIndex ? '24px' : '8px',
                    'height': '8px',
                    'border-radius': '4px',
                    'border': 'none',
                    'background-color': i == _currentIndex
                        ? 'var(--arcane-primary)'
                        : 'var(--arcane-outline-variant)',
                    'cursor': 'pointer',
                    'transition': 'all 200ms ease',
                    'padding': '0',
                  }),
                  events: {
                    'click': (_) => _goToIndex(i),
                  },
                  [],
                ),
            ],
          ),
      ],
    );
  }
}

/// A hero carousel with full-width slides.
class HeroCarousel extends StatefulComponent {
  /// Slides to display.
  final List<Component> children;

  /// Auto-play interval in milliseconds (0 to disable).
  final int autoPlayInterval;

  /// Whether to show navigation arrows.
  final bool showArrows;

  /// Whether to show dot indicators.
  final bool showIndicators;

  /// Height of the carousel.
  final String height;

  const HeroCarousel({
    super.key,
    required this.children,
    this.autoPlayInterval = 5000,
    this.showArrows = true,
    this.showIndicators = true,
    this.height = '400px',
  });

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-hero-carousel button:hover').styles(raw: {
      'background-color': 'rgba(0, 0, 0, 0.7)',
    }),
  ];
}

class _HeroCarouselState extends State<HeroCarousel> {
  int _currentIndex = 0;

  void _goToPrevious() {
    setState(() {
      _currentIndex = _currentIndex == 0
          ? component.children.length - 1
          : _currentIndex - 1;
    });
  }

  void _goToNext() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % component.children.length;
    });
  }

  void _goToIndex(int index) {
    if (index >= 0 && index < component.children.length) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);

    return div(
      classes: 'arcane-hero-carousel',
      styles: Styles(raw: {
        'position': 'relative',
        'width': '100%',
        'height': component.height,
        'overflow': 'hidden',
      }),
      [
        // Slides
        for (var i = 0; i < component.children.length; i++)
          div(
            classes: 'arcane-hero-slide',
            styles: Styles(raw: {
              'position': 'absolute',
              'inset': '0',
              'opacity': i == _currentIndex ? '1' : '0',
              'visibility': i == _currentIndex ? 'visible' : 'hidden',
              'transition': 'opacity 500ms ease, visibility 500ms ease',
            }),
            [component.children[i]],
          ),

        // Navigation arrows
        if (component.showArrows && component.children.length > 1) ...[
          button(
            attributes: {'type': 'button', 'aria-label': 'Previous'},
            styles: Styles(raw: {
              'position': 'absolute',
              'left': '16px',
              'top': '50%',
              'transform': 'translateY(-50%)',
              'width': '48px',
              'height': '48px',
              'border-radius': '50%',
              'border': 'none',
              'background-color': 'rgba(0, 0, 0, 0.5)',
              'color': 'white',
              'cursor': 'pointer',
              'font-size': '1.25rem',
              'z-index': '10',
              'transition': 'background-color 150ms ease',
            }),
            events: {'click': (_) => _goToPrevious()},
            [Component.text('<')],
          ),
          button(
            attributes: {'type': 'button', 'aria-label': 'Next'},
            styles: Styles(raw: {
              'position': 'absolute',
              'right': '16px',
              'top': '50%',
              'transform': 'translateY(-50%)',
              'width': '48px',
              'height': '48px',
              'border-radius': '50%',
              'border': 'none',
              'background-color': 'rgba(0, 0, 0, 0.5)',
              'color': 'white',
              'cursor': 'pointer',
              'font-size': '1.25rem',
              'z-index': '10',
              'transition': 'background-color 150ms ease',
            }),
            events: {'click': (_) => _goToNext()},
            [Component.text('>')],
          ),
        ],

        // Dot indicators
        if (component.showIndicators && component.children.length > 1)
          div(
            styles: Styles(raw: {
              'position': 'absolute',
              'bottom': '16px',
              'left': '50%',
              'transform': 'translateX(-50%)',
              'display': 'flex',
              'gap': '8px',
              'z-index': '10',
            }),
            [
              for (var i = 0; i < component.children.length; i++)
                button(
                  attributes: {'type': 'button', 'aria-label': 'Go to slide ${i + 1}'},
                  styles: Styles(raw: {
                    'width': '12px',
                    'height': '12px',
                    'border-radius': '50%',
                    'border': '2px solid white',
                    'background-color': i == _currentIndex ? 'white' : 'transparent',
                    'cursor': 'pointer',
                    'transition': 'background-color 200ms ease',
                    'padding': '0',
                  }),
                  events: {'click': (_) => _goToIndex(i)},
                  [],
                ),
            ],
          ),
      ],
    );
  }
}
