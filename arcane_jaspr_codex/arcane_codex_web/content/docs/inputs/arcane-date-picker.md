---
title: ArcaneDatePicker
description: Date picker input with calendar dropdown
layout: docs
component: date-picker
---

# ArcaneDatePicker

Date picker that combines an input field with a calendar dropdown.

## Basic Usage

```dart
ArcaneDatePicker(
  value: selectedDate,
  onChanged: (date) => setState(() => selectedDate = date),
  label: 'Birth Date',
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `DateTime?` | - | Currently selected date |
| `onChanged` | `Function(DateTime?)?` | - | Called when date changes |
| `label` | `String?` | - | Label above input |
| `placeholder` | `String?` | - | Placeholder text |
| `formatDate` | `Function(DateTime)?` | - | Custom date formatter |
| `minDate` | `DateTime?` | - | Minimum selectable date |
| `maxDate` | `DateTime?` | - | Maximum selectable date |
| `disabledDates` | `Function(DateTime)?` | - | Custom disabled dates |
| `disabled` | `bool` | `false` | Disable picker |
| `error` | `String?` | - | Error message |
| `clearable` | `bool` | `true` | Allow clearing selection |
| `size` | `DatePickerSize` | `md` | Size variant |

## With Placeholder

```dart
ArcaneDatePicker(
  value: appointmentDate,
  onChanged: (date) => setState(() => appointmentDate = date),
  placeholder: 'Choose appointment date',
)
```

## Date Range Picker

```dart
ArcaneDatePicker.range(
  rangeValue: dateRange,
  onRangeChanged: (range) => setState(() => dateRange = range),
  label: 'Trip Dates',
)
```

## Custom Formatting

```dart
ArcaneDatePicker(
  value: selectedDate,
  onChanged: (date) => setState(() => selectedDate = date),
  formatDate: (date) => '${date.day}/${date.month}/${date.year}',
)
```

## With Constraints

```dart
ArcaneDatePicker(
  value: selectedDate,
  onChanged: (date) => setState(() => selectedDate = date),
  minDate: DateTime.now(),
  maxDate: DateTime.now().add(Duration(days: 365)),
  label: 'Future Date',
)
```

## Sizes

```dart
ArcaneDatePicker(value: date, size: DatePickerSize.sm)
ArcaneDatePicker(value: date, size: DatePickerSize.md)
ArcaneDatePicker(value: date, size: DatePickerSize.lg)
```

## Features

- Calendar popup for date selection
- Date range picker variant
- Custom date formatting
- Clearable selection
- Min/max date constraints
- Size variants
