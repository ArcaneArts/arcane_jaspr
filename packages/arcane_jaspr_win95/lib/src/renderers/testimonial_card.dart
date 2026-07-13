import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/rendering/base/testimonial_card_render_base.dart';

import 'decoration_styles.dart';

/// Win95 testimonial-card renderer.
class Win95TestimonialCard extends TestimonialCardRenderBase {
  const Win95TestimonialCard(super.props, {super.key});

  @override
  String get cssClass => 'win95-testimonial-card';

  @override
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      win95DecorationStyles(decoration);
}

/// Win95 simple rating-stars renderer.
class Win95RatingStarsSimple extends RatingStarsSimpleRenderBase {
  const Win95RatingStarsSimple(super.props, {super.key});

  @override
  String get cssClass => 'win95-rating-stars';
}
