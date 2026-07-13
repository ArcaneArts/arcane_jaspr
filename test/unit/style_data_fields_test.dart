// Unit tests for the ArcaneStyleData fields added to eliminate raw: {} maps
// that QualityNode was forced to use (single-side padding, per-side custom
// border strings, box-sizing, background-clip, custom backdrop-filter).

import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:jaspr_test/jaspr_test.dart';

void main() {
  group('single-side padding', () {
    test('each side emits its own longhand property', () {
      final Map<String, String> css = const ArcaneStyleData(
        paddingTop: '1.25rem',
        paddingRight: '8px',
        paddingBottom: '0',
        paddingLeft: '0.5rem',
      ).toMap();
      expect(css['padding-top'], '1.25rem');
      expect(css['padding-right'], '8px');
      expect(css['padding-bottom'], '0');
      expect(css['padding-left'], '0.5rem');
    });
  });

  group('per-side custom border strings', () {
    test('carry a runtime color the BorderPreset enum cannot', () {
      final Map<String, String> css = const ArcaneStyleData(
        borderTopCustom: '2px solid #EC4899',
        borderRightCustom: 'none',
      ).toMap();
      expect(css['border-top'], '2px solid #EC4899');
      expect(css['border-right'], 'none');
    });

    test('custom string wins over the preset for the same side', () {
      final Map<String, String> css = const ArcaneStyleData(
        borderTop: BorderPreset.subtle,
        borderTopCustom: '2px solid red',
      ).toMap();
      expect(css['border-top'], '2px solid red');
    });
  });

  test('boxSizing emits box-sizing', () {
    expect(
      const ArcaneStyleData(boxSizing: BoxSizing.borderBox).toMap()['box-sizing'],
      'border-box',
    );
  });

  test('backgroundClip emits standard + -webkit- pair', () {
    final Map<String, String> css =
        const ArcaneStyleData(backgroundClip: BackgroundClip.text).toMap();
    expect(css['background-clip'], 'text');
    expect(css['-webkit-background-clip'], 'text');
  });

  test('backdropFilterCustom emits standard + -webkit- pair', () {
    final Map<String, String> css =
        const ArcaneStyleData(backdropFilterCustom: 'blur(10px)').toMap();
    expect(css['backdrop-filter'], 'blur(10px)');
    expect(css['-webkit-backdrop-filter'], 'blur(10px)');
  });

  test('merge and copyWith preserve the new fields', () {
    const base = ArcaneStyleData(paddingTop: '4px', boxSizing: BoxSizing.borderBox);
    final merged =
        const ArcaneStyleData().merge(base).copyWith(backgroundClip: BackgroundClip.text);
    final Map<String, String> css = merged.toMap();
    expect(css['padding-top'], '4px');
    expect(css['box-sizing'], 'border-box');
    expect(css['background-clip'], 'text');
  });
}
