---
title: Effects
description: Reference for shadow, transition, transform, and other effect enums
layout: kb
component: effects
---

# Effects

These enums control visual effects including shadows, transitions, transforms, and more.

## Shadow

Box shadow presets.

### Basic Shadows

| Value | Description |
|-------|-------------|
| `none` | No shadow |
| `xs` | Extra small shadow |
| `sm` | Small shadow |
| `md` | Medium shadow |
| `lg` | Large shadow |
| `xl` | Extra large shadow |
| `card` | Card-specific shadow |

### Usage

```dart
// Card shadow
Card(
  style: const ArcaneStyleData(
    shadow: Shadow.md,
  ),
  children: [...],
)

// Stronger neutral elevation
Card(
  style: const ArcaneStyleData(
    shadow: Shadow.lg,
  ),
  children: [...],
)
```

## Transition

CSS transition presets.

### Timing

| Value | Duration | Description |
|-------|----------|-------------|
| `none` | - | No transition |
| `fast` | 150ms | Quick transitions |
| `normal` | 200ms | Default transitions |
| `slow` | 300ms | Slow transitions |
| `bounce` | - | Bounce easing |

### All Properties

| Value | Description |
|-------|-------------|
| `allFast` | All properties, 150ms |
| `allNormal` | All properties, 200ms |
| `allSlow` | All properties, 300ms |

### Specific Properties

| Value | Description |
|-------|-------------|
| `colors` | Color properties only |
| `transform` | Transform only |
| `opacity` | Opacity only |
| `shadow` | Box-shadow only |

### Usage

```dart
ArcaneBox(
  style: const ArcaneStyleData(
    transition: Transition.allFast,
  ),
  children: [...],
)

// Hover effect
Button(
  style: ArcaneStyleData(
    background: isHovered ? Background.accentContainer : Background.surface,
    transition: Transition.colors,
  ),
  label: 'Hover Me',
)
```

## Transform

CSS transform presets.

| Value | Description |
|-------|-------------|
| `none` | No transform |
| `center` | Center with translate(-50%, -50%) |
| `centerX` | Center X with translateX(-50%) |
| `centerY` | Center Y with translateY(-50%) |
| `rotate90` | 90 degree rotation |
| `rotate180` | 180 degree rotation |
| `rotate270` | 270 degree rotation |
| `flipX` | Horizontal flip |
| `flipY` | Vertical flip |

### Usage

```dart
// Centered modal
ArcaneBox(
  style: const ArcaneStyleData(
    position: Position.fixed,
    transform: Transform.center,
    top: '50%',
    left: '50%',
  ),
  children: [...],
)
```

## Opacity

Opacity presets.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `transparent` | `0` | Fully transparent |
| `faint` | `0.1` | Very faint |
| `light` | `0.25` | Light opacity |
| `half` | `0.5` | Half opacity |
| `muted` | `0.75` | Muted |
| `high` | `0.9` | High opacity |
| `full` | `1` | Fully opaque |
| `disabled` | `0.5` | Disabled state |
| `hoverOverlay` | `0.04` | Subtle hover |
| `pressOverlay` | `0.08` | Press state |

### Usage

```dart
ArcaneBox(
  style: ArcaneStyleData(
    opacity: isDisabled ? Opacity.disabled : Opacity.full,
  ),
  children: [...],
)
```

## Cursor

Mouse cursor styles.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `auto` | `auto` | Browser default |
| `default_` | `default` | Default arrow |
| `pointer` | `pointer` | Clickable hand |
| `text` | `text` | Text selection |
| `move` | `move` | Move cursor |
| `grab` | `grab` | Grab hand |
| `grabbing` | `grabbing` | Grabbing hand |
| `notAllowed` | `not-allowed` | Disabled |
| `wait` | `wait` | Loading/wait |
| `progress` | `progress` | Processing |
| `crosshair` | `crosshair` | Precision select |
| `zoomIn` | `zoom-in` | Zoom in |
| `zoomOut` | `zoom-out` | Zoom out |
| `help` | `help` | Help available |
| `none` | `none` | Hidden cursor |
| `colResize` | `col-resize` | Column resize |
| `rowResize` | `row-resize` | Row resize |
| `nResize` | `n-resize` | North resize |
| `eResize` | `e-resize` | East resize |
| `sResize` | `s-resize` | South resize |
| `wResize` | `w-resize` | West resize |

### Usage

```dart
Button(
  style: ArcaneStyleData(
    cursor: isDisabled ? Cursor.notAllowed : Cursor.pointer,
  ),
  label: 'Button',
)
```

## PointerEvents

Pointer event handling.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `auto` | `auto` | Normal events |
| `none` | `none` | No events (pass through) |
| `all` | `all` | All events |

### Usage

```dart
// Overlay that passes clicks through
ArcaneBox(
  style: const ArcaneStyleData(
    pointerEvents: PointerEvents.none,
  ),
  children: [...],
)
```

## UserSelect

Text selection behavior.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `auto` | `auto` | Normal selection |
| `none` | `none` | No selection |
| `text` | `text` | Text only |
| `all` | `all` | Select all on click |
| `contain` | `contain` | Contained selection |

### Usage

```dart
Button(
  style: const ArcaneStyleData(
    userSelect: UserSelect.none,
  ),
  label: 'Non-selectable',
)
```

## Easing

Animation easing functions.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `linear` | `linear` | Constant speed |
| `ease` | `ease` | Default easing |
| `easeIn` | `ease-in` | Slow start |
| `easeOut` | `ease-out` | Slow end |
| `easeInOut` | `ease-in-out` | Slow start and end |
| `bounce` | Custom | Bounce effect |

## Common Effect Patterns

### Loading Overlay

```dart
ArcaneBox(
  style: const ArcaneStyleData(
    position: Position.absolute,
    display: Display.flex,
    alignItems: AlignItems.center,
    justifyContent: JustifyContent.center,
    background: Background.overlay,
    opacity: Opacity.full,
    inset: '0',
  ),
  children: [
    ArcaneLoader(),
  ],
)
```

### Disabled State

```dart
Button(
  style: ArcaneStyleData(
    opacity: isDisabled ? Opacity.disabled : Opacity.full,
    cursor: isDisabled ? Cursor.notAllowed : Cursor.pointer,
    pointerEvents: isDisabled ? PointerEvents.none : PointerEvents.auto,
  ),
  label: 'Button',
)
```

### Elevated Surface

```dart
Card(
  style: ArcaneStyleData(
    shadow: isHovered ? Shadow.lg : Shadow.none,
    transition: Transition.shadow,
  ),
  children: [...],
)
```
