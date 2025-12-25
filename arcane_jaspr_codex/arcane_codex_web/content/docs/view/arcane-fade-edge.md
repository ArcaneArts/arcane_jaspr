---
title: ArcaneFadeEdge
description: Gradient fade overlays for carousels and scrolling content
layout: docs
component: fade-edge
---

# ArcaneFadeEdge

A gradient fade overlay component for creating smooth edge transitions on carousels, marquees, and scrolling content.

## Basic Usage

```dart
ArcaneStack(
  children: [
    ScrollableContent(...),
    ArcaneFadeEdge.left(),
    ArcaneFadeEdge.right(),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `direction` | `FadeDirection` | required | Fade direction |
| `color` | `String?` | `null` | Fade color (defaults to background) |
| `width` | `String?` | `null` | Fade width (for left/right) |
| `height` | `String?` | `null` | Fade height (for top/bottom) |
| `zIndex` | `int?` | `null` | Stack z-index |

## Directions

```dart
// Left edge fade
ArcaneFadeEdge.left()

// Right edge fade
ArcaneFadeEdge.right()

// Top edge fade
ArcaneFadeEdge.top()

// Bottom edge fade
ArcaneFadeEdge.bottom()
```

## Examples

### Horizontal Scroll Container

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    position: Position.relative,
    overflow: Overflow.hidden,
  ),
  children: [
    ArcaneDiv(
      styles: const ArcaneStyleData(
        display: Display.flex,
        overflow: Overflow.scrollX,
      ),
      children: [...items],
    ),
    ArcaneFadeEdge.left(color: '#09090b'),
    ArcaneFadeEdge.right(color: '#09090b'),
  ],
)
```

### Vertical Scroll Area

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    position: Position.relative,
    heightCustom: '400px',
  ),
  children: [
    ArcaneScrollArea(children: [...content]),
    ArcaneFadeEdge.top(),
    ArcaneFadeEdge.bottom(),
  ],
)
```

### Custom Width

```dart
ArcaneFadeEdge.left(
  color: 'var(--arcane-background)',
  width: '100px',
)
```

## Related Components

- [ArcaneMarquee](/docs/view/arcane-marquee) - Auto-scrolling marquee with fade edges
- [ArcaneScrollArea](/docs/layout/arcane-scroll-area) - Scrollable container
