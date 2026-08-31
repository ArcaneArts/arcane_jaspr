import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';

/// Translates an [ArcaneDecoration] into Win95 CSS.
///
/// Windows 95 has no elevation model and no blurred shadow of any kind: depth
/// is expressed exclusively by hard 1-2px bevels (raised is white/light on the
/// top-left and dark-grey/black on the bottom-right; sunken inverts that). The
/// elevation scale is therefore mapped onto the bevel recipes rather than onto
/// shadows.
Map<String, String> win95DecorationStyles(ArcaneDecoration? decoration) {
  final Elevation? elevation = decoration?.elevation;
  if (elevation == null) return const <String, String>{};
  return <String, String>{'box-shadow': _win95Elevation(elevation)};
}

String _win95Elevation(Elevation elevation) => switch (elevation) {
  Elevation.none => 'none',
  // A single-pixel frame: the Office-toolbar / list-item weight.
  Elevation.xs || Elevation.sm => 'var(--w95-raised-thin)',
  // The full two-pixel control bevel every button and panel wears.
  Elevation.md => 'var(--w95-raised)',
  // A surface meant to read as floating over the client area still gets the
  // same bevel — Win95 drew no shadow under menus or dialogs at all.
  Elevation.lg || Elevation.xl => 'var(--w95-raised)',
};
