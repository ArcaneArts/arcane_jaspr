import '../swatch.dart';
import '../theme_schema.dart';

/// Red theme preset
///
/// A bold, energetic theme using Tailwind's red color palette.
/// Great for alerts, errors, or passionate brand identities.
class RedThemeSchema extends ThemeSchema {
  const RedThemeSchema();

  @override
  String get id => 'red';

  @override
  String get name => 'Red';

  @override
  ColorSwatch get accentSwatch => Swatches.red;

  @override
  ColorSwatch get neutralSwatch => Swatches.zinc;
}
