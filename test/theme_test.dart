import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:jaspr_test/jaspr_test.dart';

void main() {
  group('ArcaneTheme', () {
    test('creates theme with defaults', () {
      const theme = ArcaneTheme();
      expect(theme.themeMode, equals(ThemeMode.system));
      expect(theme.schema, isA<GreenThemeSchema>());
    });

    test('creates theme with light mode', () {
      const theme = ArcaneTheme(themeMode: ThemeMode.light);
      expect(theme.themeMode, equals(ThemeMode.light));
      expect(theme.isLight, isTrue);
    });

    test('creates theme with dark mode', () {
      const theme = ArcaneTheme(themeMode: ThemeMode.dark);
      expect(theme.themeMode, equals(ThemeMode.dark));
      expect(theme.isDark, isTrue);
    });

    test('preset themes are available', () {
      expect(ArcaneTheme.red.schema, isA<RedThemeSchema>());
      expect(ArcaneTheme.blue.schema, isA<BlueThemeSchema>());
      expect(ArcaneTheme.green.schema, isA<GreenThemeSchema>());
      expect(ArcaneTheme.purple.schema, isA<PurpleThemeSchema>());
      expect(ArcaneTheme.oledBlue.schema, isA<OledBlueThemeSchema>());
    });

    test('creates theme with custom radius', () {
      const theme = ArcaneTheme(radius: 0.75);
      expect(theme.radius, equals(0.75));
    });

    test('creates theme with custom surface opacity', () {
      const theme = ArcaneTheme(surfaceOpacity: 0.9);
      expect(theme.surfaceOpacity, equals(0.9));
    });

    test('copyWith preserves unmodified values', () {
      const original = ArcaneTheme(
        themeMode: ThemeMode.dark,
        radius: 0.5,
      );
      final copied = original.copyWith(radius: 0.8);
      expect(copied.themeMode, equals(ThemeMode.dark));
      expect(copied.radius, equals(0.8));
    });

    test('copyWith updates specified values', () {
      const original = ArcaneTheme(themeMode: ThemeMode.light);
      final copied = original.copyWith(themeMode: ThemeMode.dark);
      expect(copied.themeMode, equals(ThemeMode.dark));
    });

    test('withSchema creates theme with new schema', () {
      final theme = ArcaneTheme.red.withSchema(const BlueThemeSchema());
      expect(theme.schema, isA<BlueThemeSchema>());
    });

    test('colorScheme returns correct brightness for light mode', () {
      const theme = ArcaneTheme(
        schema: BlueThemeSchema(),
        themeMode: ThemeMode.light,
      );
      expect(theme.colorScheme.brightness, equals(Brightness.light));
    });

    test('colorScheme returns correct brightness for dark mode', () {
      const theme = ArcaneTheme(
        schema: BlueThemeSchema(),
        themeMode: ThemeMode.dark,
      );
      expect(theme.colorScheme.brightness, equals(Brightness.dark));
    });

    test('cssVariables returns map of CSS properties', () {
      final cssVars = ArcaneTheme.blue.cssVariables;
      expect(cssVars, isNotEmpty);
      expect(cssVars.keys.any((k) => k.startsWith('--arcane-')), isTrue);
    });

    test('cssVariables includes accent swatch variables', () {
      final cssVars = ArcaneTheme.red.cssVariables;
      expect(cssVars['--arcane-accent-500'], isNotNull);
      expect(cssVars['--arcane-accent-500-rgb'], isNotNull);
    });

    test('cssVariables includes neutral swatch variables', () {
      final cssVars = ArcaneTheme.blue.cssVariables;
      expect(cssVars['--arcane-neutral-500'], isNotNull);
      expect(cssVars['--arcane-neutral-500-rgb'], isNotNull);
    });

    test('OLED themes have true black background', () {
      expect(ArcaneTheme.oledBlue.isOled, isTrue);
      expect(ArcaneTheme.oledRed.isOled, isTrue);
      expect(ArcaneTheme.blue.isOled, isFalse);
    });

    test('all presets list contains all themes', () {
      expect(ArcaneTheme.all.length, equals(18));
      expect(ArcaneTheme.all, contains(ArcaneTheme.red));
      expect(ArcaneTheme.all, contains(ArcaneTheme.oledPurple));
    });

    test('accentSwatch returns schema accent swatch', () {
      expect(ArcaneTheme.red.accentSwatch, equals(Swatches.red));
      expect(ArcaneTheme.blue.accentSwatch, equals(Swatches.blue));
    });

    test('neutralSwatch returns schema neutral swatch', () {
      expect(ArcaneTheme.red.neutralSwatch, isNotNull);
    });
  });

  group('ThemeMode', () {
    test('system is default', () {
      expect(ThemeMode.system, isNotNull);
    });

    test('light mode is available', () {
      expect(ThemeMode.light, isNotNull);
    });

    test('dark mode is available', () {
      expect(ThemeMode.dark, isNotNull);
    });

    test('brightness returns correct value for light', () {
      expect(ThemeMode.light.brightness, equals(Brightness.light));
    });

    test('brightness returns correct value for dark', () {
      expect(ThemeMode.dark.brightness, equals(Brightness.dark));
    });
  });

  group('ArcaneToastTheme', () {
    test('creates with defaults', () {
      const toast = ArcaneToastTheme();
      expect(toast.duration, isNotNull);
    });
  });

  group('GutterTheme', () {
    test('creates with defaults', () {
      const gutter = GutterTheme();
      expect(gutter.small, isNotNull);
      expect(gutter.medium, isNotNull);
      expect(gutter.large, isNotNull);
    });
  });

  group('NavigationTheme', () {
    test('creates with defaults', () {
      const nav = NavigationTheme();
      expect(nav, isNotNull);
    });
  });
}
