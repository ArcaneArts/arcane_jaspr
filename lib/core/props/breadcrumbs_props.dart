import 'package:arcane_jaspr/flutter.dart';

import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';

/// Breadcrumb item data.
class BreadcrumbItemProps {
  final String label;
  final String? href;
  final Widget? icon;

  const BreadcrumbItemProps({
    required this.label,
    this.href,
    this.icon,
  });
}

enum BreadcrumbSeparatorStyle {
  slash,
  chevron,
  arrow,
  dot,
}

enum BreadcrumbSizeVariant {
  sm,
  md,
  lg,
}

/// Breadcrumbs component properties.
class BreadcrumbsProps {
  final List<BreadcrumbItemProps> items;
  final BreadcrumbSeparatorStyle separator;
  final BreadcrumbSizeVariant size;
  final bool showHomeIcon;
  final Widget? customSeparator;
  final void Function(BreadcrumbItemProps item, int index)? onItemClick;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const BreadcrumbsProps({
    required this.items,
    this.separator = BreadcrumbSeparatorStyle.chevron,
    this.size = BreadcrumbSizeVariant.md,
    this.showHomeIcon = false,
    this.customSeparator,
    this.onItemClick,
    this.styles,
    this.decoration,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for breadcrumb components.
mixin BreadcrumbsRendererContract {
  /// Renders a breadcrumb navigation trail.
  Widget breadcrumbs(BreadcrumbsProps props);
}
