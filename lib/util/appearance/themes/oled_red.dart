import '../swatch.dart';
import '../theme_schema.dart';
import 'red.dart';

/// OLED Red theme preset
///
/// An energy-efficient theme with true black (#000000) backgrounds
/// and red accents. Perfect for OLED/AMOLED displays where black
/// pixels are completely off, saving battery life.
class OledRedThemeSchema extends RedThemeSchema with OledThemeMixin {
  const OledRedThemeSchema();

  @override
  String get id => 'oled_red';

  @override
  String get name => 'OLED Red';

  @override
  ColorSwatch get neutralSwatch => Swatches.zinc;
}
