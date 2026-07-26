import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_win95/arcane_jaspr_win95.dart';
import 'package:jaspr_test/server_test.dart';

const Win95Stylesheet _win95 = Win95Stylesheet();

String _rule(String css, String selector) {
  final int selectorStart = css.indexOf(selector);
  if (selectorStart < 0) {
    throw StateError('Missing CSS selector: $selector');
  }
  final int bodyStart = css.indexOf('{', selectorStart);
  final int bodyEnd = css.indexOf('}', bodyStart);
  if (bodyStart < 0 || bodyEnd < 0) {
    throw StateError('Malformed CSS selector: $selector');
  }
  return css.substring(bodyStart + 1, bodyEnd);
}

void main() {
  group('Win95 field contrast contract', () {
    final String css = _win95.baseCss;

    test('uses mode-aware field tokens for text, caret, and placeholder', () {
      expect(css, contains('--w95-field-placeholder: #666666;'));
      expect(css, contains('--w95-field-placeholder: #bcbcbc;'));
      expect(css, contains('input[type="datetime-local"]'));
      expect(css, contains('select.arcane-field-select'));
      expect(
        css,
        contains('-webkit-text-fill-color: var(--w95-field-text) !important;'),
      );
      expect(
        css,
        contains(
          '-webkit-text-fill-color: '
          'var(--w95-field-placeholder) !important;',
        ),
      );
      expect(
        css,
        contains(
          '#arcane-root.arcane-theme-win95 '
          '.win95-command-input::placeholder {\n'
          '  color: var(--w95-field-placeholder) !important;\n'
          '}',
        ),
      );
    });

    test('core field controls receive the Win95 sunken edit well', () {
      final String fieldRule = _rule(
        css,
        '#arcane-root.arcane-theme-win95 .arcane-textarea,',
      );
      expect(fieldRule, contains('background: var(--w95-field) !important'));
      expect(fieldRule, contains('color: var(--w95-field-text) !important'));
      expect(fieldRule, contains('border-radius: 0 !important'));
      expect(fieldRule, contains('box-shadow: var(--w95-sunken) !important'));
    });
  });

  group('Win95 surface contracts', () {
    final String css = _win95.baseCss;

    test('flat cards keep a thin panel frame while ghost cards do not', () {
      final String flat = _rule(
        css,
        '#arcane-root.arcane-theme-win95 '
        '.win95-card[data-variant="flat"]',
      );
      final String ghost = _rule(
        css,
        '#arcane-root.arcane-theme-win95 '
        '.win95-card[data-variant="ghost"]',
      );

      expect(flat, contains('box-shadow: var(--w95-raised-thin)'));
      expect(ghost, contains('box-shadow: none'));
      expect(ghost, contains('background: transparent'));
    });

    test('gallery windows have a frame and tokenized caption contrast', () {
      final String tile = _rule(
        css,
        '#arcane-root.arcane-theme-win95 .win95-gallery-tile',
      );
      final String title = _rule(
        css,
        '#arcane-root.arcane-theme-win95 .win95-gallery-tile-title',
      );
      final String meta = _rule(
        css,
        '#arcane-root.arcane-theme-win95 .win95-gallery-tile-meta',
      );

      expect(tile, contains('border: 1px solid var(--w95-dark)'));
      expect(title, contains('color: var(--w95-title-text)'));
      expect(meta, contains('color: var(--w95-title-text)'));
      expect(meta, contains('opacity: 0.78'));
      expect(meta, isNot(contains('rgba(')));
    });
  });

  testServer('ArcaneApp delegates its canvas to the stylesheet hook', (
    ServerTester tester,
  ) async {
    tester.pumpComponent(
      const ArcaneApp(
        stylesheet: _win95,
        brightness: Brightness.light,
        includeFallbackScripts: false,
        home: Text('desktop'),
      ),
    );

    final DocumentResponse response = await tester.request('/');
    expect(response.statusCode, 200, reason: response.body);
    expect(
      response.body,
      contains(
        'background-color: '
        'var(--arcane-app-background, var(--background))',
      ),
    );
    expect(
      response.body,
      contains('--arcane-app-background: var(--w95-desktop)'),
    );
    expect(
      response.body,
      contains('color: var(--arcane-app-foreground, var(--foreground))'),
    );
    expect(
      response.body,
      contains('--arcane-app-foreground: var(--w95-desktop-text)'),
    );
  });

  test('every Win95 desktop scheme has a paired AA foreground', () {
    for (final Win95Theme theme in Win95Theme.values) {
      final int foreground = PaletteGenerator.contrastingForeground(
        theme.desktop,
      );
      final double contrast = PaletteGenerator.contrastRatio(
        theme.desktop,
        foreground,
      );
      final String css = Win95Stylesheet(theme: theme).componentCss;

      expect(
        contrast,
        greaterThanOrEqualTo(4.5),
        reason: '${theme.label} desktop contrast is $contrast',
      );
      expect(
        css,
        contains(
          '--w95-desktop-text: var(--w95-desktop-text-in, '
          '${PaletteGenerator.toHex(foreground)})',
        ),
      );
    }
  });
}
