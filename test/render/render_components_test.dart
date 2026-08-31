// Breadth render smoke tests for the full exported component surface.
//
// Every exported widget is constructed with a minimal valid instance (see
// component_cases.dart) and server-rendered inside an ArcaneThemeProvider using
// the shadcn stylesheet. A throw during build surfaces as an HTTP 500 from the
// jaspr server tester (verified empirically), so `expect(statusCode, 200)` is
// the safety net that will catch breakage during the upcoming renderer refactor.

import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_shadcn/arcane_jaspr_shadcn.dart';
import 'package:jaspr_test/server_test.dart';

import 'component_cases.dart';

const ArcaneStylesheet _sheet = ShadcnStylesheet(theme: ShadcnTheme.midnight);

Widget _wrap(Widget child) =>
    ArcaneThemeProvider(stylesheet: _sheet, child: child);

bool _hasNestedSurface(String html) {
  const Set<String> voidTags = <String>{
    'area',
    'base',
    'br',
    'col',
    'embed',
    'hr',
    'img',
    'input',
    'link',
    'meta',
    'param',
    'source',
    'track',
    'wbr',
  };
  final List<bool> surfaceStack = <bool>[];
  int surfaceDepth = 0;
  final RegExp tags = RegExp(
    r'<(/?)([A-Za-z][A-Za-z0-9:-]*)\b([^>]*)>',
    dotAll: true,
  );

  for (final RegExpMatch match in tags.allMatches(html)) {
    final bool closing = match.group(1) == '/';
    final String tag = match.group(2)!.toLowerCase();
    final String attributes = match.group(3)!;
    if (closing) {
      if (surfaceStack.isNotEmpty && surfaceStack.removeLast()) {
        surfaceDepth--;
      }
      continue;
    }

    final bool isSurface = RegExp(
      r'\bdata-arcane-surface\s*=',
      caseSensitive: false,
    ).hasMatch(attributes);
    final bool isHidden = RegExp(
      r'\bhidden(?:\s|=|$)|\bdata-arcane-state\s*=\s*["\x27]closed["\x27]',
      caseSensitive: false,
    ).hasMatch(attributes);
    final bool isVisibleSurface = isSurface && !isHidden;
    if (isVisibleSurface && surfaceDepth > 0) return true;
    if (attributes.trimRight().endsWith('/') || voidTags.contains(tag)) {
      continue;
    }
    surfaceStack.add(isVisibleSurface);
    if (isVisibleSurface) surfaceDepth++;
  }
  return false;
}

void main() {
  for (final (String name, Widget widget) in componentCases()) {
    testServer('renders $name without throwing', (ServerTester tester) async {
      tester.pumpComponent(_wrap(widget));
      final DocumentResponse res = await tester.request('/');
      expect(
        res.statusCode,
        200,
        reason: '$name failed to render server-side:\n${res.body}',
      );
      expect(res.body.isNotEmpty, isTrue, reason: '$name produced empty body');
      expect(
        _hasNestedSurface(res.body),
        isFalse,
        reason: '$name rendered one data-arcane-surface inside another',
      );
    });
  }

  for (final (String name, Widget widget) in formFieldCases()) {
    testServer('renders $name without throwing', (ServerTester tester) async {
      tester.pumpComponent(_wrap(widget));
      final DocumentResponse res = await tester.request('/');
      expect(res.statusCode, 200, reason: res.body);
    });
  }
}
