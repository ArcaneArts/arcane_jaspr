---
title: ArcaneMeter
description: Progress meter or gauge display
layout: docs
component: meter
---

# ArcaneMeter

A meter component for displaying progress, usage, or capacity with visual feedback.

## Basic Usage

```dart
ArcaneMeter(value: 0.65)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `double` | required | Value between 0 and 1 |
| `style` | `MeterStyle` | `bar` | Visual style |
| `color` | `MeterColor` | `primary` | Color variant |
| `size` | `MeterSize` | `md` | Size variant |
| `label` | `String?` | `null` | Label text |
| `showValue` | `bool` | `false` | Display percentage |
| `animated` | `bool` | `true` | Animate changes |
| `segments` | `int` | `10` | Segments for segmented style |

## Style Variants

```dart
// Bar (default)
ArcaneMeter(
  value: 0.65,
  style: MeterStyle.bar,
)

// Gradient
ArcaneMeter(
  value: 0.65,
  style: MeterStyle.gradient,
)

// Segmented
ArcaneMeter(
  value: 0.65,
  style: MeterStyle.segmented,
  segments: 10,
)

// Circular
ArcaneMeter(
  value: 0.65,
  style: MeterStyle.circular,
)
```

## Color Variants

```dart
// Primary (default)
ArcaneMeter(value: 0.65, color: MeterColor.primary)

// Success
ArcaneMeter(value: 0.65, color: MeterColor.success)

// Warning
ArcaneMeter(value: 0.65, color: MeterColor.warning)

// Error
ArcaneMeter(value: 0.65, color: MeterColor.error)

// Adaptive (changes based on value)
ArcaneMeter(value: 0.85, color: MeterColor.adaptive)
```

## With Label and Value

```dart
ArcaneMeter(
  value: 0.65,
  label: 'Storage',
  showValue: true,
)
```

## Factory Constructors

```dart
// Storage meter
ArcaneMeter.storage(
  used: 65,
  total: 100,
  unit: 'GB',
)

// Battery meter
ArcaneMeter.battery(
  level: 0.85,
)
```

## Size Variants

```dart
// Small
ArcaneMeter(value: 0.65, size: MeterSize.sm)

// Medium (default)
ArcaneMeter(value: 0.65, size: MeterSize.md)

// Large
ArcaneMeter(value: 0.65, size: MeterSize.lg)
```

## Examples

### Storage Usage

```dart
ArcaneColumn(
  gapSize: Gap.sm,
  children: [
    ArcaneMeter.storage(
      used: 65,
      total: 100,
      unit: 'GB',
    ),
    ArcaneText(
      '65 GB of 100 GB used',
      color: TextColor.muted,
    ),
  ],
)
```

### Battery Indicator

```dart
ArcaneRow(
  gapSize: Gap.sm,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    ArcaneMeter.battery(level: 0.25),
    ArcaneText('25%'),
  ],
)
```

### Resource Usage Dashboard

```dart
ArcaneColumn(
  gapSize: Gap.md,
  children: [
    ArcaneMeter(
      value: 0.45,
      label: 'CPU Usage',
      showValue: true,
      color: MeterColor.adaptive,
    ),
    ArcaneMeter(
      value: 0.72,
      label: 'Memory Usage',
      showValue: true,
      color: MeterColor.adaptive,
    ),
    ArcaneMeter(
      value: 0.95,
      label: 'Disk Usage',
      showValue: true,
      color: MeterColor.adaptive,
    ),
  ],
)
```

## Related Components

- [ArcaneProgressBar](/arcane_jaspr/docs/view/arcane-progress-bar) - Progress indicator
- [ArcaneSlider](/arcane_jaspr/docs/inputs/arcane-slider) - Value slider
