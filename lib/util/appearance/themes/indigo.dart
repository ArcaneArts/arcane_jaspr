import '../swatch.dart';
import '../theme_schema.dart';

/// Indigo theme preset
///
/// A deep, sophisticated theme using Tailwind's indigo color palette.
/// Great for creative, tech, or premium applications.
class IndigoThemeSchema extends ThemeSchema {
  const IndigoThemeSchema();

  @override
  String get id => 'indigo';

  @override
  String get name => 'Indigo';

  @override
  ColorSwatch get accentSwatch => Swatches.indigo;

  @override
  ColorSwatch get neutralSwatch => Swatches.zinc;
}
