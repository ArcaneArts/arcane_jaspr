import 'package:arcane_jaspr/flutter.dart';

import '../../util/arcane.dart';

/// Carpet/surface container component properties.
class CarpetProps {
  final Widget child;
  final EdgeInsets? padding;
  final double? radius;
  final String? color;
  final bool border;

  const CarpetProps({
    required this.child,
    this.padding,
    this.radius,
    this.color,
    this.border = false,
  });
}

/// Surface component properties.
class SurfaceProps {
  final Widget child;
  final EdgeInsets? padding;
  final double? radius;
  final int elevation;
  final String? color;
  final bool border;

  const SurfaceProps({
    required this.child,
    this.padding,
    this.radius,
    this.elevation = 1,
    this.color,
    this.border = true,
  });
}

/// Arcane divider component properties.
class ArcaneDividerProps {
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final String? color;
  final bool vertical;

  const ArcaneDividerProps({
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
    this.vertical = false,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for carpet/surface components.
mixin CarpetRendererContract {
  Widget carpet(CarpetProps props);
  Widget surface(SurfaceProps props);
  Widget arcaneDivider(ArcaneDividerProps props);
}
