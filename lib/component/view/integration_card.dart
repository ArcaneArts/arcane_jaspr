import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';

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
    final content = div(
      classes: 'arcane-integration-card ${featured ? 'featured' : ''}',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '16px',
        'padding': '24px',
        'background-color': 'var(--arcane-surface)',
        'border': '1px solid ${featured ? 'var(--arcane-accent)' : 'var(--arcane-border)'}',
        'border-radius': 'var(--arcane-radius)',
        'transition': 'border-color var(--arcane-transition-fast), box-shadow var(--arcane-transition-fast)',
        'cursor': (href != null || onTap != null) ? 'pointer' : 'default',
      }),
      [
        // Header with logo and category
        div(
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'flex-start',
            'justify-content': 'space-between',
          }),
          [
            // Logo
            div(
              classes: 'arcane-integration-logo',
              styles: Styles(raw: {
                'width': '48px',
                'height': '48px',
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'background-color': 'var(--arcane-surface-variant)',
                'border-radius': 'var(--arcane-radius)',
                'overflow': 'hidden',
              }),
              [
                if (logo != null)
                  logo!
                else if (logoUrl != null)
                  img(
                    src: logoUrl!,
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
                      'font-weight': '600',
                      'color': 'var(--arcane-muted)',
                    }),
                    [text(name.substring(0, 1).toUpperCase())],
                  ),
              ],
            ),

            // Category badge
            if (category != null)
              span(
                styles: Styles(raw: {
                  'padding': '4px 8px',
                  'font-size': '0.6875rem',
                  'font-weight': '500',
                  'text-transform': 'uppercase',
                  'letter-spacing': '0.05em',
                  'color': 'var(--arcane-muted)',
                  'background-color': 'var(--arcane-surface-variant)',
                  'border-radius': 'var(--arcane-radius-full)',
                }),
                [text(category!)],
              ),
          ],
        ),

        // Content
        div(
          styles: Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '8px',
          }),
          [
            // Name
            div(
              styles: Styles(raw: {
                'font-size': '1rem',
                'font-weight': '600',
                'color': 'var(--arcane-on-surface)',
              }),
              [text(name)],
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
          ],
        ),

        // Learn more link
        if (href != null || onTap != null)
          div(
            styles: Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '4px',
              'margin-top': 'auto',
              'font-size': '0.875rem',
              'font-weight': '500',
              'color': 'var(--arcane-accent)',
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
        styles: Styles(raw: {
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
      'border-color': 'var(--arcane-accent)',
      'box-shadow': 'var(--arcane-shadow-md)',
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
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '32px',
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
                    'font-size': '1.5rem',
                    'font-weight': '600',
                    'color': 'var(--arcane-on-surface)',
                  }),
                  [text(title!)],
                ),
              if (description != null)
                div(
                  styles: Styles(raw: {
                    'font-size': '1rem',
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
          integrations,
        ),
      ],
    );
  }
}
