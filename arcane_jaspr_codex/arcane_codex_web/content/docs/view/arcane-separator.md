---
title: ArcaneSeparator
description: Visual separator for dividing content sections
layout: docs
component: separator
---

# ArcaneSeparator

A visual separator component for dividing content sections. Supports horizontal and vertical orientations, as well as labeled separators.

## Basic Usage

```dart
ArcaneSeparator()
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `orientation` | `SeparatorOrientation` | `horizontal` | Direction of separator |
| `thickness` | `String` | `'1px'` | Line thickness |
| `color` | `String?` | `null` | Custom color (defaults to border color) |
| `margin` | `String?` | `null` | Margin around separator |

## Orientations

### Horizontal (Default)

```dart
ArcaneColumn(
  children: [
    ArcaneText('Section 1'),
    ArcaneSeparator(),
    ArcaneText('Section 2'),
  ],
)
```

### Vertical

```dart
ArcaneRow(
  children: [
    ArcaneText('Left'),
    ArcaneSeparator.vertical(height: '24px'),
    ArcaneText('Right'),
  ],
)
```

## With Label

Add a text label in the center of the separator:

```dart
ArcaneSeparator.withLabel(label: 'OR')
```

```dart
ArcaneSeparator.withLabel(
  label: 'Section Title',
  labelStyle: const ArcaneStyleData(
    fontWeight: FontWeight.bold,
    textColor: TextColor.accent,
  ),
)
```

## Custom Styling

```dart
ArcaneSeparator(
  thickness: '2px',
  color: ArcaneColors.accent,
  margin: '24px 0',
)
```

## Use Cases

- Dividing form sections
- Separating list items
- Creating visual breaks in content
- "Or" dividers in auth forms
