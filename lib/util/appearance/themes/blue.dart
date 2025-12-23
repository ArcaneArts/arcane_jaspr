import '../swatch.dart';
import '../theme_schema.dart';

/// Blue theme preset
///
/// A calm, professional theme using Tailwind's blue color palette.
/// Great for corporate, technology, or trust-focused applications.
class BlueThemeSchema extends ThemeSchema {
  const BlueThemeSchema();

  @override
  String get id => 'blue';

  @override
  String get name => 'Blue';

  @override
  ColorSwatch get accentSwatch => Swatches.blue;

  @override
  ColorSwatch get neutralSwatch => Swatches.zinc;
}
