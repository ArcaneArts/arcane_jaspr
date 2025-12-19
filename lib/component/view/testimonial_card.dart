import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

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
        'padding': ArcaneSpacing.xl,
        'background-color': ArcaneColors.card,
        'border': '1px solid ${ArcaneColors.border}',
        'border-radius': ArcaneRadius.xl,
      }),
      [
        // Rating stars
        if (rating != null)
          div(
            classes: 'arcane-testimonial-rating',
            styles: Styles(raw: {
              'display': 'flex',
              'gap': '2px',
              'margin-bottom': ArcaneSpacing.lg,
            }),
            [
              for (var i = 0; i < 5; i++)
                span(
                  styles: Styles(raw: {
                    'font-size': ArcaneTypography.fontMd,
                    'color': i < rating!
                        ? ArcaneColors.warning
                        : ArcaneColors.muted,
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
            'font-size': ArcaneTypography.fontMd,
            'line-height': ArcaneTypography.leadingRelaxed,
            'color': ArcaneColors.onSurface,
            'margin-bottom': ArcaneSpacing.lg,
            'flex': '1',
          }),
          [
            if (showQuotes)
              span(
                styles: Styles(raw: {
                  'position': 'absolute',
                  'top': '-8px',
                  'left': '-4px',
                  'font-size': ArcaneTypography.font4xl,
                  'color': ArcaneColors.accent,
                  'opacity': '0.3',
                  'font-family': 'Georgia, serif',
                  'line-height': '1',
                }),
                [text('"')],
              ),
            p(
              styles: Styles(raw: {
                'margin': '0',
                if (showQuotes) 'padding-left': ArcaneSpacing.lg,
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
            'gap': ArcaneSpacing.md,
          }),
          [
            // Avatar
            if (avatarUrl != null)
              div(
                classes: 'arcane-testimonial-avatar',
                styles: Styles(raw: {
                  'width': '44px',
                  'height': '44px',
                  'border-radius': ArcaneRadius.full,
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
                  'border-radius': ArcaneRadius.full,
                  'background-color': ArcaneColors.accentContainer,
                  'color': ArcaneColors.accent,
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'font-weight': ArcaneTypography.weightSemibold,
                  'font-size': ArcaneTypography.fontMd,
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
                    'font-weight': ArcaneTypography.weightSemibold,
                    'font-size': ArcaneTypography.fontMd,
                    'color': ArcaneColors.onSurface,
                  }),
                  [text(authorName)],
                ),
                if (authorTitle != null || authorCompany != null)
                  div(
                    styles: Styles(raw: {
                      'font-size': ArcaneTypography.fontSm,
                      'color': ArcaneColors.muted,
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
                  ? ArcaneColors.warning
                  : ArcaneColors.muted,
              if (interactive) 'cursor': 'pointer',
              'transition': ArcaneEffects.transitionFast,
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
