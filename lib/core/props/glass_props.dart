import 'package:arcane_jaspr/flutter.dart';

/// Glass container component properties.
class GlassProps {
  final Widget child;
  final double blur;
  final double opacity;
  final String? padding;
  final String? radius;
  final bool border;

  const GlassProps({
    required this.child,
    this.blur = 12.0,
    this.opacity = 0.7,
    this.padding,
    this.radius,
    this.border = true,
  });
}

/// Glass card component properties.
class GlassCardProps {
  final Widget child;
  final double blur;
  final double opacity;
  final String? padding;
  final String? radius;
  final bool border;
  final void Function()? onTap;

  const GlassCardProps({
    required this.child,
    this.blur = 12.0,
    this.opacity = 0.7,
    this.padding,
    this.radius,
    this.border = true,
    this.onTap,
  });
}

/// Gradient glass component properties.
class GradientGlassProps {
  final Widget child;
  final double blur;
  final String? gradientStart;
  final String? gradientEnd;
  final double opacity;
  final String? padding;
  final String? radius;
  final String direction;

  const GradientGlassProps({
    required this.child,
    this.blur = 12.0,
    this.gradientStart,
    this.gradientEnd,
    this.opacity = 0.2,
    this.padding,
    this.radius,
    this.direction = 'to bottom right',
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for glass components.
mixin GlassRendererContract {
  Widget glass(GlassProps props);
  Widget glassCard(GlassCardProps props);
  Widget gradientGlass(GradientGlassProps props);
}
