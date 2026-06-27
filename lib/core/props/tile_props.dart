import 'package:arcane_jaspr/flutter.dart';

/// Tile component properties.
class TileProps {
  final String? title;
  final Widget? titleWidget;
  final String? subtitle;
  final Widget? subtitleWidget;
  final Widget? leading;
  final Widget? trailing;
  final bool selected;
  final bool disabled;
  final bool dense;
  final void Function()? onTap;
  final String? padding;

  const TileProps({
    this.title,
    this.titleWidget,
    this.subtitle,
    this.subtitleWidget,
    this.leading,
    this.trailing,
    this.selected = false,
    this.disabled = false,
    this.dense = false,
    this.onTap,
    this.padding,
  });
}

/// Navigation tile component properties.
class NavTileProps {
  final String label;
  final Widget? icon;
  final bool selected;
  final bool disabled;
  final String? badge;
  final void Function()? onTap;

  const NavTileProps({
    required this.label,
    this.icon,
    this.selected = false,
    this.disabled = false,
    this.badge,
    this.onTap,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for tile components.
mixin TileRendererContract {
  Widget tile(TileProps props);
  Widget navTile(NavTileProps props);
}
