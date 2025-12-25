---
title: ArcaneRadioGroup
description: Radio button group with multiple visual variants
layout: docs
component: radio-group
---

# ArcaneRadioGroup

A group of radio buttons for single-selection from multiple options. Supports multiple visual variants including standard radios, cards, buttons, and chips.

## Basic Usage

```dart
ArcaneRadioGroup<String>(
  options: [
    RadioOption(value: 'small', label: 'Small'),
    RadioOption(value: 'medium', label: 'Medium'),
    RadioOption(value: 'large', label: 'Large'),
  ],
  value: selectedSize,
  onChanged: (value) {
    setState(() => selectedSize = value);
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `options` | `List<RadioOption<T>>` | required | Available options |
| `value` | `T?` | `null` | Currently selected value |
| `onChanged` | `ValueChanged<T?>?` | `null` | Selection change handler |
| `variant` | `RadioGroupVariant` | `standard` | Visual variant |
| `direction` | `Axis` | `vertical` | Layout direction |
| `label` | `String?` | `null` | Group label |
| `description` | `String?` | `null` | Help text |
| `disabled` | `bool` | `false` | Disable all options |

## Variants

### Standard (Default)

Classic radio buttons with labels:

```dart
ArcaneRadioGroup<String>(
  variant: RadioGroupVariant.standard,
  options: options,
  value: selected,
  onChanged: (v) => setState(() => selected = v),
)
```

### Cards

Radio options displayed as selectable cards:

```dart
ArcaneRadioGroup<String>(
  variant: RadioGroupVariant.cards,
  options: [
    RadioOption(
      value: 'free',
      label: 'Free',
      description: 'Basic features',
    ),
    RadioOption(
      value: 'pro',
      label: 'Pro',
      description: 'Advanced features',
    ),
  ],
  value: selected,
  onChanged: (v) => setState(() => selected = v),
)
```

### Buttons

Segmented button-style radio group:

```dart
ArcaneRadioGroup<String>(
  variant: RadioGroupVariant.buttons,
  direction: Axis.horizontal,
  options: options,
  value: selected,
  onChanged: (v) => setState(() => selected = v),
)
```

### Chips

Chip-style radio options:

```dart
ArcaneRadioGroup<String>(
  variant: RadioGroupVariant.chips,
  direction: Axis.horizontal,
  options: options,
  value: selected,
  onChanged: (v) => setState(() => selected = v),
)
```

## RadioOption Properties

| Property | Type | Description |
|----------|------|-------------|
| `value` | `T` | The option's value |
| `label` | `String` | Display label |
| `description` | `String?` | Optional description (cards variant) |
| `disabled` | `bool` | Disable this specific option |
| `icon` | `Component?` | Optional icon |

## Accessibility

- Full keyboard navigation (arrow keys)
- Proper ARIA role="radiogroup" and role="radio"
- Focus indicators for keyboard users
