import 'package:arcane_jaspr/flutter.dart';

import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';

/// Stat card component properties.
class StatCardProps {
  final String label;
  final String value;
  final String? icon;
  final String? trend;
  final bool trendPositive;
  final String? description;
  final String? iconBackground;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const StatCardProps({
    required this.label,
    required this.value,
    this.icon,
    this.trend,
    this.trendPositive = true,
    this.description,
    this.iconBackground,
    this.styles,
    this.decoration,
  });
}

/// Stat card row component properties.
class StatCardRowProps {
  final List<Widget> cards;
  final int columns;
  final String? gap;

  const StatCardRowProps({
    required this.cards,
    this.columns = 4,
    this.gap,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for stat card components.
mixin StatCardRendererContract {
  Widget statCard(StatCardProps props);
  Widget statCardRow(StatCardRowProps props);
}
