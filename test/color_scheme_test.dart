import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:jaspr_test/jaspr_test.dart';

void main() {
  group('ColorScheme', () {
    test('has correct brightness', () {
      final lightScheme = ColorScheme(
        brightness: Brightness.light,
        primary: Colors.blue,
        onPrimary: Colors.white,
        primaryContainer: Colors.blue,
        onPrimaryContainer: Colors.white,
        secondary: Colors.gray500,
        onSecondary: Colors.white,
        secondaryContainer: Colors.gray500,
        onSecondaryContainer: Colors.white,
        tertiary: Colors.teal,
        onTertiary: Colors.white,
        tertiaryContainer: Colors.teal,
        onTertiaryContainer: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        errorContainer: Colors.red,
        onErrorContainer: Colors.white,
        background: Colors.white,
        onBackground: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black,
        surfaceVariant: Colors.gray500,
        onSurfaceVariant: Colors.black,
        outline: Colors.gray500,
        outlineVariant: Colors.gray500,
        shadow: Colors.black,
        scrim: Colors.black,
        inverseSurface: Colors.black,
        onInverseSurface: Colors.white,
        inversePrimary: Colors.blue,
        surfaceTint: Colors.blue,
      );
      expect(lightScheme.brightness, equals(Brightness.light));
    });

    test('copyWith preserves unmodified colors', () {
      final original = ColorScheme(
        brightness: Brightness.light,
        primary: Colors.blue,
        onPrimary: Colors.white,
        primaryContainer: Colors.blue,
        onPrimaryContainer: Colors.white,
        secondary: Colors.gray500,
        onSecondary: Colors.white,
        secondaryContainer: Colors.gray500,
        onSecondaryContainer: Colors.white,
        tertiary: Colors.teal,
        onTertiary: Colors.white,
        tertiaryContainer: Colors.teal,
        onTertiaryContainer: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        errorContainer: Colors.red,
        onErrorContainer: Colors.white,
        background: Colors.white,
        onBackground: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black,
        surfaceVariant: Colors.gray500,
        onSurfaceVariant: Colors.black,
        outline: Colors.gray500,
        outlineVariant: Colors.gray500,
        shadow: Colors.black,
        scrim: Colors.black,
        inverseSurface: Colors.black,
        onInverseSurface: Colors.white,
        inversePrimary: Colors.blue,
        surfaceTint: Colors.blue,
      );
      final copied = original.copyWith(primary: Colors.red);
      expect(copied.secondary.value, equals(original.secondary.value));
      expect(copied.surface.value, equals(original.surface.value));
      expect(copied.primary.value, equals(Colors.red.value));
    });
  });

  group('ContrastedColorScheme', () {
    test('provides light and dark schemes', () {
      // Create using ThemeSchema
      final schema = const BlueThemeSchema();
      final contrasted = schema.toColorScheme();
      expect(contrasted.light.brightness, equals(Brightness.light));
      expect(contrasted.dark.brightness, equals(Brightness.dark));
    });

    test('scheme returns correct scheme based on brightness', () {
      final schema = const RedThemeSchema();
      final contrasted = schema.toColorScheme();
      expect(contrasted.scheme(Brightness.light), equals(contrasted.light));
      expect(contrasted.scheme(Brightness.dark), equals(contrasted.dark));
    });

    test('spin rotates colors', () {
      final schema = const GreenThemeSchema();
      final contrasted = schema.toColorScheme();
      final spun = contrasted.spin(180);
      // After 180 degree spin, colors should be different
      expect(spun.light.primary.value, isNot(equals(contrasted.light.primary.value)));
    });
  });

  group('ColorSwatch', () {
    test('predefined swatches are available', () {
      expect(Swatches.red, isNotNull);
      expect(Swatches.blue, isNotNull);
      expect(Swatches.emerald, isNotNull);
      expect(Swatches.amber, isNotNull);
      expect(Swatches.violet, isNotNull);
    });

    test('swatch has all shade values', () {
      final swatch = Swatches.blue;
      expect(swatch.shade50, isNotNull);
      expect(swatch.shade100, isNotNull);
      expect(swatch.shade200, isNotNull);
      expect(swatch.shade300, isNotNull);
      expect(swatch.shade400, isNotNull);
      expect(swatch.shade500, isNotNull);
      expect(swatch.shade600, isNotNull);
      expect(swatch.shade700, isNotNull);
      expect(swatch.shade800, isNotNull);
      expect(swatch.shade900, isNotNull);
      expect(swatch.shade950, isNotNull);
    });

    test('swatch bracket operator works', () {
      final swatch = Swatches.red;
      expect(swatch[500], equals(swatch.shade500));
      expect(swatch[100], equals(swatch.shade100));
    });

    test('toCssVariables generates variables', () {
      final vars = Swatches.blue.toCssVariables('--test');
      expect(vars['--test-500'], isNotNull);
      expect(vars['--test-500-rgb'], isNotNull);
    });
  });

  group('ThemeSchema', () {
    test('generates ColorScheme for light mode', () {
      final schema = const RedThemeSchema();
      final colorScheme = schema.toColorScheme().light;
      expect(colorScheme.brightness, equals(Brightness.light));
      expect(colorScheme.primary, isNotNull);
    });

    test('generates ColorScheme for dark mode', () {
      final schema = const BlueThemeSchema();
      final colorScheme = schema.toColorScheme().dark;
      expect(colorScheme.brightness, equals(Brightness.dark));
      expect(colorScheme.primary, isNotNull);
    });

    test('OLED themes have isOled true', () {
      expect(const OledBlueThemeSchema().isOled, isTrue);
      expect(const OledRedThemeSchema().isOled, isTrue);
      expect(const BlueThemeSchema().isOled, isFalse);
    });

    test('OLED themes have true black background', () {
      final schema = const OledBlueThemeSchema();
      expect(schema.backgroundDark, equals(Colors.black));
    });

    test('monochromatic themes use neutral as accent', () {
      final schema = const GreyThemeSchema();
      expect(schema.accentSwatch, equals(schema.neutralSwatch));
    });
  });
}
