import 'package:jaspr/jaspr.dart';

import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';

/// Testimonial card component properties.
class TestimonialCardProps {
  final String quote;
  final String authorName;
  final String? authorTitle;
  final String? authorCompany;
  final String? avatarUrl;
  final int? rating;
  final bool showQuotes;

  /// Whether to show the rating badge (e.g., "5/5") next to stars.
  final bool showRatingBadge;

  /// Whether to show a uniform colored border based on rating.
  final bool showAccentBorder;

  /// Custom accent color override (CSS color value).
  /// If null and rating is provided, color is derived from rating.
  final String? accentColor;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const TestimonialCardProps({
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
  });

  /// Returns the accent color based on rating (5=green, 4=cyan, 3=yellow, 2=orange, 1=red).
  /// Returns primary color if no rating or custom accent color is provided.
  String get effectiveAccentColor {
    if (accentColor != null) return accentColor!;
    if (rating == null) return 'var(--primary)';
    return switch (rating!) {
      5 => 'var(--success, #22c55e)',
      4 => 'var(--info, #06b6d4)',
      3 => 'var(--warning, #eab308)',
      2 => 'var(--orange, #f97316)',
      _ => 'var(--destructive, #ef4444)',
    };
  }
}

/// Simple rating stars component properties.
class RatingStarsSimpleProps {
  final double rating;
  final int maxStars;
  final double size;
  final bool interactive;
  final void Function(int)? onRatingChanged;

  const RatingStarsSimpleProps({
    required this.rating,
    this.maxStars = 5,
    this.size = 16,
    this.interactive = false,
    this.onRatingChanged,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for testimonial card components.
mixin TestimonialCardRendererContract {
  Component testimonialCard(TestimonialCardProps props);
  Component ratingStarsSimple(RatingStarsSimpleProps props);
}
