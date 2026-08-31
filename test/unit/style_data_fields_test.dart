// Unit tests for the bounded ArcaneStyleData fields used by QualityNode.

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

  test('a complete custom border remains available', () {
    final Map<String, String> css = const ArcaneStyleData(
      borderCustom: '2px solid var(--primary)',
    ).toMap();
    expect(css['border'], '2px solid var(--primary)');
  });

  test('custom borders reject injected directional declarations', () {
    for (final String border in <String>[
      '1px solid gray; border-left: 5px solid green',
      'var(--border, 1px solid gray; border-top: 5px solid green)',
      '1px solid gray { border-right: 5px solid green }',
    ]) {
      expect(
        () => ArcaneStyleData(borderCustom: border).toMap(),
        throwsArgumentError,
        reason: border,
      );
    }
  });

  test('boxSizing emits box-sizing', () {
    expect(
      const ArcaneStyleData(
        boxSizing: BoxSizing.borderBox,
      ).toMap()['box-sizing'],
      'border-box',
    );
  });

  test('backgroundClip emits standard + -webkit- pair', () {
    final Map<String, String> css = const ArcaneStyleData(
      backgroundClip: BackgroundClip.text,
    ).toMap();
    expect(css['background-clip'], 'text');
    expect(css['-webkit-background-clip'], 'text');
  });

  test('custom backgrounds reject gradients', () {
    expect(
      () => const ArcaneStyleData(
        backgroundCustom: 'linear-gradient(red, blue)',
      ).toMap(),
      throwsArgumentError,
    );
  });

  test('merge and copyWith preserve the new fields', () {
    const base = ArcaneStyleData(
      paddingTop: '4px',
      boxSizing: BoxSizing.borderBox,
    );
    final merged = const ArcaneStyleData()
        .merge(base)
        .copyWith(backgroundClip: BackgroundClip.text);
    final Map<String, String> css = merged.toMap();
    expect(css['padding-top'], '4px');
    expect(css['box-sizing'], 'border-box');
    expect(css['background-clip'], 'text');
  });
}
