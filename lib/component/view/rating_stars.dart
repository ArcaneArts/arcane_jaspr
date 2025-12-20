import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Star rating display component
class ArcaneRatingStars extends StatelessComponent {
  /// Rating value (0.0 to 5.0)
  final double rating;

  /// Total number of stars
  final int totalStars;

  /// Star size
  final String size;

  /// Color when filled
  final String? filledColor;

  /// Color when empty
  final String? emptyColor;

  /// Whether to show the numeric value
  final bool showValue;

  const ArcaneRatingStars({
    required this.rating,
    this.totalStars = 5,
    this.size = '20px',
    this.filledColor,
    this.emptyColor,
    this.showValue = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final String effectiveFilledColor = filledColor ?? ArcaneColors.warning;
    final String effectiveEmptyColor = emptyColor ?? ArcaneColors.muted;

    return div(
      classes: 'arcane-rating-stars',
      styles: const Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.xs,
      }),
      [
        for (var i = 0; i < totalStars; i++) _buildStar(i, effectiveFilledColor, effectiveEmptyColor),
        if (showValue)
          span(
            styles: const Styles(raw: {
              'margin-left': ArcaneSpacing.sm,
              'color': ArcaneColors.onSurface,
              'font-weight': ArcaneTypography.weightSemibold,
              'font-size': ArcaneTypography.fontSm,
            }),
            [text(rating.toStringAsFixed(1))],
          ),
      ],
    );
  }

  Component _buildStar(int index, String filledColor, String emptyColor) {
    final double fill = rating - index;
    String color;
    if (fill >= 1) {
      color = filledColor;
    } else if (fill > 0) {
      // Partial fill - use gradient
      color = filledColor;
    } else {
      color = emptyColor;
    }

    return span(
      styles: Styles(raw: {
        'font-size': size,
        'color': color,
        'line-height': '1',
      }),
      [text('★')],
    );
  }
}