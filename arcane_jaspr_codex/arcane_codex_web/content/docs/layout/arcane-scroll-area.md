---
title: ArcaneScrollArea
description: Scrollable container with customizable scrollbars
layout: docs
component: scroll-area
---

# ArcaneScrollArea

A scrollable container with styled scrollbars that match the Arcane design system. Provides consistent scroll behavior across browsers.

## Basic Usage

```dart
ArcaneScrollArea(
  maxHeight: '400px',
  child: ArcaneColumn(
    children: [
      // Long content that will scroll
      for (var i = 0; i < 50; i++)
        ArcaneText('Item $i'),
    ],
  ),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `child` | `Component` | required | Scrollable content |
| `maxHeight` | `String?` | `null` | Maximum height before scrolling |
| `maxWidth` | `String?` | `null` | Maximum width before horizontal scrolling |
| `direction` | `ScrollDirection` | `vertical` | Scroll direction |
| `showScrollbar` | `bool` | `true` | Whether to show scrollbar |
| `autoHide` | `bool` | `true` | Hide scrollbar when not scrolling |
| `padding` | `String?` | `null` | Inner padding |

## Scroll Directions

### Vertical (Default)

```dart
ArcaneScrollArea(
  direction: ScrollDirection.vertical,
  maxHeight: '300px',
  child: longContent,
)
```

### Horizontal

```dart
ArcaneScrollArea(
  direction: ScrollDirection.horizontal,
  maxWidth: '500px',
  child: wideContent,
)
```

### Both

```dart
ArcaneScrollArea(
  direction: ScrollDirection.both,
  maxHeight: '300px',
  maxWidth: '500px',
  child: largeContent,
)
```

## Scrollbar Visibility

```dart
// Always show scrollbar
ArcaneScrollArea(
  autoHide: false,
  showScrollbar: true,
  child: content,
)

// Hide scrollbar completely
ArcaneScrollArea(
  showScrollbar: false,
  child: content,
)
```

## With Padding

```dart
ArcaneScrollArea(
  maxHeight: '400px',
  padding: '16px',
  child: content,
)
```

## Styling

The scrollbar is styled to match the Arcane design system:
- Thin, minimal scrollbar track
- Rounded thumb with accent color
- Smooth transitions on hover
- Consistent across browsers
