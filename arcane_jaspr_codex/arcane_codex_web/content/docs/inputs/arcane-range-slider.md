---
title: ArcaneRangeSlider
description: Dual-handle slider for selecting a range
layout: docs
---

# ArcaneRangeSlider

A dual-handle slider for selecting a range between minimum and maximum values.

## Basic Usage

```dart
ArcaneRangeSlider(
  minValue: rangeStart,
  maxValue: rangeEnd,
  min: 0,
  max: 100,
  onChanged: (start, end) {
    setState(() {
      rangeStart = start;
      rangeEnd = end;
    });
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `minValue` | `double` | required | Current minimum value |
| `maxValue` | `double` | required | Current maximum value |
| `min` | `double` | `0` | Absolute minimum |
| `max` | `double` | `100` | Absolute maximum |
| `onChanged` | `Function(double, double)?` | `null` | Range change handler |
| `step` | `double?` | `null` | Step increment |
| `label` | `String?` | `null` | Label text |
| `showValues` | `bool` | `false` | Display current values |
| `isDisabled` | `bool` | `false` | Disable interaction |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## With Label

```dart
ArcaneRangeSlider(
  label: 'Price Range',
  minValue: minPrice,
  maxValue: maxPrice,
  min: 0,
  max: 1000,
  onChanged: (min, max) {
    setState(() {
      minPrice = min;
      maxPrice = max;
    });
  },
)
```

## Show Values

```dart
ArcaneRangeSlider(
  label: 'Age Range',
  minValue: minAge,
  maxValue: maxAge,
  min: 18,
  max: 65,
  showValues: true,
  onChanged: (min, max) {
    setState(() {
      minAge = min;
      maxAge = max;
    });
  },
)
```

## With Step

```dart
ArcaneRangeSlider(
  label: 'Budget',
  minValue: minBudget,
  maxValue: maxBudget,
  min: 0,
  max: 10000,
  step: 100,
  showValues: true,
  onChanged: (min, max) {
    setState(() {
      minBudget = min;
      maxBudget = max;
    });
  },
)
```

## Examples

### Price Filter

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    padding: PaddingPreset.md,
    background: Background.surface,
    borderRadius: Radius.lg,
  ),
  children: [
    ArcaneDiv(
      styles: const ArcaneStyleData(
        display: Display.flex,
        justifyContent: JustifyContent.spaceBetween,
        margin: MarginPreset.bottomMd,
      ),
      children: [
        ArcaneText('Price'),
        ArcaneText('\$${minPrice.toInt()} - \$${maxPrice.toInt()}'),
      ],
    ),
    ArcaneRangeSlider(
      minValue: minPrice,
      maxValue: maxPrice,
      min: 0,
      max: 1000,
      step: 10,
      onChanged: (min, max) {
        setState(() {
          minPrice = min;
          maxPrice = max;
        });
        filterProducts();
      },
    ),
  ],
)
```

### Date Range (Days)

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
        ArcaneText('Duration'),
        ArcaneText('${startDay.toInt()} - ${endDay.toInt()} days'),
      ],
    ),
    ArcaneRangeSlider(
      minValue: startDay,
      maxValue: endDay,
      min: 1,
      max: 30,
      step: 1,
      onChanged: (start, end) {
        setState(() {
          startDay = start;
          endDay = end;
        });
      },
    ),
  ],
)
```

### Filter Panel

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    gap: Gap.xl,
    padding: PaddingPreset.lg,
  ),
  children: [
    // Price range
    ArcaneRangeSlider(
      label: 'Price (\$)',
      minValue: priceMin,
      maxValue: priceMax,
      min: 0,
      max: 500,
      step: 10,
      showValues: true,
      onChanged: (min, max) => updatePriceRange(min, max),
    ),

    // Rating range
    ArcaneRangeSlider(
      label: 'Rating',
      minValue: ratingMin,
      maxValue: ratingMax,
      min: 1,
      max: 5,
      step: 0.5,
      showValues: true,
      onChanged: (min, max) => updateRatingRange(min, max),
    ),

    // Distance range
    ArcaneRangeSlider(
      label: 'Distance (km)',
      minValue: distanceMin,
      maxValue: distanceMax,
      min: 0,
      max: 50,
      step: 1,
      showValues: true,
      onChanged: (min, max) => updateDistanceRange(min, max),
    ),

    ArcaneButton.primary(
      label: 'Apply Filters',
      fullWidth: true,
      onPressed: applyFilters,
    ),
  ],
)
```

## Related Components

- [ArcaneSlider](/arcane_jaspr/docs/inputs/arcane-slider) - Single-value slider
- [ArcaneTextInput](/arcane_jaspr/docs/inputs/arcane-text-input) - Precise value input
