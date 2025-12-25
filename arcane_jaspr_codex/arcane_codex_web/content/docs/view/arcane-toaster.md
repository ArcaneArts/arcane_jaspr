---
title: ArcaneToaster
description: Toast notification system with Sonner-style API
layout: docs
component: toaster
---

# ArcaneToaster

A toast notification system inspired by Sonner. Provides a simple API for showing temporary notifications with support for different variants, actions, and promise-based toasts.

## Setup

Add the Toaster component once at the root of your app:

```dart
ArcaneApp(
  child: ArcaneStack(
    children: [
      // Your app content
      MyApp(),
      // Toaster overlay
      ArcaneToaster(),
    ],
  ),
)
```

## Basic Usage

Use the global `toast` accessor to show notifications:

```dart
// Simple info toast
toast.info('This is an info message');

// Success toast
toast.success('Item saved successfully');

// Warning toast
toast.warning('Please review your input');

// Error toast
toast.error('Something went wrong');
```

## Toast Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `position` | `ToastPosition` | `bottomRight` | Screen position |
| `gap` | `double` | `8` | Gap between toasts |
| `maxVisible` | `int` | `3` | Maximum visible toasts |
| `expandable` | `bool` | `true` | Show expand button when queued |
| `offset` | `double` | `16` | Distance from screen edge |

## Variants

### With Title

```dart
toast.success(
  'Changes saved',
  title: 'Success',
  description: 'Your profile has been updated.',
);
```

### With Action

```dart
toast.info(
  'Item deleted',
  action: ToastAction(
    label: 'Undo',
    onPressed: () => undoDelete(),
  ),
);
```

### Loading Toast

```dart
final id = toast.loading('Uploading file...');

// Later, update it
ToastManager.instance.update(id, (t) => t.copyWith(
  message: 'Upload complete!',
  variant: ToastVariant.success,
));
```

### Promise Toast

Automatically updates based on async result:

```dart
toast.promise(
  saveData(),
  loading: 'Saving...',
  success: (result) => 'Saved successfully!',
  error: (e) => 'Failed to save: $e',
);
```

## Positions

```dart
ArcaneToaster(position: ToastPosition.topRight)
ArcaneToaster(position: ToastPosition.topCenter)
ArcaneToaster(position: ToastPosition.topLeft)
ArcaneToaster(position: ToastPosition.bottomRight)
ArcaneToaster(position: ToastPosition.bottomCenter)
ArcaneToaster(position: ToastPosition.bottomLeft)
```

## Dismissing Toasts

```dart
// Dismiss specific toast
toast.dismiss(toastId);

// Dismiss all
toast.dismissAll();
```

## Custom Duration

```dart
toast.info(
  'Quick message',
  duration: 2000, // 2 seconds
);

toast.error(
  'Important error',
  duration: 10000, // 10 seconds
);

toast.loading(
  'Processing...',
  // duration: 0 means no auto-dismiss
);
```

## Accessibility

- Uses ARIA live regions for screen readers
- Proper role="alert" attributes
- Keyboard-dismissible
- Focus management for action buttons
