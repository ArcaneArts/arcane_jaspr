---
title: ArcanePositioned
description: Absolutely positioned element within a Stack
layout: docs
component: positioned
---

# ArcanePositioned

A wrapper for positioning elements absolutely within an ArcaneStack or relative parent.

## Basic Usage

```dart
ArcaneStack(
  children: [
    ArcaneImage(src: '/photo.jpg'),
    ArcanePositioned(
      top: Spacing.md,
      right: Spacing.md,
      child: ArcaneBadge(label: 'New'),
    ),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `child` | `Component` | required | Content to position |
| `top` | `Spacing?` | `null` | Distance from top |
| `right` | `Spacing?` | `null` | Distance from right |
| `bottom` | `Spacing?` | `null` | Distance from bottom |
| `left` | `Spacing?` | `null` | Distance from left |
| `all` | `Spacing?` | `null` | Distance from all edges |

## Position Examples

### Top Left

```dart
ArcanePositioned(
  top: Spacing.md,
  left: Spacing.md,
  child: ArcaneBadge(label: 'Top Left'),
)
```

### Top Right

```dart
ArcanePositioned(
  top: Spacing.md,
  right: Spacing.md,
  child: ArcaneCloseButton(onPressed: () {}),
)
```

### Bottom Left

```dart
ArcanePositioned(
  bottom: Spacing.md,
  left: Spacing.md,
  child: ArcaneText('Caption'),
)
```

### Bottom Right

```dart
ArcanePositioned(
  bottom: Spacing.md,
  right: Spacing.md,
  child: ArcaneFab(icon: span([text('+')]), onPressed: () {}),
)
```

### Fill

```dart
ArcanePositioned(
  all: Spacing.none,
  child: ArcaneDiv(
    styles: const ArcaneStyleData(
      background: Background.overlay,
    ),
    children: [],
  ),
)
```

## Examples

### Close Button on Modal

```dart
ArcaneStack(
  children: [
    ArcaneCard(
      styles: const ArcaneStyleData(
        padding: PaddingPreset.xl,
        minWidthCustom: '400px',
      ),
      child: ArcaneColumn(
        gap: Gap.md,
        children: [
          ArcaneHeading(text: 'Modal Title'),
          ArcaneParagraph(text: 'Modal content...'),
        ],
      ),
    ),
    ArcanePositioned(
      top: Spacing.md,
      right: Spacing.md,
      child: ArcaneCloseButton(onPressed: closeModal),
    ),
  ],
)
```

### Avatar Status

```dart
ArcaneStack(
  styles: const ArcaneStyleData(
    widthCustom: '48px',
    heightCustom: '48px',
  ),
  children: [
    ArcaneAvatar(
      imageUrl: '/user.jpg',
      size: AvatarSize.medium,
    ),
    ArcanePositioned(
      bottom: Spacing.none,
      right: Spacing.none,
      child: ArcaneDiv(
        styles: const ArcaneStyleData(
          widthCustom: '12px',
          heightCustom: '12px',
          borderRadius: Radius.circle,
          background: Background.success,
          border: Border.default_,
        ),
        children: [],
      ),
    ),
  ],
)
```

### Product Card Badge

```dart
ArcaneStack(
  children: [
    ArcaneCard(
      child: ArcaneColumn(
        children: [
          ArcaneImage(src: '/product.jpg'),
          ArcaneDiv(
            styles: const ArcaneStyleData(padding: PaddingPreset.md),
            children: [
              ArcaneText('Product Name'),
              ArcaneText('\$99.99'),
            ],
          ),
        ],
      ),
    ),
    ArcanePositioned(
      top: Spacing.md,
      left: Spacing.md,
      child: ArcaneBadge(
        label: 'Sale',
        variant: BadgeVariant.destructive,
      ),
    ),
  ],
)
```

### Floating Action Button

```dart
ArcaneStack(
  styles: const ArcaneStyleData(
    minHeightCustom: '100vh',
  ),
  children: [
    ArcaneColumn(
      children: [
        // Main content
      ],
    ),
    ArcanePositioned(
      bottom: Spacing.xl,
      right: Spacing.xl,
      child: ArcaneFab(
        icon: span([text('+')]),
        label: 'Add Item',
        onPressed: () {},
      ),
    ),
  ],
)
```

### Image Actions

```dart
ArcaneStack(
  styles: const ArcaneStyleData(
    borderRadius: Radius.lg,
    overflow: Overflow.hidden,
  ),
  children: [
    ArcaneImage(src: '/gallery-image.jpg'),
    ArcanePositioned(
      top: Spacing.sm,
      right: Spacing.sm,
      child: ArcaneRow(
        gap: Gap.xs,
        children: [
          ArcaneIconButton(
            icon: span([text('❤')]),
            size: IconButtonSize.small,
            onPressed: () {},
          ),
          ArcaneIconButton(
            icon: span([text('↗')]),
            size: IconButtonSize.small,
            onPressed: () {},
          ),
        ],
      ),
    ),
  ],
)
```

### Tooltip-like Positioning

```dart
ArcaneStack(
  children: [
    ArcaneButton(label: 'Hover me', onPressed: () {}),
    if (showTooltip)
      ArcanePositioned(
        bottom: Spacing.xl2,
        left: Spacing.none,
        child: ArcaneCard(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.sm,
            shadow: Shadow.lg,
          ),
          child: ArcaneText('Tooltip content'),
        ),
      ),
  ],
)
```

## Related Components

- [ArcaneStack](/docs/layout/arcane-stack) - Parent stack container
- [ArcaneDiv](/docs/layout/arcane-div) - Generic layout div
