import 'package:arcane_jaspr/flutter.dart';

import '../../component/view/map/map_data.dart';
import '../../component/view/map/map_style.dart';

export '../../component/view/map/map_data.dart';
export '../../component/view/map/map_style.dart';

/// Region configuration for map section grouping and coloring.
///
/// Not to be confused with [MapRegion] from `map_data.dart` which
/// represents SVG path data for rendering states/countries.
class MapRegionConfig {
  /// Display name of the region.
  final String name;

  /// CSS color for region markers and accents.
  final String color;

  const MapRegionConfig({
    required this.name,
    required this.color,
  });
}

/// Map section component properties.
class MapSectionProps {
  /// Section title (e.g., "Global Coverage").
  final String title;

  /// Optional subtitle/description.
  final String? subtitle;

  /// Location data to display on the map.
  final List<MapLocation> locations;

  /// Region configurations for grouping and coloring.
  /// Keys should match `MapLocation.region` values.
  final Map<String, MapRegionConfig> regions;

  /// Map style configuration.
  final MapStyle mapStyle;

  /// Whether to show the location list panel.
  final bool showLocationPanel;

  /// Location panel title (default: "Server Locations").
  final String locationPanelTitle;

  /// Whether to show tabs for different map types (World, USA, etc.).
  final bool showMapTabs;

  /// Custom tooltip builder for location pins.
  final Widget Function(MapLocation)? tooltipBuilder;

  /// Callback when a location is selected.
  final void Function(MapLocation)? onLocationSelect;

  /// Height of the map container (CSS value).
  final String height;

  const MapSectionProps({
    required this.title,
    this.subtitle,
    required this.locations,
    this.regions = const {},
    this.mapStyle = const MapStyle(),
    this.showLocationPanel = true,
    this.locationPanelTitle = 'Server Locations',
    this.showMapTabs = true,
    this.tooltipBuilder,
    this.onLocationSelect,
    this.height = '520px',
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for map section components.
mixin MapSectionRendererContract {
  Widget mapSection(MapSectionProps props);
}
