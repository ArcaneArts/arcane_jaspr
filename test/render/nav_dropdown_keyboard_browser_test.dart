@TestOn('browser')
library;

import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:jaspr/jaspr.dart' hide Text;
import 'package:jaspr_test/jaspr_test.dart';
import 'package:web/web.dart' as web;

Finder _trigger() {
  return find.byComponentPredicate(
    (Component component) =>
        component is DomComponent &&
        component.attributes?['role'] == 'button' &&
        component.attributes?['aria-haspopup'] == 'menu',
    description: 'navigation dropdown trigger',
  );
}

void main() {
  testComponents('Enter, Space, and Escape control the dropdown', (
    ComponentTester tester,
  ) async {
    tester.pumpComponent(
      const ArcaneNavDropdown(
        label: 'Game servers',
        width: '240px',
        content: Text('Dropdown content'),
      ),
    );

    tester.dispatchEvent(
      _trigger(),
      'keydown',
      web.KeyboardEvent('keydown', web.KeyboardEventInit(key: 'Enter')),
    );
    await tester.pump();
    expect(find.text('Dropdown content'), findsOneComponent);

    tester.dispatchEvent(
      _trigger(),
      'keydown',
      web.KeyboardEvent('keydown', web.KeyboardEventInit(key: 'Escape')),
    );
    await tester.pump();
    expect(find.text('Dropdown content'), findsNothing);

    tester.dispatchEvent(
      _trigger(),
      'keydown',
      web.KeyboardEvent('keydown', web.KeyboardEventInit(key: ' ')),
    );
    await tester.pump();
    expect(find.text('Dropdown content'), findsOneComponent);

    tester.dispatchEvent(
      _trigger(),
      'keydown',
      web.KeyboardEvent('keydown', web.KeyboardEventInit(key: ' ')),
    );
    await tester.pump();
    expect(find.text('Dropdown content'), findsNothing);
  });
}
