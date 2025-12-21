---
title: ArcaneRadio
description: Radio button for single selection from options
layout: docs
---

# ArcaneRadio

Radio buttons for selecting a single option from a group of mutually exclusive choices.

## Basic Usage

```dart
ArcaneRadio<String>(
  value: 'option1',
  groupValue: selectedOption,
  label: 'Option 1',
  onChanged: (value) {
    setState(() => selectedOption = value);
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `T` | required | This radio's value |
| `groupValue` | `T?` | required | Currently selected value |
| `onChanged` | `ValueChanged<T>?` | `null` | Selection handler |
| `label` | `String?` | `null` | Label text |
| `isDisabled` | `bool` | `false` | Disable interaction |
| `size` | `RadioSize` | `medium` | Radio size |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## Radio Group

Create a group of mutually exclusive options:

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    gap: Gap.sm,
  ),
  children: [
    ArcaneRadio<String>(
      value: 'small',
      groupValue: size,
      label: 'Small',
      onChanged: (v) => setState(() => size = v),
    ),
    ArcaneRadio<String>(
      value: 'medium',
      groupValue: size,
      label: 'Medium',
      onChanged: (v) => setState(() => size = v),
    ),
    ArcaneRadio<String>(
      value: 'large',
      groupValue: size,
      label: 'Large',
      onChanged: (v) => setState(() => size = v),
    ),
  ],
)
```

## Sizes

```dart
// Small
ArcaneRadio<String>(
  value: 'a',
  groupValue: selected,
  label: 'Small radio',
  size: RadioSize.small,
  onChanged: (v) => setState(() => selected = v),
)

// Medium (default)
ArcaneRadio<String>(
  value: 'b',
  groupValue: selected,
  label: 'Medium radio',
  size: RadioSize.medium,
  onChanged: (v) => setState(() => selected = v),
)

// Large
ArcaneRadio<String>(
  value: 'c',
  groupValue: selected,
  label: 'Large radio',
  size: RadioSize.large,
  onChanged: (v) => setState(() => selected = v),
)
```

## Disabled State

```dart
ArcaneRadio<String>(
  value: 'disabled',
  groupValue: selected,
  label: 'Disabled option',
  isDisabled: true,
  onChanged: null,
)
```

## Examples

### Payment Method Selection

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    gap: Gap.md,
  ),
  children: [
    ArcaneDiv(
      styles: const ArcaneStyleData(
        fontWeight: FontWeight.w600,
        margin: MarginPreset.bottomSm,
      ),
      children: [ArcaneText('Payment Method')],
    ),
    ArcaneRadio<String>(
      value: 'card',
      groupValue: paymentMethod,
      label: 'Credit/Debit Card',
      onChanged: (v) => setState(() => paymentMethod = v),
    ),
    ArcaneRadio<String>(
      value: 'paypal',
      groupValue: paymentMethod,
      label: 'PayPal',
      onChanged: (v) => setState(() => paymentMethod = v),
    ),
    ArcaneRadio<String>(
      value: 'bank',
      groupValue: paymentMethod,
      label: 'Bank Transfer',
      onChanged: (v) => setState(() => paymentMethod = v),
    ),
  ],
)
```

### Plan Selection with Descriptions

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    gap: Gap.md,
  ),
  children: [
    for (final plan in plans)
      ArcaneDiv(
        styles: ArcaneStyleData(
          padding: PaddingPreset.md,
          background: selectedPlan == plan.id
              ? Background.accentContainer
              : Background.surface,
          borderRadius: Radius.lg,
          border: selectedPlan == plan.id
              ? BorderPreset.accent
              : BorderPreset.subtle,
          cursor: Cursor.pointer,
        ),
        events: {
          'click': (_) => setState(() => selectedPlan = plan.id),
        },
        children: [
          ArcaneDiv(
            styles: const ArcaneStyleData(
              display: Display.flex,
              justifyContent: JustifyContent.spaceBetween,
              alignItems: AlignItems.center,
            ),
            children: [
              ArcaneRadio<String>(
                value: plan.id,
                groupValue: selectedPlan,
                label: plan.name,
                onChanged: (v) => setState(() => selectedPlan = v),
              ),
              ArcaneText('\$${plan.price}/mo'),
            ],
          ),
          ArcaneDiv(
            styles: const ArcaneStyleData(
              fontSize: FontSize.sm,
              textColor: TextColor.muted,
              margin: MarginPreset.topSm,
              raw: {'padding-left': '28px'},
            ),
            children: [ArcaneText(plan.description)],
          ),
        ],
      ),
  ],
)
```

### Horizontal Radio Group

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    gap: Gap.lg,
  ),
  children: [
    ArcaneRadio<String>(
      value: 'day',
      groupValue: timeframe,
      label: 'Day',
      onChanged: (v) => setState(() => timeframe = v),
    ),
    ArcaneRadio<String>(
      value: 'week',
      groupValue: timeframe,
      label: 'Week',
      onChanged: (v) => setState(() => timeframe = v),
    ),
    ArcaneRadio<String>(
      value: 'month',
      groupValue: timeframe,
      label: 'Month',
      onChanged: (v) => setState(() => timeframe = v),
    ),
    ArcaneRadio<String>(
      value: 'year',
      groupValue: timeframe,
      label: 'Year',
      onChanged: (v) => setState(() => timeframe = v),
    ),
  ],
)
```

## Related Components

- [ArcaneCheckbox](/arcane_jaspr/docs/inputs/arcane-checkbox) - Multiple selection
- [ArcaneSelect](/arcane_jaspr/docs/inputs/arcane-select) - Dropdown selection
- [ArcaneToggleButtonGroup](/arcane_jaspr/docs/inputs/arcane-toggle-button-group) - Button-style selection
