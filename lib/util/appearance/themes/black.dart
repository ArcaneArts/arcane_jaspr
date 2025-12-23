import '../swatch.dart';
import '../theme_schema.dart';

/// Black theme preset
///
/// A deep, bold monochromatic theme using Tailwind's zinc palette.
/// Optimized for dark mode with high contrast.
/// The accent color is the same as the neutral color (monochromatic).
class BlackThemeSchema extends ThemeSchema with MonochromaticThemeMixin {
  const BlackThemeSchema();

  @override
  String get id => 'black';

  @override
  String get name => 'Black';

  @override
  ColorSwatch get neutralSwatch => Swatches.zinc;

  @override
  bool get prefersDark => true;
}
