import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';

/// A game tile component for game server selection
class GameTile extends StatelessComponent {
  /// Game name
  final String name;

  /// Game icon/logo URL
  final String? iconUrl;

  /// Custom icon component
  final Component? icon;

  /// Whether this game is selected
  final bool selected;

  /// Click handler
  final void Function()? onTap;

  /// Whether the game is popular/featured
  final bool popular;

  /// Badge text (e.g., "New", "Beta")
  final String? badge;

  /// Description or player count
  final String? subtitle;

  const GameTile({
    required this.name,
    this.iconUrl,
    this.icon,
    this.selected = false,
    this.onTap,
    this.popular = false,
    this.badge,
    this.subtitle,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return button(
      classes: 'arcane-game-tile ${selected ? 'selected' : ''} ${popular ? 'popular' : ''}',
      attributes: {'type': 'button'},
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'gap': '12px',
        'padding': '20px 16px',
        'background-color': selected ? 'var(--arcane-accent-container)' : 'var(--arcane-surface)',
        'border': '2px solid ${selected ? 'var(--arcane-accent)' : 'var(--arcane-border)'}',
        'border-radius': 'var(--arcane-radius)',
        'cursor': 'pointer',
        'transition': 'all var(--arcane-transition-fast)',
        'position': 'relative',
        'overflow': 'hidden',
      }),
      events: {
        if (onTap != null) 'click': (e) => onTap!(),
      },
      [
        // Badge
        if (badge != null)
          div(
            classes: 'arcane-game-tile-badge',
            styles: Styles(raw: {
              'position': 'absolute',
              'top': '8px',
              'right': '8px',
              'padding': '2px 8px',
              'font-size': '0.6875rem',
              'font-weight': '600',
              'text-transform': 'uppercase',
              'color': 'var(--arcane-accent-foreground)',
              'background-color': 'var(--arcane-accent)',
              'border-radius': 'var(--arcane-radius-full)',
            }),
            [text(badge!)],
          ),

        // Icon
        div(
          classes: 'arcane-game-tile-icon',
          styles: Styles(raw: {
            'width': '64px',
            'height': '64px',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'background-color': 'var(--arcane-surface-variant)',
            'border-radius': 'var(--arcane-radius)',
            'overflow': 'hidden',
          }),
          [
            if (icon != null)
              icon!
            else if (iconUrl != null)
              img(
                src: iconUrl!,
                alt: name,
                styles: Styles(raw: {
                  'width': '48px',
                  'height': '48px',
                  'object-fit': 'contain',
                }),
              )
            else
              span(
                styles: Styles(raw: {
                  'font-size': '1.5rem',
                  'color': 'var(--arcane-muted)',
                }),
                [text('🎮')],
              ),
          ],
        ),

        // Name
        div(
          styles: Styles(raw: {
            'font-size': '0.9375rem',
            'font-weight': '600',
            'color': selected ? 'var(--arcane-accent)' : 'var(--arcane-on-surface)',
            'text-align': 'center',
          }),
          [text(name)],
        ),

        // Subtitle
        if (subtitle != null)
          div(
            styles: Styles(raw: {
              'font-size': '0.75rem',
              'color': 'var(--arcane-muted)',
            }),
            [text(subtitle!)],
          ),

        // Popular indicator
        if (popular && badge == null)
          div(
            styles: Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '4px',
              'font-size': '0.75rem',
              'color': 'var(--arcane-warning)',
            }),
            [
              span([text('⭐')]),
              text('Popular'),
            ],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-game-tile:hover').styles(raw: {
      'border-color': 'var(--arcane-accent)',
      'box-shadow': 'var(--arcane-shadow-md)',
    }),
    css('.arcane-game-tile:focus').styles(raw: {
      'outline': 'none',
      'border-color': 'var(--arcane-accent)',
      'box-shadow': '0 0 0 2px var(--arcane-accent-container)',
    }),
  ];
}

/// A grid of game tiles
class GameSelector extends StatelessComponent {
  /// Game tiles
  final List<GameTile> games;

  /// Number of columns
  final int columns;

  /// Gap between tiles
  final double gap;

  /// Title
  final String? title;

  /// Description
  final String? description;

  const GameSelector({
    required this.games,
    this.columns = 4,
    this.gap = 16,
    this.title,
    this.description,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-game-selector',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '24px',
      }),
      [
        if (title != null || description != null)
          div(
            styles: Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'gap': '8px',
            }),
            [
              if (title != null)
                div(
                  styles: Styles(raw: {
                    'font-size': '1.25rem',
                    'font-weight': '600',
                    'color': 'var(--arcane-on-surface)',
                  }),
                  [text(title!)],
                ),
              if (description != null)
                div(
                  styles: Styles(raw: {
                    'font-size': '0.875rem',
                    'color': 'var(--arcane-muted)',
                  }),
                  [text(description!)],
                ),
            ],
          ),
        div(
          styles: Styles(raw: {
            'display': 'grid',
            'grid-template-columns': 'repeat($columns, 1fr)',
            'gap': '${gap}px',
          }),
          games,
        ),
      ],
    );
  }
}

/// A game card with more details
class GameCard extends StatelessComponent {
  /// Game name
  final String name;

  /// Game description
  final String? description;

  /// Icon URL
  final String? iconUrl;

  /// Custom icon
  final Component? icon;

  /// Background image URL
  final String? backgroundUrl;

  /// Player count or status
  final String? status;

  /// Features list
  final List<String>? features;

  /// Click handler
  final void Function()? onTap;

  /// CTA button text
  final String? ctaText;

  const GameCard({
    required this.name,
    this.description,
    this.iconUrl,
    this.icon,
    this.backgroundUrl,
    this.status,
    this.features,
    this.onTap,
    this.ctaText,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-game-card',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'background-color': 'var(--arcane-surface)',
        'border': '1px solid var(--arcane-border)',
        'border-radius': 'var(--arcane-radius)',
        'overflow': 'hidden',
        'transition': 'border-color var(--arcane-transition-fast), box-shadow var(--arcane-transition-fast)',
        if (onTap != null) 'cursor': 'pointer',
      }),
      events: {
        if (onTap != null) 'click': (e) => onTap!(),
      },
      [
        // Background/header
        div(
          classes: 'arcane-game-card-header',
          styles: Styles(raw: {
            'position': 'relative',
            'height': '120px',
            'background-color': 'var(--arcane-surface-variant)',
            if (backgroundUrl != null) 'background-image': 'url($backgroundUrl)',
            'background-size': 'cover',
            'background-position': 'center',
          }),
          [
            // Overlay
            div(
              styles: Styles(raw: {
                'position': 'absolute',
                'inset': '0',
                'background': 'linear-gradient(to top, var(--arcane-surface) 0%, transparent 100%)',
              }),
              [],
            ),
            // Icon overlay
            div(
              styles: Styles(raw: {
                'position': 'absolute',
                'bottom': '-24px',
                'left': '20px',
              }),
              [
                div(
                  styles: Styles(raw: {
                    'width': '48px',
                    'height': '48px',
                    'display': 'flex',
                    'align-items': 'center',
                    'justify-content': 'center',
                    'background-color': 'var(--arcane-surface)',
                    'border': '2px solid var(--arcane-border)',
                    'border-radius': 'var(--arcane-radius)',
                    'overflow': 'hidden',
                  }),
                  [
                    if (icon != null)
                      icon!
                    else if (iconUrl != null)
                      img(
                        src: iconUrl!,
                        alt: name,
                        styles: Styles(raw: {
                          'width': '32px',
                          'height': '32px',
                          'object-fit': 'contain',
                        }),
                      )
                    else
                      span(
                        styles: Styles(raw: {
                          'font-size': '1.25rem',
                        }),
                        [text('🎮')],
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),

        // Content
        div(
          styles: Styles(raw: {
            'padding': '32px 20px 20px',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '12px',
          }),
          [
            // Name and status
            div(
              styles: Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'space-between',
              }),
              [
                div(
                  styles: Styles(raw: {
                    'font-size': '1.125rem',
                    'font-weight': '600',
                    'color': 'var(--arcane-on-surface)',
                  }),
                  [text(name)],
                ),
                if (status != null)
                  span(
                    styles: Styles(raw: {
                      'font-size': '0.75rem',
                      'color': 'var(--arcane-success)',
                    }),
                    [text(status!)],
                  ),
              ],
            ),

            // Description
            if (description != null)
              div(
                styles: Styles(raw: {
                  'font-size': '0.875rem',
                  'line-height': '1.5',
                  'color': 'var(--arcane-muted)',
                }),
                [text(description!)],
              ),

            // Features
            if (features != null && features!.isNotEmpty)
              div(
                styles: Styles(raw: {
                  'display': 'flex',
                  'flex-wrap': 'wrap',
                  'gap': '8px',
                  'margin-top': '4px',
                }),
                [
                  for (final feature in features!)
                    span(
                      styles: Styles(raw: {
                        'padding': '4px 8px',
                        'font-size': '0.75rem',
                        'color': 'var(--arcane-muted)',
                        'background-color': 'var(--arcane-surface-variant)',
                        'border-radius': 'var(--arcane-radius-sm)',
                      }),
                      [text(feature)],
                    ),
                ],
              ),

            // CTA
            if (ctaText != null)
              button(
                attributes: {'type': 'button'},
                styles: Styles(raw: {
                  'margin-top': '8px',
                  'padding': '10px 16px',
                  'font-size': '0.875rem',
                  'font-weight': '500',
                  'color': 'var(--arcane-accent-foreground)',
                  'background-color': 'var(--arcane-accent)',
                  'border': 'none',
                  'border-radius': 'var(--arcane-radius)',
                  'cursor': 'pointer',
                  'transition': 'background-color var(--arcane-transition-fast)',
                }),
                [text(ctaText!)],
              ),
          ],
        ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-game-card:hover').styles(raw: {
      'border-color': 'var(--arcane-accent)',
      'box-shadow': 'var(--arcane-shadow-md)',
    }),
  ];
}
