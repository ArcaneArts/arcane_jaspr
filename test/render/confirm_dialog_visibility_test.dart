import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_shadcn/arcane_jaspr_shadcn.dart';
import 'package:jaspr_test/server_test.dart';

const ArcaneStylesheet _sheet = ShadcnStylesheet();

Widget _wrap(Widget child) =>
    ArcaneThemeProvider(stylesheet: _sheet, child: child);

void main() {
  final List<(String, Widget)> cases = <(String, Widget)>[
    (
      'confirm dialog',
      const ArcaneConfirmDialog(title: 'Confirm', message: 'Continue?'),
    ),
    (
      'alert dialog',
      const ArcaneAlertDialog(title: 'Alert', message: 'Notice'),
    ),
  ];

  for (final (String name, Widget widget) in cases) {
    testServer('$name renders as an open surface', (ServerTester tester) async {
      tester.pumpComponent(_wrap(widget));

      final DocumentResponse response = await tester.request('/');

      expect(response.statusCode, 200);
      expect(response.body, contains('data-arcane-surface="dialog"'));
      expect(response.body, contains('data-arcane-state="open"'));
      expect(
        response.body,
        isNot(contains('data-arcane-state="closed" hidden')),
      );
    });
  }
}
