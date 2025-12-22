---
title: Borders
description: Reference for border, radius, and outline enums
layout: docs
component: borders
---

# Borders

These enums control border styling including presets, radius, width, and style.

## BorderPreset

Complete border configurations combining width, style, and color.

### Basic Borders

| Value | Description |
|-------|-------------|
| `none` | No border |
| `subtle` | 1px subtle border |
| `standard` | 1px standard border |
| `medium` | 1px medium visibility |
| `light` | 1px light border |

### Semantic Borders

| Value | Description |
|-------|-------------|
| `accent` | 1px accent color |
| `success` | 1px success color |
| `warning` | 1px warning color |
| `error` | 1px error color |
| `info` | 1px info color |

### Special Borders

| Value | Description |
|-------|-------------|
| `focus` | 2px ring color (focus state) |
| `accentThick` | 2px accent border |
| `brand` | 1px brand color |
| `brandThick` | 2px brand color |

### Dashed Borders

| Value | Description |
|-------|-------------|
| `dashedSubtle` | 1px dashed subtle |
| `dashedStandard` | 1px dashed standard |

### Directional Borders

| Value | Description |
|-------|-------------|
| `topSubtle` | Top border only |
| `bottomSubtle` | Bottom border only |

### Usage

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    border: BorderPreset.subtle,
    borderRadius: Radius.lg,
  ),
  children: [...],
)

// Bottom border separator
ArcaneDiv(
  styles: const ArcaneStyleData(
    padding: PaddingPreset.md,
    borderBottom: BorderPreset.subtle,
  ),
  children: [...],
)
```

## Radius

Border radius presets. Many values are theme-reactive.

| Value | CSS Value | Static Value | Description |
|-------|----------|--------------|-------------|
| `none` | `0` | `0` | No radius |
| `xs` | `4px` | `4px` | Extra small |
| `sm` | `var(--arcane-radius-sm)` | `6px` | Small |
| `md` | `var(--arcane-radius-md)` | `8px` | Medium |
| `lg` | `var(--arcane-radius-lg)` | `12px` | Large |
| `xl` | `var(--arcane-radius-xl)` | `16px` | Extra large |
| `xxl` | `var(--arcane-radius-2xl)` | `24px` | Double extra large |
| `full` | `9999px` | `9999px` | Pill shape |
| `circle` | `50%` | `50%` | Perfect circle |

### Properties

```dart
Radius.md.css       // "var(--arcane-radius-md)" (theme-reactive)
Radius.md.staticCss // "8px" (static value)
```

### Usage

```dart
// Card radius
ArcaneCard(
  styles: const ArcaneStyleData(
    borderRadius: Radius.lg,
  ),
  children: [...],
)

// Pill button
ArcaneButton(
  styles: const ArcaneStyleData(
    borderRadius: Radius.full,
  ),
  label: 'Pill Button',
)

// Avatar circle
ArcaneAvatar(
  styles: const ArcaneStyleData(
    borderRadius: Radius.circle,
  ),
  imageUrl: 'avatar.jpg',
)
```

## BorderWidth

Border width values.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `none` | `0` | No border |
| `hairline` | `1px` | Hairline border |
| `thin` | `1px` | Thin border |
| `medium` | `2px` | Medium border |
| `thick` | `3px` | Thick border |
| `heavy` | `4px` | Heavy border |

### Usage

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    raw: {
      'border-width': BorderWidth.medium.css,
      'border-style': 'solid',
      'border-color': 'var(--arcane-accent)',
    },
  ),
  children: [...],
)
```

## BorderStyle

Border line styles.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `none` | `none` | No border |
| `solid` | `solid` | Solid line |
| `dashed` | `dashed` | Dashed line |
| `dotted` | `dotted` | Dotted line |
| `double_` | `double` | Double line |
| `groove` | `groove` | 3D groove |
| `ridge` | `ridge` | 3D ridge |
| `inset` | `inset` | 3D inset |
| `outset` | `outset` | 3D outset |

### Usage

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    raw: {
      'border': '2px dashed var(--arcane-border)',
    },
  ),
  children: [...],
)
```

## OutlinePreset

Outline configurations for focus states.

| Value | Description |
|-------|-------------|
| `none` | No outline |
| `focus` | Standard focus ring |
| `focusAccent` | Accent color focus |
| `focusError` | Error color focus |
| `ring` | Ring outline |

### Usage

```dart
ArcaneButton(
  styles: const ArcaneStyleData(
    outline: OutlinePreset.focus,
  ),
  label: 'Focused Button',
)
```

## Common Patterns

### Card with Border

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    padding: PaddingPreset.lg,
    background: Background.card,
    border: BorderPreset.subtle,
    borderRadius: Radius.lg,
  ),
  children: [...],
)
```

### Input Field

```dart
ArcaneDiv(
  styles: ArcaneStyleData(
    padding: PaddingPreset.smMd,
    background: Background.input,
    border: isFocused ? BorderPreset.accent : BorderPreset.subtle,
    borderRadius: Radius.md,
    transition: Transition.allFast,
  ),
  children: [...],
)
```

### Divider

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    height: Size.auto,
    borderBottom: BorderPreset.subtle,
    margin: MarginPreset.verticalLg,
  ),
  children: [],
)
```

### Avatar with Ring

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    borderRadius: Radius.circle,
    raw: {
      'border': '3px solid var(--arcane-accent)',
      'padding': '2px',
    },
  ),
  children: [
    ArcaneAvatar(imageUrl: 'avatar.jpg'),
  ],
)
```

### Dashed Upload Area

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    padding: PaddingPreset.xl,
    border: BorderPreset.dashedSubtle,
    borderRadius: Radius.lg,
    raw: {
      'border-width': '2px',
    },
  ),
  children: [
    ArcaneText('Drop files here'),
  ],
)
```

### Accent Left Border

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    padding: PaddingPreset.md,
    background: Background.surface,
    borderRadius: Radius.md,
    raw: {
      'border-left': '4px solid var(--arcane-accent)',
    },
  ),
  children: [
    ArcaneText('Note: This is important information.'),
  ],
)
```
