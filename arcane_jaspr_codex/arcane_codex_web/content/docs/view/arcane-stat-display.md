---
title: ArcaneStatDisplay
description: Metric display with large value and label
layout: docs
component: stat-display
---

# ArcaneStatDisplay

A metric/stat display component with a large value and descriptive label, perfect for trust indicators and key metrics.

## Basic Usage

```dart
ArcaneStatDisplay(
  value: '99.9%',
  label: 'Uptime SLA',
)
```

## Properties

### ArcaneStatDisplay

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `String` | required | The metric value |
| `label` | `String` | required | Description label |
| `layout` | `StatDisplayLayout` | `vertical` | Layout direction |
| `valueColor` | `String?` | `null` | Custom value color |
| `labelColor` | `String?` | `null` | Custom label color |
| `valueSize` | `String?` | `null` | Custom value font size |
| `labelSize` | `String?` | `null` | Custom label font size |

### ArcaneStatRow

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `stats` | `List<ArcaneStatDisplay>` | required | List of stat displays |
| `gap` | `String?` | `null` | Gap between stats |
| `justify` | `String?` | `null` | Justify content |

## Variants

### Default

```dart
ArcaneStatDisplay(
  value: '10K+',
  label: 'Active Users',
)
```

### Accent Colored

```dart
ArcaneStatDisplay.accent(
  value: '5M+',
  label: 'Downloads',
)
```

### Brand Colored

```dart
ArcaneStatDisplay.brand(
  value: '150+',
  label: 'Contributors',
)
```

## Layouts

```dart
// Vertical (default) - value on top, label below
ArcaneStatDisplay(
  value: '99.9%',
  label: 'Uptime',
  layout: StatDisplayLayout.vertical,
)

// Horizontal - value and label side by side
ArcaneStatDisplay(
  value: '<60s',
  label: 'Deploy Time',
  layout: StatDisplayLayout.horizontal,
)
```

## Examples

### Trust Indicators Row

```dart
ArcaneStatRow(
  stats: [
    ArcaneStatDisplay(value: '99.9%', label: 'Uptime SLA'),
    ArcaneStatDisplay(value: '10K+', label: 'Active Servers'),
    ArcaneStatDisplay(value: '<60s', label: 'Deploy Time'),
  ],
)
```

### Project Stats

```dart
ArcaneRow(
  gapSize: Gap.xl,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    ArcaneStatDisplay.accent(value: '5M+', label: 'Downloads'),
    ArcaneStatDisplay.accent(value: '150+', label: 'Contributors'),
    ArcaneStatDisplay.accent(value: '50+', label: 'Integrations'),
  ],
)
```

### Pricing Card Stats

```dart
ArcaneRow(
  gapSize: Gap.lg,
  children: [
    ArcaneStatDisplay(
      value: '\$29',
      label: '/month',
      layout: StatDisplayLayout.horizontal,
    ),
  ],
)
```

## Related Components

- [ArcaneStatCard](/docs/view/arcane-stat-card) - Stat card with icon
- [ArcaneBadge](/docs/view/arcane-badge) - Status badges
