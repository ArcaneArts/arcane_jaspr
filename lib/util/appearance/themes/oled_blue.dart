import '../swatch.dart';
import '../theme_schema.dart';
import 'blue.dart';

/// OLED Blue theme preset
///
/// An energy-efficient theme with true black (#000000) backgrounds
/// and blue accents. Perfect for OLED/AMOLED displays where black
/// pixels are completely off, saving battery life.
class OledBlueThemeSchema extends BlueThemeSchema with OledThemeMixin {
  const OledBlueThemeSchema();

  @override
  String get id => 'oled_blue';

  @override
  String get name => 'OLED Blue';

  @override
  ColorSwatch get neutralSwatch => Swatches.zinc;
}
