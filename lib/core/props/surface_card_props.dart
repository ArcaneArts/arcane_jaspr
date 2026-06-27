import 'package:arcane_jaspr/flutter.dart';

enum SurfaceEffect {
  none,
  blur,
  frosted,
  gradient,
  glass,
  ice,
}

enum SurfaceShadow {
  none,
  sm,
  md,
  lg,
  xl,
}

/// Surface card component properties.
class SurfaceCardProps {
  final Widget child;
  final SurfaceEffect effect;
  final double blurAmount;
  final double backgroundOpacity;
  final String? backgroundColor;
  final List<String>? gradientColors;
  final int gradientAngle;
  final String? borderRadius;
  final bool showBorder;
  final String? padding;
  final SurfaceShadow shadow;

  const SurfaceCardProps({
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
    this.shadow = SurfaceShadow.md,
  });
}

/// ThumbHash card component properties.
class ThumbHashCardProps {
  final String hash;
  final Widget child;
  final String? borderRadius;
  final String? padding;
  final double overlayOpacity;

  const ThumbHashCardProps({
    required this.hash,
    required this.child,
    this.borderRadius,
    this.padding,
    this.overlayOpacity = 0.3,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for surface card components.
mixin SurfaceCardRendererContract {
  Widget surfaceCard(SurfaceCardProps props);
  Widget thumbHashCard(ThumbHashCardProps props);
}
