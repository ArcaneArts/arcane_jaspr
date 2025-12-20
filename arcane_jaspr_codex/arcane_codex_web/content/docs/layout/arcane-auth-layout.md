---
title: ArcaneAuthLayout
description: Pre-styled layout for authentication pages
layout: docs
component: auth-layout
---

# ArcaneAuthLayout

A specialized layout for authentication pages (login, signup, password reset) with centered content and optional branding.

## Basic Usage

```dart
ArcaneAuthLayout(
  child: LoginForm(),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `child` | `Component` | required | Form content |
| `title` | `String?` | `null` | Page title |
| `subtitle` | `String?` | `null` | Supporting text |
| `logo` | `Component?` | `null` | Brand logo |
| `backgroundImage` | `String?` | `null` | Background image URL |
| `showThemeToggle` | `bool` | `true` | Show dark mode toggle |
| `footer` | `Component?` | `null` | Footer content |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## With Branding

```dart
ArcaneAuthLayout(
  logo: ArcaneImage(src: '/logo.svg', width: 120),
  title: 'Welcome Back',
  subtitle: 'Sign in to your account',
  child: ArcaneColumn(
    gap: Gap.md,
    children: [
      ArcaneTextInput(label: 'Email'),
      ArcaneTextInput(label: 'Password', type: TextInputType.password),
      ArcaneButton.primary(
        label: 'Sign In',
        isFullWidth: true,
        onPressed: () {},
      ),
    ],
  ),
)
```

## Examples

### Login Page

```dart
ArcaneAuthLayout(
  logo: span([text('🔐')]),
  title: 'Sign In',
  subtitle: 'Enter your credentials to continue',
  child: ArcaneColumn(
    gap: Gap.lg,
    children: [
      ArcaneTextInput(
        label: 'Email',
        placeholder: 'you@example.com',
        leading: span([text('📧')]),
      ),
      ArcaneTextInput(
        label: 'Password',
        type: TextInputType.password,
        leading: span([text('🔑')]),
      ),
      ArcaneRow(
        mainAxisAlignment: JustifyContent.spaceBetween,
        children: [
          ArcaneCheckbox(
            label: 'Remember me',
            value: rememberMe,
            onChanged: (v) => setState(() => rememberMe = v),
          ),
          ArcaneButton.link(
            label: 'Forgot password?',
            onPressed: goToForgotPassword,
          ),
        ],
      ),
      ArcaneButton.primary(
        label: 'Sign In',
        isFullWidth: true,
        onPressed: handleLogin,
      ),
      ArcaneDivider(label: 'or'),
      ArcaneButton.ghost(
        label: 'Continue with Google',
        isFullWidth: true,
        leading: span([text('🔵')]),
        onPressed: handleGoogleLogin,
      ),
    ],
  ),
  footer: ArcaneRow(
    mainAxisAlignment: JustifyContent.center,
    gap: Gap.xs,
    children: [
      ArcaneText("Don't have an account?"),
      ArcaneButton.link(label: 'Sign up', onPressed: goToSignup),
    ],
  ),
)
```

### Signup Page

```dart
ArcaneAuthLayout(
  title: 'Create Account',
  subtitle: 'Get started with your free account',
  child: ArcaneColumn(
    gap: Gap.md,
    children: [
      ArcaneRow(
        gap: Gap.md,
        children: [
          ArcaneExpanded(
            child: ArcaneTextInput(label: 'First Name'),
          ),
          ArcaneExpanded(
            child: ArcaneTextInput(label: 'Last Name'),
          ),
        ],
      ),
      ArcaneTextInput(label: 'Email'),
      ArcaneTextInput(label: 'Password', type: TextInputType.password),
      ArcaneTextInput(label: 'Confirm Password', type: TextInputType.password),
      ArcaneCheckbox(
        label: 'I agree to the Terms of Service',
        value: agreeToTerms,
        onChanged: (v) => setState(() => agreeToTerms = v),
      ),
      ArcaneButton.primary(
        label: 'Create Account',
        isFullWidth: true,
        isDisabled: !agreeToTerms,
        onPressed: handleSignup,
      ),
    ],
  ),
  footer: ArcaneRow(
    mainAxisAlignment: JustifyContent.center,
    gap: Gap.xs,
    children: [
      ArcaneText('Already have an account?'),
      ArcaneButton.link(label: 'Sign in', onPressed: goToLogin),
    ],
  ),
)
```

### Password Reset

```dart
ArcaneAuthLayout(
  title: 'Reset Password',
  subtitle: 'Enter your email to receive a reset link',
  child: ArcaneColumn(
    gap: Gap.md,
    children: [
      ArcaneTextInput(
        label: 'Email',
        placeholder: 'you@example.com',
      ),
      ArcaneButton.primary(
        label: 'Send Reset Link',
        isFullWidth: true,
        onPressed: sendResetLink,
      ),
    ],
  ),
  footer: ArcaneButton.link(
    label: '← Back to Sign In',
    onPressed: goToLogin,
  ),
)
```

### With Background

```dart
ArcaneAuthLayout(
  backgroundImage: '/auth-bg.jpg',
  logo: ArcaneImage(src: '/logo-white.svg'),
  title: 'Welcome',
  subtitle: 'Join thousands of users',
  child: LoginForm(),
  styles: const ArcaneStyleData(
    textColor: TextColor.onPrimary,
  ),
)
```

### Two-Factor Auth

```dart
ArcaneAuthLayout(
  title: 'Two-Factor Authentication',
  subtitle: 'Enter the code from your authenticator app',
  child: ArcaneColumn(
    gap: Gap.lg,
    crossAxisAlignment: AlignItems.center,
    children: [
      ArcaneRow(
        gap: Gap.sm,
        mainAxisAlignment: JustifyContent.center,
        children: [
          for (var i = 0; i < 6; i++)
            ArcaneTextInput(
              styles: const ArcaneStyleData(
                widthCustom: '48px',
                textAlign: TextAlign.center,
              ),
              maxLength: 1,
            ),
        ],
      ),
      ArcaneButton.primary(
        label: 'Verify',
        isFullWidth: true,
        onPressed: verify2FA,
      ),
      ArcaneButton.link(
        label: 'Use backup code',
        onPressed: useBackupCode,
      ),
    ],
  ),
)
```

## Related Components

- [ArcaneDashboardLayout](/docs/layout/arcane-dashboard-layout) - Dashboard layout
- [ArcaneCenter](/docs/layout/arcane-center) - Center alignment
- [ArcaneCard](/docs/layout/arcane-card) - Card container
