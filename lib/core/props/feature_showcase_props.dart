import 'package:arcane_jaspr/flutter.dart';

/// Feature showcase item data.
class FeatureShowcaseItem {
  final Widget icon;
  final String title;
  final String description;
  final Widget? header;
  final Widget? footer;
  final void Function()? onTap;
  final String? href;

  const FeatureShowcaseItem({
    required this.icon,
    required this.title,
    required this.description,
    this.header,
    this.footer,
    this.onTap,
    this.href,
  });
}

/// Feature showcase component properties.
class FeatureShowcaseProps {
  final String title;
  final String? subtitle;
  final List<FeatureShowcaseItem> items;
  final double expandedFlex;
  final double collapsedFlex;
  final String gap;
  final String minCardWidth;
  final bool expandOnHover;
  final String? background;
  final bool centerHeader;

  const FeatureShowcaseProps({
    required this.title,
    this.subtitle,
    required this.items,
    this.expandedFlex = 2.5,
    this.collapsedFlex = 1.0,
    this.gap = '1.5rem',
    this.minCardWidth = '280px',
    this.expandOnHover = true,
    this.background,
    this.centerHeader = true,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for feature showcase components.
mixin FeatureShowcaseRendererContract {
  Widget featureShowcase(FeatureShowcaseProps props);
}
