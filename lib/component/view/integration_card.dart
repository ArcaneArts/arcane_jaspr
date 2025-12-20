import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// An integration/partner card (Supabase-style)
class IntegrationCard extends StatelessComponent {
  /// Integration name
  final String name;

  /// Description
  final String? description;

  /// Logo image URL
  final String? logoUrl;

  /// Custom logo component
  final Component? logo;

  /// Link URL
  final String? href;

  /// Click handler
  final void Function()? onTap;

  /// Category/tag
  final String? category;

  /// Whether it's featured
  final bool featured;

  const IntegrationCard({
    required this.name,
    this.description,
    this.logoUrl,
    this.logo,
    this.href,
    this.onTap,
    this.category,
    this.featured = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final Component content = div(
      classes: 'arcane-integration-card ${featured ? 'featured' : ''}',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.lg,
        'padding': ArcaneSpacing.xl,
        'background-color': ArcaneColors.surface,
        'border': '1px solid ${featured ? ArcaneColors.accent : ArcaneColors.border}',
        'border-radius': ArcaneRadius.md,
        'transition': ArcaneEffects.transitionFast,
        'cursor': (href != null || onTap != null) ? 'pointer' : 'default',
      }),
      [
        // Header with logo and category
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'flex-start',
            'justify-content': 'space-between',
          }),
          [
            // Logo
            div(
              classes: 'arcane-integration-logo',
              styles: const Styles(raw: {
                'width': '48px',
                'height': '48px',
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'background-color': ArcaneColors.surfaceVariant,
                'border-radius': ArcaneRadius.md,
                'overflow': 'hidden',
              }),
              [
                if (logo != null)
                  logo!
                else if (logoUrl != null)
                  img(
                    src: logoUrl!,
                    alt: name,
                    styles: const Styles(raw: {
                      'width': '32px',
                      'height': '32px',
                      'object-fit': 'contain',
                    }),
                  )
                else
                  span(
                    styles: const Styles(raw: {
                      'font-size': ArcaneTypography.fontXl,
                      'font-weight': ArcaneTypography.weightSemibold,
                      'color': ArcaneColors.muted,
                    }),
                    [text(name.substring(0, 1).toUpperCase())],
                  ),
              ],
            ),

            // Category badge
            if (category != null)
              span(
                styles: const Styles(raw: {
                  'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
                  'font-size': ArcaneTypography.fontXs,
                  'font-weight': ArcaneTypography.weightMedium,
                  'text-transform': 'uppercase',
                  'letter-spacing': '0.05em',
                  'color': ArcaneColors.muted,
                  'background-color': ArcaneColors.surfaceVariant,
                  'border-radius': ArcaneRadius.full,
                }),
                [text(category!)],
              ),
          ],
        ),

        // Content
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'gap': ArcaneSpacing.sm,
          }),
          [
            // Name
            div(
              styles: const Styles(raw: {
                'font-size': ArcaneTypography.fontMd,
                'font-weight': ArcaneTypography.weightSemibold,
                'color': ArcaneColors.onSurface,
              }),
              [text(name)],
            ),

            // Description
            if (description != null)
              div(
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontSm,
                  'line-height': ArcaneTypography.leadingNormal,
                  'color': ArcaneColors.muted,
                }),
                [text(description!)],
              ),
          ],
        ),

        // Learn more link
        if (href != null || onTap != null)
          div(
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': ArcaneSpacing.xs,
              'margin-top': 'auto',
              'font-size': ArcaneTypography.fontSm,
              'font-weight': ArcaneTypography.weightMedium,
              'color': ArcaneColors.accent,
            }),
            [
              text('Learn more'),
              span([text('→')]),
            ],
          ),
      ],
    );

    if (href != null) {
      return a(
        href: href!,
        classes: 'arcane-integration-link',
        styles: const Styles(raw: {
          'text-decoration': 'none',
          'display': 'block',
        }),
        [content],
      );
    }

    if (onTap != null) {
      return div(
        events: {'click': (e) => onTap!()},
        [content],
      );
    }

    return content;
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-integration-card:hover').styles(raw: {
      'border-color': ArcaneColors.accent,
      'box-shadow': ArcaneEffects.shadowMd,
    }),
  ];
}

/// A grid of integration cards
class IntegrationGrid extends StatelessComponent {
  /// Integration items
  final List<IntegrationCard> integrations;

  /// Number of columns
  final int columns;

  /// Gap between cards
  final double gap;

  /// Optional title
  final String? title;

  /// Optional description
  final String? description;

  const IntegrationGrid({
    required this.integrations,
    this.columns = 3,
    this.gap = 24,
    this.title,
    this.description,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-integration-grid',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.xxl,
      }),
      [
        if (title != null || description != null)
          div(
            styles: const Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'gap': ArcaneSpacing.sm,
            }),
            [
              if (title != null)
                div(
                  styles: const Styles(raw: {
                    'font-size': ArcaneTypography.font2xl,
                    'font-weight': ArcaneTypography.weightSemibold,
                    'color': ArcaneColors.onSurface,
                  }),
                  [text(title!)],
                ),
              if (description != null)
                div(
                  styles: const Styles(raw: {
                    'font-size': ArcaneTypography.fontMd,
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
          integrations,
        ),
      ],
    );
  }
}