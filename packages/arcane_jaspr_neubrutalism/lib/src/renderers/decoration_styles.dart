import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';

/// Translates an [ArcaneDecoration] into neubrutalism CSS.
///
/// Neubrutalism renders elevation as a hard offset block via the `--nb-shadow-*`
/// tokens (`Npx Npx 0 0 var(--nb-shadow-color)`). `shadowColor` recolors that
/// shadow for this element only: every `--nb-shadow-*` token reads
/// `var(--nb-shadow-color)`, so overriding that custom property inline retints
/// the offset shadow without touching the `box-shadow` declaration.
///
/// Caveat: `.neubrutalism-card` pins `box-shadow: var(--nb-shadow-md) !important`
/// in the theme stylesheet, so an inline elevation *change* is overridden there
/// (recolor still applies, because it feeds the variable the !important rule
/// reads). Surfaces whose shadow is set inline (buttons, etc.) accept both.
Map<String, String> neubrutalismDecorationStyles(ArcaneDecoration? decoration) {
  if (decoration == null) return const <String, String>{};
  final String? shadowColor = decoration.shadowColor;
  return <String, String>{
    if (decoration.elevation != null)
      'box-shadow': _nbElevation(decoration.elevation!, shadowColor),
    if (shadowColor != null) '--nb-shadow-color': shadowColor,
  };
}

// The offset color is baked directly into the box-shadow string rather than
// left to `var(--nb-shadow-color)`: that custom property is resolved at the
// theme root before inheritance, so an inline override on a descendant would
// not retint a `var()`-based shadow. Baking the literal color makes the
// per-instance recolor actually take effect (given the element opts out of the
// theme's `!important` box-shadow reset — see decorated-instance handling).
String _nbElevation(Elevation elevation, String? shadowColor) {
  final String color = shadowColor ?? 'var(--nb-shadow-color, #000)';
  return switch (elevation) {
    Elevation.none => 'none',
    Elevation.xs => '2px 2px 0 0 $color',
    Elevation.sm => '3px 3px 0 0 $color',
    Elevation.md => '5px 5px 0 0 $color',
    Elevation.lg => '7px 7px 0 0 $color',
    Elevation.xl => '10px 10px 0 0 $color',
  };
}
