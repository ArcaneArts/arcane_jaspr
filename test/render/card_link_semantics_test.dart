import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_shadcn/arcane_jaspr_shadcn.dart';
import 'package:arcane_jaspr_win95/arcane_jaspr_win95.dart';
import 'package:jaspr_test/server_test.dart';

Future<String> _render(
  ServerTester tester,
  ArcaneStylesheet stylesheet,
  Widget widget,
) async {
  tester.pumpComponent(
    ArcaneThemeProvider(stylesheet: stylesheet, child: widget),
  );
  final DocumentResponse response = await tester.request('/');
  expect(response.statusCode, 200, reason: response.body);
  return response.body;
}

String _openingTagForClass(String html, String className) {
  for (final RegExpMatch match in RegExp(
    r'<[^>]+class="([^"]*)"[^>]*>',
  ).allMatches(html)) {
    final List<String> classes = match.group(1)!.split(RegExp(r'\s+'));
    if (classes.contains(className)) {
      return match.group(0)!;
    }
  }
  fail('Missing .$className in rendered HTML');
}

void main() {
  const List<(String, ArcaneStylesheet, String)> themes =
      <(String, ArcaneStylesheet, String)>[
        ('ShadCN', ShadcnStylesheet(), 'arcane-card'),
        ('Win95', Win95Stylesheet(), 'win95-card'),
      ];

  for (final (String name, ArcaneStylesheet stylesheet, String cssClass)
      in themes) {
    group('$name Card root semantics', () {
      testServer('legacy non-interactive constructor remains a div', (
        ServerTester tester,
      ) async {
        final String html = await _render(
          tester,
          stylesheet,
          const Card.flat(child: Text('Static card')),
        );
        final String tag = _openingTagForClass(html, cssClass);

        expect(tag, startsWith('<div'));
        expect(tag, contains('data-variant="flat"'));
        expect(tag, isNot(contains(' clickable')));
      });

      testServer('onTap remains a native button and accepts root metadata', (
        ServerTester tester,
      ) async {
        final String html = await _render(
          tester,
          stylesheet,
          Card.interactive(
            child: const Text('Run action'),
            onTap: () {},
            classes: 'app-card analytics-surface',
            attributes: const <String, String>{
              'data-card-id': 'action-42',
              'type': 'submit',
            },
            ariaLabel: 'Run card action',
          ),
        );
        final String tag = _openingTagForClass(html, cssClass);

        expect(tag, startsWith('<button'));
        expect(tag, contains('type="button"'));
        expect(tag, isNot(contains('type="submit"')));
        expect(
          tag,
          contains('class="$cssClass clickable app-card analytics-surface"'),
        );
        expect(tag, contains('data-card-id="action-42"'));
        expect(tag, contains('aria-label="Run card action"'));
      });

      testServer(
        'href is a keyboard-native anchor with theme layering intact',
        (ServerTester tester) async {
          final String html = await _render(
            tester,
            stylesheet,
            const Card.outlined(
              child: Text('Open record'),
              href: '/records/example',
              classes: 'custom-link-card',
              attributes: <String, String>{'data-record-id': 'example'},
              ariaLabel: 'Open example record',
              decoration: ArcaneDecoration(color: '#123456'),
              styles: ArcaneStyleData(
                displayCustom: 'grid',
                textDecoration: TextDecoration.underline,
              ),
            ),
          );
          final String tag = _openingTagForClass(html, cssClass);

          expect(tag, startsWith('<a'));
          expect(tag, contains('href="/records/example"'));
          expect(tag, contains('class="$cssClass clickable custom-link-card"'));
          expect(tag, contains('data-record-id="example"'));
          expect(tag, contains('aria-label="Open example record"'));
          expect(tag, contains('data-arcane-decorated'));
          expect(tag, contains('background: #123456'));
          expect(tag, contains('display: grid'));
          expect(tag, contains('text-decoration: underline'));
          expect(tag, isNot(contains('role="button"')));
          expect(tag, isNot(contains('tabindex=')));
          expect(tag, isNot(contains('type="button"')));
        },
      );

      testServer(
        '_blank augments rel and dedicated fields stay authoritative',
        (ServerTester tester) async {
          final String html = await _render(
            tester,
            stylesheet,
            const Card(
              child: Text('External documentation'),
              href: 'https://example.com/docs',
              target: '_blank',
              rel: 'nofollow noopener',
              ariaLabel: 'External documentation',
              attributes: <String, String>{
                'target': '_self',
                'rel': 'unsafe',
                'class': 'not-the-card-class',
                'style': 'display:none',
                'data-variant': 'ghost',
                'aria-label': 'Attribute fallback',
                'data-track': 'external-card',
              },
            ),
          );
          final String tag = _openingTagForClass(html, cssClass);

          expect(tag, contains('target="_blank"'));
          expect(tag, contains('rel="nofollow noopener noreferrer"'));
          expect(tag, contains('aria-label="External documentation"'));
          expect(tag, contains('data-track="external-card"'));
          expect(tag, contains('data-variant="elevated"'));
          expect(tag, isNot(contains('not-the-card-class')));
          expect(tag, isNot(contains('display:none')));
        },
      );
    });
  }

  test(
    'Card and CardProps reject conflicting navigation and callback APIs',
    () {
      expect(
        () => Card(
          child: const Text('Ambiguous'),
          href: '/somewhere',
          onTap: () {},
        ),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => CardProps(
          child: const Text('Ambiguous'),
          href: '/somewhere',
          onTap: () {},
        ),
        throwsA(isA<AssertionError>()),
      );
    },
  );

  test('CardProps copyWith preserves and forwards link metadata', () {
    const CardProps original = CardProps(child: Text('Card props'));
    final CardProps linked = original.copyWith(
      href: '/records',
      target: '_self',
      rel: 'bookmark',
      classes: 'catalog-card',
      attributes: const <String, String>{'data-kind': 'catalog'},
      ariaLabel: 'Record catalog',
    );

    expect(linked.href, '/records');
    expect(linked.target, '_self');
    expect(linked.rel, 'bookmark');
    expect(linked.classes, 'catalog-card');
    expect(linked.attributes, <String, String>{'data-kind': 'catalog'});
    expect(linked.ariaLabel, 'Record catalog');
    expect(linked.variant, CardVariant.elevated);
  });

  test('CardProps copyWith switches and clears interaction modes', () {
    void runAction() {}

    const CardProps linked = CardProps(
      child: Text('Switchable card'),
      href: '/records',
    );
    final CardProps button = linked.copyWith(onTap: runAction);
    expect(button.href, isNull);
    expect(button.onTap, same(runAction));

    final CardProps relinked = button.copyWith(href: '/records/next');
    expect(relinked.href, '/records/next');
    expect(relinked.onTap, isNull);

    final CardProps staticCard = relinked.copyWith(clearInteraction: true);
    expect(staticCard.href, isNull);
    expect(staticCard.onTap, isNull);
  });

  test('CardProps copyWith rejects ambiguous interaction updates', () {
    const CardProps props = CardProps(child: Text('Card props'));

    expect(
      () => props.copyWith(href: '/records', onTap: () {}),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => props.copyWith(href: '/records', clearInteraction: true),
      throwsA(isA<AssertionError>()),
    );
  });
}
