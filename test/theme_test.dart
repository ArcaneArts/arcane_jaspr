import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:jaspr_test/jaspr_test.dart';

void main() {
  group('ArcaneTheme', () {
    test('creates theme with defaults', () {
      final theme = ArcaneTheme();
      expect(theme.themeMode, equals(ThemeMode.system));
    });

    test('creates theme with light mode', () {
      final theme = ArcaneTheme(themeMode: ThemeMode.light);
      expect(theme.themeMode, equals(ThemeMode.light));
    });

    test('creates theme with dark mode', () {
      final theme = ArcaneTheme(themeMode: ThemeMode.dark);
      expect(theme.themeMode, equals(ThemeMode.dark));
    });

    test('creates theme with custom scheme', () {
      final scheme = ContrastedColorScheme.purple();
      final theme = ArcaneTheme(scheme: scheme);
      expect(theme.scheme, equals(scheme));
    });

    test('creates theme with custom radius', () {
      final theme = ArcaneTheme(radius: 0.75);
      expect(theme.radius, equals(0.75));
    });

    test('creates theme with custom surface opacity', () {
      final theme = ArcaneTheme(surfaceOpacity: 0.9);
      expect(theme.surfaceOpacity, equals(0.9));
    });

    test('copyWith preserves unmodified values', () {
      final original = ArcaneTheme(
        themeMode: ThemeMode.dark,
        radius: 0.5,
      );
      final copied = original.copyWith(radius: 0.8);
      expect(copied.themeMode, equals(ThemeMode.dark));
      expect(copied.radius, equals(0.8));
    });

    test('copyWith updates specified values', () {
      final original = ArcaneTheme(themeMode: ThemeMode.light);
      final copied = original.copyWith(themeMode: ThemeMode.dark);
      expect(copied.themeMode, equals(ThemeMode.dark));
    });

    test('colorScheme returns correct scheme for light mode', () {
      final theme = ArcaneTheme(
        themeMode: ThemeMode.light,
        scheme: ContrastedColorScheme.blue(),
      );
      expect(theme.colorScheme.brightness, equals(Brightness.light));
    });

    test('colorScheme returns correct scheme for dark mode', () {
      final theme = ArcaneTheme(
        themeMode: ThemeMode.dark,
        scheme: ContrastedColorScheme.blue(),
      );
      expect(theme.colorScheme.brightness, equals(Brightness.dark));
    });

    test('cssVariables returns map of CSS properties', () {
      final theme = ArcaneTheme(
        themeMode: ThemeMode.dark,
        scheme: ContrastedColorScheme.blue(),
      );
      final cssVars = theme.cssVariables;
      expect(cssVars, isNotEmpty);
      expect(cssVars.keys.any((k) => k.startsWith('--arcane-')), isTrue);
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
      final toast = ArcaneToastTheme();
      expect(toast.duration, isNotNull);
    });
  });

  group('GutterTheme', () {
    test('creates with defaults', () {
      final gutter = GutterTheme();
      expect(gutter.small, isNotNull);
      expect(gutter.medium, isNotNull);
      expect(gutter.large, isNotNull);
    });
  });

  group('NavigationTheme', () {
    test('creates with defaults', () {
      final nav = NavigationTheme();
      expect(nav, isNotNull);
    });
  });
}
