import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:jaspr/jaspr.dart' hide Text;
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
}
