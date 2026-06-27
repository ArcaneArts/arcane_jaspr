import 'package:arcane_jaspr/flutter.dart';

/// Feature card component properties.
class FeatureCardProps {
  final String title;
  final String description;
  final Widget? icon;
  final String? href;
  final void Function()? onTap;
  final bool showArrow;
  final bool horizontal;

  /// Custom accent color for theming (CSS color value).
  /// When set, applies accent styling to icon container and gradient border.
  final String? accentColor;

  /// Custom CTA button text. Defaults to 'Learn More' or 'View Docs' for external.
  final String? ctaText;

  /// Whether the link opens in a new tab (external link).
  final bool isExternal;

  /// Whether to show CTA button at the bottom.
  final bool showCta;

  const FeatureCardProps({
    required this.title,
    required this.description,
    this.icon,
    this.href,
    this.onTap,
    this.showArrow = false,
    this.horizontal = false,
    this.accentColor,
    this.ctaText,
    this.isExternal = false,
    this.showCta = false,
  });

  /// Creates a feature card with accent color styling and CTA button.
  /// This is the style used for InfoTile-like cards.
  const FeatureCardProps.accented({
    required this.title,
    required this.description,
    required this.icon,
    required String this.accentColor,
    this.href,
    this.onTap,
    this.ctaText,
    this.isExternal = false,
  })  : showArrow = false,
        horizontal = false,
        showCta = true;
}

/// Icon card component properties.
class IconCardProps {
  final String title;
  final String? subtitle;
  final Widget icon;
  final void Function()? onTap;
  final String? href;

  const IconCardProps({
    required this.title,
    required this.icon,
    this.subtitle,
    this.onTap,
    this.href,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for feature card components.
mixin FeatureCardRendererContract {
  Widget featureCard(FeatureCardProps props);
  Widget iconCard(IconCardProps props);
}
