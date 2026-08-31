import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';

/// Translates an [ArcaneDecoration]'s theme-interpreted fields into ShadCN CSS.
///
/// ShadCN renders elevation as an ambient blurred drop shadow via the palette's
/// generated neutral `--shadow-*` variables.
Map<String, String> shadcnDecorationStyles(ArcaneDecoration? decoration) {
  final Elevation? elevation = decoration?.elevation;
  if (elevation == null) return const <String, String>{};
  return <String, String>{'box-shadow': _shadcnElevation(elevation)};
}

String _shadcnElevation(Elevation elevation) => switch (elevation) {
  Elevation.none => 'none',
  Elevation.xs => 'var(--shadow-xs)',
  Elevation.sm => 'var(--shadow-sm)',
  Elevation.md => 'var(--shadow-md)',
  Elevation.lg => 'var(--shadow-lg)',
  Elevation.xl => 'var(--shadow-xl)',
};
