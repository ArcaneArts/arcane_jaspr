import '../swatch.dart';
import '../theme_schema.dart';

/// Green theme preset
///
/// A fresh, natural theme using Tailwind's emerald color palette.
/// Great for eco-friendly, health, or success-focused applications.
class GreenThemeSchema extends ThemeSchema {
  const GreenThemeSchema();

  @override
  String get id => 'green';

  @override
  String get name => 'Green';

  @override
  ColorSwatch get accentSwatch => Swatches.emerald;

  @override
  ColorSwatch get neutralSwatch => Swatches.zinc;
}
