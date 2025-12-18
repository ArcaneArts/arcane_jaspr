import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';

/// A feature card component (Supabase-style)
/// Used for showcasing product features with icon, title, and description
class FeatureCard extends StatelessComponent {
  /// The feature title
  final String title;

  /// The feature description
  final String description;

  /// Optional icon component
  final Component? icon;

  /// Optional link URL
  final String? href;

  /// Click handler (alternative to href)
  final void Function()? onTap;

  /// Whether to show an arrow indicator
  final bool showArrow;

  /// Card orientation (vertical or horizontal)
  final bool horizontal;

  const FeatureCard({
    required this.title,
    required this.description,
    this.icon,
    this.href,
    this.onTap,
    this.showArrow = false,
    this.horizontal = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final isClickable = href != null || onTap != null;

    final content = [
      // Icon
      if (icon != null)
        div(
          classes: 'arcane-feature-card-icon',
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'width': '48px',
            'height': '48px',
            'border-radius': 'var(--arcane-radius)',
            'background-color': 'var(--arcane-accent-container)',
            'color': 'var(--arcane-accent)',
            'flex-shrink': '0',
            if (!horizontal) 'margin-bottom': '16px',
          }),
          [icon!],
        ),

      // Content
      div(
        classes: 'arcane-feature-card-content',
        styles: Styles(raw: {
          'flex': '1',
        }),
        [
          // Title with optional arrow
          div(
            classes: 'arcane-feature-card-title',
            styles: Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '8px',
              'font-size': '1.125rem',
              'font-weight': '600',
              'color': 'var(--arcane-on-surface)',
              'margin-bottom': '8px',
            }),
            [
              text(title),
              if (showArrow && isClickable)
                span(
                  classes: 'arcane-feature-card-arrow',
                  styles: Styles(raw: {
                    'transition': 'transform var(--arcane-transition-fast)',
                  }),
                  [text('→')],
                ),
            ],
          ),

          // Description
          p(
            classes: 'arcane-feature-card-description',
            styles: Styles(raw: {
              'font-size': '0.9375rem',
              'line-height': '1.6',
              'color': 'var(--arcane-muted)',
              'margin': '0',
            }),
            [text(description)],
          ),
        ],
      ),
    ];

    final cardStyles = <String, String>{
      'display': 'flex',
      'flex-direction': horizontal ? 'row' : 'column',
      'gap': horizontal ? '16px' : '0',
      'padding': '24px',
      'background-color': 'var(--arcane-card)',
      'border': '1px solid var(--arcane-border)',
      'border-radius': 'var(--arcane-radius-lg)',
      'transition': 'var(--arcane-transition)',
      if (isClickable) 'cursor': 'pointer',
    };

    if (href != null) {
      return a(
        classes: 'arcane-feature-card',
        href: href!,
        styles: Styles(raw: {
          ...cardStyles,
          'text-decoration': 'none',
          'color': 'inherit',
        }),
        content,
      );
    }

    if (onTap != null) {
      return button(
        classes: 'arcane-feature-card',
        attributes: {'type': 'button'},
        styles: Styles(raw: {
          ...cardStyles,
          'text-align': 'left',
        }),
        events: {'click': (e) => onTap!()},
        content,
      );
    }

    return div(
      classes: 'arcane-feature-card',
      styles: Styles(raw: cardStyles),
      content,
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-feature-card:hover').styles(raw: {
      'border-color': 'var(--arcane-accent)',
    }),
    css('.arcane-feature-card:hover .arcane-feature-card-arrow').styles(raw: {
      'transform': 'translateX(4px)',
    }),
  ];
}

/// A simple icon card for feature grids
class IconCard extends StatelessComponent {
  /// The card title
  final String title;

  /// Optional subtitle
  final String? subtitle;

  /// Icon component
  final Component icon;

  /// Click handler
  final void Function()? onTap;

  /// Optional link
  final String? href;

  const IconCard({
    required this.title,
    required this.icon,
    this.subtitle,
    this.onTap,
    this.href,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final isClickable = href != null || onTap != null;

    final content = [
      div(
        classes: 'arcane-icon-card-icon',
        styles: Styles(raw: {
          'display': 'flex',
          'align-items': 'center',
          'justify-content': 'center',
          'width': '40px',
          'height': '40px',
          'border-radius': 'var(--arcane-radius)',
          'background-color': 'var(--arcane-surface-variant)',
          'color': 'var(--arcane-accent)',
          'margin-bottom': '12px',
        }),
        [icon],
      ),
      span(
        classes: 'arcane-icon-card-title',
        styles: Styles(raw: {
          'font-size': '0.9375rem',
          'font-weight': '500',
          'color': 'var(--arcane-on-surface)',
        }),
        [text(title)],
      ),
      if (subtitle != null)
        span(
          classes: 'arcane-icon-card-subtitle',
          styles: Styles(raw: {
            'font-size': '0.8125rem',
            'color': 'var(--arcane-muted)',
            'margin-top': '4px',
          }),
          [text(subtitle!)],
        ),
    ];

    final cardStyles = <String, String>{
      'display': 'flex',
      'flex-direction': 'column',
      'align-items': 'center',
      'text-align': 'center',
      'padding': '20px',
      'background-color': 'var(--arcane-card)',
      'border': '1px solid var(--arcane-border)',
      'border-radius': 'var(--arcane-radius)',
      'transition': 'var(--arcane-transition)',
      if (isClickable) 'cursor': 'pointer',
    };

    if (href != null) {
      return a(
        classes: 'arcane-icon-card',
        href: href!,
        styles: Styles(raw: {
          ...cardStyles,
          'text-decoration': 'none',
          'color': 'inherit',
        }),
        content,
      );
    }

    if (onTap != null) {
      return button(
        classes: 'arcane-icon-card',
        attributes: {'type': 'button'},
        styles: Styles(raw: cardStyles),
        events: {'click': (e) => onTap!()},
        content,
      );
    }

    return div(
      classes: 'arcane-icon-card',
      styles: Styles(raw: cardStyles),
      content,
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-icon-card:hover').styles(raw: {
      'border-color': 'var(--arcane-accent)',
      'background-color': 'var(--arcane-surface-variant)',
    }),
  ];
}
