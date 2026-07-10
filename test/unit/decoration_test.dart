// Unit tests for ArcaneDecoration — the semantic, theme-permeable box surface.
// Universal fields compile to CSS identically on every theme; intent
// (elevation) and theme-specific (shadowColor) fields are resolved by each
// theme's decorationStyles() hook, NOT here.

import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:jaspr_test/jaspr_test.dart';

void main() {
  group('ArcaneDecoration.universalStyles', () {
    test('compiles universal fields to CSS', () {
      final Map<String, String> css = const ArcaneDecoration(
        color: '#ffffff',
        borderRadius: Radius.lg,
        border: '1px solid var(--border)',
      ).universalStyles();
      expect(css['background'], '#ffffff');
      expect(css['border-radius'], isNotNull);
      expect(css['border'], '1px solid var(--border)');
    });

    test('gradient wins over color for the background', () {
      final Map<String, String> css = const ArcaneDecoration(
        color: '#fff',
        gradient: 'linear-gradient(180deg, #000, #111)',
      ).universalStyles();
      expect(css['background'], 'linear-gradient(180deg, #000, #111)');
    });

    test('does NOT emit intent/theme-specific fields (themes resolve those)', () {
      final Map<String, String> css = const ArcaneDecoration(
        elevation: Elevation.lg,
        shadowColor: '#EC4899',
      ).universalStyles();
      expect(css.containsKey('box-shadow'), isFalse);
      expect(css.containsKey('--nb-shadow-color'), isFalse);
    });
  });

  test('intent and theme-specific fields are readable by theme renderers', () {
    const ArcaneDecoration d =
        ArcaneDecoration(elevation: Elevation.md, shadowColor: '#000');
    expect(d.elevation, Elevation.md);
    expect(d.shadowColor, '#000');
  });
}
