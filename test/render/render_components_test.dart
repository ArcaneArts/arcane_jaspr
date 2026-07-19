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
    });
  }

  for (final (String name, Widget widget) in formFieldCases()) {
    testServer(
      'renders $name without throwing',
      (ServerTester tester) async {
        tester.pumpComponent(_wrap(widget));
        final DocumentResponse res = await tester.request('/');
        expect(res.statusCode, 200, reason: res.body);
      },
    );
  }
}
