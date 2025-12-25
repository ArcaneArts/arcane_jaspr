---
title: ArcaneStatusBadge
description: Status indicator badges with pulse animation
layout: docs
component: status-badge
---

# ArcaneStatusBadge

A status indicator badge with pulse animation for showing system status, service health, or state indicators.

## Basic Usage

```dart
ArcaneStatusBadge.success('All Systems Operational')
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `status` | `StatusType` | required | Status type |
| `label` | `String` | required | Badge label |
| `size` | `StatusBadgeSize` | `md` | Badge size |
| `showGlow` | `bool` | `true` | Show glow effect |
| `showPulse` | `bool` | `true` | Show pulse animation |
| `indicatorColor` | `String?` | `null` | Custom indicator color |
| `background` | `String?` | `null` | Custom background |
| `borderColor` | `String?` | `null` | Custom border color |

## Status Types

```dart
// Success - green, operational
ArcaneStatusBadge.success('Online')

// Warning - yellow, degraded
ArcaneStatusBadge.warning('Degraded Performance')

// Error - red, down
ArcaneStatusBadge.error('Service Down')

// Info - blue, informational
ArcaneStatusBadge.info('Maintenance Scheduled')

// Offline - gray, disabled
ArcaneStatusBadge.offline('Offline')
```

## Sizes

```dart
// Small
ArcaneStatusBadge.success('Small', size: StatusBadgeSize.sm)

// Medium (default)
ArcaneStatusBadge.success('Medium', size: StatusBadgeSize.md)

// Large
ArcaneStatusBadge.success('Large', size: StatusBadgeSize.lg)
```

## Examples

### System Status Page

```dart
ArcaneColumn(
  gapSize: Gap.md,
  children: [
    ArcaneRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ArcaneText('API'),
        ArcaneStatusBadge.success('Operational'),
      ],
    ),
    ArcaneRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ArcaneText('Database'),
        ArcaneStatusBadge.success('Operational'),
      ],
    ),
    ArcaneRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ArcaneText('CDN'),
        ArcaneStatusBadge.warning('Degraded'),
      ],
    ),
  ],
)
```

### Footer Status

```dart
ArcaneFooterBrandColumn(
  logo: MyLogo(),
  description: 'Premium game server hosting.',
  bottomContent: ArcaneStatusBadge.success('All Systems Operational'),
)
```

### Dashboard Header

```dart
ArcaneRow(
  gapSize: Gap.md,
  children: [
    ArcaneText('Server Status'),
    ArcaneStatusBadge.success('Online', size: StatusBadgeSize.sm),
  ],
)
```

### Without Animation

```dart
ArcaneStatusBadge(
  status: StatusType.success,
  label: 'Active',
  showPulse: false,
  showGlow: false,
)
```

## Related Components

- [ArcaneBadge](/docs/view/arcane-badge) - General purpose badge
- [ArcaneStatusIndicator](/docs/view/arcane-status-indicator) - Simple status dot
- [ArcaneAlertBanner](/docs/feedback/arcane-alert-banner) - Alert banners
