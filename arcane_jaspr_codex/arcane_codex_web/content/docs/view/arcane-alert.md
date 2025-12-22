---
title: ArcaneAlert
description: Inline alert for status messages
layout: docs
component: alert
---

# ArcaneAlert

An inline alert component for displaying status messages, notifications, or feedback within content.

## Basic Usage

```dart
ArcaneAlert(
  title: 'Success',
  message: 'Your changes have been saved.',
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `title` | `String?` | `null` | Alert title |
| `message` | `String` | required | Alert message |
| `severity` | `AlertSeverity` | `info` | Severity level |
| `style` | `AlertStyle` | `subtle` | Visual style |
| `icon` | `Component?` | `null` | Custom icon |
| `actions` | `List<Component>?` | `null` | Action buttons |
| `dismissible` | `bool` | `false` | Can be dismissed |
| `onDismiss` | `VoidCallback?` | `null` | Dismiss callback |

## Severity Levels

```dart
// Info (default)
ArcaneAlert(
  severity: AlertSeverity.info,
  message: 'This is an informational message.',
)

// Success
ArcaneAlert(
  severity: AlertSeverity.success,
  message: 'Operation completed successfully.',
)

// Warning
ArcaneAlert(
  severity: AlertSeverity.warning,
  message: 'Please review before continuing.',
)

// Error
ArcaneAlert(
  severity: AlertSeverity.error,
  message: 'An error occurred.',
)
```

## Style Variants

```dart
// Subtle (default)
ArcaneAlert(
  style: AlertStyle.subtle,
  message: 'Subtle alert style.',
)

// Solid
ArcaneAlert(
  style: AlertStyle.solid,
  message: 'Solid alert style.',
)

// Outline
ArcaneAlert(
  style: AlertStyle.outline,
  message: 'Outline alert style.',
)

// Accent
ArcaneAlert(
  style: AlertStyle.accent,
  message: 'Accent border style.',
)
```

## With Title

```dart
ArcaneAlert(
  title: 'Account Updated',
  message: 'Your profile information has been saved.',
  severity: AlertSeverity.success,
)
```

## Dismissible

```dart
ArcaneAlert(
  title: 'New Feature',
  message: 'Check out our latest update!',
  dismissible: true,
  onDismiss: () => setState(() => showAlert = false),
)
```

## With Actions

```dart
ArcaneAlert(
  title: 'Session Expiring',
  message: 'Your session will expire in 5 minutes.',
  severity: AlertSeverity.warning,
  actions: [
    ArcaneButton.secondary(
      label: 'Extend Session',
      onPressed: extendSession,
    ),
  ],
)
```

## Factory Constructors

```dart
// Info alert
ArcaneAlert.info(message: 'Information message')

// Success alert
ArcaneAlert.success(message: 'Success message')

// Warning alert
ArcaneAlert.warning(message: 'Warning message')

// Error alert
ArcaneAlert.error(message: 'Error message')
```

## Examples

### Form Validation

```dart
if (formErrors.isNotEmpty)
  ArcaneAlert.error(
    title: 'Validation Failed',
    message: 'Please correct the errors below.',
  ),
```

### Success Message

```dart
if (saveSuccessful)
  ArcaneAlert.success(
    title: 'Saved!',
    message: 'Your changes have been saved successfully.',
    dismissible: true,
    onDismiss: clearMessage,
  ),
```

## Related Components

- [ArcaneCallout](/arcane_jaspr/docs/view/arcane-callout) - Callout notice
- [ArcaneAlertBanner](/arcane_jaspr/docs/feedback/arcane-alert-banner) - Top banner alert
- [ArcaneToast](/arcane_jaspr/docs/view/arcane-toast) - Toast notification
