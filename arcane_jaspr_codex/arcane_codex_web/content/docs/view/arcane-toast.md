---
title: ArcaneToast
description: Toast notification system with global API
layout: docs
component: toast
---

# ArcaneToast

A toast notification system with a simple global API. Supports all variants (info, success, warning, error, loading) with configurable positioning and action buttons.

**Aliases:** `ArcaneToast`, `AToast`

## Setup

Add the toast container once at the root of your app:

```dart
ArcaneToast.container(
  position: ToastPosition.bottomRight,
)
```

## Basic Usage

Use the global `toast` accessor anywhere in your app:

```dart
// Info toast
toast.info('This is an info message');

// Success toast
toast.success('Item saved successfully');

// Warning toast
toast.warning('Please review your input');

// Error toast
toast.error('Something went wrong');

// Loading toast (no auto-dismiss)
toast.loading('Processing...');
```

## Container Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `position` | `ToastPosition` | `bottomRight` | Screen position |
| `gap` | `double` | `12` | Gap between toasts |
| `maxVisible` | `int` | `3` | Maximum visible toasts |
| `offset` | `double` | `20` | Distance from screen edge |

## Toast Positions

```dart
ArcaneToast.container(position: ToastPosition.topLeft)
ArcaneToast.container(position: ToastPosition.topCenter)
ArcaneToast.container(position: ToastPosition.topRight)
ArcaneToast.container(position: ToastPosition.bottomLeft)
ArcaneToast.container(position: ToastPosition.bottomCenter)
ArcaneToast.container(position: ToastPosition.bottomRight) // default
```

## With Title and Description

```dart
toast.success(
  'Changes saved',
  title: 'Success',
  description: 'Your profile has been updated.',
);
```

## With Action Button

```dart
toast.info(
  'Item deleted',
  action: ToastAction(
    label: 'Undo',
    onPressed: () => undoDelete(),
  ),
);

// Destructive action
toast.error(
  'Failed to save',
  action: ToastAction(
    label: 'Delete Draft',
    onPressed: () => deleteDraft(),
    destructive: true,
  ),
);
```

## Loading Toast

```dart
// Show loading toast
final id = toast.loading('Uploading file...');

// Later, update it to success
ToastManager.instance.update(id, (t) => t.copyWith(
  message: 'Upload complete!',
  variant: ToastVariant.success,
  duration: 4000,
  dismissible: true,
));

// Or dismiss it
toast.dismiss(id);
```

## Promise Toast

Automatically updates based on async result:

```dart
toast.promise(
  saveData(),
  loading: 'Saving...',
  success: (result) => 'Saved ${result.name}!',
  error: (e) => 'Failed: ${e.message}',
);
```

## Custom Duration

Duration is in milliseconds:

```dart
// Quick toast (2 seconds)
toast.info('Quick message', duration: 2000);

// Default durations:
// - info/success: 4000ms
// - warning: 5000ms
// - error: 6000ms
// - loading: 0 (no auto-dismiss)
```

## Per-Toast Positioning

Override the default position for individual toasts:

```dart
toast.error(
  'Critical error!',
  position: ToastPosition.topCenter,
);
```

## Dismissing Toasts

```dart
// Get toast ID from any toast method
final id = toast.success('Saved!');

// Dismiss specific toast
toast.dismiss(id);

// Dismiss all toasts
toast.dismissAll();
```

## Custom Icon

```dart
toast.success(
  'Copied to clipboard',
  icon: ArcaneIcon.copy(size: IconSize.md),
);
```

## Standalone Toast Component

For controlled usage without the global API:

```dart
ArcaneToast(
  message: 'Operation completed successfully',
  variant: ToastVariant.success,
  onClose: () => print('Toast closed'),
)
```

### Component Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `message` | `String` | required | Toast message |
| `title` | `String?` | `null` | Optional title above message |
| `description` | `String?` | `null` | Optional description below message |
| `variant` | `ToastVariant` | `info` | Visual variant |
| `position` | `ToastPosition` | `bottomRight` | Screen position |
| `duration` | `int` | `4000` | Auto-dismiss in ms (0 = never) |
| `dismissible` | `bool` | `true` | Show close button |
| `action` | `ToastAction?` | `null` | Action button |
| `icon` | `Component?` | `null` | Custom icon |
| `onClose` | `Function?` | `null` | Callback when closed |

## All Variants

- **info** - Blue accent, info circle icon
- **success** - Green accent, checkmark icon
- **warning** - Yellow/orange accent, warning triangle icon
- **error** - Red accent, X icon
- **loading** - Accent color, animated spinner icon

## Static Site Support

The JavaScript fallback system fully supports all features:
- Creates toaster container dynamically
- Proper variant-specific colors and SVG icons
- Progress bar with hover pause
- Auto-dismiss with configurable duration
- Action buttons with callbacks
- Respects positioning settings

Demo buttons containing "Success", "Error", "Warning", "Info", or "Loading" text automatically trigger toasts.

## Example: Form Submission

```dart
void submitForm() {
  toast.promise(
    saveFormData(),
    loading: 'Submitting form...',
    success: (_) => 'Form submitted successfully!',
    error: (e) => 'Failed to submit: ${e.message}',
  );
}
```

## Example: Undo Action

```dart
void deleteItem(Item item) {
  removeItem(item);
  toast.info(
    '${item.name} deleted',
    action: ToastAction(
      label: 'Undo',
      onPressed: () => restoreItem(item),
    ),
  );
}
```

## Example: Manual Dismiss Required

For critical notifications that require user acknowledgment:

```dart
// Acknowledgment required - no auto-dismiss, no close button
ArcaneToast(
  title: 'Session Warning',
  message: 'Your session will expire in 5 minutes.',
  variant: ToastVariant.warning,
  duration: 0,           // No auto-dismiss
  dismissible: false,    // No close button
  action: ToastAction(
    label: 'OK',
    onPressed: () => dismissToast(),
  ),
)

// Destructive confirmation
ArcaneToast(
  title: 'Are you sure?',
  message: 'This action cannot be undone.',
  variant: ToastVariant.error,
  duration: 0,
  dismissible: false,
  action: ToastAction(
    label: 'I Understand',
    onPressed: () => proceedWithAction(),
    destructive: true,
  ),
)
```

## Related Components

- [ArcaneAlertBanner](/arcane_jaspr/docs/feedback/arcane-alert-banner) - Inline alerts
