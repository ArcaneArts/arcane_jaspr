import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_neon/arcane_jaspr_neon.dart';
import 'package:jaspr_test/server_test.dart';

String _extractBody(String html) {
  final RegExpMatch? match = RegExp(
    r'<body[^>]*>(.*)</body>',
    dotAll: true,
  ).firstMatch(html);
  return match?.group(1) ?? html;
}

String _cssRule(String css, String selector) {
  final String normalizedCss = css.replaceAll(RegExp(r'\s+'), ' ');
  final RegExpMatch? match = RegExp(
    '${RegExp.escape(selector)}\\s*\\{([^}]*)\\}',
  ).firstMatch(normalizedCss);
  if (match == null) {
    throw StateError('Missing CSS rule: $selector');
  }
  return match.group(1)!;
}

Future<String> _renderDisclosure(
  ServerTester tester, {
  required bool open,
}) async {
  tester.pumpComponent(
    ArcaneThemeProvider(
      stylesheet: const NeonStylesheet(),
      child: ArcaneDisclosure(
        open: open,
        summary: const Text('Question'),
        child: const Text('Answer'),
      ),
    ),
  );
  final DocumentResponse response = await tester.request('/');
  expect(response.statusCode, 200, reason: response.body);
  return _extractBody(response.body);
}

void main() {
  testServer('Neon disclosure renders one plain plus on the summary row', (
    ServerTester tester,
  ) async {
    final String body = await _renderDisclosure(tester, open: false);
    final RegExpMatch? markerMatch = RegExp(
      r'<span class="neon-disclosure-chevron"[^>]*>\+</span>',
    ).firstMatch(body);

    expect(
      body,
      contains(
        'style="display: flex; align-items: center; '
        'justify-content: space-between;',
      ),
    );
    expect(body, contains('list-style: none'));
    expect(
      RegExp('class="neon-disclosure-chevron"').allMatches(body),
      hasLength(1),
    );
    expect(markerMatch, isNotNull);
    expect(markerMatch!.group(0), contains('aria-hidden="true"'));
    expect(markerMatch.group(0), isNot(contains('background')));
    expect(markerMatch.group(0), isNot(contains('border')));
    expect(markerMatch.group(0), isNot(contains('box-shadow')));
    expect(body, isNot(contains('▼')));
  });

  testServer('Neon disclosure open state uses the same single marker', (
    ServerTester tester,
  ) async {
    final String body = await _renderDisclosure(tester, open: true);

    expect(
      RegExp(r'<details\b[^>]*\bopen(?:="")?[^>]*>').hasMatch(body),
      isTrue,
    );
    expect(
      RegExp('class="neon-disclosure-chevron"').allMatches(body),
      hasLength(1),
    );
  });

  test(
    'Neon disclosure CSS hides native markers and rotates only the plus',
    () {
      final String css = const NeonStylesheet().componentCss;
      final String webkitMarker = _cssRule(
        css,
        '#arcane-root.arcane-theme-neon '
        '.neon-disclosure-summary::-webkit-details-marker',
      );
      final String standardMarker = _cssRule(
        css,
        '#arcane-root.arcane-theme-neon .neon-disclosure-summary::marker',
      );
      final String openMarker = _cssRule(
        css,
        '#arcane-root.arcane-theme-neon '
        '.neon-disclosure[open] > .neon-disclosure-summary > '
        '.neon-disclosure-chevron',
      );

      expect(webkitMarker, contains('display: none'));
      expect(standardMarker, contains("content: ''"));
      expect(openMarker, contains('transform: rotate(45deg)'));
      for (final String forbidden in <String>[
        'background',
        'border',
        'box-shadow',
        'filter',
        'gradient',
      ]) {
        expect(openMarker, isNot(contains(forbidden)), reason: forbidden);
      }
    },
  );
}
