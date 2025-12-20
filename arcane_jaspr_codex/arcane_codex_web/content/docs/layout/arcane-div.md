---
title: ArcaneDiv
description: The fundamental building block for layouts with Arcane styling
layout: docs
component: div
---

# ArcaneDiv

The core layout component that wraps content with ArcaneStyleData styling capabilities. It's the foundation for building any UI structure.

## Basic Usage

```dart
ArcaneDiv(
  children: [
    ArcaneText('Hello World'),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `children` | `List<Component>` | `[]` | Child components |
| `styles` | `ArcaneStyleData?` | `null` | Styling configuration |
| `id` | `String?` | `null` | HTML id attribute |
| `className` | `String?` | `null` | Additional CSS classes |
| `events` | `Events?` | `null` | Event handlers |

## With Styling

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    padding: PaddingPreset.lg,
    background: Background.surface,
    borderRadius: Radius.lg,
    border: Border.subtle,
  ),
  children: [
    ArcaneText('Styled content'),
  ],
)
```

## Flexbox Layout

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.row,
    justifyContent: JustifyContent.spaceBetween,
    alignItems: AlignItems.center,
    gap: Gap.md,
  ),
  children: [
    ArcaneText('Left'),
    ArcaneText('Right'),
  ],
)
```

## Grid Layout

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.grid,
    gridTemplateColumns: 'repeat(3, 1fr)',
    gap: Gap.lg,
  ),
  children: [
    for (var i = 0; i < 6; i++)
      ArcaneCard(child: ArcaneText('Item $i')),
  ],
)
```

## Examples

### Card Container

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    padding: PaddingPreset.xl,
    background: Background.card,
    borderRadius: Radius.xl,
    shadow: Shadow.lg,
  ),
  children: [
    ArcaneHeading(text: 'Welcome'),
    ArcaneParagraph(text: 'This is a card-like container.'),
  ],
)
```

### Centered Content

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    justifyContent: JustifyContent.center,
    alignItems: AlignItems.center,
    minHeightCustom: '400px',
  ),
  children: [
    ArcaneText('Centered!'),
  ],
)
```

### Responsive Column

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    gap: Gap.md,
    maxWidthCustom: '600px',
    margin: Margin.auto,
  ),
  children: [
    ArcaneTextInput(label: 'Name'),
    ArcaneTextInput(label: 'Email'),
    ArcaneButton(label: 'Submit', onPressed: () {}),
  ],
)
```

### Overlay Container

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    position: Position.relative,
  ),
  children: [
    ArcaneImage(src: '/hero.jpg'),
    ArcaneDiv(
      styles: const ArcaneStyleData(
        position: Position.absolute,
        inset: Inset.zero,
        background: Background.overlay,
        display: Display.flex,
        justifyContent: JustifyContent.center,
        alignItems: AlignItems.center,
      ),
      children: [
        ArcaneHeadline(text: 'Hero Title'),
      ],
    ),
  ],
)
```

### Hover Effects

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    padding: PaddingPreset.md,
    background: Background.surface,
    borderRadius: Radius.md,
    transition: Transition.colors,
    cursor: Cursor.pointer,
    hover: HoverStyles(
      background: Background.surfaceHover,
      shadow: Shadow.md,
    ),
  ),
  children: [
    ArcaneText('Hover me'),
  ],
)
```

## Related Components

- [ArcaneContainer](/docs/layout/arcane-container) - Max-width centered container
- [ArcaneSection](/docs/layout/arcane-section) - Semantic section wrapper
- [ArcaneRow](/docs/layout/arcane-row) - Horizontal flex layout
- [ArcaneColumn](/docs/layout/arcane-column) - Vertical flex layout
