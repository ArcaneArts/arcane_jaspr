---
title: ArcaneButtonGroup
description: Group of related buttons with connected styling
layout: docs
component: button-group
---

# ArcaneButtonGroup

A container for grouping related buttons together with connected borders and consistent spacing.

## Basic Usage

```dart
ArcaneButtonGroup(
  children: [
    ArcaneButton(label: 'Left', onPressed: () {}),
    ArcaneButton(label: 'Center', onPressed: () {}),
    ArcaneButton(label: 'Right', onPressed: () {}),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `children` | `List<Component>` | `[]` | Button children |
| `direction` | `GroupDirection` | `horizontal` | Layout direction |
| `size` | `ButtonSize?` | `null` | Override button sizes |
| `isAttached` | `bool` | `true` | Connect button borders |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Direction

```dart
// Horizontal (default)
ArcaneButtonGroup(
  direction: GroupDirection.horizontal,
  children: [
    ArcaneButton(label: 'A', onPressed: () {}),
    ArcaneButton(label: 'B', onPressed: () {}),
    ArcaneButton(label: 'C', onPressed: () {}),
  ],
)

// Vertical
ArcaneButtonGroup(
  direction: GroupDirection.vertical,
  children: [
    ArcaneButton(label: 'Top', onPressed: () {}),
    ArcaneButton(label: 'Middle', onPressed: () {}),
    ArcaneButton(label: 'Bottom', onPressed: () {}),
  ],
)
```

## Detached Buttons

```dart
ArcaneButtonGroup(
  isAttached: false,
  children: [
    ArcaneButton(label: 'Save', onPressed: () {}),
    ArcaneButton.ghost(label: 'Cancel', onPressed: () {}),
  ],
)
```

## Examples

### Pagination

```dart
ArcaneButtonGroup(
  children: [
    ArcaneIconButton(icon: span([text('«')]), onPressed: goToFirst),
    ArcaneIconButton(icon: span([text('‹')]), onPressed: goToPrev),
    ArcaneButton(label: '1', onPressed: () => goToPage(1)),
    ArcaneButton(label: '2', onPressed: () => goToPage(2)),
    ArcaneButton(label: '3', onPressed: () => goToPage(3)),
    ArcaneIconButton(icon: span([text('›')]), onPressed: goToNext),
    ArcaneIconButton(icon: span([text('»')]), onPressed: goToLast),
  ],
)
```

### Zoom Controls

```dart
ArcaneButtonGroup(
  children: [
    ArcaneIconButton(icon: span([text('-')]), onPressed: zoomOut),
    ArcaneButton(label: '${zoomLevel}%', onPressed: resetZoom),
    ArcaneIconButton(icon: span([text('+')]), onPressed: zoomIn),
  ],
)
```

### Text Editor Actions

```dart
ArcaneButtonGroup(
  children: [
    ArcaneIconButton(icon: span([text('B')]), onPressed: toggleBold),
    ArcaneIconButton(icon: span([text('I')]), onPressed: toggleItalic),
    ArcaneIconButton(icon: span([text('U')]), onPressed: toggleUnderline),
  ],
)
```

### Split Button

```dart
ArcaneButtonGroup(
  children: [
    ArcaneButton.primary(label: 'Save', onPressed: save),
    ArcaneIconButton(
      icon: span([text('▼')]),
      onPressed: showSaveOptions,
      variant: IconButtonVariant.primary,
    ),
  ],
)
```

### Alignment Buttons

```dart
ArcaneButtonGroup(
  children: [
    ArcaneToggleButton(
      isSelected: alignment == 'left',
      icon: span([text('⬅')]),
      onChanged: (v) => setAlignment('left'),
    ),
    ArcaneToggleButton(
      isSelected: alignment == 'center',
      icon: span([text('⬌')]),
      onChanged: (v) => setAlignment('center'),
    ),
    ArcaneToggleButton(
      isSelected: alignment == 'right',
      icon: span([text('➡')]),
      onChanged: (v) => setAlignment('right'),
    ),
    ArcaneToggleButton(
      isSelected: alignment == 'justify',
      icon: span([text('☰')]),
      onChanged: (v) => setAlignment('justify'),
    ),
  ],
)
```

### Vertical Stack

```dart
ArcaneButtonGroup(
  direction: GroupDirection.vertical,
  children: [
    ArcaneButton(label: 'Option 1', onPressed: () {}),
    ArcaneButton(label: 'Option 2', onPressed: () {}),
    ArcaneButton(label: 'Option 3', onPressed: () {}),
  ],
)
```

### With Primary Action

```dart
ArcaneButtonGroup(
  isAttached: false,
  children: [
    ArcaneButton.ghost(label: 'Cancel', onPressed: cancel),
    ArcaneButton.ghost(label: 'Save Draft', onPressed: saveDraft),
    ArcaneButton.primary(label: 'Publish', onPressed: publish),
  ],
)
```

## Related Components

- [ArcaneButtonPanel](/docs/layout/arcane-button-panel) - Button container with layout
- [ArcaneToggleButtonGroup](/docs/inputs/arcane-toggle-button-group) - Selectable button group
- [ArcaneRow](/docs/layout/arcane-row) - Horizontal layout
