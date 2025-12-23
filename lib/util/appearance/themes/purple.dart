import '../swatch.dart';
import '../theme_schema.dart';

/// Purple theme preset
///
/// A rich, creative theme using Tailwind's violet color palette.
/// Great for luxury, creative, or artistic applications.
class PurpleThemeSchema extends ThemeSchema {
  const PurpleThemeSchema();

  @override
  String get id => 'purple';

  @override
  String get name => 'Purple';

  @override
  ColorSwatch get accentSwatch => Swatches.violet;

  @override
  ColorSwatch get neutralSwatch => Swatches.zinc;
}
