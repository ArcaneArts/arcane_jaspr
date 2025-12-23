import '../swatch.dart';
import '../theme_schema.dart';

/// Yellow theme preset
///
/// A warm, sunny theme using Tailwind's amber color palette.
/// Great for optimistic, attention-grabbing applications.
class YellowThemeSchema extends ThemeSchema {
  const YellowThemeSchema();

  @override
  String get id => 'yellow';

  @override
  String get name => 'Yellow';

  @override
  ColorSwatch get accentSwatch => Swatches.amber;

  @override
  ColorSwatch get neutralSwatch => Swatches.zinc;
}
