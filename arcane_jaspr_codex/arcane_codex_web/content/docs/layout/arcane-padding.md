---
title: ArcanePadding
description: Simple padding wrapper component
layout: docs
component: padding
---

# ArcanePadding

A convenience wrapper that adds padding around its child content without additional styling.

## Basic Usage

```dart
ArcanePadding(
  padding: PaddingPreset.md,
  child: ArcaneText('Padded content'),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `child` | `Component` | required | Content to pad |
| `padding` | `PaddingPreset` | `md` | Padding amount |

## Padding Sizes

```dart
// None
ArcanePadding(
  padding: PaddingPreset.none,
  child: ArcaneText('No padding'),
)

// Extra small
ArcanePadding(
  padding: PaddingPreset.xs,
  child: ArcaneText('XS padding'),
)

// Small
ArcanePadding(
  padding: PaddingPreset.sm,
  child: ArcaneText('Small padding'),
)

// Medium (default)
ArcanePadding(
  padding: PaddingPreset.md,
  child: ArcaneText('Medium padding'),
)

// Large
ArcanePadding(
  padding: PaddingPreset.lg,
  child: ArcaneText('Large padding'),
)

// Extra large
ArcanePadding(
  padding: PaddingPreset.xl,
  child: ArcaneText('XL padding'),
)

// 2XL
ArcanePadding(
  padding: PaddingPreset.xl2,
  child: ArcaneText('2XL padding'),
)
```

## Examples

### Card Content Padding

```dart
ArcaneCard(
  child: ArcanePadding(
    padding: PaddingPreset.lg,
    child: ArcaneColumn(
      gap: Gap.md,
      children: [
        ArcaneHeading(text: 'Card Title'),
        ArcaneText('Card content goes here'),
      ],
    ),
  ),
)
```

### List Item

```dart
ArcaneColumn(
  children: [
    for (var item in items)
      ArcanePadding(
        padding: PaddingPreset.md,
        child: ArcaneRow(
          mainAxisAlignment: JustifyContent.spaceBetween,
          children: [
            ArcaneText(item.name),
            ArcaneText(item.value),
          ],
        ),
      ),
  ],
)
```

### Modal Body

```dart
ArcaneDialog(
  title: 'Confirm',
  content: ArcanePadding(
    padding: PaddingPreset.lg,
    child: ArcaneText('Are you sure you want to proceed?'),
  ),
  actions: [
    ArcaneButton.ghost(label: 'Cancel', onPressed: () {}),
    ArcaneButton.primary(label: 'Confirm', onPressed: () {}),
  ],
)
```

### Sidebar Section

```dart
ArcaneColumn(
  children: [
    ArcanePadding(
      padding: PaddingPreset.smMd,
      child: ArcaneText('Navigation'),
    ),
    ArcaneSidebarItem(label: 'Home', icon: '🏠'),
    ArcaneSidebarItem(label: 'Settings', icon: '⚙'),
  ],
)
```

## Related Components

- [ArcaneDiv](/arcane_jaspr/docs/layout/arcane-div) - Generic div with full styling
- [ArcaneBox](/arcane_jaspr/docs/layout/arcane-box) - Container with border
- [ArcaneGutter](/arcane_jaspr/docs/layout/arcane-gutter) - Spacing between sections
