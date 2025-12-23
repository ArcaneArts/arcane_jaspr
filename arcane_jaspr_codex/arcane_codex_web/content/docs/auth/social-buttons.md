---
title: Social Sign-In Buttons
description: Pre-styled OAuth provider buttons for authentication
layout: docs
component: social-buttons
---

# Social Sign-In Buttons

Pre-styled, branded buttons for OAuth authentication with popular providers. All buttons follow consistent sizing, loading states, and accessibility patterns.

## Available Providers

### Primary Providers

```dart
// GitHub
GithubSignInButton(
  onPressed: () => signInWithGitHub(),
)

// Google
GoogleSignInButton(
  onPressed: () => signInWithGoogle(),
)

// Apple
AppleSignInButton(
  onPressed: () => signInWithApple(),
)

// Microsoft
MicrosoftSignInButton(
  onPressed: () => signInWithMicrosoft(),
)
```

### Social Providers

```dart
// Facebook
FacebookSignInButton(
  onPressed: () => signInWithFacebook(),
)

// Twitter/X
TwitterSignInButton(
  onPressed: () => signInWithTwitter(),
)

// LinkedIn
LinkedInSignInButton(
  onPressed: () => signInWithLinkedIn(),
)
```

### Developer Providers

```dart
// GitLab
GitLabSignInButton(
  onPressed: () => signInWithGitLab(),
)

// Discord
DiscordSignInButton(
  onPressed: () => signInWithDiscord(),
)

// Slack
SlackSignInButton(
  onPressed: () => signInWithSlack(),
)
```

## Common Properties

All social sign-in buttons share these properties:

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `onPressed` | `void Function()?` | `null` | Click handler |
| `label` | `String` | Provider-specific | Button text |
| `size` | `ButtonSize` | `medium` | Button size |
| `fullWidth` | `bool` | `false` | Expand to container width |
| `disabled` | `bool` | `false` | Disable the button |
| `loading` | `bool` | `false` | Show loading spinner |

## Sizes

```dart
// Small
GithubSignInButton(
  size: ButtonSize.small,
  onPressed: handleGitHub,
)

// Medium (default)
GithubSignInButton(
  size: ButtonSize.medium,
  onPressed: handleGitHub,
)

// Large
GithubSignInButton(
  size: ButtonSize.large,
  onPressed: handleGitHub,
)
```

## Full Width

```dart
ArcaneColumn(
  gapSize: Gap.sm,
  children: [
    GithubSignInButton(fullWidth: true, onPressed: handleGitHub),
    GoogleSignInButton(fullWidth: true, onPressed: handleGoogle),
    AppleSignInButton(fullWidth: true, onPressed: handleApple),
  ],
)
```

## Loading State

```dart
GithubSignInButton(
  loading: isLoading,
  onPressed: isLoading ? null : handleGitHub,
)
```

## Custom Labels

```dart
GithubSignInButton(
  label: 'Sign up with GitHub',
  onPressed: handleSignUp,
)

GoogleSignInButton(
  label: 'Link Google Account',
  onPressed: handleLink,
)
```

## Examples

### Login Form with Multiple Providers

```dart
ArcaneCard(
  child: ArcaneColumn(
    gapSize: Gap.md,
    children: [
      ArcaneHeading.h3(child: ArcaneText('Sign in')),

      // Email/password form
      ArcaneTextInput(label: 'Email'),
      ArcaneTextInput(label: 'Password', type: InputType.password),
      ArcaneButton.primary(
        label: 'Sign in',
        fullWidth: true,
        onPressed: handleEmailSignIn,
      ),

      // Divider
      ArcaneRow(
        children: [
          ArcaneDivider(),
          ArcaneText('or', color: TextColor.muted),
          ArcaneDivider(),
        ],
      ),

      // Social providers
      GithubSignInButton(fullWidth: true, onPressed: handleGitHub),
      GoogleSignInButton(fullWidth: true, onPressed: handleGoogle),
    ],
  ),
)
```

### Provider Selection Grid

```dart
ArcaneFlow(
  gap: 8,
  children: [
    GithubSignInButton(onPressed: handleGitHub),
    GoogleSignInButton(onPressed: handleGoogle),
    AppleSignInButton(onPressed: handleApple),
    MicrosoftSignInButton(onPressed: handleMicrosoft),
    DiscordSignInButton(onPressed: handleDiscord),
    TwitterSignInButton(onPressed: handleTwitter),
  ],
)
```

### Account Linking

```dart
ArcaneSection(
  header: 'Connected Accounts',
  children: [
    _buildAccountRow(
      button: GithubSignInButton(
        label: isGitHubLinked ? 'Unlink' : 'Link GitHub',
        onPressed: handleGitHubToggle,
      ),
      connected: isGitHubLinked,
    ),
    _buildAccountRow(
      button: GoogleSignInButton(
        label: isGoogleLinked ? 'Unlink' : 'Link Google',
        onPressed: handleGoogleToggle,
      ),
      connected: isGoogleLinked,
    ),
  ],
)
```

## Creating Custom Social Buttons

Use `SocialSignInButton` as a base for custom providers:

```dart
class CustomProviderButton extends StatelessComponent {
  final void Function()? onPressed;
  final bool fullWidth;

  const CustomProviderButton({
    this.onPressed,
    this.fullWidth = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return SocialSignInButton(
      label: 'Continue with Custom',
      icon: _buildIcon(),
      onPressed: onPressed,
      fullWidth: fullWidth,
      backgroundColor: '#custom-color',
      foregroundColor: '#ffffff',
      borderColor: '#custom-color',
      hoverBackgroundColor: '#darker-color',
    );
  }

  Component _buildIcon() {
    // Return SVG or icon component
  }
}
```

## Related Components

- [ArcaneLoginCard](/arcane_jaspr/docs/auth/arcane-login-card) - Complete login form
- [ArcaneSignupCard](/arcane_jaspr/docs/auth/arcane-signup-card) - Complete signup form
- [AuthSplitLayout](/arcane_jaspr/docs/auth/auth-split-layout) - Split layout for auth pages
