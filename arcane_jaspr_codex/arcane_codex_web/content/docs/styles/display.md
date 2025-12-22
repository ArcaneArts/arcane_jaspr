---
title: Display & Layout
description: Reference for display, position, and flex layout enums
layout: docs
component: display
---

# Display & Layout

These enums control the display mode, positioning, and flex/grid layout of elements.

## Display

Controls how an element is displayed.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `none` | `none` | Hidden, removed from layout |
| `block` | `block` | Block-level element |
| `inline` | `inline` | Inline element |
| `inlineBlock` | `inline-block` | Inline with block behavior |
| `flex` | `flex` | Flex container |
| `inlineFlex` | `inline-flex` | Inline flex container |
| `grid` | `grid` | Grid container |
| `inlineGrid` | `inline-grid` | Inline grid container |
| `contents` | `contents` | Only children are rendered |
| `flowRoot` | `flow-root` | Block with BFC |

### Usage

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
  ),
  children: [...],
)
```

## Position

Controls element positioning.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `static_` | `static` | Default positioning |
| `relative` | `relative` | Relative to normal position |
| `absolute` | `absolute` | Relative to positioned parent |
| `fixed` | `fixed` | Relative to viewport |
| `sticky` | `sticky` | Sticky positioning |

### Usage

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    position: Position.absolute,
    raw: {
      'top': '0',
      'right': '0',
    },
  ),
  children: [...],
)
```

## FlexDirection

Controls the direction of flex items.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `row` | `row` | Horizontal, left to right |
| `rowReverse` | `row-reverse` | Horizontal, right to left |
| `column` | `column` | Vertical, top to bottom |
| `columnReverse` | `column-reverse` | Vertical, bottom to top |

### Usage

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
  ),
  children: [...],
)
```

## FlexWrap

Controls whether flex items wrap.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `nowrap` | `nowrap` | Single line, may overflow |
| `wrap` | `wrap` | Wrap to multiple lines |
| `wrapReverse` | `wrap-reverse` | Wrap in reverse order |

## AlignItems

Controls cross-axis alignment of flex/grid items.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `stretch` | `stretch` | Stretch to fill |
| `flexStart` | `flex-start` | Align to start |
| `flexEnd` | `flex-end` | Align to end |
| `center` | `center` | Center alignment |
| `baseline` | `baseline` | Align baselines |

### Usage

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    alignItems: AlignItems.center,
  ),
  children: [...],
)
```

## JustifyContent

Controls main-axis alignment of flex/grid items.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `flexStart` | `flex-start` | Pack at start |
| `flexEnd` | `flex-end` | Pack at end |
| `center` | `center` | Pack at center |
| `spaceBetween` | `space-between` | Even spacing, no edge space |
| `spaceAround` | `space-around` | Even spacing with half edge space |
| `spaceEvenly` | `space-evenly` | Even spacing including edges |

### Usage

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    justifyContent: JustifyContent.spaceBetween,
  ),
  children: [...],
)
```

## AlignSelf

Controls alignment of individual flex/grid items.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `auto` | `auto` | Inherit from parent |
| `stretch` | `stretch` | Stretch to fill |
| `flexStart` | `flex-start` | Align to start |
| `flexEnd` | `flex-end` | Align to end |
| `center` | `center` | Center alignment |
| `baseline` | `baseline` | Align baseline |

## CrossAxisAlignment

Alternative alignment enum (same as AlignItems).

| Value | Description |
|-------|-------------|
| `start` | Align to start |
| `end` | Align to end |
| `center` | Center alignment |
| `stretch` | Stretch to fill |
| `baseline` | Align baselines |

## Size

Preset size values for width/height.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `auto` | `auto` | Content-based size |
| `full` | `100%` | Full parent size |
| `screen` | `100vh` | Full viewport height |
| `fit` | `fit-content` | Fit to content |
| `min` | `min-content` | Minimum content size |
| `max` | `max-content` | Maximum content size |
| `half` | `50%` | Half parent size |
| `third` | `33.333%` | One third |
| `quarter` | `25%` | One quarter |
| `threeQuarter` | `75%` | Three quarters |

### Usage

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    width: Size.full,
    height: Size.screen,
  ),
  children: [...],
)
```

## MaxWidth

Maximum width presets for containers.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `none` | `none` | No maximum |
| `card` | `400px` | Card width |
| `form` | `480px` | Form width |
| `narrowText` | `560px` | Narrow text |
| `text` | `640px` | Text content |
| `narrow` | `768px` | Narrow layout |
| `content` | `1024px` | Main content |
| `container` | `1280px` | Page container |
| `full` | `1440px` | Full width |

### Usage

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    maxWidth: MaxWidth.content,
    margin: MarginPreset.autoX,
  ),
  children: [...],
)
```

## MaxHeight

Maximum height presets for containers.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `none` | `none` | No maximum |
| `sm` | `200px` | Small content area |
| `md` | `300px` | Medium content area |
| `lg` | `400px` | Large content area |
| `codeBlock` | `500px` | Code block height |
| `xl` | `600px` | Extra large |
| `modal` | `80vh` | Modal height |
| `screen` | `100vh` | Full screen |

## MinWidth

Minimum width presets.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `none` | `0` | No minimum |
| `touchTarget` | `44px` | Minimum touch target |
| `sm` | `100px` | Small minimum |
| `md` | `200px` | Medium minimum |
| `lg` | `300px` | Large minimum |

## Overflow

Controls overflow behavior.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `visible` | `visible` | Content visible outside |
| `hidden` | `hidden` | Content clipped |
| `scroll` | `scroll` | Always show scrollbars |
| `auto` | `auto` | Scrollbars when needed |
| `clip` | `clip` | Clip without scroll |

## OverflowAxis

Per-axis overflow control (for overflowX/overflowY).

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `visible` | `visible` | Content visible |
| `hidden` | `hidden` | Content clipped |
| `scroll` | `scroll` | Always scrollable |
| `auto` | `auto` | Scrollable when needed |
| `clip` | `clip` | Clip without scroll |

## Visibility

Controls element visibility.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `visible` | `visible` | Element visible |
| `hidden` | `hidden` | Hidden but takes space |
| `collapse` | `collapse` | Collapsed (table rows) |

## ZIndex

Semantic z-index layers.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `auto` | `auto` | Default stacking |
| `below` | `-1` | Below content |
| `base` | `0` | Base layer |
| `dropdown` | `1000` | Dropdowns |
| `sticky` | `1020` | Sticky elements |
| `fixed` | `1030` | Fixed elements |
| `fab` | `1035` | FABs |
| `modalBackdrop` | `1040` | Modal backdrops |
| `modal` | `1050` | Modals |
| `popover` | `1060` | Popovers |
| `tooltip` | `1070` | Tooltips |
| `toast` | `1080` | Toasts |

## ObjectFit

Controls how replaced content (images) fits.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `contain` | `contain` | Scale to fit, preserve aspect |
| `cover` | `cover` | Scale to cover, may crop |
| `fill` | `fill` | Stretch to fill |
| `none` | `none` | Original size |
| `scaleDown` | `scale-down` | Smaller of none/contain |

## ObjectPosition

Controls position of replaced content.

| Value | CSS Output | Description |
|-------|-----------|-------------|
| `center` | `center` | Centered |
| `top` | `top` | Top edge |
| `bottom` | `bottom` | Bottom edge |
| `left` | `left` | Left edge |
| `right` | `right` | Right edge |
| `topLeft` | `top left` | Top-left corner |
| `topRight` | `top right` | Top-right corner |
| `bottomLeft` | `bottom left` | Bottom-left corner |
| `bottomRight` | `bottom right` | Bottom-right corner |
