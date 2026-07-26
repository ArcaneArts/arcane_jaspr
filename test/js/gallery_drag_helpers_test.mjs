import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { test } from 'node:test';
import vm from 'node:vm';

const source = readFileSync(
  new URL(
    '../../lib/util/interactivity/scripts/gallery/gallery_drag_scripts.dart',
    import.meta.url,
  ),
  'utf8',
);
const packingSource = readFileSync(
  new URL(
    '../../lib/util/interactivity/scripts/gallery/gallery_scripts.dart',
    import.meta.url,
  ),
  'utf8',
);
const quotes = "'".repeat(3);
const marker = `static String get code => r${quotes}`;
const start = source.indexOf(marker) + marker.length;
const end = source.lastIndexOf(`${quotes};`);

assert.ok(start >= marker.length, 'Dart raw JavaScript start marker is present');
assert.ok(end > start, 'Dart raw JavaScript end marker is present');

const script = source.slice(start, end);
const context = vm.createContext({ window: {} });
vm.runInContext(script, context);
const drag = context.window.ArcaneGalleryDrag;

test('the checked-in drag runtime parses and exposes pure helpers', () => {
  assert.equal(typeof drag.crossedThreshold, 'function');
  assert.equal(typeof drag.clampOffset, 'function');
});

test('click-sized motion remains below the drag threshold', () => {
  assert.equal(drag.crossedThreshold(2, 3), false);
  assert.equal(drag.crossedThreshold(6, 0), true);
  assert.equal(drag.crossedThreshold(4, 5), true);
});

test('offsets clamp the full item inside its gallery boundary', () => {
  const itemRect = {
    left: 100,
    top: 120,
    right: 300,
    bottom: 320,
  };
  const galleryRect = {
    left: 50,
    top: 80,
    right: 700,
    bottom: 600,
  };

  assert.deepEqual(
    { ...drag.clampOffset({
      originX: 0,
      originY: 0,
      deltaX: -500,
      deltaY: 500,
      itemRect,
      galleryRect,
      inset: 4,
    }) },
    { x: -46, y: 276 },
  );
  assert.deepEqual(
    { ...drag.clampOffset({
      originX: 12,
      originY: -8,
      deltaX: 30,
      deltaY: 20,
      itemRect,
      galleryRect,
      inset: 4,
    }) },
    { x: 42, y: 12 },
  );
});

test('runtime includes cancellation, nested-control, and rerender guards', () => {
  assert.match(script, /lostpointercapture/);
  assert.match(script, /a\[href\].*summary.*role="button".*tabindex/s);
  assert.match(script, /offsetsByGalleryId/);
  assert.match(script, /arcaneDragKey/);
  assert.match(script, /Item is already at the edge of the gallery/);
  assert.match(
    packingSource,
    /is-arcane-gallery-drag-active[\s\S]*data-arcane-draggable-item/,
  );
});
