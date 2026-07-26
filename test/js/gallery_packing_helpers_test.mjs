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

function assertNoPlacementOverlaps(packed) {
  for (let firstIndex = 0; firstIndex < packed.length; firstIndex++) {
    const first = packed[firstIndex];
    for (
      let secondIndex = firstIndex + 1;
      secondIndex < packed.length;
      secondIndex++
    ) {
      const second = packed[secondIndex];
      const overlapWidth =
        Math.min(
          first.column + first.columnSpan,
          second.column + second.columnSpan,
        ) - Math.max(first.column, second.column);
      const overlapHeight =
        Math.min(first.row + first.rowSpan, second.row + second.rowSpan) -
        Math.max(first.row, second.row);

      assert.equal(
        overlapWidth > 0 && overlapHeight > 0,
        false,
        `placements ${firstIndex} and ${secondIndex} must not overlap`,
      );
    }
  }
}

function assertSolidPrefix(packed, columns) {
  const rows = [];
  for (const placement of packed) {
    for (
      let row = placement.row;
      row < placement.row + placement.rowSpan;
      row++
    ) {
      rows[row] ??= Array.from({ length: columns }, () => false);
      for (
        let column = placement.column;
        column < placement.column + placement.columnSpan;
        column++
      ) {
        rows[row][column] = true;
      }
    }
  }

  const tailStart = packed.at(-1)?.row ?? 0;
  for (let row = 0; row < tailStart; row++) {
    assert.equal(
      rows[row]?.every(Boolean),
      true,
      `packed row ${row} must not contain an interior empty cell`,
    );
  }
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

test('packing never overlaps tiles when an early gap cannot fit a candidate', () => {
  const packed = gallery.pack(
    [0.25, 1.25, 1, 1.5, 4, 1.5].map((aspectRatio) => ({ aspectRatio })),
    {
      columns: 2,
      columnWidth: 240,
      rowHeight: 75,
      gap: 10,
      minimumTileArea: 4,
      targetTileArea: 6,
    },
  );

  assertNoPlacementOverlaps(packed);
});

test('owner-sized packing leaves no empty cells without row bands', () => {
  const columns = 5;
  const packed = gallery.pack(
    [0.75, 0.75, 2.3256, 0.75, 0.5625, 0.5625, 1.7778, 2.3256].map(
      (aspectRatio) => ({ aspectRatio }),
    ),
    {
      columns,
      columnWidth: 226.438,
      rowHeight: 94,
      gap: 10,
      minimumTileArea: 4,
      targetTileArea: 6,
    },
  );

  assertNoPlacementOverlaps(packed);
  assertSolidPrefix(packed, columns);
  assert.equal(
    packed.some((placement, index) =>
      packed.some((other, otherIndex) =>
        index !== otherIndex &&
        placement.row !== other.row &&
        Math.max(placement.row, other.row) <
          Math.min(
            placement.row + placement.rowSpan,
            other.row + other.rowSpan,
          ),
      ),
    ),
    true,
    'tiles must retain staggered masonry starts instead of shared row bands',
  );
});

test('one-column packing never degrades the configured minimum area', () => {
  const packed = gallery.pack(
    [{ aspectRatio: 0.4 }, { aspectRatio: 1 }, { aspectRatio: 2.5 }],
    {
      columns: 1,
      columnWidth: 240,
      rowHeight: 75,
      gap: 0,
      maxRowSpan: 5,
      minimumTileArea: 10,
      targetTileArea: 12,
    },
  );

  assert.equal(
    packed.every(
      (placement) => placement.columnSpan * placement.rowSpan >= 10,
    ),
    true,
  );
  assertNoPlacementOverlaps(packed);
  assertSolidPrefix(packed, 1);
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
