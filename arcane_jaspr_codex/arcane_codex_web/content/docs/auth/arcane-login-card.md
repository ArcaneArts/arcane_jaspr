---
title: ArcaneLoginCard
description: Complete login UI with email/password and social sign-in
layout: docs
component: login-card
---

# ArcaneLoginCard

A complete login UI component with email/password form and social sign-in buttons. Integrates with Firebase Authentication via the auth context.

## Basic Usage

```dart
ArcaneLoginCard(
  methods: [AuthMethod.email, AuthMethod.github, AuthMethod.google],
  signupRoute: '/signup',
  forgotPasswordRoute: '/forgot-password',
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `methods` | `List<AuthMethod>` | `[email, github, google]` | Authentication methods to display |
| `header` | `Component?` | `null` | Header component (logo, title) |
| `signupRoute` | `String?` | `null` | Route for signup link |
| `forgotPasswordRoute` | `String?` | `null` | Route for forgot password link |
| `passwordPolicy` | `PasswordPolicy?` | `null` | Password validation policy |
| `onSuccess` | `VoidCallback?` | `null` | Callback when login succeeds |
| `maxWidth` | `String` | `'400px'` | Max width of the card |

## AuthMethod Options

```dart
// Email/password authentication
AuthMethod.email

// OAuth providers
AuthMethod.github
AuthMethod.google
AuthMethod.apple
```

## Examples

### Email Only

```dart
ArcaneLoginCard(
  methods: [AuthMethod.email],
  signupRoute: '/signup',
  forgotPasswordRoute: '/forgot-password',
)
```

### Social Only

```dart
ArcaneLoginCard(
  methods: [AuthMethod.github, AuthMethod.google, AuthMethod.apple],
  signupRoute: '/signup',
)
```

### With Custom Header

```dart
ArcaneLoginCard(
  header: ArcaneColumn(
    gapSize: Gap.sm,
    children: [
      ArcaneIcon.home(size: IconSize.xl2),
      ArcaneText('MyApp', weight: FontWeight.bold),
    ],
  ),
  methods: [AuthMethod.email, AuthMethod.github],
  signupRoute: '/signup',
)
```

### With Success Callback

```dart
ArcaneLoginCard(
  methods: [AuthMethod.email],
  onSuccess: () {
    // Navigate to dashboard
    context.go('/dashboard');
  },
)
```

## Features

- **Social sign-in buttons** - GitHub, Google, Apple with branded styling
- **Email/password form** - Built-in validation and error handling
- **Loading states** - Shows loading spinner during authentication
- **Error display** - Shows error messages from auth failures
- **Navigation links** - Links to signup and forgot password pages
- **Firebase integration** - Uses `context.signInWithEmail()` and OAuth methods

## Context Extensions

The login card uses these auth context extensions:

```dart
// Email sign-in
context.signInWithEmail(email, password)

// OAuth sign-in (triggered by social buttons)
context.signInWithGitHub()
context.signInWithGoogle()
context.signInWithApple()
```

## Related Components

- [ArcaneSignupCard](/arcane_jaspr/docs/auth/arcane-signup-card) - Registration form
- [ArcaneForgotPasswordCard](/arcane_jaspr/docs/auth/arcane-forgot-password-card) - Password reset
- [AuthSplitLayout](/arcane_jaspr/docs/auth/auth-split-layout) - Split-screen auth layout
