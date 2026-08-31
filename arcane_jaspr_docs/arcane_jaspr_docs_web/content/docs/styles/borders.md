---
title: Borders
description: Reference for border, radius, and outline enums
layout: kb
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

### Usage

```dart
ArcaneBox(
  style: const ArcaneStyleData(
    border: BorderPreset.subtle,
    borderRadius: Radius.md,
  ),
  children: [...],
)
```

`ArcaneStyleData` intentionally has no one-sided border fields. Use a
`Separator` between adjoining regions or a complete perimeter around a
surface.

## Radius

Border radius presets. Many values are theme-reactive.

| Value | CSS Value | Static Value | Description |
|-------|----------|--------------|-------------|
| `none` | `0` | `0` | No radius |
| `xs` | `4px` | `4px` | Extra small |
| `sm` | `var(--arcane-radius-sm)` | `6px` | Small |
| `md` | `var(--arcane-radius-md)` | `8px` | Medium |
Generic radius values stop at 8px. Circular geometry is private to semantic
components, so generic styles cannot turn a button, badge, tab, statistic, or
card into a pill.

### Properties

```dart
Radius.md.css       // "var(--arcane-radius-md)" (theme-reactive)
Radius.md.staticCss // "8px" (static value)
```

### Usage

```dart
// Card radius
Card(
  style: const ArcaneStyleData(
    borderRadius: Radius.md,
  ),
  children: [...],
)

// Avatar circle uses the semantic component API.
ArcaneAvatar.circle(
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
ArcaneBox(
  style: const ArcaneStyleData(
    borderCustom: '2px solid var(--arcane-accent)',
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
ArcaneBox(
  style: const ArcaneStyleData(
    borderCustom: '2px dashed var(--arcane-border)',
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
Button(
  style: const ArcaneStyleData(
    outline: OutlinePreset.focus,
  ),
  label: 'Focused Button',
)
```

## Common Patterns

### Card with Border

```dart
ArcaneBox(
  style: const ArcaneStyleData(
    padding: PaddingPreset.lg,
    background: Background.card,
    border: BorderPreset.subtle,
    borderRadius: Radius.md,
  ),
  children: [...],
)
```

### Input Field

```dart
ArcaneBox(
  style: ArcaneStyleData(
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
ArcaneBox(
  style: const ArcaneStyleData(
    height: Size.auto,
    border: BorderPreset.subtle,
    margin: MarginPreset.verticalLg,
  ),
  children: [],
)
```

### Avatar with Ring

```dart
ArcaneAvatar.circle(
  imageUrl: 'avatar.jpg',
  borderColor: 'var(--arcane-accent)',
)
```

### Dashed Upload Area

```dart
ArcaneBox(
  style: const ArcaneStyleData(
    padding: PaddingPreset.xl,
    border: BorderPreset.dashedSubtle,
    borderRadius: Radius.md,
    borderWidth: BorderWidth.medium,
  ),
  children: [
    Text('Drop files here'),
  ],
)
```

### Accent Perimeter

```dart
ArcaneBox(
  style: const ArcaneStyleData(
    padding: PaddingPreset.md,
    background: Background.surface,
    borderRadius: Radius.md,
    border: BorderPreset.accentThick,
  ),
  children: [
    Text('Note: This is important information.'),
  ],
)
```
