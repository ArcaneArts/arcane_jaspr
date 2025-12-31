---
title: ArcaneTimePicker
description: Time selection component with dropdown
layout: docs
component: time-picker
---

# ArcaneTimePicker

A styled time picker component for selecting hours and minutes.

## Basic Usage

```dart
ArcaneTimePicker(
  value: TimeOfDay(hour: 14, minute: 30),
  onChanged: (time) {
    print('Selected: ${time.hour}:${time.minute}');
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `TimeOfDay` | required | Currently selected time |
| `onChanged` | `ValueChanged<TimeOfDay>?` | `null` | Time change handler |
| `label` | `String?` | `null` | Label text |
| `disabled` | `bool` | `false` | Disable interaction |
| `use24Hour` | `bool` | `false` | Use 24-hour format |

## With Label

```dart
ArcaneTimePicker(
  label: 'Start Time',
  value: startTime,
  onChanged: (time) => setState(() => startTime = time),
)
```

## 24-Hour Format

```dart
ArcaneTimePicker(
  label: 'Meeting Time',
  value: meetingTime,
  use24Hour: true,
  onChanged: (time) => setState(() => meetingTime = time),
)
```

## Disabled State

```dart
ArcaneTimePicker(
  label: 'Locked Time',
  value: TimeOfDay(hour: 9, minute: 0),
  disabled: true,
)
```

## Examples

### Schedule Form

```dart
ArcaneColumn(
  gapSize: Gap.lg,
  children: [
    ArcaneTimePicker(
      label: 'Start Time',
      value: startTime,
      onChanged: (t) => setState(() => startTime = t),
    ),
    ArcaneTimePicker(
      label: 'End Time',
      value: endTime,
      onChanged: (t) => setState(() => endTime = t),
    ),
    ArcaneButton.primary(
      label: 'Schedule',
      onPressed: () => scheduleEvent(startTime, endTime),
    ),
  ],
)
```

## Related Components

- [ArcaneFormattedInput](/arcane_jaspr/docs/inputs/arcane-formatted-input) - Formatted time input
- [ArcaneTimeDialog](/arcane_jaspr/docs/feedback/arcane-time-dialog) - Time picker in dialog
