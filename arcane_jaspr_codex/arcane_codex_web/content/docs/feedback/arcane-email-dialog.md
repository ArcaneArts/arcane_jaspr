---
title: ArcaneEmailDialog
description: Dialog for collecting email addresses with validation
layout: docs
component: email-dialog
---

# ArcaneEmailDialog

A dialog component for collecting email addresses with built-in validation.

## Basic Usage

```dart
ArcaneEmailDialog(
  isOpen: showEmailDialog,
  onClose: () => setState(() => showEmailDialog = false),
  onSubmit: (email) {
    print('Email submitted: $email');
    setState(() => showEmailDialog = false);
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `isOpen` | `bool` | required | Whether dialog is visible |
| `onClose` | `VoidCallback?` | `null` | Close handler |
| `onSubmit` | `ValueChanged<String>` | required | Submit handler |
| `title` | `String` | `'Enter Email'` | Dialog title |
| `description` | `String?` | `null` | Description text |
| `placeholder` | `String` | `'you@example.com'` | Input placeholder |
| `submitLabel` | `String` | `'Submit'` | Submit button text |
| `cancelLabel` | `String` | `'Cancel'` | Cancel button text |

## With Custom Text

```dart
ArcaneEmailDialog(
  isOpen: showDialog,
  title: 'Subscribe to Newsletter',
  description: 'Get weekly updates delivered to your inbox.',
  placeholder: 'your.email@example.com',
  submitLabel: 'Subscribe',
  onClose: () => close(),
  onSubmit: (email) => subscribe(email),
)
```

## Examples

### Password Reset

```dart
ArcaneButton.secondary(
  label: 'Forgot Password?',
  onPressed: () => setState(() => showResetDialog = true),
),
ArcaneEmailDialog(
  isOpen: showResetDialog,
  title: 'Reset Password',
  description: 'Enter your email to receive a password reset link.',
  submitLabel: 'Send Reset Link',
  onClose: () => setState(() => showResetDialog = false),
  onSubmit: (email) {
    sendResetEmail(email);
    setState(() => showResetDialog = false);
  },
)
```

### Invite User

```dart
ArcaneEmailDialog(
  isOpen: showInviteDialog,
  title: 'Invite Team Member',
  description: 'They will receive an invitation email.',
  submitLabel: 'Send Invite',
  onClose: () => close(),
  onSubmit: (email) => sendInvite(email),
)
```

## Related Components

- [ArcaneDialog](/arcane_jaspr/docs/feedback/arcane-dialog) - Generic dialog
- [ArcaneTimeDialog](/arcane_jaspr/docs/feedback/arcane-time-dialog) - Time picker dialog
- [ArcaneTextInput](/arcane_jaspr/docs/inputs/arcane-text-input) - Text input component
