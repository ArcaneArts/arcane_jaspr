import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

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
        'gap': ArcaneSpacing.md,
        'padding': '${ArcaneSpacing.lg} ${ArcaneSpacing.lg}',
        'background-color': selected ? ArcaneColors.accentContainer : ArcaneColors.surface,
        'border': '2px solid ${selected ? ArcaneColors.accent : ArcaneColors.border}',
        'border-radius': ArcaneRadius.md,
        'cursor': 'pointer',
        'transition': ArcaneEffects.transitionFast,
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
              'top': ArcaneSpacing.sm,
              'right': ArcaneSpacing.sm,
              'padding': '2px ${ArcaneSpacing.sm}',
              'font-size': ArcaneTypography.fontXs,
              'font-weight': ArcaneTypography.weightSemibold,
              'text-transform': 'uppercase',
              'color': ArcaneColors.accentForeground,
              'background-color': ArcaneColors.accent,
              'border-radius': ArcaneRadius.full,
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
            'background-color': ArcaneColors.surfaceVariant,
            'border-radius': ArcaneRadius.md,
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
                  'font-size': ArcaneTypography.fontXl,
                  'color': ArcaneColors.muted,
                  'font-weight': ArcaneTypography.weightBold,
                }),
                [text(name.isNotEmpty ? name[0].toUpperCase() : '?')],
              ),
          ],
        ),

        // Name
        div(
          styles: Styles(raw: {
            'font-size': ArcaneTypography.fontMd,
            'font-weight': ArcaneTypography.weightSemibold,
            'color': selected ? ArcaneColors.accent : ArcaneColors.onSurface,
            'text-align': 'center',
          }),
          [text(name)],
        ),

        // Subtitle
        if (subtitle != null)
          div(
            styles: Styles(raw: {
              'font-size': ArcaneTypography.fontXs,
              'color': ArcaneColors.muted,
            }),
            [text(subtitle!)],
          ),

        // Popular indicator
        if (popular && badge == null)
          div(
            styles: Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': ArcaneSpacing.xs,
              'font-size': ArcaneTypography.fontXs,
              'color': ArcaneColors.warning,
            }),
            [text('Popular')],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-game-tile:hover').styles(raw: {
      'border-color': ArcaneColors.accent,
      'box-shadow': ArcaneEffects.shadowMd,
    }),
    css('.arcane-game-tile:focus').styles(raw: {
      'outline': 'none',
      'border-color': ArcaneColors.accent,
      'box-shadow': '0 0 0 2px ${ArcaneColors.accentContainer}',
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
        'gap': ArcaneSpacing.xl,
      }),
      [
        if (title != null || description != null)
          div(
            styles: Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'gap': ArcaneSpacing.sm,
            }),
            [
              if (title != null)
                div(
                  styles: Styles(raw: {
                    'font-size': ArcaneTypography.fontXl,
                    'font-weight': ArcaneTypography.weightSemibold,
                    'color': ArcaneColors.onSurface,
                  }),
                  [text(title!)],
                ),
              if (description != null)
                div(
                  styles: Styles(raw: {
                    'font-size': ArcaneTypography.fontSm,
                    'color': ArcaneColors.muted,
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
        'background-color': ArcaneColors.surface,
        'border': '1px solid ${ArcaneColors.border}',
        'border-radius': ArcaneRadius.md,
        'overflow': 'hidden',
        'transition': ArcaneEffects.transitionFast,
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
            'background-color': ArcaneColors.surfaceVariant,
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
                'background': 'linear-gradient(to top, ${ArcaneColors.surface} 0%, transparent 100%)',
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
                    'background-color': ArcaneColors.surface,
                    'border': '2px solid ${ArcaneColors.border}',
                    'border-radius': ArcaneRadius.md,
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
                          'font-size': ArcaneTypography.fontLg,
                          'color': ArcaneColors.muted,
                          'font-weight': ArcaneTypography.weightBold,
                        }),
                        [text(name.isNotEmpty ? name[0].toUpperCase() : '?')],
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
            'padding': '${ArcaneSpacing.xxl} ${ArcaneSpacing.lg} ${ArcaneSpacing.lg}',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': ArcaneSpacing.md,
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
                    'font-size': ArcaneTypography.fontLg,
                    'font-weight': ArcaneTypography.weightSemibold,
                    'color': ArcaneColors.onSurface,
                  }),
                  [text(name)],
                ),
                if (status != null)
                  span(
                    styles: Styles(raw: {
                      'font-size': ArcaneTypography.fontXs,
                      'color': ArcaneColors.success,
                    }),
                    [text(status!)],
                  ),
              ],
            ),

            // Description
            if (description != null)
              div(
                styles: Styles(raw: {
                  'font-size': ArcaneTypography.fontSm,
                  'line-height': ArcaneTypography.leadingNormal,
                  'color': ArcaneColors.muted,
                }),
                [text(description!)],
              ),

            // Features
            if (features != null && features!.isNotEmpty)
              div(
                styles: Styles(raw: {
                  'display': 'flex',
                  'flex-wrap': 'wrap',
                  'gap': ArcaneSpacing.sm,
                  'margin-top': ArcaneSpacing.xs,
                }),
                [
                  for (final feature in features!)
                    span(
                      styles: Styles(raw: {
                        'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
                        'font-size': ArcaneTypography.fontXs,
                        'color': ArcaneColors.muted,
                        'background-color': ArcaneColors.surfaceVariant,
                        'border-radius': ArcaneRadius.sm,
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
                  'margin-top': ArcaneSpacing.sm,
                  'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.lg}',
                  'font-size': ArcaneTypography.fontSm,
                  'font-weight': ArcaneTypography.weightMedium,
                  'color': ArcaneColors.accentForeground,
                  'background-color': ArcaneColors.accent,
                  'border': 'none',
                  'border-radius': ArcaneRadius.md,
                  'cursor': 'pointer',
                  'transition': ArcaneEffects.transitionFast,
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
      'border-color': ArcaneColors.accent,
      'box-shadow': ArcaneEffects.shadowMd,
    }),
  ];
}
