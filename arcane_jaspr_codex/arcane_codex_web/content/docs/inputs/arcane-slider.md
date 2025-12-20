---
title: ArcaneSlider
description: Range slider for numeric value selection
layout: docs
---

# ArcaneSlider

A styled slider component for selecting numeric values within a range.

## Basic Usage

```dart
ArcaneSlider(
  value: sliderValue,
  min: 0,
  max: 100,
  onChanged: (value) {
    setState(() => sliderValue = value);
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `double` | required | Current value |
| `min` | `double` | `0` | Minimum value |
| `max` | `double` | `100` | Maximum value |
| `onChanged` | `ValueChanged<double>?` | `null` | Value change handler |
| `step` | `double?` | `null` | Step increment |
| `label` | `String?` | `null` | Label text |
| `showValue` | `bool` | `false` | Display current value |
| `isDisabled` | `bool` | `false` | Disable interaction |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## With Label

```dart
ArcaneSlider(
  label: 'Volume',
  value: volume,
  min: 0,
  max: 100,
  onChanged: (value) => setState(() => volume = value),
)
```

## Show Current Value

```dart
ArcaneSlider(
  label: 'Brightness',
  value: brightness,
  min: 0,
  max: 100,
  showValue: true,
  onChanged: (value) => setState(() => brightness = value),
)
```

## With Step

```dart
ArcaneSlider(
  label: 'Quantity',
  value: quantity.toDouble(),
  min: 1,
  max: 10,
  step: 1,
  showValue: true,
  onChanged: (value) => setState(() => quantity = value.toInt()),
)
```

## Custom Range

```dart
// Temperature slider
ArcaneSlider(
  label: 'Temperature',
  value: temperature,
  min: -20,
  max: 40,
  showValue: true,
  onChanged: (value) => setState(() => temperature = value),
)

// Percentage
ArcaneSlider(
  label: 'Opacity',
  value: opacity,
  min: 0,
  max: 1,
  step: 0.1,
  showValue: true,
  onChanged: (value) => setState(() => opacity = value),
)
```

## Disabled State

```dart
ArcaneSlider(
  label: 'Locked Setting',
  value: 50,
  isDisabled: true,
)
```

## Examples

### Volume Control

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    alignItems: AlignItems.center,
    gap: Gap.md,
  ),
  children: [
    ArcaneText('🔇'),
    ArcaneSlider(
      value: volume,
      min: 0,
      max: 100,
      onChanged: (v) => setState(() => volume = v),
      styles: const ArcaneStyleData(
        flexGrow: 1,
      ),
    ),
    ArcaneText('🔊'),
    ArcaneText('${volume.toInt()}%'),
  ],
)
```

### Price Range Filter

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    gap: Gap.sm,
  ),
  children: [
    ArcaneDiv(
      styles: const ArcaneStyleData(
        display: Display.flex,
        justifyContent: JustifyContent.spaceBetween,
      ),
      children: [
        ArcaneText('Price Range'),
        ArcaneText('\$${minPrice.toInt()} - \$${maxPrice.toInt()}'),
      ],
    ),
    ArcaneSlider(
      value: maxPrice,
      min: 0,
      max: 1000,
      step: 50,
      onChanged: (v) => setState(() => maxPrice = v),
    ),
  ],
)
```

### Settings Panel

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    gap: Gap.lg,
  ),
  children: [
    ArcaneSlider(
      label: 'Font Size',
      value: fontSize,
      min: 12,
      max: 24,
      step: 1,
      showValue: true,
      onChanged: (v) => setState(() => fontSize = v),
    ),
    ArcaneSlider(
      label: 'Line Spacing',
      value: lineSpacing,
      min: 1,
      max: 2,
      step: 0.1,
      showValue: true,
      onChanged: (v) => setState(() => lineSpacing = v),
    ),
    ArcaneSlider(
      label: 'Margin',
      value: margin,
      min: 0,
      max: 100,
      step: 10,
      showValue: true,
      onChanged: (v) => setState(() => margin = v),
    ),
  ],
)
```

## Related Components

- [ArcaneRangeSlider](/docs/inputs/arcane-range-slider) - Dual-handle range slider
- [ArcaneTextInput](/docs/inputs/arcane-text-input) - Text input for precise values
