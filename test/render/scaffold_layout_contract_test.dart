import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_shadcn/arcane_jaspr_shadcn.dart';
import 'package:arcane_jaspr_win95/arcane_jaspr_win95.dart';
import 'package:jaspr_test/server_test.dart';

const List<(String, bool, bool, String)> _layoutCases =
    <(String, bool, bool, String)>[
      ('body only', false, false, 'minmax(0, 1fr)'),
      ('sidebar only', true, false, 'minmax(0, auto) minmax(0, 1fr)'),
      ('secondary only', false, true, 'minmax(0, 1fr) minmax(0, auto)'),
      (
        'both sidebars',
        true,
        true,
        'minmax(0, auto) minmax(0, 1fr) minmax(0, auto)',
      ),
    ];

const List<(String, ArcaneStylesheet)> _themes = <(String, ArcaneStylesheet)>[
  ('shadcn', ShadcnStylesheet()),
  ('win95', Win95Stylesheet()),
];

Future<String> _render(
  ServerTester tester,
  ArcaneStylesheet stylesheet, {
  required bool sidebar,
  required bool secondary,
  bool footer = false,
  String? title,
}) async {
  tester.pumpComponent(
    ArcaneThemeProvider(
      stylesheet: stylesheet,
      child: ArcaneScaffold(
        title: title,
        sidebar: sidebar ? const Text('sidebar') : null,
        body: const Text('body'),
        secondary: secondary ? const Text('secondary') : null,
        footer: footer ? const Text('footer') : null,
      ),
    ),
  );
  final DocumentResponse response = await tester.request('/');
  expect(response.statusCode, 200, reason: response.body);
  return response.body;
}

String _scaffoldBodyTag(String html) {
  final RegExpMatch? match = RegExp(
    r'<div class="arcane-scaffold-body"[^>]*>',
  ).firstMatch(html);
  expect(match, isNotNull, reason: 'ArcaneScaffold body was not rendered.');
  return match!.group(0)!;
}

String _normalizedCss(String css) => css.replaceAll(RegExp(r'\s+'), ' ').trim();

void _expectColumns(String css, String selector, String columns) {
  expect(
    css,
    contains('$selector { grid-template-columns: $columns !important; }'),
  );
}

void _verifyThemeCss({
  required String css,
  required String themeClass,
  required String sidebarColumns,
  required String secondaryColumns,
  required String bothColumns,
}) {
  final String root = '#arcane-root.$themeClass';
  final String body = '$root .arcane-scaffold-body';
  final String bodyOnly =
      '$body:not([data-has-sidebar]):not([data-has-secondary])';
  final String sidebarOnly =
      '$body[data-has-sidebar]:not([data-has-secondary])';
  final String secondaryOnly =
      '$body:not([data-has-sidebar])[data-has-secondary]';
  final String both = '$body[data-has-sidebar][data-has-secondary]';
  final String normalized = _normalizedCss(css);

  final RegExpMatch? genericRule = RegExp(
    '${RegExp.escape(body)}\\s*\\{([^}]*)\\}',
  ).firstMatch(normalized);
  expect(genericRule, isNotNull);
  expect(
    genericRule!.group(1),
    isNot(contains('grid-template-columns')),
    reason: 'The generic rule must not force a sidebar track.',
  );

  _expectColumns(normalized, bodyOnly, 'minmax(0, 1fr)');
  _expectColumns(normalized, sidebarOnly, sidebarColumns);
  _expectColumns(normalized, secondaryOnly, secondaryColumns);
  _expectColumns(normalized, both, bothColumns);

  expect(
    normalized,
    contains(
      '$bodyOnly, $sidebarOnly, $secondaryOnly, $both { '
      'grid-template-columns: minmax(0, 1fr) !important; }',
    ),
    reason: 'Every desktop layout must collapse to one column below 900px.',
  );
}

void main() {
  for (final (String themeName, ArcaneStylesheet stylesheet) in _themes) {
    for (final (
          String caseName,
          bool hasSidebar,
          bool hasSecondary,
          String inlineColumns,
        )
        in _layoutCases) {
      testServer('$themeName scaffold exposes $caseName layout state', (
        ServerTester tester,
      ) async {
        final String html = await _render(
          tester,
          stylesheet,
          sidebar: hasSidebar,
          secondary: hasSecondary,
        );
        final String bodyTag = _scaffoldBodyTag(html);

        expect(bodyTag.contains('data-has-sidebar'), hasSidebar);
        expect(bodyTag.contains('data-has-secondary'), hasSecondary);
        expect(bodyTag, contains('grid-template-columns: $inlineColumns'));
      });
    }
  }

  test('shadcn CSS maps every scaffold presence state', () {
    _verifyThemeCss(
      css: const ShadcnStylesheet().componentCss,
      themeClass: 'arcane-theme-shadcn',
      sidebarColumns: 'minmax(15rem, 17.5rem) minmax(0, 1fr)',
      secondaryColumns: 'minmax(0, 1fr) minmax(15rem, 18rem)',
      bothColumns: 'minmax(15rem, 17.5rem) minmax(0, 1fr) minmax(15rem, 18rem)',
    );
  });

  test('win95 CSS maps every scaffold presence state without hiding slots', () {
    final String css = const Win95Stylesheet().componentCss;
    _verifyThemeCss(
      css: css,
      themeClass: 'arcane-theme-win95',
      sidebarColumns: 'minmax(13rem, 16rem) minmax(0, 1fr)',
      secondaryColumns: 'minmax(0, 1fr) minmax(13rem, 18rem)',
      bothColumns: 'minmax(13rem, 16rem) minmax(0, 1fr) minmax(13rem, 18rem)',
    );

    final String normalized = _normalizedCss(css);
    expect(
      normalized,
      isNot(
        contains(
          '#arcane-root.arcane-theme-win95 .arcane-scaffold-secondary, '
          '#arcane-root.arcane-theme-win95 .arcane-scaffold-footer { '
          'display: none !important; }',
        ),
      ),
    );
  });

  testServer('win95 keeps secondary and footer slots in rendered output', (
    ServerTester tester,
  ) async {
    final String html = await _render(
      tester,
      const Win95Stylesheet(),
      sidebar: false,
      secondary: true,
      footer: true,
    );

    expect(html, contains('arcane-scaffold-secondary'));
    expect(html, contains('>secondary</span>'));
    expect(html, contains('arcane-scaffold-footer'));
    expect(html, contains('>footer</span>'));
  });

  testServer('win95 renders the supplied scaffold title as real DOM content', (
    ServerTester tester,
  ) async {
    final String html = await _render(
      tester,
      const Win95Stylesheet(),
      sidebar: false,
      secondary: false,
      title: 'Wildlife Control Center',
    );

    final RegExpMatch? header = RegExp(
      r'<header class="arcane-scaffold-header"[^>]*>(.*?)</header>',
      dotAll: true,
    ).firstMatch(html);
    expect(header, isNotNull);
    expect(header!.group(1), contains('class="arcane-scaffold-title"'));
    expect(header.group(1), contains('Wildlife Control Center'));
  });

  test('win95 scaffold chrome contains no inert pseudo controls or copy', () {
    final String css = const Win95Stylesheet().componentCss;

    expect(
      css,
      contains('#arcane-root.arcane-theme-win95 .arcane-scaffold-title {'),
    );
    expect(css, contains('color: var(--w95-title-text) !important;'));

    for (final String forbidden in <String>[
      'Arcane Jaspr Documentation',
      '12:00 PM',
      'content: "Start"',
      'File Edit View Favorites Help',
      '.arcane-scaffold::before',
      '.arcane-scaffold::after',
      '.arcane-scaffold-body::after',
      '.arcane-scaffold-header::before',
      '.arcane-scaffold-header::after',
      '.kb-page-shell::before',
      '.kb-page-shell::after',
      '.kb-scaffold::after',
      '.kb-article-panel::before',
      '.kb-article-panel::after',
      '.kb-topbar::before',
    ]) {
      expect(css, isNot(contains(forbidden)), reason: forbidden);
    }
  });
}
