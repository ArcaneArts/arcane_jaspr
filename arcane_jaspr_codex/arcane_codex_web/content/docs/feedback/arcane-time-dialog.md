---
title: ArcaneTimeDialog
description: Dialog for time selection
layout: docs
component: time-dialog
---

# ArcaneTimeDialog

A dialog component for selecting a time value.

## Basic Usage

```dart
ArcaneTimeDialog(
  isOpen: showTimeDialog,
  onClose: () => setState(() => showTimeDialog = false),
  onConfirm: (time) {
    setState(() {
      selectedTime = time;
      showTimeDialog = false;
    });
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `isOpen` | `bool` | required | Whether dialog is visible |
| `onClose` | `VoidCallback?` | `null` | Close handler |
| `onConfirm` | `ValueChanged<TimeOfDay>` | required | Confirm handler |
| `initialTime` | `TimeOfDay?` | `null` | Initial selected time |
| `title` | `String` | `'Select Time'` | Dialog title |
| `confirmLabel` | `String` | `'Confirm'` | Confirm button text |
| `cancelLabel` | `String` | `'Cancel'` | Cancel button text |
| `use24Hour` | `bool` | `false` | Use 24-hour format |

## With Initial Time

```dart
ArcaneTimeDialog(
  isOpen: showDialog,
  initialTime: TimeOfDay(hour: 9, minute: 30),
  onClose: () => close(),
  onConfirm: (time) => selectTime(time),
)
```

## 24-Hour Format

```dart
ArcaneTimeDialog(
  isOpen: showDialog,
  use24Hour: true,
  title: 'Set Alarm',
  onClose: () => close(),
  onConfirm: (time) => setAlarm(time),
)
```

## Examples

### Schedule Meeting

```dart
ArcaneRow(
  gapSize: Gap.md,
  children: [
    ArcaneButton.secondary(
      label: 'Set Start Time',
      onPressed: () => setState(() => showStartDialog = true),
    ),
    ArcaneText(
      startTime != null
          ? '${startTime!.hour}:${startTime!.minute.toString().padLeft(2, '0')}'
          : 'Not set',
    ),
  ],
),
ArcaneTimeDialog(
  isOpen: showStartDialog,
  title: 'Meeting Start Time',
  initialTime: startTime,
  onClose: () => setState(() => showStartDialog = false),
  onConfirm: (time) {
    setState(() {
      startTime = time;
      showStartDialog = false;
    });
  },
)
```

### Reminder Setup

```dart
ArcaneTimeDialog(
  isOpen: showReminderDialog,
  title: 'Daily Reminder',
  use24Hour: true,
  confirmLabel: 'Set Reminder',
  onClose: () => close(),
  onConfirm: (time) => scheduleReminder(time),
)
```

## Related Components

- [ArcaneTimePicker](/arcane_jaspr/docs/inputs/arcane-time-picker) - Inline time picker
- [ArcaneEmailDialog](/arcane_jaspr/docs/feedback/arcane-email-dialog) - Email input dialog
- [ArcaneDialog](/arcane_jaspr/docs/feedback/arcane-dialog) - Generic dialog
