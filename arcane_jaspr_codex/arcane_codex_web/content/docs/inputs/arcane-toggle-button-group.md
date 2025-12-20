---
title: ArcaneToggleButtonGroup
description: Group of toggle buttons for single or multiple selection
layout: docs
---

# ArcaneToggleButtonGroup

A group of connected toggle buttons for selecting one or multiple options, styled as a segmented control.

## Basic Usage

```dart
ArcaneToggleButtonGroup<String>(
  value: selectedOption,
  options: [
    ToggleOption(value: 'left', label: 'Left'),
    ToggleOption(value: 'center', label: 'Center'),
    ToggleOption(value: 'right', label: 'Right'),
  ],
  onChanged: (value) {
    setState(() => selectedOption = value);
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `T?` | `null` | Currently selected value |
| `values` | `Set<T>?` | `null` | Selected values (multi-select) |
| `options` | `List<ToggleOption<T>>` | required | Available options |
| `onChanged` | `ValueChanged<T>?` | `null` | Single selection handler |
| `onMultiChanged` | `ValueChanged<Set<T>>?` | `null` | Multi selection handler |
| `multiSelect` | `bool` | `false` | Allow multiple selections |
| `size` | `ToggleGroupSize` | `medium` | Button size |
| `isDisabled` | `bool` | `false` | Disable all buttons |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## ToggleOption

```dart
ToggleOption<String>(
  value: 'option1',
  label: 'Label',           // Text label
  icon: span([text('🔍')]), // Optional icon
  isDisabled: false,        // Disable specific option
)
```

## With Icons

```dart
ArcaneToggleButtonGroup<String>(
  value: alignment,
  options: [
    ToggleOption(value: 'left', icon: span([text('⬅')])),
    ToggleOption(value: 'center', icon: span([text('⬌')])),
    ToggleOption(value: 'right', icon: span([text('➡')])),
  ],
  onChanged: (v) => setState(() => alignment = v),
)
```

## Multi-Select

```dart
ArcaneToggleButtonGroup<String>(
  values: selectedFormats,
  multiSelect: true,
  options: [
    ToggleOption(value: 'bold', label: 'B'),
    ToggleOption(value: 'italic', label: 'I'),
    ToggleOption(value: 'underline', label: 'U'),
  ],
  onMultiChanged: (values) {
    setState(() => selectedFormats = values);
  },
)
```

## Sizes

```dart
// Small
ArcaneToggleButtonGroup<String>(
  value: selected,
  size: ToggleGroupSize.small,
  options: options,
  onChanged: (v) => setState(() => selected = v),
)

// Medium (default)
ArcaneToggleButtonGroup<String>(
  value: selected,
  size: ToggleGroupSize.medium,
  options: options,
  onChanged: (v) => setState(() => selected = v),
)

// Large
ArcaneToggleButtonGroup<String>(
  value: selected,
  size: ToggleGroupSize.large,
  options: options,
  onChanged: (v) => setState(() => selected = v),
)
```

## Examples

### View Mode Selector

```dart
ArcaneToggleButtonGroup<String>(
  value: viewMode,
  options: [
    ToggleOption(value: 'grid', icon: span([text('⊞')]), label: 'Grid'),
    ToggleOption(value: 'list', icon: span([text('☰')]), label: 'List'),
    ToggleOption(value: 'table', icon: span([text('▦')]), label: 'Table'),
  ],
  onChanged: (v) => setState(() => viewMode = v),
)
```

### Time Period Selector

```dart
ArcaneToggleButtonGroup<String>(
  value: period,
  options: [
    ToggleOption(value: '1d', label: '1D'),
    ToggleOption(value: '1w', label: '1W'),
    ToggleOption(value: '1m', label: '1M'),
    ToggleOption(value: '3m', label: '3M'),
    ToggleOption(value: '1y', label: '1Y'),
    ToggleOption(value: 'all', label: 'All'),
  ],
  onChanged: (v) {
    setState(() => period = v);
    fetchData(v);
  },
)
```

### Text Alignment

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    alignItems: AlignItems.center,
    gap: Gap.md,
  ),
  children: [
    ArcaneText('Align:'),
    ArcaneToggleButtonGroup<String>(
      value: textAlign,
      size: ToggleGroupSize.small,
      options: [
        ToggleOption(value: 'left', icon: span([text('⬅')])),
        ToggleOption(value: 'center', icon: span([text('⬌')])),
        ToggleOption(value: 'right', icon: span([text('➡')])),
        ToggleOption(value: 'justify', icon: span([text('☰')])),
      ],
      onChanged: (v) => setState(() => textAlign = v),
    ),
  ],
)
```

### Feature Tags (Multi-select)

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    gap: Gap.sm,
  ),
  children: [
    ArcaneText('Features:'),
    ArcaneToggleButtonGroup<String>(
      values: selectedFeatures,
      multiSelect: true,
      options: [
        ToggleOption(value: 'wifi', label: 'WiFi'),
        ToggleOption(value: 'parking', label: 'Parking'),
        ToggleOption(value: 'pool', label: 'Pool'),
        ToggleOption(value: 'gym', label: 'Gym'),
      ],
      onMultiChanged: (values) {
        setState(() => selectedFeatures = values);
      },
    ),
  ],
)
```

### Billing Cycle

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    alignItems: AlignItems.center,
    gap: Gap.md,
  ),
  children: [
    ArcaneToggleButtonGroup<String>(
      value: billingCycle,
      options: [
        ToggleOption(value: 'monthly', label: 'Monthly'),
        ToggleOption(value: 'yearly', label: 'Yearly (Save 20%)'),
      ],
      onChanged: (v) => setState(() => billingCycle = v),
    ),
    // Pricing cards based on selection...
  ],
)
```

## Related Components

- [ArcaneToggleButton](/docs/inputs/arcane-toggle-button) - Single toggle button
- [ArcaneRadio](/docs/inputs/arcane-radio) - Radio button selection
- [ArcaneSelect](/docs/inputs/arcane-select) - Dropdown selection
