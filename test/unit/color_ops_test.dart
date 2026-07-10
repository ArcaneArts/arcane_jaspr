// Unit tests for ArcaneColorOps — the opacity/blend helpers that replace raw
// color-mix() strings and the fragile `${color}30` hex-alpha suffix hack.

import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:jaspr_test/jaspr_test.dart';

void main() {
  group('String.opacity', () {
    test('fades a hex color toward transparent', () {
      expect(
        '#4CAF50'.opacity(0.3),
        'color-mix(in srgb, #4CAF50 30%, transparent)',
      );
    });

    test('works on a CSS variable (the case the hex-suffix hack corrupts)', () {
      // `${'var(--primary)'}30` produces invalid `var(--primary)30`; the helper
      // is the only form that survives a var() color.
      expect(
        'var(--primary)'.opacity(0.19),
        'color-mix(in srgb, var(--primary) 19%, transparent)',
      );
    });

    test('matches the 0x15 hex-alpha the migration replaces (~8%)', () {
      expect(
        '#3B82F6'.opacity(0.08),
        'color-mix(in srgb, #3B82F6 8%, transparent)',
      );
    });

    test('clamps amount to 0..1', () {
      expect('#fff'.opacity(1.5), 'color-mix(in srgb, #fff 100%, transparent)');
      expect('#fff'.opacity(-0.2), 'color-mix(in srgb, #fff 0%, transparent)');
    });
  });

  group('String.on', () {
    test('tints this color over a base color', () {
      expect(
        '#000000'.on('var(--card)', 0.1),
        'color-mix(in srgb, #000000 10%, var(--card))',
      );
    });

    test('composes with ArcaneColor via .css', () {
      expect(
        ArcaneColor.primary.css.opacity(0.3),
        'color-mix(in srgb, var(--primary) 30%, transparent)',
      );
    });
  });
}
