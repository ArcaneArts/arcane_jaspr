---
title: ArcaneIcon
description: SVG icon component with built-in common icons
layout: docs
---

# ArcaneIcon

A component for rendering SVG icons with consistent styling and built-in common icons.

## Usage

### Built-in Icons

ArcaneIcon comes with many common icons ready to use:

```dart
// Search icon
ArcaneIcon.search()

// Theme icons
ArcaneIcon.sun()
ArcaneIcon.moon()

// Navigation icons
ArcaneIcon.menu()
ArcaneIcon.close()
ArcaneIcon.chevronDown()
ArcaneIcon.chevronRight()
ArcaneIcon.arrowLeft()
ArcaneIcon.home()

// Action icons
ArcaneIcon.check()
ArcaneIcon.copy()
ArcaneIcon.externalLink()
ArcaneIcon.settings()

// Brand icons
ArcaneIcon.github()

// Documentation
ArcaneIcon.book()
```

### Icon Sizes

All icons support size presets:

```dart
ArcaneIcon.search(size: IconSize.xs)  // 12px
ArcaneIcon.search(size: IconSize.sm)  // 14px
ArcaneIcon.search(size: IconSize.md)  // 16px (default)
ArcaneIcon.search(size: IconSize.lg)  // 20px
ArcaneIcon.search(size: IconSize.xl)  // 24px
ArcaneIcon.search(size: IconSize.xl2) // 32px

// Or custom size
ArcaneIcon.search(sizeCustom: '48')
```

### Custom Colors

Icons inherit `currentColor` by default, but you can customize:

```dart
ArcaneIcon.sun(color: 'var(--arcane-accent)')
ArcaneIcon.moon(color: '#10b981')
```

### Custom Stroke Width

```dart
ArcaneIcon.search(strokeWidth: '1.5')
ArcaneIcon.check(strokeWidth: '3')
```

## Custom Icons

Create custom icons using SVG path elements:

```dart
ArcaneIcon(
  viewBox: '0 0 24 24',
  size: IconSize.lg,
  children: [
    ArcaneIconPath(d: 'M12 2L2 7l10 5 10-5-10-5z'),
    ArcaneIconPath(d: 'M2 17l10 5 10-5'),
  ],
)
```

Or use raw SVG elements:

```dart
ArcaneIcon(
  viewBox: '0 0 24 24',
  children: [
    Component.element(
      tag: 'circle',
      attributes: {'cx': '12', 'cy': '12', 'r': '10'},
    ),
    Component.element(
      tag: 'path',
      attributes: {'d': 'M12 6v6l4 2'},
    ),
  ],
)
```

## Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `viewBox` | `String` | `'0 0 24 24'` | SVG viewBox attribute |
| `size` | `IconSize` | `IconSize.md` | Size preset (xs, sm, md, lg, xl, xl2) |
| `sizeCustom` | `String?` | `null` | Custom size in pixels |
| `color` | `String?` | `null` | Stroke color (defaults to currentColor) |
| `strokeWidth` | `String` | `'2'` | Stroke width |
| `fill` | `String` | `'none'` | Fill color |
| `strokeLinecap` | `String` | `'round'` | Stroke linecap |
| `strokeLinejoin` | `String` | `'round'` | Stroke linejoin |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |
| `children` | `List<Component>` | required | SVG child elements |

## Available Icons

| Factory | Description |
|---------|-------------|
| `ArcaneIcon.search()` | Magnifying glass |
| `ArcaneIcon.sun()` | Sun with rays |
| `ArcaneIcon.moon()` | Crescent moon |
| `ArcaneIcon.close()` | X / close |
| `ArcaneIcon.menu()` | Hamburger menu |
| `ArcaneIcon.chevronDown()` | Chevron pointing down |
| `ArcaneIcon.chevronRight()` | Chevron pointing right |
| `ArcaneIcon.check()` | Checkmark |
| `ArcaneIcon.externalLink()` | External link arrow |
| `ArcaneIcon.copy()` | Copy/duplicate |
| `ArcaneIcon.settings()` | Gear/cog |
| `ArcaneIcon.github()` | GitHub logo |
| `ArcaneIcon.arrowLeft()` | Left arrow |
| `ArcaneIcon.home()` | House |
| `ArcaneIcon.book()` | Book/documentation |

## Alias

```dart
import 'package:arcane_jaspr/aliases.dart';

AIcon.search()
AIconPath(d: 'M...')
```

## Theme Integration

Icons automatically use `currentColor`, so they inherit the text color of their parent:

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    textColor: TextColor.accent,
  ),
  children: [
    ArcaneIcon.check(), // Will be accent colored
  ],
)
```

Or use CSS variables directly:

```dart
ArcaneIcon.sun(color: 'var(--arcane-accent)')
```
