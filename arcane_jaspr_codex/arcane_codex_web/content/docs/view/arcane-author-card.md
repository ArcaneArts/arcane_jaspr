---
title: ArcaneAuthorCard
description: Author attribution card with avatar, name, and role
layout: docs
component: author-card
---

# ArcaneAuthorCard

An author attribution card component with avatar, name, and role for testimonials, blog posts, and team pages.

## Basic Usage

```dart
ArcaneAuthorCard(
  name: 'John Doe',
  role: 'Software Engineer',
  initials: 'JD',
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `name` | `String` | required | Author name |
| `role` | `String?` | `null` | Author role/title |
| `avatarUrl` | `String?` | `null` | Avatar image URL |
| `initials` | `String?` | `null` | Fallback initials |
| `size` | `AuthorCardSize` | `md` | Card size |
| `nameColor` | `String?` | `null` | Custom name color |
| `roleColor` | `String?` | `null` | Custom role color |
| `avatarBg` | `String?` | `null` | Avatar background color |

## Sizes

```dart
// Small - 32px avatar
ArcaneAuthorCard.sm(
  name: 'Jane Doe',
  role: 'Developer',
  initials: 'JD',
)

// Medium (default) - 40px avatar
ArcaneAuthorCard(
  name: 'John Smith',
  role: 'Software Engineer',
  initials: 'JS',
)

// Large - 48px avatar
ArcaneAuthorCard.lg(
  name: 'Alice Johnson',
  role: 'CEO & Founder',
  initials: 'AJ',
)
```

## Examples

### With Avatar Image

```dart
ArcaneAuthorCard(
  avatarUrl: 'https://example.com/avatar.jpg',
  name: 'Sarah Wilson',
  role: 'Product Designer',
)
```

### Testimonial Card

```dart
ArcaneCard(
  children: [
    ArcaneText('"This product changed how we work."'),
    ArcaneSpacer(height: Spacing.md),
    ArcaneAuthorCard(
      name: 'Mike Chen',
      role: 'CTO at TechCorp',
      initials: 'MC',
    ),
  ],
)
```

### Blog Post Attribution

```dart
ArcaneRow(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    ArcaneAuthorCard.sm(
      avatarUrl: 'https://example.com/author.jpg',
      name: 'Emily Roberts',
      role: 'Tech Writer',
    ),
    ArcaneText('Dec 25, 2024'),
  ],
)
```

### Team Grid

```dart
ArcaneRow(
  gapSize: Gap.xl,
  children: [
    ArcaneAuthorCard.lg(
      initials: 'JD',
      name: 'John Doe',
      role: 'Founder',
    ),
    ArcaneAuthorCard.lg(
      initials: 'AS',
      name: 'Alice Smith',
      role: 'CTO',
    ),
    ArcaneAuthorCard.lg(
      initials: 'BJ',
      name: 'Bob Johnson',
      role: 'Lead Developer',
    ),
  ],
)
```

## Related Components

- [ArcaneAvatar](/docs/view/arcane-avatar) - Standalone avatar
- [ArcaneTestimonialCard](/docs/view/arcane-testimonial-card) - Full testimonial
