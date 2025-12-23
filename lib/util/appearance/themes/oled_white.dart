import '../colors.dart';
import '../swatch.dart';
import '../theme_schema.dart';

/// OLED White theme preset
///
/// An energy-efficient monochromatic theme with true black (#000000)
/// backgrounds and white/neutral accents. Perfect for OLED/AMOLED
/// displays where black pixels are completely off, saving battery life.
/// Creates a stark, high-contrast appearance.
class OledWhiteThemeSchema extends ThemeSchema
    with OledThemeMixin, MonochromaticThemeMixin {
  const OledWhiteThemeSchema();

  @override
  String get id => 'oled_white';

  @override
  String get name => 'OLED White';

  @override
  ColorSwatch get neutralSwatch => Swatches.neutral;

  // Override accent colors to use lighter shades for visibility on black
  @override
  Color get accentDark => neutralSwatch.shade300;

  @override
  Color get accentHoverDark => neutralSwatch.shade200;

  @override
  Color get onAccentDark => Colors.black;
}
