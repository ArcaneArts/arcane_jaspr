import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../../util/tokens/tokens.dart';

/// Surface effect types for cards
enum SurfaceEffect {
  /// No effect (plain surface)
  none,

  /// Subtle blur effect
  blur,

  /// Frosted glass effect
  frosted,

  /// Gradient overlay
  gradient,

  /// Glassmorphism effect
  glass,

  /// Ice/crystal effect
  ice,
}

/// A card with surface effects (blur, frosted glass, etc.)
///
/// ```dart
/// ArcaneSurfaceCard(
///   effect: SurfaceEffect.frosted,
///   child: CardContent(),
/// )
/// ```
class ArcaneSurfaceCard extends StatelessComponent {
  /// Card content
  final Component child;

  /// Surface effect to apply
  final SurfaceEffect effect;

  /// Blur amount (for blur-based effects)
  final double blurAmount;

  /// Background opacity (0.0 - 1.0)
  final double backgroundOpacity;

  /// Custom background color
  final String? backgroundColor;

  /// Custom gradient colors (for gradient effect)
  final List<String>? gradientColors;

  /// Gradient direction in degrees
  final int gradientAngle;

  /// Border radius
  final String? borderRadius;

  /// Whether to show border
  final bool showBorder;

  /// Padding
  final String? padding;

  /// Shadow intensity
  final ShadowIntensity shadow;

  const ArcaneSurfaceCard({
    required this.child,
    this.effect = SurfaceEffect.none,
    this.blurAmount = 10.0,
    this.backgroundOpacity = 0.8,
    this.backgroundColor,
    this.gradientColors,
    this.gradientAngle = 135,
    this.borderRadius,
    this.showBorder = true,
    this.padding,
    this.shadow = ShadowIntensity.md,
    super.key,
  });

  /// Blur effect card
  const ArcaneSurfaceCard.blur({
    required this.child,
    this.blurAmount = 10.0,
    this.backgroundOpacity = 0.8,
    this.backgroundColor,
    this.borderRadius,
    this.showBorder = true,
    this.padding,
    this.shadow = ShadowIntensity.md,
    super.key,
  })  : effect = SurfaceEffect.blur,
        gradientColors = null,
        gradientAngle = 135;

  /// Frosted glass card
  const ArcaneSurfaceCard.frosted({
    required this.child,
    this.blurAmount = 12.0,
    this.backgroundOpacity = 0.6,
    this.backgroundColor,
    this.borderRadius,
    this.showBorder = true,
    this.padding,
    this.shadow = ShadowIntensity.md,
    super.key,
  })  : effect = SurfaceEffect.frosted,
        gradientColors = null,
        gradientAngle = 135;

  /// Glass morphism card
  const ArcaneSurfaceCard.glass({
    required this.child,
    this.blurAmount = 16.0,
    this.backgroundOpacity = 0.4,
    this.backgroundColor,
    this.borderRadius,
    this.showBorder = true,
    this.padding,
    this.shadow = ShadowIntensity.lg,
    super.key,
  })  : effect = SurfaceEffect.glass,
        gradientColors = null,
        gradientAngle = 135;

  /// Gradient background card
  const ArcaneSurfaceCard.gradient({
    required this.child,
    this.gradientColors,
    this.gradientAngle = 135,
    this.borderRadius,
    this.showBorder = false,
    this.padding,
    this.shadow = ShadowIntensity.md,
    super.key,
  })  : effect = SurfaceEffect.gradient,
        blurAmount = 0,
        backgroundOpacity = 1.0,
        backgroundColor = null;

  String get _backgroundStyle {
    final effectiveBgColor = backgroundColor ?? ArcaneColors.surface;

    return switch (effect) {
      SurfaceEffect.none => effectiveBgColor,
      SurfaceEffect.blur =>
        'rgba(from $effectiveBgColor r g b / $backgroundOpacity)',
      SurfaceEffect.frosted =>
        'rgba(from $effectiveBgColor r g b / $backgroundOpacity)',
      SurfaceEffect.glass =>
        'linear-gradient(135deg, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0.05) 100%)',
      SurfaceEffect.ice =>
        'linear-gradient(135deg, rgba(200,220,255,${backgroundOpacity * 0.3}) 0%, rgba(180,200,255,${backgroundOpacity * 0.2}) 100%)',
      SurfaceEffect.gradient => gradientColors != null && gradientColors!.length >= 2
          ? 'linear-gradient(${gradientAngle}deg, ${gradientColors!.join(', ')})'
          : 'linear-gradient(${gradientAngle}deg, ${ArcaneColors.accent}, ${ArcaneColors.accentHover})',
    };
  }

  String? get _backdropFilter {
    if (effect == SurfaceEffect.none || effect == SurfaceEffect.gradient) {
      return null;
    }

    final blur = switch (effect) {
      SurfaceEffect.blur => blurAmount,
      SurfaceEffect.frosted => blurAmount * 1.2,
      SurfaceEffect.glass => blurAmount * 1.5,
      SurfaceEffect.ice => blurAmount * 0.8,
      _ => 0.0,
    };

    return 'blur(${blur}px)';
  }

  String get _shadowStyle => switch (shadow) {
        ShadowIntensity.none => 'none',
        ShadowIntensity.sm => ArcaneEffects.shadowSm,
        ShadowIntensity.md => ArcaneEffects.shadowMd,
        ShadowIntensity.lg => ArcaneEffects.shadowLg,
        ShadowIntensity.xl => ArcaneEffects.shadowXl,
      };

  @override
  Component build(BuildContext context) {
    final backdropFilter = _backdropFilter;

    return div(
      classes: 'arcane-surface-card arcane-surface-${effect.name}',
      styles: Styles(raw: {
        'background': _backgroundStyle,
        'border-radius': borderRadius ?? ArcaneRadius.lg,
        'padding': padding ?? ArcaneSpacing.lg,
        if (showBorder) 'border': '1px solid ${ArcaneColors.border}',
        'box-shadow': _shadowStyle,
        if (backdropFilter != null) 'backdrop-filter': backdropFilter,
        if (backdropFilter != null) '-webkit-backdrop-filter': backdropFilter,
        'transition': ArcaneEffects.transitionFast,
      }),
      [child],
    );
  }
}

/// Shadow intensity levels
enum ShadowIntensity {
  none,
  sm,
  md,
  lg,
  xl,
}

/// A card with a thumbhash or blurhash placeholder background.
///
/// Useful for image cards while loading or as decorative backgrounds.
///
/// Note: Actual thumbhash decoding requires JS interop or a decoder.
/// This component provides the structure for it.
///
/// ```dart
/// ArcaneThumbHashCard(
///   hash: 'H3IFHI4ri5RQpWdCen0rUPLtCQ',
///   child: CardContent(),
/// )
/// ```
class ArcaneThumbHashCard extends StatelessComponent {
  /// ThumbHash or BlurHash string
  final String hash;

  /// Card content
  final Component child;

  /// Border radius
  final String? borderRadius;

  /// Padding
  final String? padding;

  /// Overlay opacity (to darken for text readability)
  final double overlayOpacity;

  const ArcaneThumbHashCard({
    required this.hash,
    required this.child,
    this.borderRadius,
    this.padding,
    this.overlayOpacity = 0.3,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    // In a real implementation, you'd decode the thumbhash to a data URL
    // For now, we use a gradient placeholder
    return div(
      classes: 'arcane-thumbhash-card',
      attributes: {
        'data-thumbhash': hash,
      },
      styles: Styles(raw: {
        'position': 'relative',
        'border-radius': borderRadius ?? ArcaneRadius.lg,
        'overflow': 'hidden',
        // Placeholder gradient (would be replaced by decoded thumbhash)
        'background':
            'linear-gradient(135deg, ${ArcaneColors.surfaceVariant} 0%, ${ArcaneColors.surface} 100%)',
      }),
      [
        // Overlay for text readability
        if (overlayOpacity > 0)
          div(
            styles: Styles(raw: {
              'position': 'absolute',
              'inset': '0',
              'background': 'rgba(0,0,0,$overlayOpacity)',
              'pointer-events': 'none',
            }),
            [],
          ),

        // Content
        div(
          styles: Styles(raw: {
            'position': 'relative',
            'z-index': '1',
            'padding': padding ?? ArcaneSpacing.lg,
          }),
          [child],
        ),
      ],
    );
  }
}
