import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_shadcn/arcane_jaspr_shadcn.dart';
import 'package:arcane_jaspr_win95/arcane_jaspr_win95.dart';
import 'package:jaspr_test/server_test.dart';

Widget _wrap(ArcaneStylesheet sheet, Widget child) =>
    ArcaneThemeProvider(stylesheet: sheet, child: child);

Future<String> _render(
  ServerTester tester,
  ArcaneStylesheet sheet, {
  required bool draggable,
  bool packing = false,
  int? minimumTileArea,
  int? targetTileArea,
}) async {
  tester.pumpComponent(
    _wrap(
      sheet,
      ArcaneGallery(
        id: 'art-gallery',
        ariaLabel: 'Movable artwork',
        packing: packing,
        minimumTileArea: minimumTileArea,
        targetTileArea: targetTileArea,
        draggableTiles: draggable,
        dragKeyboardStep: 12,
        dragInset: 6,
        tiles: const <ArcaneGalleryTile>[
          ArcaneGalleryTile(
            media: ArcaneGalleryMedia(
              aspectRatio: 1.5,
              src: '/art.png',
              alt: 'Artwork',
            ),
            title: 'Artwork window',
            href: '/artwork',
            dragId: 'artwork-1',
          ),
        ],
      ),
    ),
  );
  final DocumentResponse response = await tester.request('/');
  expect(response.statusCode, 200, reason: response.body);
  return response.body;
}

String _openingTagForClass(String html, String className) {
  for (final RegExpMatch match in RegExp(
    r'<[^>]+class="([^"]*)"[^>]*>',
  ).allMatches(html)) {
    if (match.group(1)!.split(RegExp(r'\s+')).contains(className)) {
      return match.group(0)!;
    }
  }
  fail('Missing .$className in rendered HTML');
}

void main() {
  testServer('draggable gallery emits the shared root and tile contract', (
    ServerTester tester,
  ) async {
    final String html = await _render(
      tester,
      const ShadcnStylesheet(),
      draggable: true,
    );

    expect(html, contains('data-arcane-gallery-draggable="true"'));
    expect(html, contains('role="region"'));
    expect(html, contains('id="art-gallery"'));
    expect(html, contains('data-arcane-gallery-drag-id="art-gallery"'));
    expect(html, contains('data-arcane-drag-keyboard-step="12.0"'));
    expect(html, contains('data-arcane-drag-inset="6.0"'));
    expect(html, contains('data-arcane-draggable-item="true"'));
    expect(html, contains('data-arcane-drag-key="artwork-1"'));
    expect(html, contains('data-arcane-drag-handle="true"'));
    expect(html, contains('draggable="false"'));
    expect(
      html,
      contains(
        'aria-keyshortcuts="Shift+ArrowUp Shift+ArrowDown '
        'Shift+ArrowLeft Shift+ArrowRight"',
      ),
    );
    expect(
      html,
      contains(
        'aria-description="Hold Shift and use the arrow keys to reposition '
        'this item."',
      ),
    );
  });

  testServer('Win95 title bar is the pointer drag handle', (
    ServerTester tester,
  ) async {
    final String html = await _render(
      tester,
      const Win95Stylesheet(),
      draggable: true,
    );

    expect(
      html,
      matches(
        RegExp(
          r'class="win95-gallery-tile-header" '
          r'data-arcane-drag-handle="true"',
        ),
      ),
    );
  });

  testServer('dragging remains opt-in', (ServerTester tester) async {
    final String html = await _render(
      tester,
      const ShadcnStylesheet(),
      draggable: false,
    );

    expect(html, isNot(contains('data-arcane-gallery-draggable')));
    expect(html, isNot(contains('data-arcane-draggable-item')));
    expect(html, isNot(contains('data-arcane-drag-handle')));
    expect(html, isNot(contains('aria-keyshortcuts')));
  });

  testServer('packing and dragging expose both opt-in contracts', (
    ServerTester tester,
  ) async {
    final String html = await _render(
      tester,
      const Win95Stylesheet(),
      draggable: true,
      packing: true,
    );

    expect(html, contains('data-packing="true"'));
    expect(html, contains('data-arcane-gallery-draggable="true"'));
  });

  testServer('packing area controls emit their measurement contract', (
    ServerTester tester,
  ) async {
    final String html = await _render(
      tester,
      const ShadcnStylesheet(),
      draggable: false,
      packing: true,
      minimumTileArea: 4,
      targetTileArea: 6,
    );

    expect(html, contains('data-arcane-gallery-minimum-tile-area="4"'));
    expect(html, contains('data-arcane-gallery-target-tile-area="6"'));
  });

  testServer('packing area controls remain absent by default', (
    ServerTester tester,
  ) async {
    final String html = await _render(
      tester,
      const ShadcnStylesheet(),
      draggable: false,
      packing: true,
    );

    expect(html, isNot(contains('data-arcane-gallery-minimum-tile-area')));
    expect(html, isNot(contains('data-arcane-gallery-target-tile-area')));
  });

  testServer('drag targets protect structural attributes and custom label', (
    ServerTester tester,
  ) async {
    tester.pumpComponent(
      _wrap(
        const ShadcnStylesheet(),
        const ArcaneGallery(
          ariaLabel: 'Protected gallery',
          draggableTiles: true,
          tiles: <ArcaneGalleryTile>[
            ArcaneGalleryTile(
              media: ArcaneGalleryMedia(aspectRatio: 1),
              attributes: <String, String>{
                'data-arcane-gallery-item': 'false',
                'data-arcane-draggable-item': 'false',
                'data-arcane-drag-key': 'overridden',
                'data-arcane-drag-handle': 'false',
                'draggable': 'true',
                'tabindex': '-1',
                'role': 'presentation',
                'aria-keyshortcuts': 'Enter',
                'aria-description': 'Wrong instructions',
                'aria-label': 'Custom movable tile',
                'data-tracking-id': 'tile-1',
              },
            ),
          ],
        ),
      ),
    );

    final DocumentResponse response = await tester.request('/');
    expect(response.statusCode, 200, reason: response.body);
    final String tile = _openingTagForClass(
      response.body,
      'shadcn-gallery-tile',
    );

    expect(tile, contains('data-arcane-gallery-item="true"'));
    expect(tile, contains('data-arcane-draggable-item="true"'));
    expect(tile, contains('data-arcane-drag-key="0"'));
    expect(tile, contains('data-arcane-drag-handle="true"'));
    expect(tile, contains('draggable="false"'));
    expect(tile, contains('tabindex="0"'));
    expect(tile, contains('role="group"'));
    expect(tile, contains('aria-label="Custom movable tile"'));
    expect(tile, contains('data-tracking-id="tile-1"'));
    expect(tile, isNot(contains('Wrong instructions')));
    expect(tile, isNot(contains('role="presentation"')));
  });

  testServer('unnamed drag targets receive a stable accessible fallback', (
    ServerTester tester,
  ) async {
    tester.pumpComponent(
      _wrap(
        const ShadcnStylesheet(),
        const ArcaneGallery(
          ariaLabel: 'Fallback gallery',
          draggableTiles: true,
          tiles: <ArcaneGalleryTile>[
            ArcaneGalleryTile(media: ArcaneGalleryMedia(aspectRatio: 1)),
          ],
        ),
      ),
    );

    final DocumentResponse response = await tester.request('/');
    expect(response.statusCode, 200, reason: response.body);
    final String tile = _openingTagForClass(
      response.body,
      'shadcn-gallery-tile',
    );
    expect(tile, contains('role="group"'));
    expect(tile, contains('aria-label="Gallery item 1"'));
  });

  testServer('non-draggable tiles retain caller-owned semantics', (
    ServerTester tester,
  ) async {
    tester.pumpComponent(
      _wrap(
        const ShadcnStylesheet(),
        const ArcaneGallery(
          ariaLabel: 'Static gallery',
          tiles: <ArcaneGalleryTile>[
            ArcaneGalleryTile(
              media: ArcaneGalleryMedia(aspectRatio: 1),
              attributes: <String, String>{
                'role': 'group',
                'tabindex': '-1',
                'draggable': 'true',
                'aria-keyshortcuts': 'Enter',
                'aria-description': 'Caller supplied instructions',
                'aria-label': 'Caller supplied tile',
              },
            ),
          ],
        ),
      ),
    );

    final DocumentResponse response = await tester.request('/');
    expect(response.statusCode, 200, reason: response.body);
    final String tile = _openingTagForClass(
      response.body,
      'shadcn-gallery-tile',
    );

    expect(tile, contains('role="group"'));
    expect(tile, contains('tabindex="-1"'));
    expect(tile, contains('draggable="true"'));
    expect(tile, contains('aria-keyshortcuts="Enter"'));
    expect(tile, contains('aria-description="Caller supplied instructions"'));
    expect(tile, contains('aria-label="Caller supplied tile"'));
  });

  testServer('presentational caller roles never receive a synthesized name', (
    ServerTester tester,
  ) async {
    tester.pumpComponent(
      _wrap(
        const ShadcnStylesheet(),
        const ArcaneGallery(
          ariaLabel: 'Decorative gallery',
          tiles: <ArcaneGalleryTile>[
            ArcaneGalleryTile(
              media: ArcaneGalleryMedia(aspectRatio: 1),
              title: 'Suppressed decorative title',
              attributes: <String, String>{'role': 'presentation'},
            ),
          ],
        ),
      ),
    );

    final DocumentResponse response = await tester.request('/');
    expect(response.statusCode, 200, reason: response.body);
    final String tile = _openingTagForClass(
      response.body,
      'shadcn-gallery-tile',
    );
    expect(tile, contains('role="presentation"'));
    expect(tile, isNot(contains('aria-label')));
  });

  testServer('hidden static titles receive nameable group semantics', (
    ServerTester tester,
  ) async {
    tester.pumpComponent(
      _wrap(
        const ShadcnStylesheet(),
        const ArcaneGallery(
          ariaLabel: 'Static gallery',
          tiles: <ArcaneGalleryTile>[
            ArcaneGalleryTile(
              media: ArcaneGalleryMedia(aspectRatio: 1),
              mediaChild: Text('Custom media'),
              title: 'Hidden tile title',
            ),
          ],
        ),
      ),
    );

    final DocumentResponse response = await tester.request('/');
    expect(response.statusCode, 200, reason: response.body);
    final String tile = _openingTagForClass(
      response.body,
      'shadcn-gallery-tile',
    );
    expect(tile, contains('role="group"'));
    expect(tile, contains('aria-label="Hidden tile title"'));
  });

  testServer('genuinely unlabeled static tiles stay generic', (
    ServerTester tester,
  ) async {
    tester.pumpComponent(
      _wrap(
        const ShadcnStylesheet(),
        const ArcaneGallery(
          ariaLabel: 'Static gallery',
          tiles: <ArcaneGalleryTile>[
            ArcaneGalleryTile(media: ArcaneGalleryMedia(aspectRatio: 1)),
          ],
        ),
      ),
    );

    final DocumentResponse response = await tester.request('/');
    expect(response.statusCode, 200, reason: response.body);
    final String tile = _openingTagForClass(
      response.body,
      'shadcn-gallery-tile',
    );
    expect(tile, isNot(contains('aria-label')));
    expect(tile, isNot(contains('role=')));
  });

  test('fallback bundle contains the complete drag safety contract', () {
    final String script = ArcaneScripts.all;
    final String css = ArcaneScripts.runtimeCss;

    expect(script, contains('const DRAG_THRESHOLD_PX = 6'));
    expect(script, contains('clampOffset'));
    expect(script, contains('setPointerCapture'));
    expect(script, contains('pointercancel'));
    expect(script, contains('lostpointercapture'));
    expect(script, contains("event.key === 'Escape'"));
    expect(
      script,
      contains("!event.shiftKey || !event.key.startsWith('Arrow')"),
    );
    expect(script, contains('event.stopImmediatePropagation()'));
    expect(script, contains('offsetsByGalleryId'));
    expect(script, contains('data-arcane-draggable-item="true"'));
    expect(script, contains('is-arcane-gallery-drag-active'));
    expect(script, contains("'(pointer: coarse)'"));
    expect(script, contains('ResizeObserver'));
    expect(script, contains('MutationObserver'));
    expect(script, contains('aria-live'));
    expect(css, contains('[data-arcane-gallery-draggable="true"]'));
    expect(css, contains('var(--arcane-drag-x, 0px)'));
    expect(css, contains('.arcane-gallery-drag-announcer'));
  });

  test('drag distances reject non-finite values', () {
    const List<ArcaneGalleryTile> tiles = <ArcaneGalleryTile>[
      ArcaneGalleryTile(media: ArcaneGalleryMedia(aspectRatio: 1)),
    ];

    expect(
      () => ArcaneGallery(
        tiles: tiles,
        ariaLabel: 'Invalid keyboard step',
        dragKeyboardStep: double.infinity,
      ),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => ArcaneGallery(
        tiles: tiles,
        ariaLabel: 'Invalid inset',
        dragInset: double.nan,
      ),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => ArcaneGallery(
        tiles: tiles,
        ariaLabel: 'Invalid minimum tile area',
        minimumTileArea: -1,
      ),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => ArcaneGallery(
        tiles: tiles,
        ariaLabel: 'Invalid target tile area',
        targetTileArea: 0,
      ),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => ArcaneGallery(
        tiles: tiles,
        ariaLabel: 'Inverted tile area range',
        minimumTileArea: 8,
        targetTileArea: 6,
      ),
      throwsA(isA<AssertionError>()),
    );
  });
}
