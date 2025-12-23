import '../swatch.dart';
import '../theme_schema.dart';

/// Grey theme preset
///
/// A balanced, neutral monochromatic theme using Tailwind's slate palette.
/// Works well in both light and dark modes with a professional look.
/// The accent color is the same as the neutral color (monochromatic).
class GreyThemeSchema extends ThemeSchema with MonochromaticThemeMixin {
  const GreyThemeSchema();

  @override
  String get id => 'grey';

  @override
  String get name => 'Grey';

  @override
  ColorSwatch get neutralSwatch => Swatches.slate;
}
