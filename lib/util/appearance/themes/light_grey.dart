import '../swatch.dart';
import '../theme_schema.dart';

/// Light Grey theme preset
///
/// A soft, airy monochromatic theme using Tailwind's gray palette.
/// Perfect for light mode applications with a clean, minimal aesthetic.
/// The accent color is the same as the neutral color (monochromatic).
class LightGreyThemeSchema extends ThemeSchema with MonochromaticThemeMixin {
  const LightGreyThemeSchema();

  @override
  String get id => 'light_grey';

  @override
  String get name => 'Light Grey';

  @override
  ColorSwatch get neutralSwatch => Swatches.gray;

  @override
  bool get prefersLight => true;
}
