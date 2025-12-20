import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:jaspr_test/jaspr_test.dart';

void main() {
  group('ColorScheme', () {
    test('light scheme has correct brightness', () {
      final scheme = ColorScheme.light();
      expect(scheme.brightness, equals(Brightness.light));
    });

    test('dark scheme has correct brightness', () {
      final scheme = ColorScheme.dark();
      expect(scheme.brightness, equals(Brightness.dark));
    });

    test('light scheme has expected default colors', () {
      final scheme = ColorScheme.light();
      expect(scheme.primary, isNotNull);
      expect(scheme.secondary, isNotNull);
      expect(scheme.surface, isNotNull);
      expect(scheme.background, isNotNull);
      expect(scheme.error, isNotNull);
    });

    test('dark scheme has expected default colors', () {
      final scheme = ColorScheme.dark();
      expect(scheme.primary, isNotNull);
      expect(scheme.secondary, isNotNull);
      expect(scheme.surface, isNotNull);
      expect(scheme.background, isNotNull);
      expect(scheme.error, isNotNull);
    });

    test('custom colors override defaults', () {
      final customPrimary = const Color(0xFF123456);
      final scheme = ColorScheme.light(primary: customPrimary);
      expect(scheme.primary.value, equals(customPrimary.value));
    });

    test('copyWith preserves unmodified colors', () {
      final original = ColorScheme.light();
      final copied = original.copyWith(primary: const Color(0xFF000000));
      expect(copied.secondary.value, equals(original.secondary.value));
      expect(copied.surface.value, equals(original.surface.value));
    });

    test('copyWith updates specified colors', () {
      final original = ColorScheme.light();
      final newPrimary = const Color(0xFF123456);
      final copied = original.copyWith(primary: newPrimary);
      expect(copied.primary.value, equals(newPrimary.value));
    });
  });

  group('ContrastedColorScheme', () {
    test('provides light and dark schemes', () {
      final contrasted = ContrastedColorScheme.blue();
      expect(contrasted.light.brightness, equals(Brightness.light));
      expect(contrasted.dark.brightness, equals(Brightness.dark));
    });

    test('blue preset has blue primary', () {
      final contrasted = ContrastedColorScheme.blue();
      // Primary should be blue-ish
      expect(contrasted.light.primary.blue, greaterThan(contrasted.light.primary.red));
    });

    test('green preset has green primary', () {
      final contrasted = ContrastedColorScheme.green();
      expect(contrasted.light.primary.green, greaterThan(contrasted.light.primary.blue));
    });

    test('purple preset has purple primary', () {
      final contrasted = ContrastedColorScheme.purple();
      // Purple has high red and blue
      expect(contrasted.light.primary.red, greaterThan(contrasted.light.primary.green));
      expect(contrasted.light.primary.blue, greaterThan(contrasted.light.primary.green));
    });

    test('custom scheme accepts light and dark', () {
      final lightScheme = ColorScheme.light(primary: const Color(0xFF111111));
      final darkScheme = ColorScheme.dark(primary: const Color(0xFFEEEEEE));
      final contrasted = ContrastedColorScheme(light: lightScheme, dark: darkScheme);
      expect(contrasted.light.primary.value, equals(0xFF111111));
      expect(contrasted.dark.primary.value, equals(0xFFEEEEEE));
    });

    test('scheme returns correct scheme based on brightness', () {
      final contrasted = ContrastedColorScheme.blue();
      expect(contrasted.scheme(Brightness.light), equals(contrasted.light));
      expect(contrasted.scheme(Brightness.dark), equals(contrasted.dark));
    });
  });
}