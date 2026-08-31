import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_shadcn/arcane_jaspr_shadcn.dart';
import 'package:jaspr_test/server_test.dart';

void main() {
  test('global runtime contains no literal calendar template controls', () {
    final String script = ArcaneScripts.all;

    expect(script, isNot(contains('<button')));
    expect(script, isNot(contains('<div class="arcane-calendar')));
    expect(script, contains(r'\x3Cbutton'));
    expect(script, contains(r'\x3Cdiv class="arcane-calendar'));
  });

  test('carousel runtime neutralizes every cloned focus path', () {
    final String script = ArcaneScripts.all;

    expect(script, contains('[data-arcane-carousel-content="clone"]'));
    expect(script, contains("element.setAttribute('tabindex', '-1')"));
    expect(script, contains("element.disabled = true"));
    expect(script, contains("element.removeAttribute('autofocus')"));
    expect(script, contains("clone.inert = true"));
    expect(script, contains("element.removeAttribute('id')"));
  });

  testServer('carousel clone is inert in server-rendered DOM', (
    ServerTester tester,
  ) async {
    tester.pumpComponent(
      const ArcaneThemeProvider(
        stylesheet: ShadcnStylesheet(),
        child: ArcaneInfiniteCarousel(
          children: <Widget>[Button(label: 'Focusable action')],
        ),
      ),
    );

    final DocumentResponse response = await tester.request('/');
    expect(response.statusCode, 200, reason: response.body);
    final RegExpMatch? cloneTag = RegExp(
      r'<div[^>]*data-arcane-carousel-content="clone"[^>]*>',
    ).firstMatch(response.body);

    expect(cloneTag, isNotNull, reason: response.body);
    expect(cloneTag!.group(0), contains('aria-hidden="true"'));
    expect(
      cloneTag.group(0),
      anyOf(contains('inert="true"'), contains('inert')),
    );
    expect(cloneTag.group(0), contains('pointer-events: none'));
  });
}
