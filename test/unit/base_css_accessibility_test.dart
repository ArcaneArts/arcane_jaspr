import 'package:arcane_jaspr/stylesheets/base_css.dart';
import 'package:jaspr_test/jaspr_test.dart';

void main() {
  test('CSS-only tooltips reveal for pointer and keyboard interaction', () {
    expect(
      ArcaneBaseCss.shared,
      contains('.arcane-css-tooltip-trigger:is(:hover, :focus-within)'),
    );
    expect(ArcaneBaseCss.shared, contains('> .arcane-css-tooltip-content'));
    expect(ArcaneBaseCss.shared, contains('opacity: 1 !important'));
    expect(ArcaneBaseCss.shared, contains('visibility: visible !important'));
  });

  test('coarse pointers floor native text controls at 16px', () {
    expect(ArcaneBaseCss.shared, contains('@media (pointer: coarse)'));
    expect(
      ArcaneBaseCss.shared,
      contains('#arcane-root :is(input, textarea, select)'),
    );
    expect(
      ArcaneBaseCss.shared,
      contains('font-size: max(16px, 1em) !important'),
    );
  });
}
