---
title: ArcaneSkeleton
description: Animated placeholder for loading content
layout: docs
component: skeleton
---

# ArcaneSkeleton

An animated placeholder component that shows a shimmering effect while content is loading.

## Basic Usage

```dart
ArcaneSkeleton(
  width: '200px',
  height: '20px',
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `width` | `String?` | `100%` | Skeleton width |
| `height` | `String?` | `20px` | Skeleton height |
| `borderRadius` | `Radius?` | `md` | Corner radius |
| `variant` | `SkeletonVariant` | `text` | Shape variant |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Variants

```dart
// Text (default)
ArcaneSkeleton(variant: SkeletonVariant.text)

// Circle
ArcaneSkeleton(variant: SkeletonVariant.circle, width: '48px', height: '48px')

// Rectangle
ArcaneSkeleton(variant: SkeletonVariant.rectangle, height: '200px')
```

## Examples

### Text Lines

```dart
ArcaneColumn(
  gap: Gap.sm,
  children: [
    ArcaneSkeleton(width: '100%'),
    ArcaneSkeleton(width: '80%'),
    ArcaneSkeleton(width: '60%'),
  ],
)
```

### Card Skeleton

```dart
ArcaneCard(
  child: ArcaneColumn(
    gap: Gap.md,
    children: [
      ArcaneSkeleton(
        variant: SkeletonVariant.rectangle,
        height: '200px',
        borderRadius: Radius.lg,
      ),
      ArcaneSkeleton(width: '70%', height: '24px'),
      ArcaneColumn(
        gap: Gap.xs,
        children: [
          ArcaneSkeleton(width: '100%'),
          ArcaneSkeleton(width: '90%'),
        ],
      ),
      ArcaneRow(
        gap: Gap.sm,
        children: [
          ArcaneSkeleton(width: '60px', height: '32px'),
          ArcaneSkeleton(width: '60px', height: '32px'),
        ],
      ),
    ],
  ),
)
```

### User List Skeleton

```dart
ArcaneColumn(
  gap: Gap.md,
  children: [
    for (var i = 0; i < 5; i++)
      ArcaneRow(
        gap: Gap.md,
        crossAxisAlignment: AlignItems.center,
        children: [
          ArcaneSkeleton(
            variant: SkeletonVariant.circle,
            width: '48px',
            height: '48px',
          ),
          ArcaneExpanded(
            child: ArcaneColumn(
              gap: Gap.xs,
              crossAxisAlignment: AlignItems.start,
              children: [
                ArcaneSkeleton(width: '60%', height: '18px'),
                ArcaneSkeleton(width: '40%', height: '14px'),
              ],
            ),
          ),
        ],
      ),
  ],
)
```

### Table Skeleton

```dart
ArcaneColumn(
  children: [
    ArcaneRow(
      gap: Gap.md,
      styles: const ArcaneStyleData(
        padding: PaddingPreset.md,
        borderBottom: Border.subtle,
      ),
      children: [
        ArcaneExpanded(child: ArcaneSkeleton(height: '16px')),
        ArcaneExpanded(child: ArcaneSkeleton(height: '16px')),
        ArcaneExpanded(child: ArcaneSkeleton(height: '16px')),
      ],
    ),
    for (var i = 0; i < 5; i++)
      ArcaneRow(
        gap: Gap.md,
        styles: const ArcaneStyleData(
          padding: PaddingPreset.md,
          borderBottom: Border.subtle,
        ),
        children: [
          ArcaneExpanded(child: ArcaneSkeleton(width: '80%')),
          ArcaneExpanded(child: ArcaneSkeleton(width: '60%')),
          ArcaneExpanded(child: ArcaneSkeleton(width: '70%')),
        ],
      ),
  ],
)
```

### Stats Card Skeleton

```dart
ArcaneRow(
  gap: Gap.lg,
  children: [
    for (var i = 0; i < 3; i++)
      ArcaneExpanded(
        child: ArcaneCard(
          child: ArcaneColumn(
            gap: Gap.sm,
            children: [
              ArcaneSkeleton(width: '60%', height: '14px'),
              ArcaneSkeleton(width: '80%', height: '28px'),
              ArcaneSkeleton(width: '40%', height: '14px'),
            ],
          ),
        ),
      ),
  ],
)
```

### Profile Skeleton

```dart
ArcaneColumn(
  crossAxisAlignment: AlignItems.center,
  gap: Gap.md,
  children: [
    ArcaneSkeleton(
      variant: SkeletonVariant.circle,
      width: '96px',
      height: '96px',
    ),
    ArcaneSkeleton(width: '150px', height: '24px'),
    ArcaneSkeleton(width: '200px', height: '16px'),
    ArcaneRow(
      gap: Gap.sm,
      children: [
        ArcaneSkeleton(width: '80px', height: '32px'),
        ArcaneSkeleton(width: '80px', height: '32px'),
        ArcaneSkeleton(width: '80px', height: '32px'),
      ],
    ),
  ],
)
```

### Conditional Loading

```dart
if (isLoading)
  ArcaneColumn(
    gap: Gap.md,
    children: [
      for (var i = 0; i < 3; i++)
        CardSkeleton(),
    ],
  )
else
  ArcaneColumn(
    gap: Gap.md,
    children: [
      for (var item in items)
        ItemCard(item: item),
    ],
  ),
```

### Article Skeleton

```dart
ArcaneColumn(
  gap: Gap.lg,
  children: [
    ArcaneSkeleton(width: '70%', height: '36px'),
    ArcaneRow(
      gap: Gap.md,
      children: [
        ArcaneSkeleton(variant: SkeletonVariant.circle, width: '40px', height: '40px'),
        ArcaneColumn(
          gap: Gap.xs,
          crossAxisAlignment: AlignItems.start,
          children: [
            ArcaneSkeleton(width: '120px', height: '16px'),
            ArcaneSkeleton(width: '80px', height: '14px'),
          ],
        ),
      ],
    ),
    ArcaneSkeleton(variant: SkeletonVariant.rectangle, height: '300px'),
    ArcaneColumn(
      gap: Gap.sm,
      children: [
        ArcaneSkeleton(width: '100%'),
        ArcaneSkeleton(width: '100%'),
        ArcaneSkeleton(width: '95%'),
        ArcaneSkeleton(width: '100%'),
        ArcaneSkeleton(width: '60%'),
      ],
    ),
  ],
)
```

## Related Components

- [ArcaneLoader](/arcane_jaspr/docs/view/arcane-loader) - Loading spinner
- [ArcaneLoadingState](/arcane_jaspr/docs/view/arcane-loading-state) - Full loading state
- [ArcaneEmptyState](/arcane_jaspr/docs/view/arcane-empty-state) - Empty content placeholder
