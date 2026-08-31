// Unit tests for ArcaneDecoration — the semantic, theme-permeable box surface.
// Universal fields compile to CSS identically on every theme; elevation intent
// is resolved by each theme's decorationStyles() hook, NOT here.

import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:jaspr_test/jaspr_test.dart';

void main() {
  group('ArcaneDecoration.universalStyles', () {
    test('compiles universal fields to CSS', () {
      final Map<String, String> css = const ArcaneDecoration(
        color: '#ffffff',
        borderRadius: Radius.md,
        border: '1px solid var(--border)',
      ).universalStyles();
      expect(css['background'], '#ffffff');
      expect(css['border-radius'], isNotNull);
      expect(css['border'], '1px solid var(--border)');
    });

    test('does NOT emit elevation intent (themes resolve it)', () {
      final Map<String, String> css = const ArcaneDecoration(
        elevation: Elevation.lg,
      ).universalStyles();
      expect(css.containsKey('box-shadow'), isFalse);
      expect(css.containsKey('--nb-shadow-color'), isFalse);
    });
  });

  test('elevation intent is readable by theme renderers', () {
    const ArcaneDecoration d = ArcaneDecoration(elevation: Elevation.md);
    expect(d.elevation, Elevation.md);
  });
}
