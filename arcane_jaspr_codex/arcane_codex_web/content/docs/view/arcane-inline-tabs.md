---
title: ArcaneTabBar
description: Inline tab bar for switching views
layout: docs
component: inline-tabs
---

# ArcaneTabBar

A simple inline tab bar component for switching between views or filtering content. For tabs with content panels, use [ArcaneTabs](/arcane_jaspr/docs/layout/arcane-tabs).

## Basic Usage

```dart
ArcaneTabBar(
  tabs: [
    ArcaneTabBarItem(label: 'Overview'),
    ArcaneTabBarItem(label: 'Features'),
    ArcaneTabBarItem(label: 'Pricing'),
  ],
  selectedIndex: selectedIndex,
  onChanged: (index) => setState(() => selectedIndex = index),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `tabs` | `List<ArcaneTabBarItem>` | required | Tab items |
| `selectedIndex` | `int` | required | Active tab index |
| `onChanged` | `void Function(int)` | required | Tab change callback |
| `fill` | `bool` | `false` | Stretch tabs to fill width |

## ArcaneTabBarItem Properties

| Property | Type | Description |
|----------|------|-------------|
| `label` | `String` | Display label |
| `icon` | `Component?` | Optional icon |

## With Icons

```dart
ArcaneTabBar(
  tabs: [
    ArcaneTabBarItem(label: 'Home', icon: ArcaneIcon.home()),
    ArcaneTabBarItem(label: 'Search', icon: ArcaneIcon.search()),
    ArcaneTabBarItem(label: 'Settings', icon: ArcaneIcon.settings()),
  ],
  selectedIndex: selectedIndex,
  onChanged: onChanged,
)
```

## Full Width

```dart
ArcaneTabBar(
  tabs: tabs,
  selectedIndex: selectedIndex,
  onChanged: onChanged,
  fill: true,
)
```

## Examples

### Filter Tabs

```dart
ArcaneTabBar(
  tabs: [
    ArcaneTabBarItem(label: 'All'),
    ArcaneTabBarItem(label: 'Active'),
    ArcaneTabBarItem(label: 'Completed'),
  ],
  selectedIndex: filterIndex,
  onChanged: (index) => setState(() => filterIndex = index),
)
```

### Navigation Tabs

```dart
ArcaneColumn(
  children: [
    ArcaneTabBar(
      tabs: [
        ArcaneTabBarItem(label: 'Description'),
        ArcaneTabBarItem(label: 'Specifications'),
        ArcaneTabBarItem(label: 'Reviews'),
      ],
      selectedIndex: tabIndex,
      onChanged: (index) => setState(() => tabIndex = index),
    ),
    ArcaneDiv(
      styles: const ArcaneStyleData(padding: PaddingPreset.md),
      children: [
        if (tabIndex == 0) DescriptionContent(),
        if (tabIndex == 1) SpecsContent(),
        if (tabIndex == 2) ReviewsContent(),
      ],
    ),
  ],
)
```

## Related Components

- [ArcaneTabs](/arcane_jaspr/docs/layout/arcane-tabs) - Full tabs with content panels
