import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_shadcn/arcane_jaspr_shadcn.dart';
import 'package:arcane_jaspr_win95/arcane_jaspr_win95.dart';
import 'package:jaspr_test/server_test.dart';

Widget _wrap(ArcaneStylesheet sheet, Widget child) =>
    ArcaneThemeProvider(stylesheet: sheet, child: child);

Future<String> _render(
  ServerTester tester,
  ArcaneStylesheet sheet,
  Widget widget,
) async {
  tester.pumpComponent(_wrap(sheet, widget));
  final DocumentResponse response = await tester.request('/');
  expect(response.statusCode, 200, reason: response.body);
  return response.body;
}

void main() {
  const ArcaneNotFoundPage page = ArcaneNotFoundPage(
    applicationName: 'Example',
    requestedPath: '/missing?<unsafe>',
    diagnosticCode: 'EXAMPLE(01)',
    actions: <ArcaneNotFoundAction>[
      ArcaneNotFoundAction(
        label: 'Back to dashboard',
        href: '/dashboard',
        primary: true,
      ),
      ArcaneNotFoundAction(
        label: 'Search',
        href: '/search',
        ariaLabel: 'Search Example',
      ),
    ],
    classes: 'example-not-found',
    attributes: <String, String>{'data-test-id': 'not-found'},
  );

  for (final (String name, ArcaneStylesheet sheet)
      in <(String, ArcaneStylesheet)>[
        ('shadcn', const ShadcnStylesheet()),
        ('win95', const Win95Stylesheet()),
      ]) {
    testServer('renders semantic recovery markup [$name]', (
      ServerTester tester,
    ) async {
      final String html = await _render(tester, sheet, page);

      expect(html, contains('<main'));
      expect(html, contains('data-arcane-not-found="true"'));
      expect(html, contains('class="arcane-not-found example-not-found"'));
      expect(html, contains('data-test-id="not-found"'));
      expect(html, contains('aria-label="Page not found"'));
      expect(html, contains('data-arcane-not-found-standalone="true"'));
      expect(html, contains('<h1 class="arcane-not-found-title"'));
      expect(html, isNot(contains('id="arcane-not-found-title"')));
      expect(html, contains('aria-label="Recovery options"'));
      expect(html, contains('href="/dashboard"'));
      expect(html, contains('href="/search"'));
      expect(html, contains('aria-label="Search Example"'));
      expect(html, contains('EXAMPLE(01)'));
      expect(html, contains('/missing?&lt;unsafe&gt;'));
      expect(html, isNot(contains('/missing?<unsafe>')));
    });
  }

  testServer('default page always offers a home recovery link', (
    ServerTester tester,
  ) async {
    final String html = await _render(
      tester,
      const ShadcnStylesheet(),
      const ArcaneNotFoundPage(),
    );

    expect(html, contains('Page not found'));
    expect(html, contains('href="/"'));
    expect(html, contains('Return home'));
  });

  testServer('embedded mode avoids a nested main landmark', (
    ServerTester tester,
  ) async {
    final String html = await _render(
      tester,
      const ShadcnStylesheet(),
      const ArcaneNotFoundPage(id: 'embedded-missing', standalone: false),
    );

    expect(
      html,
      contains('<section id="embedded-missing" class="arcane-not-found"'),
    );
    expect(html, contains('data-arcane-not-found-standalone="false"'));
    expect(html, contains('<h2 class="arcane-not-found-title"'));
    expect(html, isNot(contains('<main')));
    expect(html, isNot(contains('<h1')));
  });

  testServer('custom attributes cannot replace semantic state hooks', (
    ServerTester tester,
  ) async {
    final String html = await _render(
      tester,
      const ShadcnStylesheet(),
      const ArcaneNotFoundPage(
        attributes: <String, String>{
          'aria-label': 'Incorrect',
          'data-arcane-not-found': 'false',
          'data-arcane-not-found-standalone': 'false',
        },
      ),
    );

    expect(html, contains('aria-label="Page not found"'));
    expect(html, contains('data-arcane-not-found="true"'));
    expect(html, contains('data-arcane-not-found-standalone="true"'));
    expect(html, isNot(contains('aria-label="Incorrect"')));
  });

  test(
    'themes include the shared surface and Win95 system-error treatment',
    () {
      final String shadcnCss = const ShadcnStylesheet().baseCss;
      final String win95Css = const Win95Stylesheet().baseCss;

      expect(shadcnCss, contains('.arcane-not-found-surface'));
      expect(shadcnCss, contains('.arcane-not-found-action-primary'));
      expect(
        win95Css,
        contains('#arcane-root.arcane-theme-win95 .arcane-not-found-surface'),
      );
      expect(win95Css, contains('background: #0000a8 !important'));
      expect(
        win95Css,
        contains(
          '#arcane-root.arcane-theme-win95 .arcane-not-found-action-primary',
        ),
      );
    },
  );
}
