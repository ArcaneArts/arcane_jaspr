---
title: ArcaneToast
description: Temporary notification message
layout: docs
component: toast
---

# ArcaneToast

A toast notification component for displaying temporary messages to users.

## Basic Usage

```dart
ArcaneToast.show(
  context,
  message: 'Changes saved successfully',
)
```

## Toast Types

```dart
// Success
ArcaneToast.success(context, message: 'Saved successfully')

// Error
ArcaneToast.error(context, message: 'Something went wrong')

// Warning
ArcaneToast.warning(context, message: 'Please check your input')

// Info
ArcaneToast.info(context, message: 'New update available')
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `message` | `String` | required | Toast message |
| `variant` | `ToastVariant` | `default_` | Toast type |
| `duration` | `Duration` | `4s` | Display duration |
| `position` | `ToastPosition` | `bottomRight` | Screen position |
| `action` | `ToastAction?` | `null` | Action button |
| `icon` | `Component?` | `null` | Custom icon |
| `dismissible` | `bool` | `true` | Show close button |

## Positions

```dart
// Bottom right (default)
ArcaneToast.show(
  context,
  message: 'Message',
  position: ToastPosition.bottomRight,
)

// Bottom left
ArcaneToast.show(
  context,
  message: 'Message',
  position: ToastPosition.bottomLeft,
)

// Top right
ArcaneToast.show(
  context,
  message: 'Message',
  position: ToastPosition.topRight,
)

// Top left
ArcaneToast.show(
  context,
  message: 'Message',
  position: ToastPosition.topLeft,
)

// Top center
ArcaneToast.show(
  context,
  message: 'Message',
  position: ToastPosition.topCenter,
)

// Bottom center
ArcaneToast.show(
  context,
  message: 'Message',
  position: ToastPosition.bottomCenter,
)
```

## With Action

```dart
ArcaneToast.show(
  context,
  message: 'File deleted',
  action: ToastAction(
    label: 'Undo',
    onPressed: undoDelete,
  ),
)
```

## Custom Duration

```dart
ArcaneToast.show(
  context,
  message: 'Quick message',
  duration: Duration(seconds: 2),
)

// Persistent (no auto-dismiss)
ArcaneToast.show(
  context,
  message: 'Important message',
  duration: Duration.zero,
)
```

## Examples

### Form Submission

```dart
void submitForm() async {
  try {
    await saveData();
    ArcaneToast.success(
      context,
      message: 'Form submitted successfully!',
    );
  } catch (e) {
    ArcaneToast.error(
      context,
      message: 'Failed to submit form. Please try again.',
      action: ToastAction(
        label: 'Retry',
        onPressed: submitForm,
      ),
    );
  }
}
```

### Copy to Clipboard

```dart
void copyToClipboard(String text) {
  clipboard.write(text);
  ArcaneToast.success(
    context,
    message: 'Copied to clipboard',
    icon: span([text('📋')]),
    duration: Duration(seconds: 2),
  );
}
```

### Undo Action

```dart
void deleteItem(Item item) {
  removeItem(item);
  ArcaneToast.show(
    context,
    message: 'Item deleted',
    action: ToastAction(
      label: 'Undo',
      onPressed: () => restoreItem(item),
    ),
  );
}
```

### Network Status

```dart
void showOfflineToast() {
  ArcaneToast.warning(
    context,
    message: 'You are offline. Some features may be limited.',
    position: ToastPosition.topCenter,
    duration: Duration.zero, // Stay until dismissed
  );
}
```

### Multiple Toasts

```dart
void processItems(List<Item> items) async {
  for (var item in items) {
    try {
      await process(item);
      ArcaneToast.success(
        context,
        message: 'Processed ${item.name}',
        duration: Duration(seconds: 2),
      );
    } catch (e) {
      ArcaneToast.error(
        context,
        message: 'Failed to process ${item.name}',
      );
    }
  }
}
```

### Update Available

```dart
void showUpdateToast() {
  ArcaneToast.info(
    context,
    message: 'A new version is available',
    position: ToastPosition.topCenter,
    action: ToastAction(
      label: 'Update now',
      onPressed: performUpdate,
    ),
  );
}
```

## Toast Container

To use toasts, wrap your app with `ArcaneToastContainer`:

```dart
ArcaneApp(
  child: ArcaneToastContainer(
    child: YourApp(),
  ),
)
```

## Related Components

- [ArcaneAlertBanner](/docs/feedback/arcane-alert-banner) - Inline alerts
- [ArcaneDialog](/docs/feedback/arcane-dialog) - Modal dialogs
