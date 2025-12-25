---
title: ArcaneCalendar
description: Full calendar component for date selection
layout: docs
component: calendar
---

# ArcaneCalendar

Full calendar component for selecting dates with month navigation.

## Basic Usage

```dart
ArcaneCalendar(
  selected: selectedDate,
  onSelect: (date) => setState(() => selectedDate = date),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `selected` | `DateTime?` | - | Currently selected date |
| `onSelect` | `Function(DateTime)?` | - | Called when date selected |
| `month` | `DateTime?` | - | Month to display |
| `onMonthChange` | `Function(DateTime)?` | - | Called when month changes |
| `minDate` | `DateTime?` | - | Minimum selectable date |
| `maxDate` | `DateTime?` | - | Maximum selectable date |
| `disabledDates` | `Function(DateTime)?` | - | Custom disabled dates |
| `showWeekNumbers` | `bool` | `false` | Show week numbers |
| `showToday` | `bool` | `true` | Highlight today |
| `firstDayOfWeek` | `int` | `0` | 0=Sunday, 1=Monday |
| `mode` | `CalendarMode` | `single` | Selection mode |
| `selectedRange` | `DateRange?` | - | Selected range (range mode) |
| `onRangeSelect` | `Function(DateRange)?` | - | Range selection callback |

## Date Constraints

```dart
ArcaneCalendar(
  selected: selectedDate,
  onSelect: (date) => setState(() => selectedDate = date),
  minDate: DateTime.now(),
  maxDate: DateTime.now().add(Duration(days: 90)),
)
```

## Custom Disabled Dates

```dart
ArcaneCalendar(
  selected: selectedDate,
  onSelect: (date) => setState(() => selectedDate = date),
  disabledDates: (date) {
    // Disable weekends
    return date.weekday == DateTime.saturday ||
           date.weekday == DateTime.sunday;
  },
)
```

## Range Selection

```dart
ArcaneCalendar(
  mode: CalendarMode.range,
  selectedRange: dateRange,
  onRangeSelect: (range) => setState(() => dateRange = range),
)
```

## Week Numbers

```dart
ArcaneCalendar(
  selected: selectedDate,
  onSelect: (date) => setState(() => selectedDate = date),
  showWeekNumbers: true,
)
```

## Monday First

```dart
ArcaneCalendar(
  selected: selectedDate,
  onSelect: (date) => setState(() => selectedDate = date),
  firstDayOfWeek: 1, // Monday
)
```

## Features

- Month navigation with previous/next buttons
- Today button for quick navigation
- Single and range selection modes
- Date constraints (min/max)
- Custom disabled dates
- Week number display
- Configurable first day of week
