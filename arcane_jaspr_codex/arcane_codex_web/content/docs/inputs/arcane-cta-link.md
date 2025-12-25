---
title: ArcaneCtaLink
description: Call-to-action link buttons with multiple variants
layout: docs
component: cta-link
---

# ArcaneCtaLink

A call-to-action link styled as a button with multiple variants for different visual hierarchies.

## Basic Usage

```dart
ArcaneCtaLink.primary(
  label: 'Get Started',
  href: '/signup',
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `label` | `String` | required | Button text |
| `href` | `String` | required | Link destination |
| `showArrow` | `bool` | `false` | Show arrow indicator |
| `variant` | `CtaLinkVariant` | `primary` | Visual style variant |
| `size` | `CtaLinkSize` | `md` | Button size |
| `background` | `String?` | `null` | Custom background color |
| `border` | `String?` | `null` | Custom border |

## Variants

### Primary

Solid accent background, high prominence:

```dart
ArcaneCtaLink.primary(
  label: 'Get Started',
  href: '/signup',
  showArrow: true,
)
```

### Secondary

Outline/border style, medium prominence:

```dart
ArcaneCtaLink.secondary(
  label: 'Learn More',
  href: '/about',
)
```

### Ghost

Text-only style, low prominence:

```dart
ArcaneCtaLink.ghost(
  label: 'View Docs',
  href: '/docs',
)
```

### Accent

Gradient background, highest prominence:

```dart
ArcaneCtaLink.accent(
  label: 'Try Now',
  href: '/trial',
  showArrow: true,
)
```

## Sizes

```dart
// Small
ArcaneCtaLink.primary(label: 'Small', href: '#', size: CtaLinkSize.sm)

// Medium (default)
ArcaneCtaLink.primary(label: 'Medium', href: '#', size: CtaLinkSize.md)

// Large
ArcaneCtaLink.primary(label: 'Large', href: '#', size: CtaLinkSize.lg)
```

## Examples

### Hero Section CTAs

```dart
ArcaneRow(
  gapSize: Gap.md,
  children: [
    ArcaneCtaLink.primary(
      label: 'Get Started',
      href: '/signup',
      showArrow: true,
      size: CtaLinkSize.lg,
    ),
    ArcaneCtaLink.secondary(
      label: 'View Demo',
      href: '/demo',
      size: CtaLinkSize.lg,
    ),
  ],
)
```

### Navigation Links

```dart
ArcaneRow(
  gapSize: Gap.sm,
  children: [
    ArcaneCtaLink.ghost(label: 'Docs', href: '/docs'),
    ArcaneCtaLink.ghost(label: 'Pricing', href: '/pricing'),
    ArcaneCtaLink.ghost(label: 'Blog', href: '/blog'),
  ],
)
```

## Related Components

- [ArcaneButton](/docs/inputs/arcane-button) - Interactive button
- [ArcaneLink](/docs/html/arcane-link) - Standard hyperlink
