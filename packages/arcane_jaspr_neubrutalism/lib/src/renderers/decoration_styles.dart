import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';

/// Translates an [ArcaneDecoration] into neubrutalism CSS.
///
/// Neubrutalism renders elevation as a neutral hard offset block. Shadow color
/// is owned by the stylesheet and cannot be changed per instance.
Map<String, String> neubrutalismDecorationStyles(ArcaneDecoration? decoration) {
  if (decoration == null) return const <String, String>{};
  return <String, String>{
    if (decoration.elevation != null)
      'box-shadow': _nbElevation(decoration.elevation!),
  };
}

String _nbElevation(Elevation elevation) {
  const String color = 'var(--nb-shadow-color, #000)';
  return switch (elevation) {
    Elevation.none => 'none',
    Elevation.xs => '2px 2px 0 0 $color',
    Elevation.sm => '3px 3px 0 0 $color',
    Elevation.md => '5px 5px 0 0 $color',
    Elevation.lg => '7px 7px 0 0 $color',
    Elevation.xl => '10px 10px 0 0 $color',
  };
}
