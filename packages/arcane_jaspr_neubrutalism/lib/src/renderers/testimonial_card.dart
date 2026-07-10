import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/rendering/base/testimonial_card_render_base.dart';

import 'decoration_styles.dart';

/// Neubrutalism testimonial-card renderer.
class NeubrutalismTestimonialCard extends TestimonialCardRenderBase {
  const NeubrutalismTestimonialCard(super.props, {super.key});

  @override
  String get cssClass => 'neubrutalism-testimonial-card';

  @override
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      neubrutalismDecorationStyles(decoration);
}

/// Neubrutalism simple rating-stars renderer.
class NeubrutalismRatingStarsSimple extends RatingStarsSimpleRenderBase {
  const NeubrutalismRatingStarsSimple(super.props, {super.key});

  @override
  String get cssClass => 'neubrutalism-rating-stars';
}
