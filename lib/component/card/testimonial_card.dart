import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/props/testimonial_card_props.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

/// A quote surface: an optional uniform accent border, a large decorative
/// quote, an optional rating row, and an author row (avatar or initials, name,
/// and a muted `title · company` line). Themed automatically by the active
/// stylesheet.
class TestimonialCard extends StatelessWidget {
  final String quote;
  final String authorName;
  final String? authorTitle;
  final String? authorCompany;
  final String? avatarUrl;
  final int? rating;
  final bool showQuotes;
  final bool showRatingBadge;
  final bool showAccentBorder;
  final String? accentColor;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const TestimonialCard({
    required this.quote,
    required this.authorName,
    this.authorTitle,
    this.authorCompany,
    this.avatarUrl,
    this.rating,
    this.showQuotes = true,
    this.showRatingBadge = false,
    this.showAccentBorder = false,
    this.accentColor,
    this.styles,
    this.decoration,
    super.key,
  });

  @override
  Widget build(BuildContext context) => context.renderers.testimonialCard(
    TestimonialCardProps(
      quote: quote,
      authorName: authorName,
      authorTitle: authorTitle,
      authorCompany: authorCompany,
      avatarUrl: avatarUrl,
      rating: rating,
      showQuotes: showQuotes,
      showRatingBadge: showRatingBadge,
      showAccentBorder: showAccentBorder,
      accentColor: accentColor,
      styles: styles,
      decoration: decoration,
    ),
  );
}

/// A simple row of text rating stars (★/☆), sized by [size] and colored with
/// the palette's warning token. When [interactive], each star click reports its
/// 1-based position via [onRatingChanged].
class RatingStars extends StatelessWidget {
  final double rating;
  final int maxStars;
  final double size;
  final bool interactive;
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
  Widget build(BuildContext context) => context.renderers.ratingStarsSimple(
    RatingStarsSimpleProps(
      rating: rating,
      maxStars: maxStars,
      size: size,
      interactive: interactive,
      onRatingChanged: onRatingChanged,
    ),
  );
}
