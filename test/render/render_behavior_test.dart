// Targeted behavioral render tests for the interactive data-attribute contract.
//
// These assert that the encoded ArcaneInteraction strings and surface metadata
// actually reach the rendered HTML, where the JS runtime reads them. The
// breadth suite (render_components_test.dart) guards "does not throw"; this
// suite guards "emits the right wiring".

import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_shadcn/arcane_jaspr_shadcn.dart';
import 'package:jaspr_test/server_test.dart';

const ArcaneStylesheet _sheet = ShadcnStylesheet(theme: ShadcnTheme.midnight);

Widget _wrap(Widget child) =>
    ArcaneThemeProvider(stylesheet: _sheet, child: child);

/// Returns the value of the first occurrence of [attr] in [html], or null.
String? _attr(String html, String attr) {
  final RegExpMatch? match =
      RegExp('$attr="([^"]*)"').firstMatch(html);
  return match?.group(1);
}

Future<String> _render(ServerTester tester, Widget widget) async {
  tester.pumpComponent(_wrap(widget));
  final DocumentResponse res = await tester.request('/');
  expect(res.statusCode, 200, reason: res.body);
  return res.body;
}

void main() {
  group('Button carries data-arcane-action', () {
    testServer('single interaction encodes onto the element', (
      ServerTester tester,
    ) async {
      final ArcaneInteraction action = ArcaneInteraction.openDialog('settings');
      final String html =
          await _render(tester, Button(label: 'Open', action: action));
      expect(_attr(html, 'data-arcane-action'), action.encode());
      expect(_attr(html, 'data-arcane-action'), 'surface.open dialog settings');
    });

    testServer('composed interaction is joined with ";"', (
      ServerTester tester,
    ) async {
      final ArcaneInteraction action = ArcaneInteraction.openDialog('a')
          .then(ArcaneInteraction.showToast('done'));
      final String html =
          await _render(tester, Button(label: 'Go', action: action));
      expect(_attr(html, 'data-arcane-action'), encodeArcaneAction(action));
      expect(_attr(html, 'data-arcane-action')!.contains(';'), isTrue);
    });

    testServer('special characters survive into the attribute value', (
      ServerTester tester,
    ) async {
      final ArcaneInteraction action = ArcaneInteraction.copy('a/b c');
      final String html =
          await _render(tester, Button(label: 'Copy', action: action));
      final String? value = _attr(html, 'data-arcane-action');
      expect(value, action.encode());
      // No raw separators leaked into the encoded args.
      expect(value, 'copy ${Uri.encodeComponent('a/b c')}');
    });
  });

  group('Surfaces emit data-arcane-surface / data-arcane-id / state', () {
    testServer('ArcaneDialog (open)', (ServerTester tester) async {
      final String html = await _render(
        tester,
        const ArcaneDialog(id: 'dlg1', isOpen: true, child: Text('body')),
      );
      expect(_attr(html, 'data-arcane-surface'), 'dialog');
      expect(_attr(html, 'data-arcane-id'), 'dlg1');
      expect(_attr(html, 'data-arcane-state'), 'open');
    });

    testServer('ArcaneSheet (open)', (ServerTester tester) async {
      final String html = await _render(
        tester,
        const ArcaneSheet(id: 'sheet1', isOpen: true, child: Text('body')),
      );
      expect(_attr(html, 'data-arcane-surface'), 'sheet');
      expect(_attr(html, 'data-arcane-id'), 'sheet1');
      expect(_attr(html, 'data-arcane-state'), 'open');
    });

    testServer('ArcaneDrawer (closed) reports closed state', (
      ServerTester tester,
    ) async {
      final String html = await _render(
        tester,
        const ArcaneDrawer(id: 'drawer1', isOpen: false, child: Text('body')),
      );
      expect(_attr(html, 'data-arcane-surface'), 'drawer');
      expect(_attr(html, 'data-arcane-id'), 'drawer1');
      expect(_attr(html, 'data-arcane-state'), 'closed');
    });
  });
}
