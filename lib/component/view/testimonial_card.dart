import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/tools/styles.dart';

/// A testimonial/quote card component (Supabase-style)
class TestimonialCard extends StatelessComponent {
  /// The testimonial quote text
  final String quote;

  /// Author name
  final String authorName;

  /// Author title/role
  final String? authorTitle;

  /// Author company
  final String? authorCompany;

  /// Author avatar URL
  final String? avatarUrl;

  /// Star rating (0-5, null to hide)
  final int? rating;

  /// Whether to show quotation marks
  final bool showQuotes;

  const TestimonialCard({
    required this.quote,
    required this.authorName,
    this.authorTitle,
    this.authorCompany,
    this.avatarUrl,
    this.rating,
    this.showQuotes = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-testimonial-card',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'padding': '24px',
        'background-color': 'var(--arcane-card)',
        'border': '1px solid var(--arcane-border)',
        'border-radius': 'var(--arcane-radius-lg)',
      }),
      [
        // Rating stars
        if (rating != null)
          div(
            classes: 'arcane-testimonial-rating',
            styles: Styles(raw: {
              'display': 'flex',
              'gap': '2px',
              'margin-bottom': '16px',
            }),
            [
              for (var i = 0; i < 5; i++)
                span(
                  styles: Styles(raw: {
                    'font-size': '1rem',
                    'color': i < rating!
                        ? 'var(--arcane-warning)'
                        : 'var(--arcane-muted)',
                  }),
                  [text('★')],
                ),
            ],
          ),

        // Quote
        div(
          classes: 'arcane-testimonial-quote',
          styles: Styles(raw: {
            'position': 'relative',
            'font-size': '1rem',
            'line-height': '1.7',
            'color': 'var(--arcane-on-surface)',
            'margin-bottom': '20px',
            'flex': '1',
          }),
          [
            if (showQuotes)
              span(
                styles: Styles(raw: {
                  'position': 'absolute',
                  'top': '-8px',
                  'left': '-4px',
                  'font-size': '3rem',
                  'color': 'var(--arcane-accent)',
                  'opacity': '0.3',
                  'font-family': 'Georgia, serif',
                  'line-height': '1',
                }),
                [text('"')],
              ),
            p(
              styles: Styles(raw: {
                'margin': '0',
                if (showQuotes) 'padding-left': '16px',
              }),
              [text(quote)],
            ),
          ],
        ),

        // Author
        div(
          classes: 'arcane-testimonial-author',
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '12px',
          }),
          [
            // Avatar
            if (avatarUrl != null)
              div(
                classes: 'arcane-testimonial-avatar',
                styles: Styles(raw: {
                  'width': '44px',
                  'height': '44px',
                  'border-radius': '50%',
                  'overflow': 'hidden',
                  'flex-shrink': '0',
                }),
                [
                  img(
                    src: avatarUrl!,
                    alt: authorName,
                    styles: Styles(raw: {
                      'width': '100%',
                      'height': '100%',
                      'object-fit': 'cover',
                    }),
                  ),
                ],
              )
            else
              div(
                classes: 'arcane-testimonial-avatar-placeholder',
                styles: Styles(raw: {
                  'width': '44px',
                  'height': '44px',
                  'border-radius': '50%',
                  'background-color': 'var(--arcane-accent-container)',
                  'color': 'var(--arcane-accent)',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'font-weight': '600',
                  'font-size': '1rem',
                  'flex-shrink': '0',
                }),
                [text(authorName[0].toUpperCase())],
              ),

            // Author info
            div(
              classes: 'arcane-testimonial-author-info',
              [
                div(
                  styles: Styles(raw: {
                    'font-weight': '600',
                    'font-size': '0.9375rem',
                    'color': 'var(--arcane-on-surface)',
                  }),
                  [text(authorName)],
                ),
                if (authorTitle != null || authorCompany != null)
                  div(
                    styles: Styles(raw: {
                      'font-size': '0.8125rem',
                      'color': 'var(--arcane-muted)',
                      'margin-top': '2px',
                    }),
                    [
                      text([
                        if (authorTitle != null) authorTitle,
                        if (authorTitle != null && authorCompany != null) ' at ',
                        if (authorCompany != null) authorCompany,
                      ].join()),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// An avatar component (circular image with fallback)
class Avatar extends StatelessComponent {
  /// Image URL
  final String? imageUrl;

  /// Fallback text (usually initials)
  final String? fallback;

  /// Avatar size
  final double size;

  /// Border radius (default is fully rounded)
  final String? borderRadius;

  const Avatar({
    this.imageUrl,
    this.fallback,
    this.size = 40,
    this.borderRadius,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    if (imageUrl != null) {
      return div(
        classes: 'arcane-avatar',
        styles: Styles(raw: {
          'width': '${size}px',
          'height': '${size}px',
          'border-radius': borderRadius ?? '50%',
          'overflow': 'hidden',
          'flex-shrink': '0',
        }),
        [
          img(
            src: imageUrl!,
            alt: fallback ?? '',
            styles: Styles(raw: {
              'width': '100%',
              'height': '100%',
              'object-fit': 'cover',
            }),
          ),
        ],
      );
    }

    // Fallback avatar
    return div(
      classes: 'arcane-avatar arcane-avatar-fallback',
      styles: Styles(raw: {
        'width': '${size}px',
        'height': '${size}px',
        'border-radius': borderRadius ?? '50%',
        'background-color': 'var(--arcane-accent-container)',
        'color': 'var(--arcane-accent)',
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'font-weight': '600',
        'font-size': '${size * 0.4}px',
        'flex-shrink': '0',
      }),
      [
        if (fallback != null) text(fallback!),
      ],
    );
  }
}

/// Rating stars component
class RatingStars extends StatelessComponent {
  /// Rating value (0-5)
  final double rating;

  /// Maximum stars
  final int maxStars;

  /// Star size
  final double size;

  /// Whether the rating is interactive
  final bool interactive;

  /// Callback when rating changes (for interactive mode)
  final void Function(int)? onRatingChanged;

  const RatingStars({
    required this.rating,
    this.maxStars = 5,
    this.size = 16,
    this.interactive = false,
    this.onRatingChanged,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-rating-stars',
      styles: Styles(raw: {
        'display': 'inline-flex',
        'gap': '2px',
      }),
      [
        for (var i = 0; i < maxStars; i++)
          span(
            classes: 'arcane-star ${i < rating ? 'filled' : 'empty'}',
            styles: Styles(raw: {
              'font-size': '${size}px',
              'color': i < rating
                  ? 'var(--arcane-warning)'
                  : 'var(--arcane-muted)',
              if (interactive) 'cursor': 'pointer',
              'transition': 'color var(--arcane-transition-fast)',
            }),
            events: interactive
                ? {
                    'click': (e) => onRatingChanged?.call(i + 1),
                  }
                : null,
            [text('★')],
          ),
      ],
    );
  }
}
