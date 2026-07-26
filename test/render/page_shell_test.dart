import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr/stylesheets/base_css.dart';
import 'package:arcane_jaspr_shadcn/arcane_jaspr_shadcn.dart';
import 'package:arcane_jaspr_win95/arcane_jaspr_win95.dart';
import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr_test/server_test.dart';

Future<String> _render(ServerTester tester, Widget widget) async {
  tester.pumpComponent(
    ArcaneThemeProvider(stylesheet: const ShadcnStylesheet(), child: widget),
  );
  final DocumentResponse response = await tester.request('/');
  expect(response.statusCode, 200, reason: response.body);
  return response.body;
}

String _openingTagForClass(String html, String className) {
  final Iterable<RegExpMatch> matches = RegExp(
    r'<[^>]+class="([^"]*)"[^>]*>',
  ).allMatches(html);
  for (final RegExpMatch match in matches) {
    final List<String> classes = match.group(1)!.split(' ');
    if (classes.contains(className)) {
      return match.group(0)!;
    }
  }
  fail('Missing .$className in rendered HTML');
}

String _ruleBody(String css, String selector) {
  final RegExpMatch? match = RegExp(
    '${RegExp.escape(selector)}\\s*\\{([^}]*)\\}',
    multiLine: true,
  ).firstMatch(css);
  if (match == null) {
    fail('Missing CSS rule for $selector');
  }
  return match.group(1)!;
}

void main() {
  testServer('standalone page emits a labeled main and level-one heading', (
    ServerTester tester,
  ) async {
    final String html = await _render(
      tester,
      const ArcanePage(
        id: 'settings-page',
        eyebrow: 'Workspace',
        title: 'Settings <and> tools',
        description: 'Configure the reusable shell.',
        actions: <Widget>[
          dom.a(href: '/save', <Widget>[Widget.text('Save')]),
        ],
        body: dom.div(classes: 'example-body', <Widget>[
          Widget.text('Page body'),
        ]),
        classes: 'example-page',
        attributes: <String, String>{
          'data-test-id': 'settings',
          'data-arcane-page-width': 'application-cannot-override-this',
        },
      ),
    );

    final String root = _openingTagForClass(html, 'arcane-page');
    expect(root, startsWith('<main'));
    expect(root, contains('id="settings-page"'));
    expect(
      root,
      contains('class="arcane-page arcane-page-standard example-page"'),
    );
    expect(root, contains('aria-labelledby="settings-page-title"'));
    expect(root, contains('data-test-id="settings"'));
    expect(root, contains('data-arcane-page="true"'));
    expect(root, contains('data-arcane-page-width="standard"'));
    expect(root, contains('data-arcane-page-standalone="true"'));
    expect(
      html,
      contains(
        '<h1 id="settings-page-title" class="arcane-page-title">'
        'Settings &lt;and&gt; tools</h1>',
      ),
    );
    expect(html, contains('class="arcane-page-eyebrow">Workspace</p>'));
    expect(
      html,
      contains(
        'class="arcane-page-actions" role="group" '
        'aria-label="Page actions"',
      ),
    );
    expect(html, contains('class="arcane-page-body"'));
    expect(html, contains('class="example-body">Page body</div>'));
  });

  testServer('embedded page avoids a nested main landmark', (
    ServerTester tester,
  ) async {
    final String html = await _render(
      tester,
      const ArcanePage(
        id: 'embedded-report',
        title: 'Embedded report',
        semanticLabel: 'Report workspace',
        width: ArcanePageWidth.reading,
        standalone: false,
        body: dom.p(<Widget>[Widget.text('Report body')]),
      ),
    );

    final String root = _openingTagForClass(html, 'arcane-page');
    expect(root, startsWith('<section'));
    expect(root, contains('class="arcane-page arcane-page-reading"'));
    expect(root, contains('aria-label="Report workspace"'));
    expect(root, isNot(contains('aria-labelledby')));
    expect(root, contains('data-arcane-page-width="reading"'));
    expect(root, contains('data-arcane-page-standalone="false"'));
    expect(
      html,
      contains('<h2 id="embedded-report-title" class="arcane-page-title"'),
    );
    expect(html, isNot(contains('<main')));
    expect(html, isNot(contains('<h1')));
    expect(html, isNot(contains('arcane-page-actions')));
  });

  for (final ArcanePageWidth width in ArcanePageWidth.values) {
    testServer('${width.name} width has stable class and data hooks', (
      ServerTester tester,
    ) async {
      final String html = await _render(
        tester,
        ArcanePage(
          title: '${width.name} page',
          width: width,
          body: const dom.div(<Widget>[Widget.text('Body')]),
        ),
      );

      final String root = _openingTagForClass(html, 'arcane-page');
      expect(root, contains('arcane-page-${width.name}'));
      expect(root, contains('data-arcane-page-width="${width.name}"'));
    });
  }

  test('shared CSS defines responsive sizing and shrink-safe contracts', () {
    const String css = ArcaneBaseCss.shared;
    final String page = _ruleBody(css, '.arcane-page');
    final String header = _ruleBody(css, '.arcane-page-header');
    final String heading = _ruleBody(css, '.arcane-page-heading');
    final String actions = _ruleBody(css, '.arcane-page-actions');
    final String body = _ruleBody(css, '.arcane-page-body');

    expect(
      page,
      contains('--arcane-page-inline-gutter: clamp(1rem, 4vw, 3rem)'),
    );
    expect(page, contains('max-width: var(--arcane-page-max-width)'));
    expect(page, contains('min-width: 0'));
    expect(page, contains('grid-template-columns: minmax(0, 1fr)'));
    expect(header, contains('min-width: 0'));
    expect(header, contains('flex-wrap: wrap'));
    expect(heading, contains('min-width: 0'));
    expect(actions, contains('min-width: 0'));
    expect(actions, contains('flex-wrap: wrap'));
    expect(body, contains('min-width: 0'));

    expect(
      _ruleBody(css, '.arcane-page-wide'),
      contains('--arcane-page-max-width: 90rem'),
    );
    expect(
      _ruleBody(css, '.arcane-page-reading'),
      contains('--arcane-page-max-width: 48rem'),
    );
    expect(
      _ruleBody(css, '.arcane-page-workbench'),
      contains('--arcane-page-max-width: 100rem'),
    );
    expect(
      _ruleBody(css, '.arcane-page-full'),
      contains('--arcane-page-inline-gutter: 0px'),
    );
    expect(
      css,
      contains(
        '.arcane-page-media {\n'
        '  --arcane-page-inline-gutter: clamp(0.5rem, 1.5vw, 1.5rem);',
      ),
    );
    expect(css, contains('@media (max-width: 48rem)'));
  });

  test('ShadCN and Win95 both receive the shared page shell', () {
    final String shadcnCss = const ShadcnStylesheet().baseCss;
    final String win95Css = const Win95Stylesheet().baseCss;

    for (final String css in <String>[shadcnCss, win95Css]) {
      expect(css, contains('.arcane-page {'));
      expect(css, contains('.arcane-page-header {'));
      expect(css, contains('.arcane-page-actions {'));
      expect(css, contains('.arcane-page-full'));
      expect(css, contains('.arcane-page-media'));
    }

    final String win95Page = _ruleBody(
      win95Css,
      '#arcane-root.arcane-theme-win95 .arcane-page',
    );
    expect(win95Page, contains('background: var(--w95-face)'));
    expect(win95Page, contains('color: var(--w95-face-text)'));
    expect(win95Page, contains('box-shadow: var(--w95-raised)'));
  });
}
