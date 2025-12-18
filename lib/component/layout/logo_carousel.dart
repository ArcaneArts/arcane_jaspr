import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';

/// A logo item for the carousel
class LogoItem {
  final String name;
  final String? imageUrl;
  final Component? customLogo;
  final String? href;

  const LogoItem({
    required this.name,
    this.imageUrl,
    this.customLogo,
    this.href,
  });
}

/// An infinite scrolling logo carousel (Supabase-style)
class LogoCarousel extends StatelessComponent {
  /// Logo items
  final List<LogoItem> logos;

  /// Animation duration in seconds
  final int duration;

  /// Logo height
  final double logoHeight;

  /// Gap between logos
  final double gap;

  /// Whether to pause on hover
  final bool pauseOnHover;

  /// Whether to reverse direction
  final bool reverse;

  /// Grayscale logos
  final bool grayscale;

  /// Optional title above the carousel
  final String? title;

  const LogoCarousel({
    required this.logos,
    this.duration = 30,
    this.logoHeight = 40,
    this.gap = 48,
    this.pauseOnHover = true,
    this.reverse = false,
    this.grayscale = true,
    this.title,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final animationName = reverse ? 'arcane-scroll-reverse' : 'arcane-scroll';

    return div(
      classes: 'arcane-logo-carousel',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '24px',
        'width': '100%',
        'overflow': 'hidden',
      }),
      [
        // Optional title
        if (title != null)
          div(
            classes: 'arcane-logo-carousel-title',
            styles: Styles(raw: {
              'text-align': 'center',
              'font-size': '0.875rem',
              'font-weight': '500',
              'color': 'var(--arcane-muted)',
              'text-transform': 'uppercase',
              'letter-spacing': '0.05em',
            }),
            [text(title!)],
          ),

        // Carousel track
        div(
          classes: 'arcane-logo-carousel-track ${pauseOnHover ? 'pause-on-hover' : ''}',
          styles: Styles(raw: {
            'display': 'flex',
            'width': 'max-content',
            'animation': '$animationName ${duration}s linear infinite',
          }),
          [
            // First set of logos
            _buildLogoSet(),
            // Duplicate set for seamless loop
            _buildLogoSet(),
          ],
        ),
      ],
    );
  }

  Component _buildLogoSet() {
    return div(
      classes: 'arcane-logo-carousel-set',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '${gap}px',
        'padding': '0 ${gap / 2}px',
      }),
      [
        for (final logo in logos) _buildLogo(logo),
      ],
    );
  }

  Component _buildLogo(LogoItem logo) {
    final logoContent = logo.customLogo ??
        (logo.imageUrl != null
            ? img(
                src: logo.imageUrl!,
                alt: logo.name,
                styles: Styles(raw: {
                  'height': '${logoHeight}px',
                  'width': 'auto',
                  'object-fit': 'contain',
                  if (grayscale) 'filter': 'grayscale(100%)',
                  'opacity': grayscale ? '0.6' : '1',
                  'transition': 'filter var(--arcane-transition-fast), opacity var(--arcane-transition-fast)',
                }),
              )
            : span(
                styles: Styles(raw: {
                  'font-size': '1.25rem',
                  'font-weight': '600',
                  'color': 'var(--arcane-muted)',
                  if (grayscale) 'filter': 'grayscale(100%)',
                  'opacity': grayscale ? '0.6' : '1',
                }),
                [text(logo.name)],
              ));

    if (logo.href != null) {
      return a(
        href: logo.href!,
        classes: 'arcane-logo-carousel-item',
        attributes: {
          'target': '_blank',
          'rel': 'noopener noreferrer',
          'aria-label': logo.name,
        },
        styles: Styles(raw: {
          'display': 'flex',
          'align-items': 'center',
          'justify-content': 'center',
          'flex-shrink': '0',
          'text-decoration': 'none',
        }),
        [logoContent],
      );
    }

    return div(
      classes: 'arcane-logo-carousel-item',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'flex-shrink': '0',
      }),
      [logoContent],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('@keyframes arcane-scroll').styles(raw: {
      '0%': 'transform: translateX(0)',
      '100%': 'transform: translateX(-50%)',
    }),
    css('@keyframes arcane-scroll-reverse').styles(raw: {
      '0%': 'transform: translateX(-50%)',
      '100%': 'transform: translateX(0)',
    }),
    css('.arcane-logo-carousel-track.pause-on-hover:hover').styles(raw: {
      'animation-play-state': 'paused',
    }),
    css('.arcane-logo-carousel-item:hover img').styles(raw: {
      'filter': 'grayscale(0%)',
      'opacity': '1',
    }),
    css('.arcane-logo-carousel-item:hover span').styles(raw: {
      'filter': 'grayscale(0%)',
      'opacity': '1',
      'color': 'var(--arcane-on-surface)',
    }),
  ];
}

/// A static logo grid
class LogoGrid extends StatelessComponent {
  /// Logo items
  final List<LogoItem> logos;

  /// Logo height
  final double logoHeight;

  /// Gap between logos
  final double gap;

  /// Grayscale logos
  final bool grayscale;

  /// Optional title
  final String? title;

  /// Number of columns
  final int columns;

  const LogoGrid({
    required this.logos,
    this.logoHeight = 40,
    this.gap = 32,
    this.grayscale = true,
    this.title,
    this.columns = 6,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-logo-grid',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '24px',
      }),
      [
        if (title != null)
          div(
            styles: Styles(raw: {
              'text-align': 'center',
              'font-size': '0.875rem',
              'font-weight': '500',
              'color': 'var(--arcane-muted)',
              'text-transform': 'uppercase',
              'letter-spacing': '0.05em',
            }),
            [text(title!)],
          ),
        div(
          classes: 'arcane-logo-grid-container',
          styles: Styles(raw: {
            'display': 'grid',
            'grid-template-columns': 'repeat($columns, 1fr)',
            'gap': '${gap}px',
            'align-items': 'center',
            'justify-items': 'center',
          }),
          [
            for (final logo in logos)
              div(
                classes: 'arcane-logo-grid-item',
                styles: Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                }),
                [
                  if (logo.customLogo != null)
                    logo.customLogo!
                  else if (logo.imageUrl != null)
                    img(
                      src: logo.imageUrl!,
                      alt: logo.name,
                      styles: Styles(raw: {
                        'height': '${logoHeight}px',
                        'width': 'auto',
                        'object-fit': 'contain',
                        if (grayscale) 'filter': 'grayscale(100%)',
                        'opacity': grayscale ? '0.6' : '1',
                        'transition': 'filter var(--arcane-transition-fast), opacity var(--arcane-transition-fast)',
                      }),
                    )
                  else
                    span(
                      styles: Styles(raw: {
                        'font-size': '1rem',
                        'font-weight': '600',
                        'color': 'var(--arcane-muted)',
                      }),
                      [text(logo.name)],
                    ),
                ],
              ),
          ],
        ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-logo-grid-item:hover img').styles(raw: {
      'filter': 'grayscale(0%)',
      'opacity': '1',
    }),
  ];
}
