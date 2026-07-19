// Contract tests locking the Dart ArcaneInteraction encoder to the JavaScript
// runtime parser/dispatcher.
//
// The Dart side (lib/core/interaction/interaction.dart) encodes interactions
// into compact strings such as `surface.open dialog <id>`. The JS runtime
// (lib/core/interaction/runtime/runtime_dispatch_js.dart `runAction`) parses
// those strings and dispatches on the leading verb token. These tests pin:
//   1. The exact encoded output of every ArcaneInteraction factory (goldens).
//   2. That every encoded verb is one the JS `runAction` switch handles.
//   3. That `.then()` / compose / encodeArcaneActions flatten and join with `;`.
//   4. That values containing the structural separators (space, `;`, `/`) and
//      unicode survive a full encode -> split -> Uri.decodeComponent round-trip.
//   5. That JSON-payload actions (toast.show, event.dispatch) decode back to the
//      original map.

import 'dart:convert';

import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:jaspr_test/jaspr_test.dart';

/// The complete set of verbs the JS `runAction` switch in
/// runtime_dispatch_js.dart dispatches on. Kept in sync manually; the
/// membership tests below fail if the Dart encoder ever emits a verb absent
/// from this set.
const Set<String> jsHandledVerbs = <String>{
  'noop',
  'surface.open',
  'surface.close',
  'surface.toggle',
  'surface.dismiss',
  'value.set',
  'value.toggle',
  'value.clear',
  'tab.activate',
  'panel.expand',
  'panel.collapse',
  'panel.toggle',
  'step.go',
  'page.go',
  'carousel.go',
  'slider.set',
  'cycle.next',
  'cycle.prev',
  'calendar.prev',
  'calendar.next',
  'calendar.today',
  'calendar.select',
  'command.filter',
  'command.selectFirst',
  'form.submit',
  'form.reset',
  'form.validate',
  'field.set',
  'copy',
  'nav.go',
  'nav.external',
  'nav.back',
  'theme.mode.set',
  'theme.mode.toggle',
  'theme.stylesheet.set',
  'theme.palette.set',
  'toast.show',
  'event.dispatch',
  'script.run',
};

/// Golden table: every ArcaneInteraction factory paired with its exact encoded
/// string. Arguments are alphanumeric so the encoded form is identity-encoded
/// (Uri.encodeComponent leaves [A-Za-z0-9] untouched), keeping goldens literal.
final List<(String name, ArcaneInteraction action, String expected)>
    goldens = <(String, ArcaneInteraction, String)>[
  ('noop', ArcaneInteraction.noop, 'noop'),
  // Surfaces -------------------------------------------------------------
  ('openDialog', ArcaneInteraction.openDialog('d1'), 'surface.open dialog d1'),
  (
    'closeDialog(id)',
    ArcaneInteraction.closeDialog('d1'),
    'surface.close dialog d1'
  ),
  ('closeDialog()', ArcaneInteraction.closeDialog(), 'surface.close dialog'),
  (
    'toggleDialog',
    ArcaneInteraction.toggleDialog('d1'),
    'surface.toggle dialog d1'
  ),
  ('openSheet', ArcaneInteraction.openSheet('s1'), 'surface.open sheet s1'),
  ('closeSheet()', ArcaneInteraction.closeSheet(), 'surface.close sheet'),
  ('toggleSheet', ArcaneInteraction.toggleSheet('s1'), 'surface.toggle sheet s1'),
  ('openDrawer', ArcaneInteraction.openDrawer('dr'), 'surface.open drawer dr'),
  ('closeDrawer()', ArcaneInteraction.closeDrawer(), 'surface.close drawer'),
  (
    'toggleDrawer',
    ArcaneInteraction.toggleDrawer('dr'),
    'surface.toggle drawer dr'
  ),
  ('openPopover', ArcaneInteraction.openPopover('p1'), 'surface.open popover p1'),
  ('closePopover()', ArcaneInteraction.closePopover(), 'surface.close popover'),
  (
    'togglePopover',
    ArcaneInteraction.togglePopover('p1'),
    'surface.toggle popover p1'
  ),
  ('openCommand', ArcaneInteraction.openCommand('c1'), 'surface.open command c1'),
  ('closeCommand()', ArcaneInteraction.closeCommand(), 'surface.close command'),
  (
    'toggleCommand',
    ArcaneInteraction.toggleCommand('c1'),
    'surface.toggle command c1'
  ),
  ('openMenu', ArcaneInteraction.openMenu('m1'), 'surface.open menu m1'),
  ('closeMenu()', ArcaneInteraction.closeMenu(), 'surface.close menu'),
  ('toggleMenu', ArcaneInteraction.toggleMenu('m1'), 'surface.toggle menu m1'),
  (
    'openContextMenu',
    ArcaneInteraction.openContextMenu('cm'),
    'surface.open context-menu cm'
  ),
  (
    'closeContextMenu()',
    ArcaneInteraction.closeContextMenu(),
    'surface.close context-menu'
  ),
  (
    'openTooltip',
    ArcaneInteraction.openTooltip('t1'),
    'surface.open tooltip t1'
  ),
  (
    'closeTooltip()',
    ArcaneInteraction.closeTooltip(),
    'surface.close tooltip'
  ),
  (
    'openMobileMenu',
    ArcaneInteraction.openMobileMenu('mm'),
    'surface.open mobile-menu mm'
  ),
  (
    'closeMobileMenu()',
    ArcaneInteraction.closeMobileMenu(),
    'surface.close mobile-menu'
  ),
  (
    'toggleMobileMenu',
    ArcaneInteraction.toggleMobileMenu('mm'),
    'surface.toggle mobile-menu mm'
  ),
  ('dismissParent', ArcaneInteraction.dismissParent, 'surface.dismiss'),
  // Value groups ---------------------------------------------------------
  ('selectValue', ArcaneInteraction.selectValue('g1', 'v1'), 'value.set g1 v1'),
  (
    'toggleValue',
    ArcaneInteraction.toggleValue('g1', 'v1'),
    'value.toggle g1 v1'
  ),
  ('clearValue', ArcaneInteraction.clearValue('g1'), 'value.clear g1'),
  // Tabs / panels --------------------------------------------------------
  (
    'activateTab',
    ArcaneInteraction.activateTab('g1', 't1'),
    'tab.activate g1 t1'
  ),
  (
    'expandPanel',
    ArcaneInteraction.expandPanel('g1', 'p1'),
    'panel.expand g1 p1'
  ),
  (
    'collapsePanel',
    ArcaneInteraction.collapsePanel('g1', 'p1'),
    'panel.collapse g1 p1'
  ),
  (
    'togglePanel',
    ArcaneInteraction.togglePanel('g1', 'p1'),
    'panel.toggle g1 p1'
  ),
  // Steps / pages / carousel --------------------------------------------
  ('nextStep', ArcaneInteraction.nextStep('g1'), 'step.go g1 next'),
  ('prevStep', ArcaneInteraction.prevStep('g1'), 'step.go g1 prev'),
  ('goToStep', ArcaneInteraction.goToStep('g1', 3), 'step.go g1 3'),
  ('goToPage', ArcaneInteraction.goToPage('g1', 2), 'page.go g1 2'),
  ('nextPage', ArcaneInteraction.nextPage('g1'), 'page.go g1 next'),
  ('prevPage', ArcaneInteraction.prevPage('g1'), 'page.go g1 prev'),
  ('carouselNext', ArcaneInteraction.carouselNext('g1'), 'carousel.go g1 next'),
  ('carouselPrev', ArcaneInteraction.carouselPrev('g1'), 'carousel.go g1 prev'),
  (
    'carouselGoTo',
    ArcaneInteraction.carouselGoTo('g1', 4),
    'carousel.go g1 4'
  ),
  // Slider ---------------------------------------------------------------
  (
    'setSlider(default role)',
    ArcaneInteraction.setSlider('sl', 0.5),
    'slider.set sl 0.5 value'
  ),
  (
    'setSlider(role)',
    ArcaneInteraction.setSlider('sl', 0.25, 'min'),
    'slider.set sl 0.25 min'
  ),
  // Cycle ----------------------------------------------------------------
  ('cycleNext', ArcaneInteraction.cycleNext('g1'), 'cycle.next g1'),
  ('cyclePrev', ArcaneInteraction.cyclePrev('g1'), 'cycle.prev g1'),
  // Calendar -------------------------------------------------------------
  ('calendarPrev', ArcaneInteraction.calendarPrev('cal'), 'calendar.prev cal'),
  ('calendarNext', ArcaneInteraction.calendarNext('cal'), 'calendar.next cal'),
  (
    'calendarToday',
    ArcaneInteraction.calendarToday('cal'),
    'calendar.today cal'
  ),
  (
    'calendarSelect',
    ArcaneInteraction.calendarSelect('cal', '2026-01-02'),
    'calendar.select cal 2026-01-02'
  ),
  // Forms ----------------------------------------------------------------
  ('submitForm', ArcaneInteraction.submitForm('f1'), 'form.submit f1'),
  ('resetForm', ArcaneInteraction.resetForm('f1'), 'form.reset f1'),
  (
    'setField',
    ArcaneInteraction.setField('f1', 'email', 'joe'),
    'field.set f1 email joe'
  ),
  // Copy -----------------------------------------------------------------
  ('copy', ArcaneInteraction.copy('hello'), 'copy hello'),
  (
    'copy(feedback)',
    ArcaneInteraction.copy('hello', feedback: 'Copied'),
    'copy hello Copied'
  ),
  // Navigation -----------------------------------------------------------
  ('navigateBack', ArcaneInteraction.navigateBack, 'nav.back'),
  // Theme ----------------------------------------------------------------
  (
    'setThemeMode',
    ArcaneInteraction.setThemeMode('dark'),
    'theme.mode.set dark'
  ),
  (
    'toggleThemeMode',
    ArcaneInteraction.toggleThemeMode,
    'theme.mode.toggle'
  ),
  (
    'setStylesheet',
    ArcaneInteraction.setStylesheet('shadcn'),
    'theme.stylesheet.set shadcn'
  ),
  // Dispatch -------------------------------------------------------------
  (
    'dispatch(no detail)',
    ArcaneInteraction.dispatch('ready'),
    'event.dispatch ready'
  ),
  // Script ---------------------------------------------------------------
  ('script(no args)', ArcaneInteraction.script('fn'), 'script.run fn'),
  (
    'script(args)',
    ArcaneInteraction.script('fn', <String>['a', 'b']),
    'script.run fn a b'
  ),
];

void main() {
  group('Golden encodings (Dart encoder output is pinned)', () {
    for (final (String name, ArcaneInteraction action, String expected)
        in goldens) {
      test('$name encodes to "$expected"', () {
        expect(action.encode(), expected);
      });
    }
  });

  group('Every encoded verb is dispatched by the JS runtime', () {
    for (final (String name, ArcaneInteraction action, String _) in goldens) {
      test('$name verb is JS-handled', () {
        final String encoded = action.encode();
        final String verb = encoded.split(' ').first;
        expect(
          jsHandledVerbs.contains(verb),
          isTrue,
          reason: '$name produced verb "$verb" not handled by JS runAction',
        );
      });
    }

    test('factories using "/" arguments still emit a handled verb', () {
      // navigate and setPalette encode "/" inside arguments. The verb (first
      // whitespace token) must remain a handled verb regardless.
      final List<ArcaneInteraction> slashCases = <ArcaneInteraction>[
        ArcaneInteraction.navigate('/home'),
        ArcaneInteraction.navigate('https://x.com', external: true),
        ArcaneInteraction.setPalette('shadcn', 'midnight'),
        ArcaneInteraction.showToast('hi'),
      ];
      for (final ArcaneInteraction action in slashCases) {
        final String verb = action.encode().split(' ').first;
        expect(jsHandledVerbs.contains(verb), isTrue,
            reason: 'verb "$verb" not handled');
      }
    });

    test('the full Dart verb set is a subset of JS-handled verbs', () {
      final Set<String> dartVerbs = <String>{
        for (final (String _, ArcaneInteraction action, String _) in goldens)
          action.encode().split(' ').first,
        ArcaneInteraction.navigate('/x').encode().split(' ').first,
        ArcaneInteraction.navigate('/x', external: true)
            .encode()
            .split(' ')
            .first,
        ArcaneInteraction.setPalette('a', 'b').encode().split(' ').first,
        ArcaneInteraction.showToast('m').encode().split(' ').first,
        ArcaneInteraction.dispatch('e', detail: const <String, String>{'a': 'b'})
            .encode()
            .split(' ')
            .first,
      };
      expect(dartVerbs.difference(jsHandledVerbs), isEmpty,
          reason: 'Dart emits verbs the JS runtime does not handle');
    });
  });

  group('Navigation and palette "/" encoding', () {
    test('navigate encodes the path so "/" does not split into tokens', () {
      final String encoded = ArcaneInteraction.navigate('/home/page').encode();
      expect(encoded, 'nav.go ${Uri.encodeComponent('/home/page')}');
      // Exactly two whitespace tokens: verb + single encoded href.
      expect(encoded.split(' ').length, 2);
      final List<String> tokens = encoded.split(' ');
      expect(Uri.decodeComponent(tokens[1]), '/home/page');
    });

    test('external navigate encodes scheme and slashes', () {
      final String encoded =
          ArcaneInteraction.navigate('https://x.com/a', external: true).encode();
      expect(encoded, 'nav.external ${Uri.encodeComponent('https://x.com/a')}');
      expect(encoded.split(' ').length, 2);
    });

    test('setPalette joins ids with "/" then encodes; JS split("/") recovers it',
        () {
      final String encoded =
          ArcaneInteraction.setPalette('shadcn', 'midnight').encode();
      expect(encoded, 'theme.palette.set ${Uri.encodeComponent('shadcn/midnight')}');
      final List<String> tokens = encoded.split(' ');
      expect(tokens.length, 2);
      // Mirror the JS dispatcher: dec(arg) then split('/').
      final String decoded = Uri.decodeComponent(tokens[1]);
      final List<String> parts = decoded.split('/');
      expect(parts, <String>['shadcn', 'midnight']);
    });
  });

  group('.then() / compose / encodeArcaneActions', () {
    final ArcaneInteraction a = ArcaneInteraction.openDialog('a');
    final ArcaneInteraction b = ArcaneInteraction.closeDialog('a');
    const ArcaneInteraction c = ArcaneInteraction.navigateBack;

    test('two actions join with ";"', () {
      expect(a.then(b).encode(), 'surface.open dialog a;surface.close dialog a');
    });

    test('left-associative chaining flattens to three parts', () {
      expect(
        a.then(b).then(c).encode(),
        'surface.open dialog a;surface.close dialog a;nav.back',
      );
    });

    test('right-nested chaining flattens identically', () {
      expect(
        a.then(b.then(c)).encode(),
        'surface.open dialog a;surface.close dialog a;nav.back',
      );
    });

    test('compose matches the chained form', () {
      expect(
        ArcaneInteraction.compose(<ArcaneInteraction>[a, b, c]).encode(),
        a.then(b).then(c).encode(),
      );
    });

    test('encodeArcaneActions joins a list with ";"', () {
      expect(
        encodeArcaneActions(<ArcaneInteraction>[a, b]),
        'surface.open dialog a;surface.close dialog a',
      );
    });

    test('encodeArcaneAction wraps a single action', () {
      expect(encodeArcaneAction(a), 'surface.open dialog a');
    });

    test('interactionAttrs exposes the encoded action under data-arcane-action',
        () {
      expect(
        interactionAttrs(a),
        <String, String>{'data-arcane-action': 'surface.open dialog a'},
      );
      expect(interactionAttrs(null), const <String, String>{});
    });
  });

  group('Separator-safe round-trip (the XSS / parser concern)', () {
    // Values that contain the structural separators used by the runtime:
    // ';' separates actions, whitespace separates a verb from its args, and
    // '/' is meaningful to palette parsing. Unicode must survive too.
    const List<String> hostileValues = <String>[
      'with space',
      'semi;colon',
      'slash/path',
      'cafe-unicode-éüñ',
      'a;b c/d e',
      '"><script>alert(1)</script>',
      'tab\tafter',
    ];

    for (final String value in hostileValues) {
      test('value ${jsonEncode(value)} survives encode->split->decode', () {
        final ArcaneInteraction action =
            ArcaneInteraction.selectValue('grp', value);
        final String encoded = action.encode();

        // Mirror JS parseActions: split on ';' to separate actions.
        final List<String> actions = encoded.split(';');
        expect(actions.length, 1,
            reason: 'a raw ";" leaked and split the action: $encoded');

        // Mirror JS parseAction: split on whitespace to separate verb + args.
        final List<String> tokens = actions.single.split(RegExp(r'\s+'));
        expect(tokens.length, 3,
            reason: 'raw whitespace leaked and split the args: $encoded');
        expect(tokens[0], 'value.set');
        expect(tokens[1], 'grp');

        // Mirror JS dec(): decodeURIComponent recovers the original value.
        expect(Uri.decodeComponent(tokens[2]), value);
      });
    }

    test('field.set keeps three distinct args even with hostile values', () {
      const String formId = 'a b';
      const String field = 'na/me';
      const String value = 'x;y z';
      final String encoded =
          ArcaneInteraction.setField(formId, field, value).encode();
      final List<String> tokens = encoded.split(';').single.split(RegExp(r'\s+'));
      expect(tokens.length, 4);
      expect(tokens[0], 'field.set');
      expect(Uri.decodeComponent(tokens[1]), formId);
      expect(Uri.decodeComponent(tokens[2]), field);
      expect(Uri.decodeComponent(tokens[3]), value);
    });
  });

  group('JSON payload actions decode back to the original map', () {
    test('toast.show encodes valid JSON that decodes to the payload', () {
      final ArcaneInteraction action = ArcaneInteraction.showToast(
        'Hi there; friend',
        variant: 'success',
        durationMs: 3000,
        title: 'All done',
      );
      final String encoded = action.encode();
      final List<String> tokens = encoded.split(' ');
      // toast.show payload has no literal spaces once encoded -> 2 tokens.
      expect(tokens.length, 2);
      expect(tokens[0], 'toast.show');

      final Map<String, dynamic> payload =
          jsonDecode(Uri.decodeComponent(tokens[1])) as Map<String, dynamic>;
      expect(payload['message'], 'Hi there; friend');
      expect(payload['variant'], 'success');
      expect(payload['duration'], 3000);
      expect(payload['title'], 'All done');
    });

    test('toast.show omits duration and title when not provided', () {
      final Map<String, dynamic> payload = jsonDecode(
        Uri.decodeComponent(
          ArcaneInteraction.showToast('plain').encode().split(' ')[1],
        ),
      ) as Map<String, dynamic>;
      expect(payload, <String, dynamic>{'message': 'plain', 'variant': 'info'});
    });

    test('event.dispatch with detail decodes to the original map', () {
      final ArcaneInteraction action = ArcaneInteraction.dispatch(
        'user:login',
        detail: const <String, String>{'id': '42', 'name': 'a b'},
      );
      final String encoded = action.encode();
      final List<String> tokens = encoded.split(' ');
      expect(tokens.length, 3);
      expect(tokens[0], 'event.dispatch');
      expect(Uri.decodeComponent(tokens[1]), 'user:login');

      final Map<String, dynamic> detail =
          jsonDecode(Uri.decodeComponent(tokens[2])) as Map<String, dynamic>;
      expect(detail, <String, String>{'id': '42', 'name': 'a b'});
    });
  });
}
