import 'package:arcane_jaspr/flutter.dart';

/// Stat item for hero section stats row.
class HeroStatItem {
  final String value;
  final String label;

  const HeroStatItem({
    required this.value,
    required this.label,
  });
}

/// Hero section component properties.
class HeroSectionProps {
  /// Plain text headline. Use `headlineComponent` for rich content.
  final String? headline;

  /// Custom headline component (e.g., with gradient text).
  /// Takes precedence over `headline` if both are provided.
  final Widget? headlineComponent;

  final String? subheadline;
  final Widget? primaryCta;
  final Widget? secondaryCta;
  final Widget? badge;

  /// Optional promo banner component displayed above the headline.
  final Widget? promoBanner;

  final Widget? media;
  final bool centered;
  final double verticalPadding;
  final double maxWidth;

  /// Stats to display below CTAs (e.g., uptime, servers, deploy time).
  final List<HeroStatItem>? stats;

  /// Whether to show a radial gradient glow effect behind the content.
  final bool showBackgroundGlow;

  /// Custom glow color (CSS color value). Defaults to primary color with transparency.
  final String? glowColor;

  const HeroSectionProps({
    this.headline,
    this.headlineComponent,
    this.subheadline,
    this.primaryCta,
    this.secondaryCta,
    this.badge,
    this.promoBanner,
    this.media,
    this.centered = true,
    this.verticalPadding = 80,
    this.maxWidth = 800,
    this.stats,
    this.showBackgroundGlow = false,
    this.glowColor,
  }) : assert(headline != null || headlineComponent != null,
            'Either headline or headlineComponent must be provided');
}

/// CTA group component properties.
class CtaGroupProps {
  final Widget primaryCta;
  final Widget? secondaryCta;
  final bool centered;
  final double gap;

  const CtaGroupProps({
    required this.primaryCta,
    this.secondaryCta,
    this.centered = false,
    this.gap = 12,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for hero section components.
mixin HeroSectionRendererContract {
  Widget heroSection(HeroSectionProps props);
  Widget ctaGroup(CtaGroupProps props);
}
