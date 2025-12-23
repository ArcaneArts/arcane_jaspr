---
title: GoogleSignInButton
description: Branded Google OAuth sign-in button
layout: docs
component: google-button
---

# GoogleSignInButton

A branded Google OAuth sign-in button following Google's brand guidelines.

## Basic Usage

```dart
GoogleSignInButton(
  onPressed: () => context.signInWithGoogle(),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `onPressed` | `VoidCallback?` | `null` | Click handler (defaults to context.signInWithGoogle()) |
| `label` | `String` | `'Continue with Google'` | Button label text |
| `size` | `ButtonSize` | `ButtonSize.medium` | Button size |
| `fullWidth` | `bool` | `false` | Expand to full width |
| `disabled` | `bool` | `false` | Disable the button |
| `loading` | `bool` | `false` | Show loading spinner |

## Examples

### Default

```dart
GoogleSignInButton()
```

### Full Width

```dart
GoogleSignInButton(
  fullWidth: true,
)
```

### Custom Label

```dart
GoogleSignInButton(
  label: 'Sign up with Google',
)
```

### With Loading State

```dart
GoogleSignInButton(
  loading: isLoading,
  disabled: isLoading,
)
```

## Styling

The button uses Google's official brand colors:

- **Background**: `#ffffff` (white)
- **Text**: `#1f1f1f` (dark gray)
- **Border**: `#dadce0` (light gray)
- **Hover**: `#f8f9fa` (light hover)

The multicolored Google "G" logo is included automatically.

## Context Integration

If no `onPressed` handler is provided, the button automatically calls:

```dart
context.signInWithGoogle()
```

This triggers the Firebase Google OAuth flow.

## Related Components

- [GithubSignInButton](/arcane_jaspr/docs/auth/github-button) - GitHub OAuth button
- [AppleSignInButton](/arcane_jaspr/docs/auth/apple-button) - Apple OAuth button
- [ArcaneLoginCard](/arcane_jaspr/docs/auth/arcane-login-card) - Complete login UI
