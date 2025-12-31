---
title: ArcaneFormattedInput
description: Patterned input for structured data like dates, phones, credit cards
layout: docs
component: formatted-input
---

# ArcaneFormattedInput

A formatted input component for structured data entry with multiple segments.

## Basic Usage

```dart
ArcaneFormattedInput.date(
  initialMonth: '01',
  initialDay: '15',
  initialYear: '2024',
  onChanged: (value) {
    print('Date: ${value.combinedValue}');
  },
)
```

## Factory Constructors

### Date Input (MM/DD/YYYY)

```dart
ArcaneFormattedInput.date(
  initialMonth: '01',
  initialDay: '15',
  initialYear: '2024',
  label: 'Birth Date',
  onChanged: (value) => handleDateChange(value),
)
```

### Time Input (HH:MM)

```dart
ArcaneFormattedInput.time(
  initialHour: '09',
  initialMinute: '30',
  label: 'Start Time',
  onChanged: (value) => handleTimeChange(value),
)
```

### Phone Number

```dart
ArcaneFormattedInput.phone(
  initialAreaCode: '555',
  initialPrefix: '123',
  initialLine: '4567',
  label: 'Phone Number',
  onChanged: (value) => handlePhoneChange(value),
)
```

### Credit Card

```dart
ArcaneFormattedInput.creditCard(
  label: 'Card Number',
  onChanged: (value) => handleCardChange(value),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `initialValue` | `FormattedValue` | required | Initial value with parts |
| `onChanged` | `ValueChanged<FormattedValue>?` | `null` | Value change handler |
| `label` | `String?` | `null` | Label text |
| `error` | `String?` | `null` | Error message |
| `disabled` | `bool` | `false` | Disable interaction |
| `size` | `FormattedInputSize` | `md` | Size variant |

## Custom Format

```dart
ArcaneFormattedInput(
  initialValue: FormattedValue([
    InputPart.editable(length: 3, width: 45, placeholder: 'XXX'),
    InputPart.static('-'),
    InputPart.editable(length: 3, width: 45, placeholder: 'XXX'),
    InputPart.static('-'),
    InputPart.editable(length: 4, width: 55, placeholder: 'XXXX'),
  ]),
  label: 'Social Security Number',
  onChanged: (value) => handleSSNChange(value),
)
```

## With Error State

```dart
ArcaneFormattedInput.date(
  label: 'Expiration Date',
  error: 'Card has expired',
  onChanged: (value) => validateExpiration(value),
)
```

## Size Variants

```dart
ArcaneFormattedInput.date(
  label: 'Small',
  size: FormattedInputSize.sm,
  onChanged: (_) {},
)

ArcaneFormattedInput.date(
  label: 'Large',
  size: FormattedInputSize.lg,
  onChanged: (_) {},
)
```

## Related Components

- [ArcaneTimePicker](/arcane_jaspr/docs/inputs/arcane-time-picker) - Time selection dropdown
- [ArcaneDatePicker](/arcane_jaspr/docs/inputs/arcane-date-picker) - Calendar date picker
- [ArcaneTextInput](/arcane_jaspr/docs/inputs/arcane-text-input) - Single-field text input
