---
title: ArcaneCycleButton
description: Button that cycles through a list of options
layout: docs
---

# ArcaneCycleButton

A button that cycles through a predefined list of options with each click, ideal for compact controls.

## Basic Usage

```dart
ArcaneCycleButton<String>(
  value: currentSort,
  options: [
    ArcaneCycleOption(value: 'asc', label: 'A-Z'),
    ArcaneCycleOption(value: 'desc', label: 'Z-A'),
    ArcaneCycleOption(value: 'date', label: 'Date'),
  ],
  onChanged: (value) {
    setState(() => currentSort = value);
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `T` | required | Current selected value |
| `options` | `List<ArcaneCycleOption<T>>` | required | Available options |
| `onChanged` | `ValueChanged<T>?` | `null` | Value change handler |
| `size` | `CycleButtonSize` | `medium` | Button size |
| `showIcon` | `bool` | `true` | Show cycle indicator |
| `isDisabled` | `bool` | `false` | Disable interaction |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## ArcaneCycleOption

```dart
ArcaneCycleOption<String>(
  value: 'option1',
  label: 'Label',           // Display text
  icon: span([text('↑')]),  // Optional icon
)
```

## With Icons

```dart
ArcaneCycleButton<String>(
  value: sortDirection,
  options: [
    ArcaneCycleOption(value: 'asc', label: 'Ascending', icon: span([text('↑')])),
    ArcaneCycleOption(value: 'desc', label: 'Descending', icon: span([text('↓')])),
  ],
  onChanged: (v) => setState(() => sortDirection = v),
)
```

## Sizes

```dart
// Small
ArcaneCycleButton<String>(
  value: value,
  size: CycleButtonSize.small,
  options: options,
  onChanged: (v) => setState(() => value = v),
)

// Medium (default)
ArcaneCycleButton<String>(
  value: value,
  size: CycleButtonSize.medium,
  options: options,
  onChanged: (v) => setState(() => value = v),
)

// Large
ArcaneCycleButton<String>(
  value: value,
  size: CycleButtonSize.large,
  options: options,
  onChanged: (v) => setState(() => value = v),
)
```

## Examples

### Sort Direction

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    alignItems: AlignItems.center,
    gap: Gap.md,
  ),
  children: [
    ArcaneText('Sort:'),
    ArcaneCycleButton<String>(
      value: sortBy,
      options: [
        ArcaneCycleOption(value: 'name', label: 'Name'),
        ArcaneCycleOption(value: 'date', label: 'Date'),
        ArcaneCycleOption(value: 'size', label: 'Size'),
        ArcaneCycleOption(value: 'type', label: 'Type'),
      ],
      onChanged: (v) {
        setState(() => sortBy = v);
        sortItems();
      },
    ),
    ArcaneCycleButton<String>(
      value: sortOrder,
      options: [
        ArcaneCycleOption(value: 'asc', icon: span([text('↑')])),
        ArcaneCycleOption(value: 'desc', icon: span([text('↓')])),
      ],
      onChanged: (v) {
        setState(() => sortOrder = v);
        sortItems();
      },
    ),
  ],
)
```

### Display Density

```dart
ArcaneCycleButton<String>(
  value: density,
  options: [
    ArcaneCycleOption(value: 'compact', label: 'Compact', icon: span([text('▪')])),
    ArcaneCycleOption(value: 'normal', label: 'Normal', icon: span([text('▬')])),
    ArcaneCycleOption(value: 'comfortable', label: 'Comfortable', icon: span([text('▰')])),
  ],
  onChanged: (v) => setState(() => density = v),
)
```

### Theme Mode Cycle

```dart
ArcaneCycleButton<String>(
  value: themeMode,
  options: [
    ArcaneCycleOption(value: 'light', label: 'Light', icon: span([text('☀')])),
    ArcaneCycleOption(value: 'dark', label: 'Dark', icon: span([text('🌙')])),
    ArcaneCycleOption(value: 'system', label: 'System', icon: span([text('💻')])),
  ],
  onChanged: (v) {
    setState(() => themeMode = v);
    applyTheme(v);
  },
)
```

### View Type Cycle

```dart
ArcaneCycleButton<String>(
  value: viewType,
  size: CycleButtonSize.small,
  options: [
    ArcaneCycleOption(value: 'grid', icon: span([text('⊞')])),
    ArcaneCycleOption(value: 'list', icon: span([text('☰')])),
    ArcaneCycleOption(value: 'card', icon: span([text('▢')])),
  ],
  onChanged: (v) => setState(() => viewType = v),
)
```

### Refresh Interval

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    alignItems: AlignItems.center,
    gap: Gap.sm,
  ),
  children: [
    ArcaneText('Refresh:'),
    ArcaneCycleButton<int>(
      value: refreshInterval,
      options: [
        ArcaneCycleOption(value: 0, label: 'Off'),
        ArcaneCycleOption(value: 5, label: '5s'),
        ArcaneCycleOption(value: 15, label: '15s'),
        ArcaneCycleOption(value: 30, label: '30s'),
        ArcaneCycleOption(value: 60, label: '1m'),
      ],
      onChanged: (v) {
        setState(() => refreshInterval = v);
        updateRefreshTimer(v);
      },
    ),
  ],
)
```

## Related Components

- [ArcaneToggleButtonGroup](/arcane_jaspr/docs/inputs/arcane-toggle-button-group) - Multi-option toggle
- [ArcaneSelect](/arcane_jaspr/docs/inputs/arcane-select) - Dropdown selection
- [ArcaneSelector](/arcane_jaspr/docs/inputs/arcane-selector) - Custom selector
