---
title: AuthSplitLayout
description: Split-screen layout for authentication pages
layout: docs
component: auth-split-layout
---

# AuthSplitLayout

A split-screen layout for authentication pages with a branding panel on one side and the auth form on the other. The branding panel is hidden on mobile devices.

## Basic Usage

```dart
AuthSplitLayout(
  brandingContent: AuthBrandingPanel(
    tagline: 'Build amazing apps',
    description: 'The complete solution for your web applications.',
    features: [
      'Feature one',
      'Feature two',
      'Feature three',
    ],
  ),
  formContent: ArcaneLoginCard(
    methods: [AuthMethod.email, AuthMethod.github],
    signupRoute: '/signup',
  ),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `brandingContent` | `Component` | required | Content for the left branding panel |
| `formContent` | `Component` | required | Content for the right form panel |
| `mobileHeader` | `Component?` | `null` | Header shown on mobile (when branding is hidden) |
| `reverseSides` | `bool` | `false` | Swap left and right panels |

## Examples

### With Login Form

```dart
AuthSplitLayout(
  brandingContent: AuthBrandingPanel(
    tagline: 'Welcome back',
    description: 'Sign in to continue to your dashboard.',
    features: [
      'Real-time analytics',
      'Team collaboration',
      'Secure authentication',
    ],
  ),
  formContent: ArcaneLoginCard(
    methods: [AuthMethod.email, AuthMethod.github, AuthMethod.google],
    signupRoute: '/signup',
    forgotPasswordRoute: '/forgot-password',
  ),
)
```

### With Signup Form

```dart
AuthSplitLayout(
  brandingContent: AuthBrandingPanel(
    tagline: 'Get started today',
    description: 'Create your free account and start building.',
    features: [
      'Free tier available',
      'No credit card required',
      'Full API access',
    ],
    testimonialQuote: 'This platform transformed how we build apps.',
    testimonialAuthor: 'Jane Developer',
    testimonialTitle: 'CTO at TechCorp',
  ),
  formContent: ArcaneSignupCard(
    methods: [AuthMethod.email, AuthMethod.github],
    loginRoute: '/login',
    termsUrl: '/terms',
    privacyUrl: '/privacy',
  ),
)
```

### Reversed Layout

```dart
AuthSplitLayout(
  reverseSides: true,
  brandingContent: AuthBrandingPanel(
    tagline: 'Join us',
    description: 'Create an account to get started.',
  ),
  formContent: ArcaneSignupCard(
    loginRoute: '/login',
  ),
)
```

### With Mobile Header

```dart
AuthSplitLayout(
  mobileHeader: ArcaneRow(
    gapSize: Gap.sm,
    children: [
      ArcaneIcon.home(size: IconSize.lg),
      ArcaneText('MyApp', weight: FontWeight.bold),
    ],
  ),
  brandingContent: AuthBrandingPanel(
    tagline: 'Welcome',
  ),
  formContent: ArcaneLoginCard(),
)
```

## Layout Behavior

### Desktop
- Two-column layout (50/50 split)
- Branding panel on left, form on right
- Full-height background effects on branding panel

### Mobile
- Single column layout
- Branding panel hidden
- Mobile header shown (if provided)
- Form content centered

## Styling

The branding panel includes:
- Dark surface background
- Radial gradient glow effects (accent colors)
- Subtle grid pattern overlay
- Automatic content centering

## Related Components

- [AuthBrandingPanel](/arcane_jaspr/docs/auth/auth-branding-panel) - Branding panel content
- [ArcaneLoginCard](/arcane_jaspr/docs/auth/arcane-login-card) - Login form
- [ArcaneSignupCard](/arcane_jaspr/docs/auth/arcane-signup-card) - Signup form
