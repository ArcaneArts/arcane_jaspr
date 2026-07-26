import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { test } from 'node:test';
import vm from 'node:vm';

const source = readFileSync(
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
const context = vm.createContext({
  window: {},
  document: {
    readyState: 'loading',
    documentElement: {},
    body: {},
    addEventListener() {},
    querySelectorAll() {
      return [];
    },
  },
});
vm.runInContext(script, context);
const gallery = context.window.ArcaneGallery;

const layout = {
  columns: 4,
  columnWidth: 160,
  rowHeight: 82,
  gap: 10,
};

function placements(candidates) {
  return Array.from(candidates, (candidate) => ({
    columnSpan: candidate.columnSpan,
    rowSpan: candidate.rowSpan,
  }));
}

test('area controls remain optional and preserve legacy candidate order', () => {
  const legacy = gallery.candidateSpans({ aspectRatio: 1 }, layout);
  const omitted = gallery.candidateSpans(
    { aspectRatio: 1 },
    { ...layout, minimumTileArea: undefined, targetTileArea: undefined },
  );

  assert.deepEqual(placements(omitted), placements(legacy));
  assert.equal(legacy.length, 20);
  assert.deepEqual(placements(legacy).slice(0, 3), [
    { columnSpan: 2, rowSpan: 4 },
    { columnSpan: 1, rowSpan: 2 },
    { columnSpan: 2, rowSpan: 3 },
  ]);
});

test('minimum tile area removes every undersized candidate', () => {
  const minimumTileArea = 4;
  const candidates = gallery.candidateSpans(
    { aspectRatio: 1 },
    { ...layout, minimumTileArea },
  );

  assert.ok(candidates.length > 0);
  assert.equal(
    candidates.every(
      (candidate) =>
        candidate.columnSpan * candidate.rowSpan >= minimumTileArea,
    ),
    true,
  );
});

test('target tile area changes size while aspect ratio chooses shape', () => {
  const smallTarget = 4;
  const largeTarget = 9;
  const small = gallery.candidateSpans(
    { aspectRatio: 2 },
    { ...layout, targetTileArea: smallTarget },
  )[0];
  const large = gallery.candidateSpans(
    { aspectRatio: 2 },
    { ...layout, targetTileArea: largeTarget },
  )[0];

  assert.deepEqual(placements([small]), [{ columnSpan: 2, rowSpan: 2 }]);
  assert.deepEqual(placements([large]), [{ columnSpan: 3, rowSpan: 3 }]);
});

test('packing preserves the minimum area across mixed aspect ratios', () => {
  const packed = gallery.pack(
    [
      { aspectRatio: 0.45 },
      { aspectRatio: 0.8 },
      { aspectRatio: 1 },
      { aspectRatio: 1.6 },
      { aspectRatio: 2.4 },
      { aspectRatio: 3.5 },
    ],
    { ...layout, minimumTileArea: 4, targetTileArea: 6 },
  );

  assert.equal(
    packed.every(
      (placement) => placement.columnSpan * placement.rowSpan >= 4,
    ),
    true,
  );
});

test('an impossible minimum degrades to the largest attainable span', () => {
  const candidates = gallery.candidateSpans(
    { aspectRatio: 1 },
    {
      columns: 1,
      columnWidth: 160,
      rowHeight: 82,
      gap: 10,
      maxRowSpan: 5,
      minimumTileArea: 10,
    },
  );

  assert.ok(candidates.length > 0);
  assert.equal(
    candidates.every(
      (candidate) => candidate.columnSpan * candidate.rowSpan === 5,
    ),
    true,
  );
});
