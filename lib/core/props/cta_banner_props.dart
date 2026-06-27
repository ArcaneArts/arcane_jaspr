import 'package:arcane_jaspr/flutter.dart';

/// CTA banner component properties.
class CtaBannerProps {
  final String title;
  final String? subtitle;
  final Widget? primaryAction;
  final Widget? secondaryAction;
  final String? gradientStart;
  final String? gradientEnd;
  final String? backgroundImage;

  const CtaBannerProps({
    required this.title,
    this.subtitle,
    this.primaryAction,
    this.secondaryAction,
    this.gradientStart,
    this.gradientEnd,
    this.backgroundImage,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for CTA banner components.
mixin CtaBannerRendererContract {
  Widget ctaBanner(CtaBannerProps props);
}
