import 'dart:io';

import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_neon/arcane_jaspr_neon.dart';
import 'package:jaspr_test/server_test.dart';

final class _CssRule {
  final String selector;
  final Map<String, String> declarations;

  const _CssRule(this.selector, this.declarations);
}

List<_CssRule> _parseCssRules(String css) {
  final String withoutComments = css.replaceAll(
    RegExp(r'/\*.*?\*/', dotAll: true),
    '',
  );
  final RegExp blockPattern = RegExp(r'([^{}]+)\{([^{}]*)\}');

  return blockPattern
      .allMatches(withoutComments)
      .map((RegExpMatch match) {
        final String selector = match.group(1)!.trim();
        final Map<String, String> declarations = <String, String>{};
        for (final String declaration in match.group(2)!.split(';')) {
          final int colon = declaration.indexOf(':');
          if (colon <= 0) continue;
          declarations[declaration.substring(0, colon).trim()] = declaration
              .substring(colon + 1)
              .trim();
        }
        return _CssRule(selector, declarations);
      })
      .toList(growable: false);
}

Iterable<_CssRule> _neonRules(String css) =>
    _parseCssRules(css).where((_CssRule rule) {
      return rule.selector.contains('#arcane-root.arcane-theme-neon');
    });

String _rendererSource() {
  final Directory rendererDirectory = Directory(
    'packages/arcane_jaspr_neon/lib/src/renderers',
  );
  final StringBuffer source = StringBuffer();
  for (final FileSystemEntity entity in rendererDirectory.listSync(
    recursive: true,
  )) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    source
      ..writeln('// ${entity.path}')
      ..writeln(entity.readAsStringSync());
  }
  return source.toString();
}

bool _isIntrinsicGeometry(String selector) {
  const List<String> intrinsicSelectors = <String>[
    'avatar',
    'loading-spinner',
    'progress',
    'radio-button',
    'status-indicator',
    'toggle',
  ];
  return intrinsicSelectors.any(selector.contains);
}

bool _isTransientOverlay(String selector) {
  const List<String> overlaySelectors = <String>[
    'dropdown-menu',
    'dropdown-submenu',
    'nav-dropdown-panel',
    'popover',
    'search-results',
    'select-dropdown',
  ];
  return overlaySelectors.any(selector.contains);
}

bool _isFrostedMenuOverlay(String selector) {
  const List<String> menuOverlaySelectors = <String>[
    'neon-dropdown-menu',
    'neon-dropdown-submenu',
    'neon-select-dropdown',
    'arcane-nav-dropdown-panel',
  ];
  return menuOverlaySelectors.any(selector.contains);
}

void main() {
  const NeonStylesheet stylesheet = NeonStylesheet();
  final String css = stylesheet.componentCss;
  final List<_CssRule> rules = _neonRules(css).toList(growable: false);

  test('Neon uses only the product asset fonts', () {
    expect(stylesheet.fonts.sans, "'Akzidenz-GroteskPro'");
    expect(stylesheet.fonts.heading, "'ITCAvantGardeStd'");
    expect(stylesheet.fonts.mono, "'Hack'");
  });

  test('Neon uses compact controls and panels', () {
    expect(stylesheet.radius.sm, '4px');
    expect(stylesheet.radius.md, '4px');

    final _CssRule button = rules.singleWhere(
      (_CssRule rule) =>
          rule.selector == '#arcane-root.arcane-theme-neon .neon-button',
    );
    expect(button.declarations['border-radius'], 'var(--radius-sm)');

    final _CssRule statusBadge = rules.singleWhere(
      (_CssRule rule) => rule.selector.endsWith('.neon-status-badge'),
    );
    expect(statusBadge.declarations['border-radius'], 'var(--radius-sm)');
    expect(css, isNot(contains('.neon-promo-badge')));
    expect(css, isNot(contains('.neon-badge')));
  });

  test(
    'Neon comboboxes use anchored overlays and theme-owned search fields',
    () {
      expect(
        css,
        contains('#arcane-root.arcane-theme-neon .neon-select-search input'),
      );
      expect(
        css,
        isNot(
          contains('#arcane-root.arcane-theme-neon .neon-select-search:focus'),
        ),
      );

      final String rendererSource = File(
        'packages/arcane_jaspr_neon/lib/src/renderers/select.dart',
      ).readAsStringSync();
      expect(rendererSource, contains("'position': 'absolute'"));
      expect(rendererSource, contains("'top': 'calc(100% + 8px)'"));
      expect(rendererSource, contains("'width': '100%'"));
      expect(rendererSource, contains("'background': 'var(--input)'"));
    },
  );

  test('frost is limited to transient menu overlays', () {
    final List<_CssRule> activeFrostRules = rules
        .where((_CssRule rule) {
          return rule.declarations['backdrop-filter'] != null &&
              rule.declarations['backdrop-filter'] != 'none';
        })
        .toList(growable: false);

    expect(activeFrostRules, hasLength(1));
    final _CssRule overlayRule = activeFrostRules.single;
    for (final String selector in <String>[
      '.neon-dropdown-menu',
      '.neon-dropdown-submenu',
      '.neon-select-dropdown',
      '.arcane-nav-dropdown-panel',
    ]) {
      expect(overlayRule.selector, contains(selector));
    }
    expect(overlayRule.declarations['background'], 'var(--neon-overlay-frost)');
    expect(overlayRule.declarations['backdrop-filter'], 'blur(18px)');
    expect(overlayRule.declarations['-webkit-backdrop-filter'], 'blur(18px)');
    expect(
      overlayRule.declarations['box-shadow'],
      'var(--neon-overlay-shadow)',
    );

    final _CssRule themeRoot = rules.singleWhere(
      (_CssRule rule) =>
          rule.selector == '#arcane-root.arcane-theme-neon' &&
          rule.declarations['--neon-overlay-frost'] ==
              'rgba(var(--card-rgb), 0.78)',
    );
    expect(
      themeRoot.declarations['--neon-overlay-frost'],
      'rgba(var(--card-rgb), 0.78)',
    );
    expect(
      themeRoot.declarations['--arcane-nav-dropdown-background'],
      'var(--neon-overlay-frost)',
    );

    final _CssRule reducedTransparencyRule = rules.singleWhere(
      (_CssRule rule) =>
          _isFrostedMenuOverlay(rule.selector) &&
          rule.declarations['backdrop-filter'] == 'none',
    );
    expect(css, contains('@media (prefers-reduced-transparency: reduce)'));
    expect(reducedTransparencyRule.declarations['background'], 'var(--card)');
    expect(reducedTransparencyRule.declarations['backdrop-filter'], 'none');
    expect(
      reducedTransparencyRule.declarations['-webkit-backdrop-filter'],
      'none',
    );
    final _CssRule reducedTransparencyRoot = rules.singleWhere(
      (_CssRule rule) =>
          rule.selector == '#arcane-root.arcane-theme-neon' &&
          rule.declarations['--neon-overlay-frost'] == 'var(--card)',
    );
    expect(
      reducedTransparencyRoot.declarations['--neon-overlay-frost'],
      'var(--card)',
    );
  });

  test('Neon exposes one green and grayscale palette', () {
    expect(NeonTheme.values, <NeonTheme>[NeonTheme.green]);
    expect(stylesheet.lightSeed.primary, NeonTheme.green.color);
    expect(stylesheet.darkSeed.primary, NeonTheme.green.color);
    expect(stylesheet.lightSeed.success, NeonTheme.green.color);
    expect(stylesheet.darkSeed.success, NeonTheme.green.color);

    for (final int color in <int>[
      stylesheet.lightSeed.destructive,
      stylesheet.lightSeed.warning,
      stylesheet.lightSeed.info,
      stylesheet.darkSeed.destructive,
      stylesheet.darkSeed.warning,
      stylesheet.darkSeed.info,
    ]) {
      final int red = (color >> 16) & 0xff;
      final int green = (color >> 8) & 0xff;
      final int blue = color & 0xff;
      expect(red, green, reason: 'Expected grayscale color: $color');
      expect(green, blue, reason: 'Expected grayscale color: $color');
    }

    for (final String forbidden in <String>[
      '--neon-cool',
      '--neon-glow',
      '--neon-gradient',
      '--neon-hot',
      '[data-variant="glass"]',
    ]) {
      expect(css, isNot(contains(forbidden)), reason: forbidden);
    }
  });

  test('Neon rules reject glow, gradients, and lifted surfaces', () {
    for (final _CssRule rule in rules) {
      for (final MapEntry<String, String> declaration
          in rule.declarations.entries) {
        final String property = declaration.key;
        final String value = declaration.value;
        final String description = '${rule.selector} {$property: $value}';

        if (property == 'backdrop-filter' ||
            property == '-webkit-backdrop-filter') {
          expect(
            _isFrostedMenuOverlay(rule.selector),
            isTrue,
            reason: description,
          );
        }
        expect(value, isNot(contains('linear-gradient(')), reason: description);
        expect(value, isNot(contains('radial-gradient(')), reason: description);
        expect(property, isNot('text-shadow'), reason: description);

        if (property == 'box-shadow' &&
            value != 'none' &&
            value != 'none !important') {
          expect(value, 'var(--neon-overlay-shadow)', reason: description);
          expect(
            _isTransientOverlay(rule.selector),
            isTrue,
            reason: description,
          );
        }

        if (property == 'border-radius' &&
            (value.contains('radius-full') || value.contains('999'))) {
          expect(
            _isIntrinsicGeometry(rule.selector),
            isTrue,
            reason: description,
          );
        }

        if (property.startsWith('border-top') ||
            property.startsWith('border-right') ||
            property.startsWith('border-bottom') ||
            property.startsWith('border-left')) {
          expect(
            value,
            isNot(
              matches(
                RegExp(
                  r'--(primary|destructive|success|warning|info)|#[0-9a-fA-F]{3,8}',
                ),
              ),
            ),
            reason: 'Directional chromatic accents are forbidden: $description',
          );
        }
      }

      if (rule.selector.contains(':hover')) {
        expect(
          rule.declarations['transform'],
          isNull,
          reason: 'Hover lift is forbidden: ${rule.selector}',
        );
      }
    }
  });

  test('nested cards collapse to one visible surface', () {
    final _CssRule nestedCard = rules.singleWhere(
      (_CssRule rule) =>
          rule.selector ==
          '#arcane-root.arcane-theme-neon .neon-card .neon-card',
    );
    expect(nestedCard.declarations['background'], 'transparent !important');
    expect(nestedCard.declarations['border'], '0 !important');
    expect(nestedCard.declarations['border-radius'], '0 !important');
    expect(nestedCard.declarations['box-shadow'], 'none !important');
  });

  test('pseudo-elements do not add chrome to cards, tiles, or promos', () {
    final Iterable<_CssRule> surfacePseudoRules = rules.where((_CssRule rule) {
      final String selector = rule.selector.toLowerCase();
      final bool isPseudo =
          selector.contains('::before') || selector.contains('::after');
      final bool isSurface = <String>[
        'card',
        'tile',
        'promo',
        'banner',
      ].any(selector.contains);
      return isPseudo && isSurface;
    });

    for (final _CssRule rule in surfacePseudoRules) {
      final String declarations = rule.declarations.entries
          .map(
            (MapEntry<String, String> entry) => '${entry.key}:${entry.value}',
          )
          .join(';');
      expect(declarations, isNot(contains('gradient')), reason: rule.selector);
      expect(
        declarations,
        isNot(contains('box-shadow')),
        reason: rule.selector,
      );
      expect(
        declarations,
        isNot(contains('backdrop-filter')),
        reason: rule.selector,
      );
      expect(
        declarations,
        isNot(matches(RegExp(r'border-(top|right|bottom|left):.*--primary'))),
        reason: rule.selector,
      );
    }
  });

  testServer('status badge renders one indicator when given an icon', (
    ServerTester tester,
  ) async {
    tester.pumpComponent(
      ArcaneThemeProvider(
        stylesheet: const NeonStylesheet(),
        child: ArcaneStatusBadge(
          label: 'Online',
          showDot: true,
          icon: ArcaneIcon.server(),
        ),
      ),
    );

    final DocumentResponse response = await tester.request('/');
    expect(response.statusCode, 200, reason: response.body);
    expect(RegExp(r'<i\b').allMatches(response.body).length, 1);
    expect(response.body, contains('neon-status-indicator neon-status-icon'));
    expect(response.body, isNot(contains('class="neon-status-indicator"')));
  });

  test('renderer literals obey the same visual language', () {
    final String source = _rendererSource();
    for (final String forbidden in <String>[
      'backdrop-filter',
      'fonts.googleapis',
      'linear-gradient(',
      'neon-glow',
      'radial-gradient(',
      'text-shadow',
      'ui-monospace',
    ]) {
      expect(source, isNot(contains(forbidden)), reason: forbidden);
    }

    for (final RegExpMatch match in RegExp(
      r"'box-shadow'\s*:\s*'([^']+)'",
    ).allMatches(source)) {
      expect(
        <String>{'none', 'var(--neon-overlay-shadow)'},
        contains(match.group(1)),
        reason: match.group(0),
      );
    }

    for (final RegExpMatch match in RegExp(
      r"'border-(?:top|right|bottom|left)'\s*:\s*'([^']+)'",
    ).allMatches(source)) {
      expect(
        match.group(1),
        isNot(
          matches(
            RegExp(
              r'--(primary|destructive|success|warning|info)|#[0-9a-fA-F]{3,8}',
            ),
          ),
        ),
        reason:
            'Directional chromatic accents are forbidden: ${match.group(0)}',
      );
    }
  });
}
