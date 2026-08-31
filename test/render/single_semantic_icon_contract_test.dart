import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_neon/arcane_jaspr_neon.dart';
import 'package:arcane_jaspr_neubrutalism/arcane_jaspr_neubrutalism.dart';
import 'package:arcane_jaspr_shadcn/arcane_jaspr_shadcn.dart';
import 'package:arcane_jaspr_win95/arcane_jaspr_win95.dart';
import 'package:jaspr_test/server_test.dart';

const List<(String, ArcaneStylesheet)> _themes = <(String, ArcaneStylesheet)>[
  ('shadcn', ShadcnStylesheet()),
  ('neon', NeonStylesheet()),
  ('neubrutalism', NeubrutalismStylesheet()),
  ('win95', Win95Stylesheet()),
];

Future<String> _render(
  ServerTester tester,
  ArcaneStylesheet stylesheet,
  Widget child,
) async {
  tester.pumpComponent(
    ArcaneThemeProvider(stylesheet: stylesheet, child: child),
  );
  final DocumentResponse response = await tester.request('/');
  expect(response.statusCode, 200, reason: response.body);
  return response.body;
}

void _expectAtMostOneSemanticIconPerInteractiveRoot(String html) {
  final Iterable<RegExpMatch> roots = RegExp(
    r'<button\b[^>]*>.*?</button>|<a\b[^>]*>.*?</a>',
    caseSensitive: false,
    dotAll: true,
  ).allMatches(html);
  expect(roots, isNotEmpty);
  for (final RegExpMatch root in roots) {
    final String rootHtml = root.group(0)!;
    final int markerCount = RegExp(
      'data-arcane-semantic-icon=',
    ).allMatches(rootHtml).length;
    final int renderedIconCount = RegExp(
      r'<(?:i|svg|img)\b',
      caseSensitive: false,
    ).allMatches(rootHtml).length;
    expect(markerCount, lessThanOrEqualTo(1), reason: rootHtml);
    expect(renderedIconCount, lessThanOrEqualTo(1), reason: rootHtml);
  }
}

void main() {
  for (final (String name, ArcaneStylesheet stylesheet) in _themes) {
    testServer('Button has one typed semantic icon under $name', (
      ServerTester tester,
    ) async {
      final String html = await _render(
        tester,
        stylesheet,
        Button(
          label: 'Deploy',
          icon: ArcaneIcon.arrowRight(size: IconSize.sm),
          iconPosition: ButtonIconPosition.trailing,
          onPressed: () {},
        ),
      );

      _expectAtMostOneSemanticIconPerInteractiveRoot(html);
      expect(RegExp('data-arcane-semantic-icon=').allMatches(html).length, 1);
      expect(html, contains('data-arcane-semantic-icon="trailing"'));
    });

    testServer(
      'FeatureCard has one icon and no manufactured arrow under $name',
      (ServerTester tester) async {
        final String html = await _render(
          tester,
          stylesheet,
          FeatureCard(
            title: 'Local backups',
            description: 'Restore a server without leaving the control panel.',
            icon: ArcaneIcon.archiveRestore(size: IconSize.sm),
            href: '/backups',
            showCta: true,
          ),
        );

        _expectAtMostOneSemanticIconPerInteractiveRoot(html);
        expect(RegExp('data-arcane-semantic-icon=').allMatches(html).length, 1);
        expect(html, contains('data-arcane-surface="feature-card"'));
        expect(html, isNot(contains('→')));
      },
    );

    testServer('loading Button suppresses its semantic icon under $name', (
      ServerTester tester,
    ) async {
      final String html = await _render(
        tester,
        stylesheet,
        Button(
          label: 'Deploying',
          icon: ArcaneIcon.rocket(size: IconSize.sm),
          loading: true,
        ),
      );

      _expectAtMostOneSemanticIconPerInteractiveRoot(html);
      expect(html, isNot(contains('data-arcane-semantic-icon=')));
    });

    testServer('filled clearable date picker has one glyph under $name', (
      ServerTester tester,
    ) async {
      final String html = await _render(
        tester,
        stylesheet,
        ArcaneDatePicker(
          id: 'backup-date',
          value: DateTime(2026, 8, 31),
          onChanged: (_) {},
        ),
      );

      _expectAtMostOneSemanticIconPerInteractiveRoot(html);
      expect(html, contains('aria-label="Clear date"'));
      expect(html, isNot(contains('aria-hidden="true">calendar-days')));
    });

    testServer('custom multi-path badge glyph stays one SVG under $name', (
      ServerTester tester,
    ) async {
      final String html = await _render(
        tester,
        stylesheet,
        ArcaneStatusBadge.info(
          'Crossplay',
          icon: ArcaneIcon.customSvg(
            viewBox: '0 0 16 16',
            paths: const <String>['M1 1h6v6H1z', 'M9 9h6v6H9z'],
            size: IconSize.sm,
          ),
        ),
      );

      expect(RegExp(r'<svg\b').allMatches(html).length, 1);
      expect(RegExp(r'<path\b').allMatches(html).length, 2);
      expect(RegExp(r'<i\b').allMatches(html).length, 0);
    });
  }
}
