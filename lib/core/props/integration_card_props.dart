import 'package:arcane_jaspr/flutter.dart';

/// Integration card component properties.
class IntegrationCardProps {
  final String name;
  final String? description;
  final String? logoUrl;
  final Widget? logo;
  final String? href;
  final void Function()? onTap;
  final String? category;
  final bool featured;

  const IntegrationCardProps({
    required this.name,
    this.description,
    this.logoUrl,
    this.logo,
    this.href,
    this.onTap,
    this.category,
    this.featured = false,
  });
}

/// Integration grid component properties.
class IntegrationGridProps {
  final List<IntegrationCardProps> integrations;
  final int columns;
  final double gap;
  final String? title;
  final String? description;

  const IntegrationGridProps({
    required this.integrations,
    this.columns = 3,
    this.gap = 24,
    this.title,
    this.description,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for integration card components.
mixin IntegrationCardRendererContract {
  Widget integrationCard(IntegrationCardProps props);
  Widget integrationGrid(IntegrationGridProps props);
}
