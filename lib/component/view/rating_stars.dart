import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;
import '../../util/tools/styles.dart';

/// Star rating display component
class ArcaneRatingStars extends StatelessComponent {
  final double rating; // 0.0 to 5.0
  final int totalStars;
  final String size;
  final String filledColor;
  final String emptyColor;
  final bool showValue;

  const ArcaneRatingStars({
    required this.rating,
    this.totalStars = 5,
    this.size = '20px',
    this.filledColor = '#F59E0B',
    this.emptyColor = '#3F3F46',
    this.showValue = false,
  });

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '4px',
      }),
      [
        for (var i = 0; i < totalStars; i++) _buildStar(i),
        if (showValue)
          span(
            styles: Styles(raw: {
              'margin-left': '8px',
              'color': '#FAFAFA',
              'font-weight': '600',
              'font-size': '14px',
            }),
            [text(rating.toStringAsFixed(1))],
          ),
      ],
    );
  }

  Component _buildStar(int index) {
    final fill = rating - index;
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
