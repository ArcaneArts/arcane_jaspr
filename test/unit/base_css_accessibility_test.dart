import 'package:arcane_jaspr/stylesheets/base_css.dart';
import 'package:jaspr_test/jaspr_test.dart';

void main() {
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

  test('reduced motion disables infinite carousel animation', () {
    expect(
      ArcaneBaseCss.shared,
      contains('@media (prefers-reduced-motion: reduce)'),
    );
    expect(ArcaneBaseCss.shared, contains('.arcane-carousel-track'));
    expect(ArcaneBaseCss.shared, contains('animation: none !important'));
  });
}
