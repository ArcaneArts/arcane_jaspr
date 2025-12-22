---
title: Effects
description: Reference for shadow, transition, transform, and other effect enums
layout: docs
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

### Glow Effects

| Value | Description |
|-------|-------------|
| `glowAccent` | Accent color glow |
| `glowSuccess` | Success color glow |
| `glowError` | Error color glow |
| `glowPrimary` | Primary color glow |
| `glowGreen` | Green glow |
| `glowCyan` | Cyan glow |
| `glowPurple` | Purple glow |
| `glowOrange` | Orange glow |
| `glowPink` | Pink glow |

### Usage

```dart
// Card shadow
ArcaneCard(
  styles: const ArcaneStyleData(
    shadow: Shadow.md,
  ),
  children: [...],
)

// Glow effect
ArcaneButton.primary(
  styles: const ArcaneStyleData(
    shadow: Shadow.glowAccent,
  ),
  label: 'Glowing Button',
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
ArcaneDiv(
  styles: const ArcaneStyleData(
    transition: Transition.allFast,
  ),
  children: [...],
)

// Hover effect
ArcaneButton(
  styles: ArcaneStyleData(
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
| `hoverLift` | Slight lift on hover (translateY -2px) |
| `hoverScale` | Scale up on hover (1.05) |
| `hoverScaleSubtle` | Subtle scale (1.02) |
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
// Hover lift effect
ArcaneCard(
  styles: ArcaneStyleData(
    transform: isHovered ? Transform.hoverLift : Transform.none,
    transition: Transition.transform,
  ),
  children: [...],
)

// Centered modal
ArcaneDiv(
  styles: const ArcaneStyleData(
    position: Position.fixed,
    transform: Transform.center,
    raw: {
      'top': '50%',
      'left': '50%',
    },
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
ArcaneDiv(
  styles: ArcaneStyleData(
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
ArcaneButton(
  styles: ArcaneStyleData(
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
ArcaneDiv(
  styles: const ArcaneStyleData(
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
ArcaneButton(
  styles: const ArcaneStyleData(
    userSelect: UserSelect.none,
  ),
  label: 'Non-selectable',
)
```

## BackdropFilter

Backdrop filter effects.

| Value | Description |
|-------|-------------|
| `none` | No filter |
| `blur` | Standard blur |
| `blurStrong` | Strong blur |
| `blurLight` | Light blur |

### Usage

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    backdropFilter: BackdropFilter.blur,
    raw: {
      'background': 'rgba(0, 0, 0, 0.5)',
    },
  ),
  children: [...],
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

### Card Hover Effect

```dart
ArcaneCard(
  styles: ArcaneStyleData(
    shadow: isHovered ? Shadow.lg : Shadow.sm,
    transform: isHovered ? Transform.hoverLift : Transform.none,
    transition: Transition.allFast,
  ),
  children: [...],
)
```

### Glassmorphism

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    backdropFilter: BackdropFilter.blur,
    borderRadius: Radius.lg,
    border: BorderPreset.subtle,
    raw: {
      'background': 'rgba(255, 255, 255, 0.05)',
    },
  ),
  children: [...],
)
```

### Loading Overlay

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    position: Position.absolute,
    display: Display.flex,
    alignItems: AlignItems.center,
    justifyContent: JustifyContent.center,
    background: Background.overlay,
    backdropFilter: BackdropFilter.blur,
    opacity: Opacity.full,
    raw: {
      'inset': '0',
    },
  ),
  children: [
    ArcaneLoader(),
  ],
)
```

### Disabled State

```dart
ArcaneButton(
  styles: ArcaneStyleData(
    opacity: isDisabled ? Opacity.disabled : Opacity.full,
    cursor: isDisabled ? Cursor.notAllowed : Cursor.pointer,
    pointerEvents: isDisabled ? PointerEvents.none : PointerEvents.auto,
  ),
  label: 'Button',
)
```

### Glowing Accent Button

```dart
ArcaneButton.primary(
  styles: ArcaneStyleData(
    shadow: isHovered ? Shadow.glowAccent : Shadow.none,
    transition: Transition.shadow,
  ),
  label: 'Glow on Hover',
)
```
