import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Skeleton loading placeholder component
class Skeleton extends StatelessComponent {
  final String? width;
  final String? height;
  final String? borderRadius;
  final bool circle;

  const Skeleton({
    this.width,
    this.height,
    this.borderRadius,
    this.circle = false,
    super.key,
  });

  /// Circle skeleton
  const Skeleton.circle({
    this.height,
    super.key,
  })  : width = null,
        borderRadius = null,
        circle = true;

  /// Text line skeleton
  const Skeleton.line({
    this.width,
    super.key,
  })  : height = null,
        borderRadius = null,
        circle = false;

  @override
  Component build(BuildContext context) {
    final effectiveWidth = circle ? (height ?? '48px') : (width ?? '100%');
    final effectiveHeight = height ?? '20px';
    final effectiveRadius = circle ? ArcaneRadius.full : (borderRadius ?? ArcaneRadius.md);

    return div(
      classes: 'arcane-skeleton',
      styles: Styles(raw: {
        'width': effectiveWidth,
        'height': effectiveHeight,
        'border-radius': effectiveRadius,
        'background': 'linear-gradient(90deg, ${ArcaneColors.surfaceVariant} 0%, ${ArcaneColors.surface} 50%, ${ArcaneColors.surfaceVariant} 100%)',
        'background-size': '200% 100%',
        'animation': 'arcane-shimmer 1.5s infinite',
      }),
      [],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('@keyframes arcane-shimmer').styles(raw: {
      '0%': 'background-position: -200% 0',
      '100%': 'background-position: 200% 0',
    }),
  ];
}

/// Skeleton card placeholder
class SkeletonCard extends StatelessComponent {
  final bool showAvatar;
  final int lines;

  const SkeletonCard({
    this.showAvatar = true,
    this.lines = 3,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-skeleton-card',
      styles: const Styles(raw: {
        'background': ArcaneColors.card,
        'border': '1px solid ${ArcaneColors.border}',
        'border-radius': ArcaneRadius.lg,
        'padding': ArcaneSpacing.lg,
      }),
      [
        // Header with avatar
        if (showAvatar)
          const div(
            styles: Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': ArcaneSpacing.md,
              'margin-bottom': ArcaneSpacing.lg,
            }),
            [
              Skeleton(width: '48px', height: '48px', circle: true),
              div(
                styles: Styles(raw: {
                  'flex': '1',
                  'display': 'flex',
                  'flex-direction': 'column',
                  'gap': ArcaneSpacing.sm,
                }),
                [
                  Skeleton(width: '40%', height: '16px'),
                  Skeleton(width: '60%', height: '14px'),
                ],
              ),
            ],
          ),
        // Content lines
        for (var i = 0; i < lines; i++)
          div(
            styles: Styles(raw: {
              if (i < lines - 1) 'margin-bottom': ArcaneSpacing.sm,
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

/// Skeleton text block with multiple lines
class SkeletonText extends StatelessComponent {
  final int lines;
  final String? lineHeight;

  const SkeletonText({
    this.lines = 3,
    this.lineHeight,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-skeleton-text',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.sm,
      }),
      [
        for (var i = 0; i < lines; i++)
          Skeleton(
            width: i == lines - 1 ? '70%' : '100%',
            height: lineHeight ?? '16px',
          ),
      ],
    );
  }
}