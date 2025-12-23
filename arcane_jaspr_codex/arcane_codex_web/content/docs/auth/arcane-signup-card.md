---
title: ArcaneSignupCard
description: Complete registration UI with validation and social sign-up
layout: docs
component: signup-card
---

# ArcaneSignupCard

A complete registration UI component with email/password form, password validation, terms acceptance, and social sign-up buttons.

## Basic Usage

```dart
ArcaneSignupCard(
  methods: [AuthMethod.email, AuthMethod.github, AuthMethod.google],
  loginRoute: '/login',
  termsUrl: '/terms',
  privacyUrl: '/privacy',
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `methods` | `List<AuthMethod>` | `[email, github, google]` | Authentication methods to display |
| `header` | `Component?` | `null` | Header component (logo, title) |
| `loginRoute` | `String?` | `null` | Route for login link |
| `passwordPolicy` | `PasswordPolicy` | `PasswordPolicy()` | Password validation rules |
| `termsUrl` | `String?` | `null` | Terms of service URL |
| `privacyUrl` | `String?` | `null` | Privacy policy URL |
| `onSuccess` | `VoidCallback?` | `null` | Callback when registration succeeds |
| `maxWidth` | `String` | `'400px'` | Max width of the card |

## Password Policies

```dart
// Custom policy
ArcaneSignupCard(
  passwordPolicy: PasswordPolicy(
    minLength: 8,
    requireUppercase: true,
    requireNumber: true,
    requireSpecialChar: true,
  ),
)

// Preset policies
ArcaneSignupCard(
  passwordPolicy: PasswordPolicy.weak,   // 6+ chars
)

ArcaneSignupCard(
  passwordPolicy: PasswordPolicy.medium, // 8+ chars, uppercase, number
)

ArcaneSignupCard(
  passwordPolicy: PasswordPolicy.strong, // 8+ chars, upper, lower, number, special
)
```

## Examples

### With Terms Acceptance

```dart
ArcaneSignupCard(
  methods: [AuthMethod.email],
  loginRoute: '/login',
  termsUrl: '/terms',
  privacyUrl: '/privacy',
  passwordPolicy: PasswordPolicy.medium,
)
```

### Social Only

```dart
ArcaneSignupCard(
  methods: [AuthMethod.github, AuthMethod.google],
  loginRoute: '/login',
)
```

### With Custom Header

```dart
ArcaneSignupCard(
  header: ArcaneColumn(
    gapSize: Gap.sm,
    children: [
      ArcaneIcon.home(size: IconSize.xl2),
      ArcaneText('Join MyApp', weight: FontWeight.bold),
    ],
  ),
  methods: [AuthMethod.email, AuthMethod.github],
  loginRoute: '/login',
)
```

## Form Fields

The signup card includes:

- **Name** - Display name field
- **Email** - Email address with validation
- **Password** - With policy hint displayed
- **Confirm Password** - Must match password
- **Terms Checkbox** - Only shown if termsUrl or privacyUrl is set

## Features

- **Password validation** - Real-time policy checking
- **Confirm password** - Ensures passwords match
- **Terms acceptance** - Optional checkbox for legal compliance
- **Social sign-up** - GitHub, Google, Apple buttons
- **Loading states** - Shows progress during registration
- **Error display** - Shows validation and server errors

## Context Extensions

```dart
// Email registration
context.registerWithEmail(email, password, displayName)

// OAuth (triggered by social buttons)
context.signInWithGitHub()
context.signInWithGoogle()
context.signInWithApple()
```

## Related Components

- [ArcaneLoginCard](/arcane_jaspr/docs/auth/arcane-login-card) - Login form
- [PasswordPolicy](/arcane_jaspr/docs/auth/password-policy) - Password validation
- [AuthSplitLayout](/arcane_jaspr/docs/auth/auth-split-layout) - Split-screen auth layout
