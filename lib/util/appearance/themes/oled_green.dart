import '../swatch.dart';
import '../theme_schema.dart';
import 'green.dart';

/// OLED Green theme preset
///
/// An energy-efficient theme with true black (#000000) backgrounds
/// and emerald green accents. Perfect for OLED/AMOLED displays where black
/// pixels are completely off, saving battery life.
class OledGreenThemeSchema extends GreenThemeSchema with OledThemeMixin {
  const OledGreenThemeSchema();

  @override
  String get id => 'oled_green';

  @override
  String get name => 'OLED Green';

  @override
  ColorSwatch get neutralSwatch => Swatches.zinc;
}
