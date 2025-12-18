import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;
import '../../util/tools/styles.dart';

/// Skeleton loading placeholder component
class Skeleton extends StatelessComponent {
  final String width;
  final String height;
  final String borderRadius;
  final bool circle;

  const Skeleton({
    this.width = '100%',
    this.height = '20px',
    this.borderRadius = '8px',
    this.circle = false,
  });

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(raw: {
        'width': circle ? height : width,
        'height': height,
        'border-radius': circle ? '50%' : borderRadius,
        'background': 'linear-gradient(90deg, #27272A 0%, #3F3F46 50%, #27272A 100%)',
        'background-size': '200% 100%',
        'animation': 'shimmer 1.5s infinite',
      }),
      [],
    );
  }
}

/// Skeleton card placeholder
class SkeletonCard extends StatelessComponent {
  final bool showAvatar;
  final int lines;

  const SkeletonCard({
    this.showAvatar = true,
    this.lines = 3,
  });

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(raw: {
        'background': '#18181B',
        'border': '1px solid rgba(63, 63, 70, 0.5)',
        'border-radius': '16px',
        'padding': '24px',
      }),
      [
        // Header with avatar
        if (showAvatar)
          div(
            styles: Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '16px',
              'margin-bottom': '20px',
            }),
            [
              Skeleton(width: '48px', height: '48px', circle: true),
              div(
                styles: Styles(raw: {
                  'flex': '1',
                }),
                [
                  Skeleton(width: '40%', height: '16px'),
                  div(styles: Styles(raw: {'height': '8px'}), []),
                  Skeleton(width: '60%', height: '14px'),
                ],
              ),
            ],
          ),
        // Content lines
        for (var i = 0; i < lines; i++)
          div(
            styles: Styles(raw: {
              'margin-bottom': i < lines - 1 ? '12px' : '0',
            }),
            [
              Skeleton(
                width: i == lines - 1 ? '80%' : '100%',
                height: '16px',
              ),
            ],
          ),
      ],
    );
  }
}

/// Injects the shimmer animation keyframes
class SkeletonStyles extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'style',
      children: [text('''
        @keyframes shimmer {
          0% { background-position: -200% 0; }
          100% { background-position: 200% 0; }
        }
      ''')],
    );
  }
}
