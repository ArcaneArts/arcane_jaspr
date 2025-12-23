---
title: GithubSignInButton
description: Branded GitHub OAuth sign-in button
layout: docs
component: github-button
---

# GithubSignInButton

A branded GitHub OAuth sign-in button with the official GitHub styling.

## Basic Usage

```dart
GithubSignInButton(
  onPressed: () => context.signInWithGitHub(),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `onPressed` | `VoidCallback?` | `null` | Click handler (defaults to context.signInWithGitHub()) |
| `label` | `String` | `'Continue with GitHub'` | Button label text |
| `size` | `ButtonSize` | `ButtonSize.medium` | Button size |
| `fullWidth` | `bool` | `false` | Expand to full width |
| `disabled` | `bool` | `false` | Disable the button |
| `loading` | `bool` | `false` | Show loading spinner |

## Examples

### Default

```dart
GithubSignInButton()
```

### Full Width

```dart
GithubSignInButton(
  fullWidth: true,
)
```

### Custom Label

```dart
GithubSignInButton(
  label: 'Sign up with GitHub',
)
```

### With Loading State

```dart
GithubSignInButton(
  loading: isLoading,
  disabled: isLoading,
)
```

## Styling

The button uses GitHub's official brand colors:

- **Background**: `#24292e` (GitHub dark)
- **Text**: `#ffffff` (white)
- **Hover**: `#2f363d` (lighter dark)

The GitHub logo icon is included automatically.

## Context Integration

If no `onPressed` handler is provided, the button automatically calls:

```dart
context.signInWithGitHub()
```

This triggers the Firebase GitHub OAuth flow.

## Related Components

- [GoogleSignInButton](/arcane_jaspr/docs/auth/google-button) - Google OAuth button
- [AppleSignInButton](/arcane_jaspr/docs/auth/apple-button) - Apple OAuth button
- [ArcaneLoginCard](/arcane_jaspr/docs/auth/arcane-login-card) - Complete login UI
