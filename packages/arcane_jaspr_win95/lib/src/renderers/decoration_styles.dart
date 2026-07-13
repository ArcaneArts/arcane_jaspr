import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';

/// Translates an [ArcaneDecoration] into Win95 CSS.
///
/// Win95 renders elevation as a colored glow at higher levels (its signature
/// look) and falls back to ambient `--shadow-*` at low levels. When present,
/// `shadowColor` tints the glow for this element only.
Map<String, String> win95DecorationStyles(ArcaneDecoration? decoration) {
  final Elevation? elevation = decoration?.elevation;
  if (elevation == null) return const <String, String>{};
  return <String, String>{
    'box-shadow': _win95Elevation(elevation, decoration?.shadowColor),
  };
}

String _win95Elevation(Elevation elevation, String? shadowColor) {
  final String glow = shadowColor != null
      ? '0 0 18px $shadowColor, 0 0 36px ${_fade(shadowColor)}'
      : 'var(--win95-glow, var(--shadow-lg))';
  return switch (elevation) {
    Elevation.none => 'none',
    Elevation.xs => 'var(--shadow-xs)',
    Elevation.sm => 'var(--shadow-sm)',
    Elevation.md => 'var(--win95-glow-sm, var(--shadow-md))',
    Elevation.lg => glow,
    Elevation.xl => glow,
  };
}

String _fade(String color) => 'color-mix(in srgb, $color 30%, transparent)';
