// Functional proof of the M0 permeability seam: the SAME authored decoration /
// styles render into theme-authentic CSS across all three stylesheets, and the
// literal `styles:` escape hatch wins over the theme.
//
// This does not depend on the golden snapshots — it asserts the specific CSS
// each theme emits (or ignores) for a shared ArcaneDecoration.

import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_neon/arcane_jaspr_neon.dart';
import 'package:arcane_jaspr_neubrutalism/arcane_jaspr_neubrutalism.dart';
import 'package:arcane_jaspr_shadcn/arcane_jaspr_shadcn.dart';
import 'package:jaspr_test/server_test.dart';

const ArcaneStylesheet _shadcn = ShadcnStylesheet();
const ArcaneStylesheet _neon = NeonStylesheet();
const ArcaneStylesheet _neubrutalism = NeubrutalismStylesheet();

Future<String> _render(
  ServerTester tester,
  ArcaneStylesheet sheet,
  Widget child,
) async {
  tester.pumpComponent(ArcaneThemeProvider(stylesheet: sheet, child: child));
  final DocumentResponse res = await tester.request('/');
  expect(res.statusCode, 200, reason: res.body);
  return res.body;
}

Widget _card(ArcaneDecoration? decoration, {ArcaneStyleData? styles}) =>
    Card(decoration: decoration, styles: styles, children: const <Widget>[]);

void main() {
  group('elevation intent maps to each theme idiom', () {
    const ArcaneDecoration deco = ArcaneDecoration(elevation: Elevation.lg);

    testServer('shadcn -> ambient --shadow-lg', (ServerTester tester) async {
      final String html = await _render(tester, _shadcn, _card(deco));
      expect(html.contains('box-shadow: var(--shadow-lg)'), isTrue);
    });

    testServer(
      'neubrutalism -> hard offset shadow (baked, no var indirection)',
      (ServerTester tester) async {
        final String html = await _render(tester, _neubrutalism, _card(deco));
        expect(html.contains('7px 7px 0 0'), isTrue);
        expect(html.contains('#EC4899'), isFalse);
      },
    );
  });

  group('typed radius styles win over the theme on every stylesheet', () {
    const ArcaneStyleData override = ArcaneStyleData(borderRadius: Radius.md);

    for (final (String name, ArcaneStylesheet sheet)
        in <(String, ArcaneStylesheet)>[
          ('shadcn', _shadcn),
          ('neon', _neon),
          ('neubrutalism', _neubrutalism),
        ]) {
      testServer('$name honors the typed border-radius override', (
        ServerTester tester,
      ) async {
        final String html = await _render(
          tester,
          sheet,
          _card(null, styles: override),
        );
        expect(
          html.contains('border-radius: var(--arcane-radius-md, 8px)'),
          isTrue,
        );
      });
    }
  });

  group('universal decoration fields render literally on every stylesheet', () {
    const ArcaneDecoration deco = ArcaneDecoration(color: '#123456');

    for (final (String name, ArcaneStylesheet sheet)
        in <(String, ArcaneStylesheet)>[
          ('shadcn', _shadcn),
          ('neon', _neon),
          ('neubrutalism', _neubrutalism),
        ]) {
      testServer('$name applies the universal background color', (
        ServerTester tester,
      ) async {
        final String html = await _render(tester, sheet, _card(deco));
        expect(html.contains('background: #123456'), isTrue);
      });
    }
  });

  // Spot-check a fan-out-wired component (Avatar) to prove the pattern produces
  // functional wiring, not just compiling code. Avatar uses the
  // `{...rootStyles(props), ...spreads}` getter-wrapping variant of the seam.
  group('fan-out component Avatar honors styles: and decoration:', () {
    for (final (String name, ArcaneStylesheet sheet)
        in <(String, ArcaneStylesheet)>[
          ('shadcn', _shadcn),
          ('neubrutalism', _neubrutalism),
        ]) {
      testServer('$name Avatar: typed styles override wins', (
        ServerTester tester,
      ) async {
        final String html = await _render(
          tester,
          sheet,
          const ArcaneAvatar(
            initials: 'AB',
            styles: ArcaneStyleData(borderRadius: Radius.md),
          ),
        );
        expect(
          html.contains('border-radius: var(--arcane-radius-md, 8px)'),
          isTrue,
        );
      });

      testServer('$name Avatar: universal decoration background applies', (
        ServerTester tester,
      ) async {
        final String html = await _render(
          tester,
          sheet,
          const ArcaneAvatar(
            initials: 'AB',
            decoration: ArcaneDecoration(color: '#abcdef'),
          ),
        );
        expect(html.contains('background: #abcdef'), isTrue);
      });
    }
  });

  // Regression guards for the "literal styles: always wins" invariant, covering
  // the two subtle ordering bugs the quality review caught.
  group('literal styles: wins the cascade (ordering invariant)', () {
    testServer('styles longhand beats a decoration shorthand (map-order fix)', (
      ServerTester tester,
    ) async {
      // decoration.color -> `background: #ff0000` (shorthand);
      // styles.background -> `background-color: var(--primary)` (longhand).
      // The longhand must be emitted AFTER the shorthand or the shorthand resets
      // it and decoration wrongly wins.
      final String html = await _render(
        tester,
        _shadcn,
        const Card(
          decoration: ArcaneDecoration(color: '#ff0000'),
          styles: ArcaneStyleData(background: Background.primary),
          children: <Widget>[],
        ),
      );
      final int shorthand = html.indexOf('background: #ff0000');
      final int longhand = html.indexOf('background-color: var(--primary)');
      expect(shorthand, greaterThanOrEqualTo(0));
      expect(
        longhand,
        greaterThan(shorthand),
        reason: 'styles: background-color must be emitted last to win',
      );
    });

    testServer('tappable card: styles beats the button font reset', (
      ServerTester tester,
    ) async {
      final String html = await _render(
        tester,
        _shadcn,
        Card(
          onTap: () {},
          styles: const ArcaneStyleData(fontWeightCustom: '999'),
          children: const <Widget>[],
        ),
      );
      final int reset = html.indexOf('font: inherit');
      final int weight = html.indexOf('font-weight: 999');
      expect(weight, greaterThanOrEqualTo(0));
      expect(
        weight,
        greaterThan(reset),
        reason: 'the button font reset must precede allStyles',
      );
    });
  });

  // Spot-check a needs-care component (Kbd) — its seam routes the override to
  // the visible <kbd> element (not the combo wrapper span), proving the routed
  // wiring reaches the element the user sees.
  group('needs-care component Kbd honors the typed styles override', () {
    for (final (String name, ArcaneStylesheet sheet)
        in <(String, ArcaneStylesheet)>[
          ('shadcn', _shadcn),
          ('neubrutalism', _neubrutalism),
        ]) {
      testServer('$name Kbd: typed border-radius override wins', (
        ServerTester tester,
      ) async {
        final String html = await _render(
          tester,
          sheet,
          const ArcaneKbd(
            'Ctrl',
            styles: ArcaneStyleData(borderRadius: Radius.md),
          ),
        );
        expect(
          html.contains('border-radius: var(--arcane-radius-md, 8px)'),
          isTrue,
        );
      });
    }
  });
}
