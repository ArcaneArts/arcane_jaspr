import '../swatch.dart';
import '../theme_schema.dart';

/// Dark Grey theme preset
///
/// A sleek, modern monochromatic theme using Tailwind's zinc palette.
/// Perfect for dark mode applications with a professional aesthetic.
/// The accent color is the same as the neutral color (monochromatic).
class DarkGreyThemeSchema extends ThemeSchema with MonochromaticThemeMixin {
  const DarkGreyThemeSchema();

  @override
  String get id => 'dark_grey';

  @override
  String get name => 'Dark Grey';

  @override
  ColorSwatch get neutralSwatch => Swatches.zinc;

  @override
  bool get prefersDark => true;
}
