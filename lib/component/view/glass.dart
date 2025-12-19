import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/arcane.dart';
import '../../util/tokens/tokens.dart';

/// A glassmorphism container component.
///
/// Creates a frosted glass effect using CSS backdrop-filter.
class Glass extends StatelessComponent {
  /// The child component
  final Component child;

  /// Blur amount
  final double blur;

  /// Opacity of the glass surface
  final double opacity;

  /// Custom padding
  final EdgeInsets? padding;

  /// Border radius
  final double? radius;

  /// Whether to show a border
  final bool border;

  const Glass({
    required this.child,
    this.blur = 12.0,
    this.opacity = 0.7,
    this.padding,
    this.radius,
    this.border = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final effectiveRadius = radius != null ? '${radius}px' : ArcaneRadius.lg;

    return div(
      classes: 'arcane-glass',
      styles: Styles(raw: {
        'background-color': 'rgba(24, 24, 27, $opacity)',
        'backdrop-filter': 'blur(${blur}px)',
        '-webkit-backdrop-filter': 'blur(${blur}px)',
        'border-radius': effectiveRadius,
        if (padding != null) 'padding': padding!.padding,
        if (border) 'border': '1px solid rgba(255, 255, 255, 0.1)',
        'box-shadow': ArcaneEffects.shadowMd,
      }),
      [child],
    );
  }
}

/// A glass card with standard card styling
class GlassCard extends StatelessComponent {
  final Component child;
  final double blur;
  final double opacity;
  final EdgeInsets? padding;
  final double? radius;
  final bool border;
  final void Function()? onTap;

  const GlassCard({
    required this.child,
    this.blur = 12.0,
    this.opacity = 0.7,
    this.padding,
    this.radius,
    this.border = true,
    this.onTap,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final content = Glass(
      blur: blur,
      opacity: opacity,
      padding: padding ?? const EdgeInsets.all(16),
      radius: radius,
      border: border,
      child: child,
    );

    if (onTap != null) {
      return div(
        classes: 'arcane-glass-card clickable',
        styles: Styles(raw: {
          'cursor': 'pointer',
          'transition': ArcaneEffects.transitionFast,
        }),
        events: {
          'click': (event) => onTap!(),
        },
        [content],
      );
    } else {
      return content;
    }
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-glass-card.clickable:hover').styles(raw: {
      'transform': ArcaneEffects.hoverLift,
    }),
    css('.arcane-glass-card.clickable:active').styles(raw: {
      'transform': 'translateY(0)',
    }),
  ];
}

/// A gradient glass effect
class GradientGlass extends StatelessComponent {
  final Component child;
  final double blur;
  final String? gradientStart;
  final String? gradientEnd;
  final double opacity;
  final EdgeInsets? padding;
  final double? radius;
  final String direction;

  const GradientGlass({
    required this.child,
    this.blur = 12.0,
    this.gradientStart,
    this.gradientEnd,
    this.opacity = 0.2,
    this.padding,
    this.radius,
    this.direction = 'to bottom right',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final effectiveRadius = radius != null ? '${radius}px' : ArcaneRadius.lg;
    final start = gradientStart ?? ArcaneColors.accent;
    final end = gradientEnd ?? ArcaneColors.accentHover;

    return div(
      classes: 'arcane-gradient-glass',
      styles: Styles(raw: {
        'background': 'linear-gradient($direction, color-mix(in srgb, $start ${(opacity * 100).toInt()}%, transparent), color-mix(in srgb, $end ${(opacity * 100).toInt()}%, transparent))',
        'backdrop-filter': 'blur(${blur}px)',
        '-webkit-backdrop-filter': 'blur(${blur}px)',
        'border-radius': effectiveRadius,
        if (padding != null) 'padding': padding!.padding,
        'border': '1px solid rgba(255, 255, 255, 0.2)',
      }),
      [child],
    );
  }
}
