---
title: ArcaneFooterColumn
description: Footer columns with title and link lists
layout: docs
component: footer-column
---

# ArcaneFooterColumn

Footer column components for building structured footer sections with titles and link lists.

## Basic Usage

```dart
ArcaneFooterColumn(
  title: 'Resources',
  links: [
    FooterLink(label: 'Documentation', href: '/docs'),
    FooterLink(label: 'API Reference', href: '/api'),
    FooterLink(label: 'Tutorials', href: '/tutorials'),
  ],
)
```

## Properties

### ArcaneFooterColumn

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `title` | `String` | required | Column title |
| `links` | `List<FooterLink>` | required | List of footer links |
| `titleColor` | `String?` | `null` | Custom title color |
| `linkColor` | `String?` | `null` | Custom link color |
| `linkGap` | `String?` | `null` | Gap between links |

### ArcaneFooterBrandColumn

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `logo` | `Component` | required | Logo component |
| `description` | `String?` | `null` | Brand description |
| `bottomContent` | `Component?` | `null` | Content below description |
| `descriptionMaxWidth` | `String?` | `null` | Max width for description |

### FooterLink

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `label` | `String` | required | Link text |
| `href` | `String` | required | Link destination |
| `icon` | `String?` | `null` | Optional icon |

## Examples

### Complete Footer Layout

```dart
ArcaneRow(
  gapSize: Gap.xxl,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    ArcaneFooterBrandColumn(
      logo: ArcaneText('Acme Inc', weight: FontWeight.bold),
      description: 'Building the future of web development.',
      bottomContent: ArcaneStatusBadge.success('All Systems Operational'),
    ),
    ArcaneFooterColumn(
      title: 'Product',
      links: [
        FooterLink(label: 'Features', href: '/features'),
        FooterLink(label: 'Pricing', href: '/pricing'),
        FooterLink(label: 'Documentation', href: '/docs'),
      ],
    ),
    ArcaneFooterColumn(
      title: 'Company',
      links: [
        FooterLink(label: 'About', href: '/about'),
        FooterLink(label: 'Blog', href: '/blog'),
        FooterLink(label: 'Careers', href: '/careers'),
      ],
    ),
    ArcaneFooterColumn(
      title: 'Legal',
      links: [
        FooterLink(label: 'Privacy', href: '/privacy'),
        FooterLink(label: 'Terms', href: '/terms'),
      ],
    ),
  ],
)
```

### With Icons

```dart
ArcaneFooterColumn(
  title: 'Connect',
  links: [
    FooterLink(label: 'Twitter', href: 'https://twitter.com', icon: '𝕏'),
    FooterLink(label: 'GitHub', href: 'https://github.com', icon: '⚡'),
    FooterLink(label: 'Discord', href: 'https://discord.gg', icon: '💬'),
  ],
)
```

## Related Components

- [ArcaneFooter](/docs/layout/arcane-footer) - Full footer component
- [ArcaneStatusBadge](/docs/feedback/arcane-status-badge) - Status indicator
