import '../swatch.dart';
import '../theme_schema.dart';

/// White theme preset
///
/// A clean, minimal monochromatic theme using Tailwind's neutral palette.
/// Optimized for light mode with maximum brightness and clarity.
/// The accent color is the same as the neutral color (monochromatic).
class WhiteThemeSchema extends ThemeSchema with MonochromaticThemeMixin {
  const WhiteThemeSchema();

  @override
  String get id => 'white';

  @override
  String get name => 'White';

  @override
  ColorSwatch get neutralSwatch => Swatches.neutral;

  @override
  bool get prefersLight => true;
}
