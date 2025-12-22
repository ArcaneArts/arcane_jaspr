---
title: ArcaneCallout
description: Inline notice box for important information
layout: docs
component: callout
---

# ArcaneCallout

A callout component for displaying important notices, tips, warnings, or other contextual information inline with content.

## Basic Usage

```dart
ArcaneCallout(
  title: 'Note',
  content: 'This is an important callout message.',
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `title` | `String?` | `null` | Callout title |
| `content` | `String` | required | Callout message |
| `style` | `CalloutStyle` | `info` | Visual style |
| `icon` | `Component?` | `null` | Custom icon |
| `dismissible` | `bool` | `false` | Can be dismissed |
| `onDismiss` | `VoidCallback?` | `null` | Dismiss callback |

## Style Variants

```dart
// Info (default)
ArcaneCallout(
  style: CalloutStyle.info,
  content: 'This is informational content.',
)

// Success
ArcaneCallout(
  style: CalloutStyle.success,
  content: 'Operation completed successfully.',
)

// Warning
ArcaneCallout(
  style: CalloutStyle.warning,
  content: 'Please review before continuing.',
)

// Error
ArcaneCallout(
  style: CalloutStyle.error,
  content: 'An error occurred.',
)

// Neutral
ArcaneCallout(
  style: CalloutStyle.neutral,
  content: 'General information.',
)

// Tip
ArcaneCallout(
  style: CalloutStyle.tip,
  content: 'Pro tip: Use keyboard shortcuts.',
)

// Note
ArcaneCallout(
  style: CalloutStyle.note,
  content: 'Note: This feature is in beta.',
)
```

## With Title

```dart
ArcaneCallout(
  title: 'Important',
  content: 'Please save your work before closing.',
  style: CalloutStyle.warning,
)
```

## Dismissible

```dart
ArcaneCallout(
  title: 'Welcome!',
  content: 'Check out our new features.',
  dismissible: true,
  onDismiss: () => setState(() => showWelcome = false),
)
```

## Factory Constructors

```dart
// Info
ArcaneCallout.info(
  title: 'Did you know?',
  content: 'You can customize your dashboard.',
)

// Tip
ArcaneCallout.tip(
  content: 'Use Ctrl+S to save quickly.',
)

// Warning
ArcaneCallout.warning(
  title: 'Attention',
  content: 'This action cannot be undone.',
)

// Error
ArcaneCallout.error(
  content: 'Failed to load data.',
)
```

## Examples

### Documentation Callout

```dart
ArcaneColumn(
  gapSize: Gap.md,
  children: [
    ArcaneParagraph(
      text: 'To get started, install the package:',
    ),
    ArcaneCodeSnippet(code: 'dart pub add arcane_jaspr'),
    ArcaneCallout.tip(
      content: 'You can also add it to your pubspec.yaml manually.',
    ),
  ],
)
```

### Form Validation

```dart
if (hasErrors)
  ArcaneCallout.error(
    title: 'Validation Error',
    content: 'Please fix the errors below before submitting.',
  ),
```

## Related Components

- [ArcaneAlert](/arcane_jaspr/docs/view/arcane-alert) - Inline alert
- [ArcaneAlertBanner](/arcane_jaspr/docs/feedback/arcane-alert-banner) - Top banner alert
