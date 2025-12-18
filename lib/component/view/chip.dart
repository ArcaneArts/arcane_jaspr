import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;
import '../../util/tools/styles.dart';

/// Chip/tag component for labels and filters
class ArcaneChip extends StatelessComponent {
  final String label;
  final String? icon;
  final String? color;
  final String? backgroundColor;
  final String size;
  final bool outlined;
  final bool removable;

  const ArcaneChip({
    required this.label,
    this.icon,
    this.color,
    this.backgroundColor,
    this.size = 'medium',
    this.outlined = false,
    this.removable = false,
  });

  @override
  Component build(BuildContext context) {
    final chipColor = color ?? '#10B981';
    final bgColor = backgroundColor ??
        (outlined ? 'transparent' : 'rgba(16, 185, 129, 0.15)');

    String padding;
    String fontSize;
    switch (size) {
      case 'small':
        padding = '4px 8px';
        fontSize = '11px';
        break;
      case 'large':
        padding = '8px 16px';
        fontSize = '14px';
        break;
      default:
        padding = '6px 12px';
        fontSize = '12px';
    }

    return span(
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '6px',
        'padding': padding,
        'border-radius': '999px',
        'background': bgColor,
        'border': outlined ? '1px solid $chipColor' : 'none',
        'color': chipColor,
        'font-size': fontSize,
        'font-weight': '500',
        'white-space': 'nowrap',
      }),
      [
        if (icon != null) text(icon!),
        text(label),
        if (removable)
          span(
            styles: Styles(raw: {
              'margin-left': '2px',
              'cursor': 'pointer',
              'opacity': '0.7',
            }),
            [text('×')],
          ),
      ],
    );
  }
}

/// Chip group for multiple chips
class ArcaneChipGroup extends StatelessComponent {
  final List<ArcaneChip> chips;
  final String gap;

  const ArcaneChipGroup({
    required this.chips,
    this.gap = '8px',
  });

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(raw: {
        'display': 'flex',
        'flex-wrap': 'wrap',
        'gap': gap,
      }),
      chips,
    );
  }
}
