---
title: ArcaneForgotPasswordCard
description: Password reset request UI
layout: docs
component: forgot-password-card
---

# ArcaneForgotPasswordCard

A password reset request UI that sends a reset link to the user's email address via Firebase Authentication.

## Basic Usage

```dart
ArcaneForgotPasswordCard(
  loginRoute: '/login',
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `header` | `Component?` | `null` | Header component (logo, title) |
| `loginRoute` | `String?` | `null` | Route for back to login link |
| `onSuccess` | `VoidCallback?` | `null` | Callback when email is sent |
| `maxWidth` | `String` | `'400px'` | Max width of the card |

## Examples

### Basic

```dart
ArcaneForgotPasswordCard(
  loginRoute: '/login',
)
```

### With Header

```dart
ArcaneForgotPasswordCard(
  header: ArcaneColumn(
    gapSize: Gap.sm,
    children: [
      ArcaneIcon.settings(size: IconSize.xl2),
      ArcaneText('Reset Password', weight: FontWeight.bold),
    ],
  ),
  loginRoute: '/login',
)
```

### With Success Callback

```dart
ArcaneForgotPasswordCard(
  loginRoute: '/login',
  onSuccess: () {
    // Show success toast or navigate
    showToast('Check your email for the reset link');
  },
)
```

## States

The card has two states:

### Input State
- Shows email input field
- Submit button: "Send reset link"
- Back to login link

### Success State
- Shows success message with the email address
- "Try another email" button to reset
- Back to login link

## Features

- **Email validation** - Validates email before sending
- **Loading state** - Shows spinner during API call
- **Success confirmation** - Displays which email received the link
- **Error display** - Shows Firebase error messages
- **Try again** - Allows entering a different email

## Context Extensions

```dart
// Send password reset email
context.sendPasswordResetEmail(email)
```

## Related Components

- [ArcaneLoginCard](/arcane_jaspr/docs/auth/arcane-login-card) - Login form
- [ArcaneSignupCard](/arcane_jaspr/docs/auth/arcane-signup-card) - Registration form
