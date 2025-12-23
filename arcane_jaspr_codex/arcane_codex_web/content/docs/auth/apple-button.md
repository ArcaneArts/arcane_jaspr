---
title: AppleSignInButton
description: Branded Apple Sign-In button
layout: docs
component: apple-button
---

# AppleSignInButton

A branded Apple Sign-In button following Apple's Human Interface Guidelines.

## Basic Usage

```dart
AppleSignInButton(
  onPressed: () => context.signInWithApple(),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `onPressed` | `VoidCallback?` | `null` | Click handler (defaults to context.signInWithApple()) |
| `label` | `String` | `'Continue with Apple'` | Button label text |
| `size` | `ButtonSize` | `ButtonSize.medium` | Button size |
| `fullWidth` | `bool` | `false` | Expand to full width |
| `disabled` | `bool` | `false` | Disable the button |
| `loading` | `bool` | `false` | Show loading spinner |

## Examples

### Default

```dart
AppleSignInButton()
```

### Full Width

```dart
AppleSignInButton(
  fullWidth: true,
)
```

### Custom Label

```dart
AppleSignInButton(
  label: 'Sign up with Apple',
)
```

### With Loading State

```dart
AppleSignInButton(
  loading: isLoading,
  disabled: isLoading,
)
```

## Styling

The button uses Apple's official brand colors:

- **Background**: `#000000` (black)
- **Text**: `#ffffff` (white)
- **Hover**: `#1a1a1a` (lighter black)

The Apple logo icon is included automatically.

## Requirements

Apple Sign-In requires additional setup in your Apple Developer account:
- Enable Sign in with Apple capability
- Configure Services IDs
- Set up domain verification

## Context Integration

If no `onPressed` handler is provided, the button automatically calls:

```dart
context.signInWithApple()
```

This triggers the Firebase Apple OAuth flow.

## Related Components

- [GithubSignInButton](/arcane_jaspr/docs/auth/github-button) - GitHub OAuth button
- [GoogleSignInButton](/arcane_jaspr/docs/auth/google-button) - Google OAuth button
- [ArcaneLoginCard](/arcane_jaspr/docs/auth/arcane-login-card) - Complete login UI
