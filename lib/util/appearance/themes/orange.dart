import '../swatch.dart';
import '../theme_schema.dart';

/// Orange theme preset
///
/// A warm, vibrant theme using Tailwind's orange color palette.
/// Great for creative, playful, or energetic applications.
class OrangeThemeSchema extends ThemeSchema {
  const OrangeThemeSchema();

  @override
  String get id => 'orange';

  @override
  String get name => 'Orange';

  @override
  ColorSwatch get accentSwatch => Swatches.orange;

  @override
  ColorSwatch get neutralSwatch => Swatches.zinc;
}
