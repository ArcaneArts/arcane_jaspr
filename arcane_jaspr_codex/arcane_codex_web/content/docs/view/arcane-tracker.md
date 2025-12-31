---
title: ArcaneTracker
description: GitHub-style contribution grid and uptime tracker
layout: docs
component: tracker
---

# ArcaneTracker

A dense status grid for time-series data visualization, similar to GitHub's contribution graph or uptime status displays.

## Basic Usage

```dart
ArcaneTracker(
  data: List.generate(90, (i) => TrackerData(
    level: TrackerLevel.fine,
    tooltip: 'Day ${i + 1}: 100% uptime',
  )),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `data` | `List<TrackerData>` | required | Data points |
| `columns` | `int` | `12` | Columns per row |
| `cellSize` | `int` | `12` | Cell size in px |
| `gap` | `int` | `3` | Gap between cells |
| `showTooltips` | `bool` | `true` | Show tooltips on hover |
| `showLegend` | `bool` | `false` | Show level legend |
| `onCellTap` | `Function?` | `null` | Cell tap handler |

## TrackerData

| Property | Type | Description |
|----------|------|-------------|
| `level` | `TrackerLevel` | Severity level |
| `tooltip` | `String?` | Hover tooltip text |
| `value` | `double?` | Optional numeric value |
| `label` | `String?` | Optional label |

## TrackerLevel

- `fine` - Green (healthy/success)
- `warning` - Yellow (warning state)
- `critical` - Red (error/critical)
- `unknown` - Gray (no data)

## Factory Constructors

### Weekly View (7 columns)

```dart
ArcaneTracker.weekly(
  data: weeklyData,
  showLegend: true,
)
```

### Monthly View (31 columns)

```dart
ArcaneTracker.monthly(
  data: monthlyData,
  showLegend: true,
)
```

## With Legend

```dart
ArcaneTracker(
  data: trackerData,
  showLegend: true,
)
```

## Custom Colors

```dart
ArcaneTracker(
  data: trackerData,
  levelColors: {
    TrackerLevel.fine: '#22c55e',
    TrackerLevel.warning: '#f59e0b',
    TrackerLevel.critical: '#ef4444',
    TrackerLevel.unknown: '#6b7280',
  },
)
```

# ArcaneUptimeTracker

An uptime tracker showing percentage bars for each day.

## Basic Usage

```dart
ArcaneUptimeTracker(
  days: List.generate(30, (i) => UptimeDay(
    date: DateTime.now().subtract(Duration(days: i)),
    uptime: 99.5 + (i % 5) / 10,
  )),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `days` | `List<UptimeDay>` | required | Uptime data |
| `barHeight` | `int` | `32` | Bar height in px |
| `barWidth` | `int` | `4` | Bar width in px |
| `gap` | `int` | `2` | Gap between bars |
| `showDates` | `bool` | `false` | Show date labels |
| `showPercentage` | `bool` | `true` | Show percentage on hover |

## Examples

### Status Page

```dart
ArcaneCard(
  child: ArcaneColumn(
    children: [
      ArcaneRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ArcaneText('API Status', weight: FontWeight.bold),
          ArcaneStatusBadge.success('Operational'),
        ],
      ),
      ArcaneDiv(
        styles: const ArcaneStyleData(margin: MarginPreset.topMd),
        children: [
          ArcaneUptimeTracker(
            days: uptimeData,
          ),
        ],
      ),
    ],
  ),
)
```

### Contribution Grid

```dart
ArcaneColumn(
  gapSize: Gap.sm,
  children: [
    ArcaneText('Contributions in the last 90 days'),
    ArcaneTracker(
      data: contributions,
      columns: 12,
      showLegend: true,
      onCellTap: (index, data) => showContributionDetails(index),
    ),
  ],
)
```

## Related Components

- [ArcaneProgressBar](/arcane_jaspr/docs/view/arcane-progress-bar) - Single progress bar
- [ArcaneTimeline](/arcane_jaspr/docs/view/arcane-timeline) - Event timeline
