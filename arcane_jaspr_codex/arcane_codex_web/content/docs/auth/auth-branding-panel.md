---
title: AuthBrandingPanel
description: Branding panel for split-screen auth layouts
layout: docs
component: auth-branding-panel
---

# AuthBrandingPanel

A branding panel component designed for use with `AuthSplitLayout`. Displays logo, tagline, feature list, and optional testimonial with a dark gaming-themed design.

## Basic Usage

```dart
AuthBrandingPanel(
  tagline: 'Build amazing apps',
  description: 'The complete solution for your web applications.',
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `logoUrl` | `String?` | `null` | URL to the logo image |
| `tagline` | `String` | required | Main tagline text |
| `description` | `String?` | `null` | Description below tagline |
| `features` | `List<String>?` | `null` | Feature highlights with checkmarks |
| `testimonialQuote` | `String?` | `null` | Testimonial quote text |
| `testimonialAuthor` | `String?` | `null` | Testimonial author name |
| `testimonialTitle` | `String?` | `null` | Author title/company |

## Examples

### Simple Tagline

```dart
AuthBrandingPanel(
  tagline: 'Welcome to Arcane',
)
```

### With Features

```dart
AuthBrandingPanel(
  tagline: 'Build amazing apps',
  description: 'The complete authentication solution for your Jaspr web applications.',
  features: [
    'Firebase Authentication',
    'OAuth providers (GitHub, Google, Apple)',
    'Email/password support',
    'Route protection with guards',
  ],
)
```

### With Logo

```dart
AuthBrandingPanel(
  logoUrl: '/images/logo.png',
  tagline: 'Welcome to MyApp',
  description: 'Sign in to access your dashboard.',
)
```

### With Testimonial

```dart
AuthBrandingPanel(
  tagline: 'Trusted by developers',
  description: 'Join thousands of teams building with Arcane.',
  features: [
    'Modern UI components',
    'Dark mode support',
    'Responsive design',
  ],
  testimonialQuote: 'Arcane has transformed how we build web apps.',
  testimonialAuthor: 'Jane Developer',
  testimonialTitle: 'CTO at TechCorp',
)
```

### Full Example

```dart
AuthBrandingPanel(
  logoUrl: '/images/logo.png',
  tagline: 'The future of web development',
  description: 'Build beautiful, performant web applications with Dart and Jaspr.',
  features: [
    'Type-safe CSS styling',
    'Component-based architecture',
    'Firebase integration',
    'Dark mode by default',
    'Responsive layouts',
  ],
  testimonialQuote: 'We reduced our development time by 50% using Arcane.',
  testimonialAuthor: 'John Smith',
  testimonialTitle: 'Lead Developer at StartupCo',
)
```

## Styling Details

### Tagline
- Extra large text (`FontSize.xl3`)
- Bold weight
- Tight letter spacing

### Description
- Muted text color
- Relaxed line height

### Features
- Green checkmark icons
- Accent-colored check background
- Vertical list with medium gap

### Testimonial
- Card with semi-transparent background
- Italic quote text
- Avatar with gradient background (uses first letter)
- Author name and title

## Related Components

- [AuthSplitLayout](/arcane_jaspr/docs/auth/auth-split-layout) - Split-screen layout
- [ArcaneLoginCard](/arcane_jaspr/docs/auth/arcane-login-card) - Login form
- [ArcaneSignupCard](/arcane_jaspr/docs/auth/arcane-signup-card) - Signup form
