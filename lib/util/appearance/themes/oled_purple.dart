import '../swatch.dart';
import '../theme_schema.dart';
import 'purple.dart';

/// OLED Purple theme preset
///
/// An energy-efficient theme with true black (#000000) backgrounds
/// and violet/purple accents. Perfect for OLED/AMOLED displays where black
/// pixels are completely off, saving battery life.
class OledPurpleThemeSchema extends PurpleThemeSchema with OledThemeMixin {
  const OledPurpleThemeSchema();

  @override
  String get id => 'oled_purple';

  @override
  String get name => 'OLED Purple';

  @override
  ColorSwatch get neutralSwatch => Swatches.zinc;
}
