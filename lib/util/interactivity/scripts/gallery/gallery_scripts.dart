/// Opt-in ratio-packing masonry script for `ArcaneGallery(packing: true)`.
///
/// Ported from Anim.al's `animal_masonry.js` engine. The placement algorithm
/// (candidate-span scoring, first-fit packing, interior-hole sealing, and
/// squared-off-bottom sealing) is preserved verbatim; only the DOM keying was
/// changed to the arcane contract and a self-initializing installer was added.
///
/// Self-initializes on load: it finds every `[data-arcane-gallery]
/// [data-packing="true"]` container, observes each with a `ResizeObserver`, and
/// watches the document with a single `MutationObserver` for newly-added
/// containers/items and for Jaspr re-syncing inline styles. Repacks are
/// rAF-coalesced. No per-container external call is needed; the engine is
/// stateless and keys items off `[data-arcane-gallery-item]` + their
/// `data-ratio`, sized against the render base's `grid-auto-rows: 8px` and
/// `gap: 0.75rem`.
class GalleryScripts {
  GalleryScripts._();

  static String get code => r'''
(function() {
  'use strict';

  const DEFAULT_MAX_COLUMN_SPAN = 4;
  const DEFAULT_MAX_ROW_SPAN = 5;
  const DEFAULT_ROW_DELAY_PENALTY = 0.32;
  const DEFAULT_COLUMN_DRIFT_PENALTY = 0.025;
  const DEFAULT_SEAL_MAX_RATIO_MISMATCH = Math.log(2.4);
  const DEFAULT_BOTTOM_MAX_RATIO_MISMATCH = Math.log(2.1);

  function safeNumber(value, fallback) {
    const parsed = typeof value === 'string'
      ? Number.parseFloat(value)
      : Number(value);
    return Number.isFinite(parsed) && parsed > 0 ? parsed : fallback;
  }

  function trackCount(gridTemplateColumns) {
    if (!gridTemplateColumns || gridTemplateColumns === 'none') {
      return 1;
    }
    return gridTemplateColumns
      .trim()
      .split(/\s+/)
      .filter((track) => track && track !== '/')
      .length || 1;
  }

  function firstTrackWidth(gridTemplateColumns, fallback) {
    const firstTrack = (gridTemplateColumns || '').trim().split(/\s+/)[0] || '';
    const parsed = Number.parseFloat(firstTrack);
    return Number.isFinite(parsed) && parsed > 0 ? parsed : fallback;
  }

  function spanDisplayRatio(columnSpan, rowSpan, columnWidth, rowHeight, gap) {
    const width = columnSpan * columnWidth + Math.max(0, columnSpan - 1) * gap;
    const height = rowSpan * rowHeight + Math.max(0, rowSpan - 1) * gap;
    return width / Math.max(1, height);
  }

  function layoutOptions(options, columns) {
    const safeColumns = Math.max(
      1,
      Math.floor(safeNumber(columns ?? options.columns, 1)),
    );
    return {
      columns: safeColumns,
      columnWidth: safeNumber(options.columnWidth, 160),
      rowHeight: safeNumber(options.rowHeight, 80),
      gap: safeNumber(options.gap, 0),
      maxColumnSpan: Math.min(
        safeColumns,
        Math.max(1, Math.floor(safeNumber(options.maxColumnSpan, DEFAULT_MAX_COLUMN_SPAN))),
      ),
      maxRowSpan: Math.max(
        1,
        Math.floor(safeNumber(options.maxRowSpan, DEFAULT_MAX_ROW_SPAN)),
      ),
      rowDelayPenalty: safeNumber(options.rowDelayPenalty, DEFAULT_ROW_DELAY_PENALTY),
      columnDriftPenalty: safeNumber(options.columnDriftPenalty, DEFAULT_COLUMN_DRIFT_PENALTY),
      sealMaxRatioMismatch: safeNumber(
        options.sealMaxRatioMismatch,
        DEFAULT_SEAL_MAX_RATIO_MISMATCH,
      ),
      bottomMaxRatioMismatch: safeNumber(
        options.bottomMaxRatioMismatch,
        DEFAULT_BOTTOM_MAX_RATIO_MISMATCH,
      ),
    };
  }

  function spanRatioScore(aspectRatio, columnSpan, rowSpan, layout) {
    const displayRatio = spanDisplayRatio(
      columnSpan,
      rowSpan,
      layout.columnWidth,
      layout.rowHeight,
      layout.gap,
    );
    return Math.abs(Math.log(displayRatio / aspectRatio));
  }

  function targetAreaFor(aspectRatio) {
    if (aspectRatio >= 1.9 || aspectRatio <= 0.7) {
      return 6;
    }
    if (aspectRatio >= 1.35 || aspectRatio <= 0.9) {
      return 5;
    }
    return 4;
  }

  function galleryCandidateSpans(item, options = {}) {
    const layout = layoutOptions(options, options.columns);
    const aspectRatio = safeNumber(item.aspectRatio, 1);
    const targetArea = targetAreaFor(aspectRatio);
    const candidates = [];

    for (let columnSpan = 1; columnSpan <= layout.maxColumnSpan; columnSpan++) {
      for (let rowSpan = 1; rowSpan <= layout.maxRowSpan; rowSpan++) {
        const displayRatio = spanDisplayRatio(
          columnSpan,
          rowSpan,
          layout.columnWidth,
          layout.rowHeight,
          layout.gap,
        );
        const ratioScore = Math.abs(Math.log(displayRatio / aspectRatio));
        const area = columnSpan * rowSpan;
        let score = ratioScore * 4 + Math.abs(area - targetArea) * 0.12;
        if (columnSpan === 1 && rowSpan === 1) {
          score += 1.2;
        } else if (columnSpan === 1 && layout.columns > 3) {
          score += 0.25;
        }
        if (columnSpan === layout.columns && layout.columns > 3) {
          score += 0.5;
        }
        candidates.push({ columnSpan, rowSpan, score, ratioScore, displayRatio });
      }
    }

    candidates.sort((a, b) =>
      a.score - b.score ||
      a.ratioScore - b.ratioScore ||
      b.columnSpan - a.columnSpan ||
      a.rowSpan - b.rowSpan,
    );
    return candidates;
  }

  function makeRow(columns) {
    return Array.from({ length: columns }, () => false);
  }

  function ensureRow(occupied, row, columns) {
    while (occupied.length <= row) {
      occupied.push(makeRow(columns));
    }
  }

  function isFree(occupied, row, column, columnSpan, rowSpan, columns) {
    if (column + columnSpan > columns) {
      return false;
    }
    for (let rowOffset = 0; rowOffset < rowSpan; rowOffset++) {
      ensureRow(occupied, row + rowOffset, columns);
      for (let columnOffset = 0; columnOffset < columnSpan; columnOffset++) {
        if (occupied[row + rowOffset][column + columnOffset]) {
          return false;
        }
      }
    }
    return true;
  }

  function occupy(occupied, placement, columns) {
    for (let rowOffset = 0; rowOffset < placement.rowSpan; rowOffset++) {
      ensureRow(occupied, placement.row + rowOffset, columns);
      for (let columnOffset = 0; columnOffset < placement.columnSpan; columnOffset++) {
        occupied[placement.row + rowOffset][placement.column + columnOffset] = true;
      }
    }
  }

  function ownerRowsFor(placements, columns) {
    const rows = [];
    for (let index = 0; index < placements.length; index++) {
      const placement = placements[index];
      for (let rowOffset = 0; rowOffset < placement.rowSpan; rowOffset++) {
        const row = placement.row + rowOffset;
        rows[row] ??= Array.from({ length: columns }, () => -1);
        for (let columnOffset = 0; columnOffset < placement.columnSpan; columnOffset++) {
          rows[row][placement.column + columnOffset] = index;
        }
      }
    }
    return rows.map((row) => row ?? Array.from({ length: columns }, () => -1));
  }

  function canExtendDown(ownerRows, placement, row) {
    const targetRow = ownerRows[row];
    if (!targetRow) {
      return false;
    }
    for (let column = placement.column; column < placement.column + placement.columnSpan; column++) {
      if (targetRow[column] !== -1) {
        return false;
      }
    }
    return true;
  }

  function canExpandRight(ownerRows, placement, column) {
    for (let row = placement.row; row < placement.row + placement.rowSpan; row++) {
      if (ownerRows[row]?.[column] !== -1) {
        return false;
      }
    }
    return true;
  }

  function canExpandLeft(ownerRows, placement, column) {
    for (let row = placement.row; row < placement.row + placement.rowSpan; row++) {
      if (ownerRows[row]?.[column] !== -1) {
        return false;
      }
    }
    return true;
  }

  function canExtendUp(ownerRows, placement, row) {
    const targetRow = ownerRows[row];
    if (!targetRow) {
      return false;
    }
    for (let column = placement.column; column < placement.column + placement.columnSpan; column++) {
      if (targetRow[column] !== -1) {
        return false;
      }
    }
    return true;
  }

  function expansionCandidate(placements, items, index, nextPlacement, layout, maxRatioMismatch) {
    if (index < 0 || index >= placements.length) {
      return null;
    }
    if (
      nextPlacement.column < 0 ||
      nextPlacement.column + nextPlacement.columnSpan > layout.columns ||
      nextPlacement.columnSpan > layout.maxColumnSpan ||
      nextPlacement.rowSpan > layout.maxRowSpan + 3
    ) {
      return null;
    }

    const item = items[index] ?? {};
    const aspectRatio = safeNumber(item.aspectRatio, 1);
    const current = placements[index];
    const currentScore = spanRatioScore(
      aspectRatio,
      current.columnSpan,
      current.rowSpan,
      layout,
    );
    const nextScore = spanRatioScore(
      aspectRatio,
      nextPlacement.columnSpan,
      nextPlacement.rowSpan,
      layout,
    );
    const allowedMismatch = Math.max(currentScore + 0.08, maxRatioMismatch);
    if (nextScore > allowedMismatch) {
      return null;
    }

    const sizeDelta =
      Math.max(0, nextPlacement.columnSpan - current.columnSpan) +
      Math.max(0, nextPlacement.rowSpan - current.rowSpan);
    return {
      index,
      placement: nextPlacement,
      score: nextScore + sizeDelta * 0.02,
    };
  }

  function bestExpansionForHole(
    ownerRows,
    placements,
    items,
    row,
    column,
    layout,
    maxRatioMismatch,
    allowBelow,
  ) {
    const candidates = [];
    const columns = layout.columns;

    const aboveIndex = row > 0 ? ownerRows[row - 1]?.[column] : -1;
    if (aboveIndex >= 0) {
      const placement = placements[aboveIndex];
      if (
        placement.row + placement.rowSpan === row &&
        canExtendDown(ownerRows, placement, row)
      ) {
        const candidate = expansionCandidate(
          placements,
          items,
          aboveIndex,
          { ...placement, rowSpan: placement.rowSpan + 1 },
          layout,
          maxRatioMismatch,
        );
        if (candidate) candidates.push(candidate);
      }
    }

    const leftIndex = column > 0 ? ownerRows[row][column - 1] : -1;
    if (leftIndex >= 0) {
      const placement = placements[leftIndex];
      if (
        placement.column + placement.columnSpan === column &&
        canExpandRight(ownerRows, placement, column)
      ) {
        const candidate = expansionCandidate(
          placements,
          items,
          leftIndex,
          { ...placement, columnSpan: placement.columnSpan + 1 },
          layout,
          maxRatioMismatch,
        );
        if (candidate) candidates.push(candidate);
      }
    }

    const rightIndex = column + 1 < columns ? ownerRows[row][column + 1] : -1;
    if (rightIndex >= 0) {
      const placement = placements[rightIndex];
      if (
        placement.column === column + 1 &&
        canExpandLeft(ownerRows, placement, column)
      ) {
        const candidate = expansionCandidate(
          placements,
          items,
          rightIndex,
          {
            ...placement,
            column,
            columnSpan: placement.columnSpan + 1,
          },
          layout,
          maxRatioMismatch,
        );
        if (candidate) candidates.push(candidate);
      }
    }

    const belowIndex = allowBelow && row + 1 < ownerRows.length
      ? ownerRows[row + 1][column]
      : -1;
    if (belowIndex >= 0) {
      const placement = placements[belowIndex];
      if (
        placement.row === row + 1 &&
        canExtendUp(ownerRows, placement, row)
      ) {
        const candidate = expansionCandidate(
          placements,
          items,
          belowIndex,
          {
            ...placement,
            row,
            rowSpan: placement.rowSpan + 1,
          },
          layout,
          maxRatioMismatch,
        );
        if (candidate) candidates.push(candidate);
      }
    }

    candidates.sort((a, b) => a.score - b.score);
    return candidates[0] ?? null;
  }

  function applyExpansion(placements, expansion) {
    const placement = placements[expansion.index];
    placement.row = expansion.placement.row;
    placement.column = expansion.placement.column;
    placement.columnSpan = expansion.placement.columnSpan;
    placement.rowSpan = expansion.placement.rowSpan;
  }

  function sealInteriorHoles(placements, items, layout) {
    let changed = true;
    let guard = placements.length * layout.columns * 8;

    while (changed && guard-- > 0) {
      changed = false;
      const ownerRows = ownerRowsFor(placements, layout.columns);
      const lastRow = ownerRows.length - 1;

      for (let row = 0; row < lastRow && !changed; row++) {
        for (let column = 0; column < layout.columns; column++) {
          if (ownerRows[row][column] !== -1) {
            continue;
          }

          const expansion = bestExpansionForHole(
            ownerRows,
            placements,
            items,
            row,
            column,
            layout,
            layout.sealMaxRatioMismatch,
            true,
          );
          if (!expansion) {
            continue;
          }

          applyExpansion(placements, expansion);
          changed = true;
          break;
        }
      }
    }

    return placements;
  }

  function squareOffBottom(placements, items, layout) {
    let changed = true;
    let guard = placements.length * layout.columns * 2;

    while (changed && guard-- > 0) {
      changed = false;
      const ownerRows = ownerRowsFor(placements, layout.columns);
      const lastRow = ownerRows.length - 1;

      for (let column = 0; column < layout.columns; column++) {
        if (ownerRows[lastRow]?.[column] !== -1) {
          continue;
        }

        const expansion = bestExpansionForHole(
          ownerRows,
          placements,
          items,
          lastRow,
          column,
          layout,
          layout.bottomMaxRatioMismatch,
          false,
        );
        if (!expansion) {
          continue;
        }

        applyExpansion(placements, expansion);
        changed = true;
        break;
      }
    }

    return placements;
  }

  function firstEmptyCell(occupied, columns) {
    for (let row = 0; row < occupied.length; row++) {
      for (let column = 0; column < columns; column++) {
        if (!occupied[row][column]) {
          return { row, column };
        }
      }
    }
    return { row: occupied.length, column: 0 };
  }

  function galleryPack(items, options = {}) {
    const layout = layoutOptions(options, options.columns);
    const columns = layout.columns;
    const occupied = [];
    const placements = [];

    for (const item of items) {
      const placement = bestPlacementForItem(
        occupied,
        galleryCandidateSpans(item, { ...options, columns }),
        layout,
      );
      occupy(occupied, placement, columns);
      placements.push(placement);
    }

    return squareOffBottom(
      sealInteriorHoles(placements, items, layout),
      items,
      layout,
    );
  }

  function bestPlacementForItem(occupied, candidates, layout) {
    const firstCell = firstEmptyCell(occupied, layout.columns);
    const maxSearchRow = firstCell.row + layout.maxRowSpan + layout.columns + 4;
    let best = null;

    for (const candidate of candidates) {
      const maxColumn = layout.columns - candidate.columnSpan;
      for (let row = firstCell.row; row <= maxSearchRow; row++) {
        const startColumn = row === firstCell.row ? firstCell.column : 0;
        for (let column = startColumn; column <= maxColumn; column++) {
          if (
            !isFree(
              occupied,
              row,
              column,
              candidate.columnSpan,
              candidate.rowSpan,
              layout.columns,
            )
          ) {
            continue;
          }

          const rowDelay = row - firstCell.row;
          const columnDrift = row === firstCell.row
            ? Math.abs(column - firstCell.column)
            : column;
          const score =
            candidate.score +
            rowDelay * layout.rowDelayPenalty +
            columnDrift * layout.columnDriftPenalty;
          if (!best || score < best.score) {
            best = {
              row,
              column,
              columnSpan: candidate.columnSpan,
              rowSpan: candidate.rowSpan,
              score,
            };
          }
        }
      }
    }

    if (best) {
      return {
        row: best.row,
        column: best.column,
        columnSpan: best.columnSpan,
        rowSpan: best.rowSpan,
      };
    }

    const fallback = candidates[0] ?? { columnSpan: 1, rowSpan: 1 };
    return {
      row: firstCell.row,
      column: firstCell.column,
      columnSpan: Math.min(fallback.columnSpan, layout.columns - firstCell.column),
      rowSpan: fallback.rowSpan,
    };
  }

  // Pure mapping from a placement to its CSS grid-line values.
  function galleryPlacementStyle(placement) {
    return {
      gridColumn: `${placement.column + 1} / span ${placement.columnSpan}`,
      gridRow: `${placement.row + 1} / span ${placement.rowSpan}`,
    };
  }

  function resetPlacementsForMeasurement(
    elements,
    previousWidth,
    currentWidth,
  ) {
    const isFirstMeasurement = !Number.isFinite(previousWidth);
    const widthShrank = currentWidth < previousWidth - 0.5;
    if (!isFirstMeasurement && !widthShrank) {
      return false;
    }

    for (const element of elements) {
      // A placement written for a wider grid can address a column that no longer
      // exists. CSS then creates an implicit sliver track, and the resolved
      // gridTemplateColumns value includes that track. Neutralize our placements
      // while measuring so the packer sees only the current explicit grid.
      element.style.gridColumn = 'auto';
      element.style.gridRow = 'auto';
    }
    return true;
  }

  const lastMeasuredWidth = typeof WeakMap === 'function' ? new WeakMap() : null;

  function applyMasonry(container) {
    if (!container || container.clientWidth <= 0) {
      return;
    }

    const elements = Array.from(container.children).filter((element) =>
      element.hasAttribute('data-arcane-gallery-item'),
    );
    const currentWidth = container.clientWidth;
    resetPlacementsForMeasurement(
      elements,
      lastMeasuredWidth?.get(container),
      currentWidth,
    );
    lastMeasuredWidth?.set(container, currentWidth);

    const styles = window.getComputedStyle(container);
    const columns = trackCount(styles.gridTemplateColumns);
    const columnWidth = firstTrackWidth(
      styles.gridTemplateColumns,
      container.clientWidth / columns,
    );
    const rowHeight = safeNumber(
      styles.getPropertyValue('--arcane-gallery-row') || styles.gridAutoRows,
      80,
    );
    const gap = safeNumber(styles.rowGap, 0);
    const maxColumnSpan = safeNumber(
      container.dataset.arcaneGalleryMaxColumnSpan,
      DEFAULT_MAX_COLUMN_SPAN,
    );
    const maxRowSpan = safeNumber(
      container.dataset.arcaneGalleryMaxRowSpan,
      DEFAULT_MAX_ROW_SPAN,
    );
    const layout = layoutOptions(
      {
        columns,
        columnWidth,
        rowHeight,
        gap,
        maxColumnSpan,
        maxRowSpan,
      },
      columns,
    );
    const items = elements.map((element) => ({
      aspectRatio: safeNumber(element.dataset.ratio, 1),
    }));
    const placements = galleryPack(items, {
      columns,
      columnWidth,
      rowHeight,
      gap,
      maxColumnSpan,
      maxRowSpan,
    });

    for (let index = 0; index < elements.length; index++) {
      const placement = placements[index];
      const element = elements[index];
      const { gridColumn, gridRow } = galleryPlacementStyle(placement);
      // Skip-detection MUST read the live inline style, not a cache: framework
      // re-renders (Jaspr diffing) wipe the inline styles between repacks, and
      // a stale "already written" cache leaves those cells permanently unplaced
      // (1x1 auto-flow tiles + holes after infinite-scroll appends). This live
      // comparison is also the loop-breaker for the document MutationObserver:
      // our own style writes fire style mutations, but the echo repack finds the
      // styles already correct and writes nothing, so the observer settles.
      if (
        element.style.gridColumn === gridColumn &&
        element.style.gridRow === gridRow
      ) {
        continue;
      }

      const displayRatio = spanDisplayRatio(
        placement.columnSpan,
        placement.rowSpan,
        columnWidth,
        rowHeight,
        gap,
      );
      const ratioMismatch = Math.abs(
        Math.log(displayRatio / safeNumber(items[index]?.aspectRatio, 1)),
      );
      element.style.gridColumn = gridColumn;
      element.style.gridRow = gridRow;
      element.dataset.arcaneGalleryColumnSpan = String(placement.columnSpan);
      element.dataset.arcaneGalleryRowSpan = String(placement.rowSpan);
      element.dataset.arcaneGalleryDisplayRatio = displayRatio.toFixed(4);
      element.dataset.arcaneGalleryRatioMismatch = ratioMismatch.toFixed(4);
      element.dataset.arcaneGalleryFit = 'cover';
    }

    container.classList.add('is-arcane-gallery-ready');
  }

  if (typeof window === 'undefined' || typeof document === 'undefined') {
    return;
  }

  const CONTAINER_SELECTOR = '[data-arcane-gallery][data-packing="true"]';
  const scheduled = new WeakSet();
  const resizeObserver = 'ResizeObserver' in window
    ? new ResizeObserver((entries) => {
        for (const entry of entries) {
          schedule(entry.target);
        }
      })
    : null;

  function schedule(container) {
    if (!container || scheduled.has(container)) {
      return;
    }
    scheduled.add(container);
    window.requestAnimationFrame(() => {
      scheduled.delete(container);
      applyMasonry(container);
    });
  }

  function observe(container) {
    if (!container) {
      return;
    }
    if (container.dataset.arcaneGalleryObserved === 'true') {
      // Already wired up: just request a repack (idempotent).
      schedule(container);
      return;
    }
    container.dataset.arcaneGalleryObserved = 'true';
    resizeObserver?.observe(container);
    schedule(container);
  }

  function containerFor(node) {
    if (!node) {
      return null;
    }
    const element = node.nodeType === 1 ? node : node.parentElement;
    return element && element.closest
      ? element.closest(CONTAINER_SELECTOR)
      : null;
  }

  function refreshAll() {
    document
      .querySelectorAll(CONTAINER_SELECTOR)
      .forEach((container) => observe(container));
  }

  // Single document-level observer. childList mutations surface newly-added
  // packing containers and newly-added items (infinite-scroll appends);
  // attribute mutations surface Jaspr re-syncing inline styles (which wipes our
  // placements). Both are coalesced through schedule() -> rAF. Our own writes
  // are neutralized by the live-style skip-detection in applyMasonry, so the
  // observer settles instead of looping.
  function handleMutations(mutations) {
    for (const mutation of mutations) {
      if (mutation.type === 'childList') {
        for (const node of mutation.addedNodes) {
          if (!node || node.nodeType !== 1) {
            continue;
          }
          if (node.matches && node.matches(CONTAINER_SELECTOR)) {
            observe(node);
          }
          if (node.querySelectorAll) {
            node
              .querySelectorAll(CONTAINER_SELECTOR)
              .forEach((container) => observe(container));
          }
        }
        const container = containerFor(mutation.target);
        if (container) {
          schedule(container);
        }
      } else if (mutation.type === 'attributes') {
        const container = containerFor(mutation.target);
        if (container) {
          schedule(container);
        }
      }
    }
  }

  const documentObserver = 'MutationObserver' in window
    ? new MutationObserver(handleMutations)
    : null;

  function startDocumentObserver() {
    documentObserver?.observe(document.documentElement || document.body, {
      childList: true,
      subtree: true,
      attributes: true,
      attributeFilter: ['style', 'data-ratio', 'data-packing'],
    });
  }

  window.ArcaneGallery = {
    observe,
    refresh: refreshAll,
    refreshAll,
    pack: galleryPack,
    candidateSpans: galleryCandidateSpans,
  };

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
      startDocumentObserver();
      refreshAll();
    }, { once: true });
  } else {
    startDocumentObserver();
    refreshAll();
  }
})();
''';
}
