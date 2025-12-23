import '../swatch.dart';
import '../theme_schema.dart';

/// Pink theme preset
///
/// A playful, feminine theme using Tailwind's pink color palette.
/// Great for fashion, beauty, or fun applications.
class PinkThemeSchema extends ThemeSchema {
  const PinkThemeSchema();

  @override
  String get id => 'pink';

  @override
  String get name => 'Pink';

  @override
  ColorSwatch get accentSwatch => Swatches.pink;

  @override
  ColorSwatch get neutralSwatch => Swatches.zinc;
}
