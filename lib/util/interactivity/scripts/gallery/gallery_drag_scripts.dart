/// Opt-in pointer and keyboard repositioning for draggable Arcane gallery
/// tiles.
///
/// The behavior is activated only for
/// `[data-arcane-gallery-draggable="true"]` surfaces. Pointer drags start from
/// renderer-owned handles, cross a click-safe threshold, remain clamped to the
/// gallery, and suppress the link click that follows a completed drag. Focused
/// tiles can be moved with Shift+Arrow and announce the result to assistive
/// technology.
class GalleryDragScripts {
  GalleryDragScripts._();

  static String get code => r'''
(function() {
  'use strict';

  const GALLERY_SELECTOR =
    '[data-arcane-gallery][data-arcane-gallery-draggable="true"]';
  const ITEM_SELECTOR = '[data-arcane-draggable-item="true"]';
  const HANDLE_SELECTOR = '[data-arcane-drag-handle="true"]';
  const DRAG_THRESHOLD_PX = 6;
  const CLICK_SUPPRESSION_MS = 500;
  const INTERACTIVE_SELECTOR =
    'a[href],button,input,textarea,select,option,summary,[contenteditable="true"],' +
    '[role="button"],[role="link"],[tabindex]';
  const offsetsByGallery = new WeakMap();
  const offsetsByGalleryId = new Map();

  function finiteNumber(value, fallback) {
    const parsed = Number.parseFloat(String(value ?? ''));
    return Number.isFinite(parsed) ? parsed : fallback;
  }

  function crossedThreshold(deltaX, deltaY) {
    return Math.hypot(deltaX, deltaY) >= DRAG_THRESHOLD_PX;
  }

  function clamp(value, minimum, maximum) {
    if (minimum > maximum) {
      return (minimum + maximum) / 2;
    }
    return Math.min(maximum, Math.max(minimum, value));
  }

  function clampOffset({
    originX,
    originY,
    deltaX,
    deltaY,
    itemRect,
    galleryRect,
    inset = 4,
  }) {
    const minDeltaX = galleryRect.left + inset - itemRect.left;
    const maxDeltaX = galleryRect.right - inset - itemRect.right;
    const minDeltaY = galleryRect.top + inset - itemRect.top;
    const maxDeltaY = galleryRect.bottom - inset - itemRect.bottom;
    return {
      x: originX + clamp(deltaX, minDeltaX, maxDeltaX),
      y: originY + clamp(deltaY, minDeltaY, maxDeltaY),
    };
  }

  function offsetStoreFor(gallery) {
    const stableId = gallery?.dataset?.arcaneGalleryDragId;
    if (stableId) {
      if (!offsetsByGalleryId.has(stableId)) {
        offsetsByGalleryId.set(stableId, new Map());
      }
      return offsetsByGalleryId.get(stableId);
    }
    if (!offsetsByGallery.has(gallery)) {
      offsetsByGallery.set(gallery, new Map());
    }
    return offsetsByGallery.get(gallery);
  }

  function storedOffsetFor(item) {
    const gallery = item.closest(GALLERY_SELECTOR);
    const key = item.dataset.arcaneDragKey;
    if (!(gallery && key)) {
      return null;
    }
    return offsetStoreFor(gallery).get(key) ?? null;
  }

  function offsetFor(item) {
    const stored = storedOffsetFor(item);
    if (stored) {
      return { x: stored.x, y: stored.y };
    }
    return {
      x: finiteNumber(item.dataset.arcaneDragX, 0),
      y: finiteNumber(item.dataset.arcaneDragY, 0),
    };
  }

  function writeOffset(item, offset) {
    const x = Math.round(offset.x);
    const y = Math.round(offset.y);
    const xText = String(x);
    const yText = String(y);
    const xCss = `${x}px`;
    const yCss = `${y}px`;
    if (item.dataset.arcaneDragX !== xText) {
      item.dataset.arcaneDragX = xText;
    }
    if (item.dataset.arcaneDragY !== yText) {
      item.dataset.arcaneDragY = yText;
    }
    if (item.style.getPropertyValue('--arcane-drag-x') !== xCss) {
      item.style.setProperty('--arcane-drag-x', xCss);
    }
    if (item.style.getPropertyValue('--arcane-drag-y') !== yCss) {
      item.style.setProperty('--arcane-drag-y', yCss);
    }
    const gallery = item.closest(GALLERY_SELECTOR);
    const key = item.dataset.arcaneDragKey;
    if (gallery && key) {
      offsetStoreFor(gallery).set(key, { x, y });
    }
  }

  function dragInsetFor(gallery) {
    return Math.max(0, finiteNumber(gallery.dataset.arcaneDragInset, 4));
  }

  function keyboardStepFor(gallery) {
    return Math.max(
      1,
      finiteNumber(gallery.dataset.arcaneDragKeyboardStep, 16),
    );
  }

  function pointerDragIsAvailable() {
    return !window.matchMedia?.('(pointer: coarse)').matches;
  }

  function dragTargetFor(target) {
    if (!(target instanceof Element)) {
      return null;
    }
    const handle = target.closest(HANDLE_SELECTOR);
    const item = handle?.closest(ITEM_SELECTOR);
    const gallery = item?.closest(GALLERY_SELECTOR);
    if (!(handle && item && gallery)) {
      return null;
    }
    const interactive = target.closest(INTERACTIVE_SELECTOR);
    if (interactive && interactive !== item && interactive !== handle) {
      return null;
    }
    return { handle, item, gallery };
  }

  function keyboardTargetFor(target) {
    if (!(target instanceof Element)) {
      return null;
    }
    const item = target.closest(ITEM_SELECTOR);
    const gallery = item?.closest(GALLERY_SELECTOR);
    if (!(item && gallery)) {
      return null;
    }
    const interactive = target.closest(INTERACTIVE_SELECTOR);
    if (interactive && interactive !== item) {
      return null;
    }
    return { item, gallery };
  }

  function createAnnouncer() {
    const existing = document.querySelector('.arcane-gallery-drag-announcer');
    if (existing) {
      return existing;
    }
    const announcer = document.createElement('div');
    announcer.className = 'arcane-gallery-drag-announcer';
    announcer.setAttribute('role', 'status');
    announcer.setAttribute('aria-live', 'polite');
    announcer.setAttribute('aria-atomic', 'true');
    document.body.appendChild(announcer);
    return announcer;
  }

  function announce(message) {
    const announcer = createAnnouncer();
    announcer.textContent = '';
    window.setTimeout(() => {
      announcer.textContent = message;
    }, 0);
  }

  function restoreOffsets(gallery) {
    if (!gallery?.matches?.(GALLERY_SELECTOR)) {
      return;
    }
    const store = offsetStoreFor(gallery);
    gallery.querySelectorAll(ITEM_SELECTOR).forEach((item) => {
      const key = item.dataset.arcaneDragKey;
      const stored = key ? store.get(key) : null;
      if (stored) {
        writeOffset(item, stored);
      }
    });
  }

  function reclampGallery(gallery) {
    if (
      !gallery?.matches?.(GALLERY_SELECTOR) ||
      gallery.clientWidth <= 0 ||
      gallery.clientHeight <= 0
    ) {
      return;
    }
    const galleryRect = gallery.getBoundingClientRect();
    const inset = dragInsetFor(gallery);
    gallery.querySelectorAll(ITEM_SELECTOR).forEach((item) => {
      const origin = offsetFor(item);
      const next = clampOffset({
        originX: origin.x,
        originY: origin.y,
        deltaX: 0,
        deltaY: 0,
        itemRect: item.getBoundingClientRect(),
        galleryRect,
        inset,
      });
      if (next.x !== origin.x || next.y !== origin.y) {
        writeOffset(item, next);
      }
    });
  }

  if (typeof window === 'undefined') {
    return;
  }

  window.ArcaneGalleryDrag = {
    crossedThreshold,
    clampOffset,
    refresh: () => {
      if (typeof document !== 'undefined') {
        document.querySelectorAll(GALLERY_SELECTOR).forEach(observeGallery);
      }
    },
  };

  if (typeof document === 'undefined') {
    return;
  }

  let active = null;
  let suppressedClick = null;
  let zOrder = 10;
  const restoreScheduled = new WeakSet();

  const resizeObserver = 'ResizeObserver' in window
    ? new ResizeObserver((entries) => {
        for (const entry of entries) {
          reclampGallery(entry.target);
        }
      })
    : null;

  function scheduleRestore(gallery) {
    if (!gallery || restoreScheduled.has(gallery)) {
      return;
    }
    restoreScheduled.add(gallery);
    window.requestAnimationFrame(() => {
      restoreScheduled.delete(gallery);
      restoreOffsets(gallery);
      reclampGallery(gallery);
    });
  }

  function observeGallery(gallery) {
    if (!gallery) {
      return;
    }
    if (gallery.dataset.arcaneDragObserved !== 'true') {
      gallery.dataset.arcaneDragObserved = 'true';
      resizeObserver?.observe(gallery);
    }
    scheduleRestore(gallery);
  }

  function refreshAll() {
    document.querySelectorAll(GALLERY_SELECTOR).forEach(observeGallery);
  }

  function finishDrag(pointerId, cancelled = false) {
    if (!active || pointerId !== active.pointerId) {
      return;
    }
    const current = active;
    active = null;
    const { item, gallery, dragging, origin } = current;
    if (cancelled && dragging) {
      writeOffset(item, origin);
    }
    try {
      if (item.hasPointerCapture(pointerId)) {
        item.releasePointerCapture(pointerId);
      }
    } catch (_) {
      // Browsers can release pointer capture automatically.
    }
    item.classList.remove('is-arcane-gallery-dragging');
    gallery.classList.remove('is-arcane-gallery-drag-active');
    if (dragging && !cancelled) {
      suppressedClick = {
        item,
        until: performance.now() + CLICK_SUPPRESSION_MS,
      };
      announce(
        'Item repositioned. Use Shift and the arrow keys to fine tune it.',
      );
    }
    if (gallery.dataset.packing === 'true') {
      window.ArcaneGallery?.observe?.(gallery);
    }
  }

  document.addEventListener(
    'pointerdown',
    (event) => {
      if (
        active ||
        !pointerDragIsAvailable() ||
        event.button !== 0 ||
        event.isPrimary === false ||
        event.altKey ||
        event.ctrlKey ||
        event.metaKey ||
        event.shiftKey
      ) {
        return;
      }
      const target = dragTargetFor(event.target);
      if (!target) {
        return;
      }
      const origin = offsetFor(target.item);
      target.item.setAttribute('draggable', 'false');
      target.item.style.zIndex = String(++zOrder);
      active = {
        ...target,
        pointerId: event.pointerId,
        startX: event.clientX,
        startY: event.clientY,
        startRect: target.item.getBoundingClientRect(),
        galleryRect: target.gallery.getBoundingClientRect(),
        origin,
        dragging: false,
      };
      try {
        target.item.setPointerCapture(event.pointerId);
      } catch (_) {
        // Dragging still works while the pointer remains over the document.
      }
    },
    true,
  );

  document.addEventListener(
    'pointermove',
    (event) => {
      if (!active || event.pointerId !== active.pointerId) {
        return;
      }
      const deltaX = event.clientX - active.startX;
      const deltaY = event.clientY - active.startY;
      if (!active.dragging) {
        if (!crossedThreshold(deltaX, deltaY)) {
          return;
        }
        active.dragging = true;
        active.item.classList.add('is-arcane-gallery-dragging');
        active.gallery.classList.add('is-arcane-gallery-drag-active');
      }
      event.preventDefault();
      writeOffset(
        active.item,
        clampOffset({
          originX: active.origin.x,
          originY: active.origin.y,
          deltaX,
          deltaY,
          itemRect: active.startRect,
          galleryRect: active.galleryRect,
          inset: dragInsetFor(active.gallery),
        }),
      );
    },
    true,
  );

  document.addEventListener(
    'pointerup',
    (event) => finishDrag(event.pointerId),
    true,
  );
  document.addEventListener(
    'pointercancel',
    (event) => finishDrag(event.pointerId, true),
    true,
  );
  document.addEventListener(
    'lostpointercapture',
    (event) => {
      if (
        active &&
        event.pointerId === active.pointerId &&
        event.target === active.item
      ) {
        finishDrag(event.pointerId, true);
      }
    },
    true,
  );

  document.addEventListener(
    'click',
    (event) => {
      if (!suppressedClick) {
        return;
      }
      if (performance.now() > suppressedClick.until) {
        suppressedClick = null;
        return;
      }
      if (event.composedPath().includes(suppressedClick.item)) {
        event.preventDefault();
        event.stopImmediatePropagation();
        suppressedClick = null;
      }
    },
    true,
  );

  document.addEventListener(
    'keydown',
    (event) => {
      if (active && event.key === 'Escape') {
        writeOffset(active.item, active.origin);
        finishDrag(active.pointerId, true);
        event.preventDefault();
        return;
      }
      if (!event.shiftKey || !event.key.startsWith('Arrow')) {
        return;
      }
      const target = keyboardTargetFor(event.target);
      if (!target) {
        return;
      }
      const step = keyboardStepFor(target.gallery);
      const direction = {
        ArrowLeft: [-step, 0],
        ArrowRight: [step, 0],
        ArrowUp: [0, -step],
        ArrowDown: [0, step],
      }[event.key];
      if (!direction) {
        return;
      }
      event.preventDefault();
      const origin = offsetFor(target.item);
      const next = clampOffset({
        originX: origin.x,
        originY: origin.y,
        deltaX: direction[0],
        deltaY: direction[1],
        itemRect: target.item.getBoundingClientRect(),
        galleryRect: target.gallery.getBoundingClientRect(),
        inset: dragInsetFor(target.gallery),
      });
      if (
        Math.round(next.x) === Math.round(origin.x) &&
        Math.round(next.y) === Math.round(origin.y)
      ) {
        announce('Item is already at the edge of the gallery.');
        return;
      }
      writeOffset(target.item, next);
      target.item.style.zIndex = String(++zOrder);
      announce(`Item moved ${event.key.replace('Arrow', '').toLowerCase()}.`);
    },
    true,
  );

  const mutationObserver = 'MutationObserver' in window
    ? new MutationObserver((mutations) => {
        for (const mutation of mutations) {
          if (mutation.type === 'attributes') {
            const gallery = mutation.target.closest?.(GALLERY_SELECTOR);
            if (gallery) {
              observeGallery(gallery);
            }
            continue;
          }
          for (const node of mutation.addedNodes) {
            if (!node || node.nodeType !== 1) {
              continue;
            }
            if (node.matches?.(GALLERY_SELECTOR)) {
              observeGallery(node);
            }
            node.querySelectorAll?.(GALLERY_SELECTOR).forEach(observeGallery);
          }
        }
      })
    : null;

  function start() {
    refreshAll();
    mutationObserver?.observe(document.documentElement || document.body, {
      childList: true,
      subtree: true,
      attributes: true,
      attributeFilter: [
        'style',
        'data-arcane-drag-x',
        'data-arcane-drag-y',
      ],
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', start, { once: true });
  } else {
    start();
  }
})();
''';
}
