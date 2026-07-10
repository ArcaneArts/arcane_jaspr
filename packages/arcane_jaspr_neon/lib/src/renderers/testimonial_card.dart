import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/rendering/base/testimonial_card_render_base.dart';

import 'decoration_styles.dart';

/// Neon testimonial-card renderer.
class NeonTestimonialCard extends TestimonialCardRenderBase {
  const NeonTestimonialCard(super.props, {super.key});

  @override
  String get cssClass => 'neon-testimonial-card';

  @override
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      neonDecorationStyles(decoration);
}

/// Neon simple rating-stars renderer.
class NeonRatingStarsSimple extends RatingStarsSimpleRenderBase {
  const NeonRatingStarsSimple(super.props, {super.key});

  @override
  String get cssClass => 'neon-rating-stars';
}
