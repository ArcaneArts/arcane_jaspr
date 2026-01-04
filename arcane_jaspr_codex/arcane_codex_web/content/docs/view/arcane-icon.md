---
title: Icons (Lucide)
description: Professional SVG icons via jaspr_lucide
layout: docs
component: icon
---

# Icons

Arcane Jaspr includes **jaspr_lucide** for 1500+ professional Lucide icons.

## Basic Usage

Icons are Component classes you instantiate directly:

```dart
// Default 24x24 icon
Search()

// Sized icon
ChevronDown(
  width: Unit.pixels(20),
  height: Unit.pixels(20),
)

// Colored icon
Github(
  attributes: {'stroke': ArcaneColors.primary},
)
```

## Common Icons

### Navigation

```dart
ChevronDown()
ChevronUp()
ChevronLeft()
ChevronRight()
ArrowLeft()
ArrowRight()
ArrowUp()
ArrowDown()
Menu()
X()  // Close/X icon
Home()
```

### Actions

```dart
Search()
Plus()
Minus()
Check()
Copy()
Trash2()
Edit()
Settings()
ExternalLink()
Download()
Upload()
Save()
Share()
```

### Status

```dart
Info()
CircleCheck()  // Success
CircleX()      // Error
TriangleAlert() // Warning
Loader()
LoaderCircle()
```

### Social

```dart
Github()
Twitter()
Linkedin()
Youtube()
Instagram()
Facebook()
```

### Media

```dart
Play()
Pause()
SkipForward()
SkipBack()
Volume2()
VolumeX()
```

## Size Reference

| Size | Pixels | Usage |
|------|--------|-------|
| Small | 16px | Inline, tight spaces |
| Medium | 20px | Default for most UIs |
| Large | 24px | Default Lucide size |
| XL | 32px | Prominent icons |

```dart
// Small icon
Search(width: Unit.pixels(16), height: Unit.pixels(16))

// Medium icon
Search(width: Unit.pixels(20), height: Unit.pixels(20))

// Large icon (default)
Search()  // 24x24

// Extra large
Search(width: Unit.pixels(32), height: Unit.pixels(32))
```

## Customization

### Color

```dart
// Via stroke attribute
Info(attributes: {'stroke': ArcaneColors.primary})

// Via CSS variable
Info(attributes: {'stroke': 'var(--arcane-primary)'})
```

### Stroke Width

```dart
Github(attributes: {'stroke-width': '1.5'})
```

### Styles

```dart
Search(
  styles: Styles(raw: {
    'opacity': '0.5',
    'cursor': 'pointer',
  }),
)
```

## Hidden Icons

Some Lucide icon names conflict with Dart/jaspr types and are hidden from the export:
- `Factory`, `Target`, `Key`, `List`, `Timer`, `View`, `Map`
- `Import`, `Contrast`, `Radius`, `SpellCheck`, `TextWrap`

To use these icons, import jaspr_lucide directly with a prefix:

```dart
import 'package:jaspr_lucide/jaspr_lucide.dart' as lucide;

// Then use:
lucide.Key()
lucide.List()
lucide.Timer()
```

## Browse All Icons

Visit [lucide.dev/icons](https://lucide.dev/icons) to browse all 1500+ available icons.

Icon class names match the Lucide icon names in PascalCase:
- `arrow-right` → `ArrowRight()`
- `chevron-down` → `ChevronDown()`
- `circle-check` → `CircleCheck()`
