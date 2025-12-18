import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:jaspr_test/jaspr_test.dart';

void main() {
  group('Color', () {
    test('creates color from hex value', () {
      final color = Color(0xFF6366F1);
      expect(color.value, equals(0xFF6366F1));
    });

    test('creates color from ARGB components', () {
      final color = Color.fromARGB(255, 99, 102, 241);
      expect(color.alpha, equals(255));
      expect(color.red, equals(99));
      expect(color.green, equals(102));
      expect(color.blue, equals(241));
    });

    test('creates color from RGB components', () {
      final color = Color.fromRGBO(99, 102, 241, 1.0);
      expect(color.red, equals(99));
      expect(color.green, equals(102));
      expect(color.blue, equals(241));
      expect(color.opacity, equals(1.0));
    });

    test('withOpacity returns new color with opacity', () {
      final color = Color(0xFF6366F1);
      final withOpacity = color.withOpacity(0.5);
      expect(withOpacity.opacity, closeTo(0.5, 0.01));
    });

    test('withAlpha returns new color with alpha', () {
      final color = Color(0xFF6366F1);
      final withAlpha = color.withAlpha(128);
      expect(withAlpha.alpha, equals(128));
    });

    test('css getter returns valid CSS color', () {
      final color = Color(0xFF6366F1);
      expect(color.css, startsWith('rgba('));
    });

    test('hex getter returns hex string', () {
      final color = Color(0xFF6366F1);
      expect(color.hex, matches(RegExp(r'^#[0-9A-Fa-f]{6}$')));
    });
  });

  group('Colors', () {
    test('predefined colors are valid', () {
      expect(Colors.white.value, equals(0xFFFFFFFF));
      expect(Colors.black.value, equals(0xFF000000));
      expect(Colors.transparent.alpha, equals(0));
    });

    test('material colors exist', () {
      expect(Colors.blue, isNotNull);
      expect(Colors.red, isNotNull);
      expect(Colors.green, isNotNull);
      expect(Colors.purple, isNotNull);
      expect(Colors.orange, isNotNull);
    });
  });
}
