---
title: ArcaneSvg
description: SVG element abstraction
layout: docs
component: svg
---

# ArcaneSvg

A set of components for creating inline SVG elements with a clean, type-safe API.

## Basic Usage

```dart
ArcaneSvg(
  viewBox: '0 0 24 24',
  size: SvgSize.lg,
  children: [
    ArcaneSvgPath(
      d: 'M12 2L15.09 8.26L22 9.27...',
    ),
  ],
)
```

## ArcaneSvg Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `viewBox` | `String` | `'0 0 24 24'` | SVG viewBox |
| `width` | `String?` | `null` | Width (if size not set) |
| `height` | `String?` | `null` | Height (if size not set) |
| `size` | `SvgSize?` | `null` | Size preset |
| `fill` | `String` | `'currentColor'` | Fill color |
| `stroke` | `String?` | `null` | Stroke color |
| `strokeWidth` | `String?` | `null` | Stroke width |
| `attributes` | `Map<String, String>?` | `null` | Additional attributes |
| `children` | `List<Component>` | required | SVG elements |
| `className` | `String?` | `null` | CSS class |

## Size Presets

```dart
ArcaneSvg(size: SvgSize.xs, ...)  // 12px
ArcaneSvg(size: SvgSize.sm, ...)  // 16px
ArcaneSvg(size: SvgSize.md, ...)  // 20px
ArcaneSvg(size: SvgSize.lg, ...)  // 24px
ArcaneSvg(size: SvgSize.xl, ...)  // 32px
ArcaneSvg(size: SvgSize.xxl, ...) // 48px
```

## SVG Primitives

### ArcaneSvgPath

```dart
ArcaneSvgPath(
  d: 'M12 2L15.09 8.26L22 9.27L17 14.14L18.18 21.02L12 17.77L5.82 21.02L7 14.14L2 9.27L8.91 8.26L12 2Z',
  fill: 'currentColor',
)
```

### ArcaneSvgCircle

```dart
ArcaneSvgCircle(
  cx: '12',
  cy: '12',
  r: '10',
  fill: 'none',
  stroke: 'currentColor',
  strokeWidth: '2',
)
```

### ArcaneSvgRect

```dart
ArcaneSvgRect(
  x: '3',
  y: '3',
  width: '18',
  height: '18',
  rx: '2',
  fill: 'none',
  stroke: 'currentColor',
)
```

### ArcaneSvgLine

```dart
ArcaneSvgLine(
  x1: '12',
  y1: '5',
  x2: '12',
  y2: '19',
  stroke: 'currentColor',
  strokeWidth: '2',
  strokeLinecap: 'round',
)
```

### ArcaneSvgPolyline

```dart
ArcaneSvgPolyline(
  points: '20 6 9 17 4 12',
  fill: 'none',
  stroke: 'currentColor',
  strokeWidth: '2',
)
```

### ArcaneSvgPolygon

```dart
ArcaneSvgPolygon(
  points: '12,2 22,22 2,22',
  fill: 'currentColor',
)
```

### ArcaneSvgGroup

```dart
ArcaneSvgGroup(
  transform: 'translate(2, 2)',
  children: [
    ArcaneSvgCircle(cx: '10', cy: '10', r: '8'),
    ArcaneSvgLine(x1: '10', y1: '6', x2: '10', y2: '10'),
  ],
)
```

## Examples

### Custom Icon

```dart
ArcaneSvg(
  viewBox: '0 0 24 24',
  size: SvgSize.lg,
  children: [
    ArcaneSvgPath(
      d: 'M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87...',
      fill: 'none',
      stroke: 'currentColor',
      strokeWidth: '2',
      strokeLinecap: 'round',
      strokeLinejoin: 'round',
    ),
  ],
)
```

### Loading Spinner

```dart
ArcaneSvg(
  viewBox: '0 0 24 24',
  size: SvgSize.lg,
  className: 'animate-spin',
  children: [
    ArcaneSvgCircle(
      cx: '12',
      cy: '12',
      r: '10',
      fill: 'none',
      stroke: 'currentColor',
      strokeWidth: '3',
    ),
    ArcaneSvgPath(
      d: 'M12 2a10 10 0 0 1 10 10',
      fill: 'none',
      stroke: 'var(--arcane-accent)',
      strokeWidth: '3',
      strokeLinecap: 'round',
    ),
  ],
)
```

### Multi-element Icon

```dart
ArcaneSvg(
  viewBox: '0 0 24 24',
  size: SvgSize.lg,
  children: [
    ArcaneSvgRect(
      x: '3',
      y: '4',
      width: '18',
      height: '18',
      rx: '2',
      fill: 'none',
      stroke: 'currentColor',
      strokeWidth: '2',
    ),
    ArcaneSvgLine(x1: '16', y1: '2', x2: '16', y2: '6', stroke: 'currentColor'),
    ArcaneSvgLine(x1: '8', y1: '2', x2: '8', y2: '6', stroke: 'currentColor'),
    ArcaneSvgLine(x1: '3', y1: '10', x2: '21', y2: '10', stroke: 'currentColor'),
  ],
)
```

## Related Components

- [ArcaneIcon](/arcane_jaspr/docs/view/arcane-icon) - Pre-built icons
