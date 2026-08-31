import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:jaspr/jaspr.dart' hide Text;
import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr_test/jaspr_test.dart';

Finder _trigger() {
  return find.byComponentPredicate(
    (Component component) =>
        component is DomComponent &&
        component.attributes?['role'] == 'button' &&
        component.attributes?['aria-haspopup'] == 'menu',
    description: 'navigation dropdown trigger',
  );
}

Finder _expandedTrigger(bool expanded) {
  return find.byComponentPredicate(
    (Component component) =>
        component is DomComponent &&
        component.attributes?['role'] == 'button' &&
        component.attributes?['tabindex'] == '0' &&
        component.attributes?['aria-haspopup'] == 'menu' &&
        component.attributes?['aria-expanded'] == '$expanded',
    description: '${expanded ? 'expanded' : 'collapsed'} dropdown trigger',
  );
}

Finder _panel() {
  return find.byComponentPredicate(
    (Component component) =>
        component is DomComponent &&
        component.classes?.split(' ').contains('arcane-nav-dropdown-panel') ==
            true,
    description: 'navigation dropdown panel',
  );
}

const ArcaneNavDropdown _dropdown = ArcaneNavDropdown(
  label: 'Game servers',
  width: '240px',
  content: Text('Dropdown content'),
);

void main() {
  testComponents('trigger renders keyboard and menu semantics', (
    ComponentTester tester,
  ) {
    tester.pumpComponent(_dropdown);

    expect(_expandedTrigger(false), findsOneComponent);
    expect(find.text('Dropdown content'), findsNothing);
  });

  testComponents('click opens and closes the dropdown', (
    ComponentTester tester,
  ) async {
    tester.pumpComponent(_dropdown);

    await tester.click(_trigger());
    expect(_expandedTrigger(true), findsOneComponent);
    expect(find.text('Dropdown content'), findsOneComponent);
    expect(_panel(), findsOneComponent);

    await tester.click(_trigger());
    expect(_expandedTrigger(false), findsOneComponent);
    expect(find.text('Dropdown content'), findsNothing);
  });

  testComponents('hover opens and leaving closes the dropdown', (
    ComponentTester tester,
  ) async {
    tester.pumpComponent(_dropdown);

    tester.dispatchEvent(find.byType(ArcaneNavDropdown), 'mouseenter');
    await tester.pump();
    expect(find.text('Dropdown content'), findsOneComponent);

    tester.dispatchEvent(find.byType(ArcaneNavDropdown), 'mouseleave');
    await tester.pump();
    expect(find.text('Dropdown content'), findsNothing);
  });

  testComponents('click after mouseenter keeps the dropdown open', (
    ComponentTester tester,
  ) async {
    tester.pumpComponent(_dropdown);

    tester.dispatchEvent(find.byType(ArcaneNavDropdown), 'mouseenter');
    await tester.pump();
    await tester.click(_trigger());
    tester.dispatchEvent(find.byType(ArcaneNavDropdown), 'mouseleave');
    await tester.pump();

    expect(_expandedTrigger(true), findsOneComponent);
    expect(find.text('Dropdown content'), findsOneComponent);

    await tester.click(_trigger());
    expect(find.text('Dropdown content'), findsNothing);
  });

  testComponents('opening a dropdown closes its open peer', (
    ComponentTester tester,
  ) async {
    tester.pumpComponent(
      const dom.div(<Widget>[
        ArcaneNavDropdown(
          label: 'Game servers',
          width: '240px',
          content: Text('Game server links'),
        ),
        ArcaneNavDropdown(
          label: 'Resources',
          width: '240px',
          content: Text('Resource links'),
        ),
      ]),
    );

    await tester.click(_trigger().first);
    expect(find.text('Game server links'), findsOneComponent);
    expect(find.text('Resource links'), findsNothing);

    await tester.click(_trigger().last);
    expect(find.text('Game server links'), findsNothing);
    expect(find.text('Resource links'), findsOneComponent);
    expect(_expandedTrigger(true), findsOneComponent);
    expect(_expandedTrigger(false), findsOneComponent);
  });
}
