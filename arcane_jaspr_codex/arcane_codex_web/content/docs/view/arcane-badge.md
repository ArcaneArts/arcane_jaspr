---
title: ArcaneBadge
description: Small label for status, counts, or categories
layout: docs
component: badge
---

# ArcaneBadge

A small label component for displaying status, counts, categories, or other short metadata.

## Basic Usage

```dart
ArcaneBadge(label: 'New')
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `label` | `String` | required | Badge text |
| `variant` | `BadgeVariant` | `default_` | Color variant |
| `size` | `BadgeSize` | `medium` | Badge size |
| `icon` | `Component?` | `null` | Leading icon |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Variants

```dart
// Default
ArcaneBadge(label: 'Default', variant: BadgeVariant.default_)

// Secondary
ArcaneBadge(label: 'Secondary', variant: BadgeVariant.secondary)

// Success
ArcaneBadge(label: 'Success', variant: BadgeVariant.success)

// Warning
ArcaneBadge(label: 'Warning', variant: BadgeVariant.warning)

// Destructive
ArcaneBadge(label: 'Error', variant: BadgeVariant.destructive)

// Outline
ArcaneBadge(label: 'Outline', variant: BadgeVariant.outline)
```

## Sizes

```dart
// Small
ArcaneBadge(label: 'Small', size: BadgeSize.small)

// Medium (default)
ArcaneBadge(label: 'Medium', size: BadgeSize.medium)

// Large
ArcaneBadge(label: 'Large', size: BadgeSize.large)
```

## With Icon

```dart
ArcaneBadge(
  label: 'Verified',
  icon: span([text('✓')]),
  variant: BadgeVariant.success,
)
```

## Examples

### Status Indicators

```dart
ArcaneRow(
  gap: Gap.sm,
  children: [
    ArcaneBadge(label: 'Active', variant: BadgeVariant.success),
    ArcaneBadge(label: 'Pending', variant: BadgeVariant.warning),
    ArcaneBadge(label: 'Inactive', variant: BadgeVariant.secondary),
    ArcaneBadge(label: 'Error', variant: BadgeVariant.destructive),
  ],
)
```

### Category Tags

```dart
ArcaneFlow(
  gap: Gap.sm,
  children: [
    ArcaneBadge(label: 'React'),
    ArcaneBadge(label: 'TypeScript'),
    ArcaneBadge(label: 'Tailwind'),
  ],
)
```

### Notification Count

```dart
ArcaneStack(
  children: [
    ArcaneIconButton(
      icon: span([text('🔔')]),
      onPressed: () {},
    ),
    ArcanePositioned(
      top: Spacing.none,
      right: Spacing.none,
      child: ArcaneBadge(
        label: '3',
        size: BadgeSize.small,
        variant: BadgeVariant.destructive,
      ),
    ),
  ],
)
```

### Table Status

```dart
ArcaneDataTable(
  columns: [...],
  rows: [
    DataRow(cells: [
      ArcaneText('Order #123'),
      ArcaneBadge(
        label: 'Shipped',
        variant: BadgeVariant.success,
        icon: span([text('📦')]),
      ),
    ]),
    DataRow(cells: [
      ArcaneText('Order #124'),
      ArcaneBadge(
        label: 'Processing',
        variant: BadgeVariant.warning,
      ),
    ]),
  ],
)
```

### Version Badge

```dart
ArcaneRow(
  gap: Gap.sm,
  crossAxisAlignment: AlignItems.center,
  children: [
    ArcaneHeading(text: 'Arcane'),
    ArcaneBadge(
      label: 'v2.0.0',
      variant: BadgeVariant.outline,
      size: BadgeSize.small,
    ),
  ],
)
```

### Feature Flags

```dart
ArcaneRow(
  gap: Gap.sm,
  children: [
    ArcaneBadge(label: 'Beta', variant: BadgeVariant.secondary),
    ArcaneBadge(label: 'Pro', variant: BadgeVariant.default_),
    ArcaneBadge(label: 'Enterprise', variant: BadgeVariant.outline),
  ],
)
```

### List Item Badge

```dart
ArcaneRow(
  mainAxisAlignment: JustifyContent.spaceBetween,
  crossAxisAlignment: AlignItems.center,
  children: [
    ArcaneColumn(
      crossAxisAlignment: AlignItems.start,
      children: [
        ArcaneRow(
          gap: Gap.sm,
          children: [
            ArcaneText('Dashboard Feature'),
            ArcaneBadge(label: 'New', size: BadgeSize.small),
          ],
        ),
        ArcaneText('Analytics dashboard with charts'),
      ],
    ),
    ArcaneBadge(
      label: 'In Progress',
      variant: BadgeVariant.warning,
    ),
  ],
)
```

### Change Indicator

```dart
ArcaneRow(
  gap: Gap.xs,
  crossAxisAlignment: AlignItems.center,
  children: [
    ArcaneHeading(text: '\$45,231'),
    ArcaneBadge(
      label: '+12.5%',
      variant: BadgeVariant.success,
      icon: span([text('↑')]),
      size: BadgeSize.small,
    ),
  ],
)
```

## Related Components

- [ArcaneStatusBadge](/arcane_jaspr/docs/view/arcane-status-badge) - Status-specific badge
- [ArcaneChip](/arcane_jaspr/docs/view/arcane-chip) - Interactive chip
- [ArcaneStatusIndicator](/arcane_jaspr/docs/view/arcane-status-indicator) - Status dot
