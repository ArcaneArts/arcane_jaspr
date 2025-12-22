---
title: ArcaneNumberInput
description: Numeric input with increment/decrement controls
layout: docs
component: number-input
---

# ArcaneNumberInput

A numeric input component with increment and decrement buttons for easy value adjustment.

## Basic Usage

```dart
ArcaneNumberInput(
  value: quantity,
  onChanged: (value) {
    setState(() => quantity = value);
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `num` | required | Current value |
| `onChanged` | `ValueChanged<num>?` | `null` | Value change callback |
| `min` | `num?` | `null` | Minimum value |
| `max` | `num?` | `null` | Maximum value |
| `step` | `num` | `1` | Increment/decrement step |
| `style` | `NumberInputStyle` | `sideBySide` | Layout style |
| `size` | `NumberInputSize` | `md` | Size variant |
| `label` | `String?` | `null` | Label text |
| `prefix` | `String?` | `null` | Prefix text |
| `suffix` | `String?` | `null` | Suffix text |
| `disabled` | `bool` | `false` | Disable interaction |
| `allowNegative` | `bool` | `true` | Allow negative values |
| `allowDecimal` | `bool` | `false` | Allow decimal values |

## Style Variants

```dart
// Side by side (default)
ArcaneNumberInput(
  value: value,
  style: NumberInputStyle.sideBySide,
  onChanged: onChanged,
)

// Stacked
ArcaneNumberInput(
  value: value,
  style: NumberInputStyle.stacked,
  onChanged: onChanged,
)

// Inline
ArcaneNumberInput(
  value: value,
  style: NumberInputStyle.inline,
  onChanged: onChanged,
)
```

## With Min/Max

```dart
ArcaneNumberInput(
  value: quantity,
  min: 1,
  max: 99,
  onChanged: (v) => setState(() => quantity = v),
)
```

## With Prefix/Suffix

```dart
// Price input
ArcaneNumberInput(
  value: price,
  prefix: '\$',
  step: 0.01,
  allowDecimal: true,
  onChanged: (v) => setState(() => price = v),
)

// Percentage input
ArcaneNumberInput(
  value: percentage,
  suffix: '%',
  min: 0,
  max: 100,
  onChanged: (v) => setState(() => percentage = v),
)
```

## Examples

### Quantity Selector

```dart
ArcaneRow(
  gapSize: Gap.md,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    ArcaneText('Quantity:'),
    ArcaneNumberInput(
      value: quantity,
      min: 1,
      max: 10,
      onChanged: (v) => setState(() => quantity = v),
    ),
  ],
)
```

### Settings Panel

```dart
ArcaneColumn(
  gapSize: Gap.md,
  children: [
    ArcaneNumberInput(
      label: 'Font Size',
      value: fontSize,
      min: 8,
      max: 72,
      suffix: 'px',
      onChanged: (v) => setState(() => fontSize = v),
    ),
    ArcaneNumberInput(
      label: 'Line Height',
      value: lineHeight,
      min: 1,
      max: 3,
      step: 0.1,
      allowDecimal: true,
      onChanged: (v) => setState(() => lineHeight = v),
    ),
  ],
)
```

## Related Components

- [ArcaneSlider](/arcane_jaspr/docs/inputs/arcane-slider) - Slider for numeric values
- [ArcaneTextInput](/arcane_jaspr/docs/inputs/arcane-text-input) - Text input
