---
title: ArcaneBreadcrumbs
description: Navigation breadcrumb trail
layout: docs
component: breadcrumbs
---

# ArcaneBreadcrumbs

A breadcrumb navigation component showing the current page's location within a hierarchical structure.

## Basic Usage

```dart
ArcaneBreadcrumbs(
  items: [
    BreadcrumbItem(label: 'Home', href: '/'),
    BreadcrumbItem(label: 'Products', href: '/products'),
    BreadcrumbItem(label: 'Category'),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `items` | `List<BreadcrumbItem>` | required | Breadcrumb items |
| `separator` | `BreadcrumbSeparator` | `chevron` | Separator style |
| `size` | `BreadcrumbSize` | `md` | Size variant |
| `showHome` | `bool` | `false` | Show home icon |
| `maxItems` | `int?` | `null` | Max visible items |

## BreadcrumbItem Properties

| Property | Type | Description |
|----------|------|-------------|
| `label` | `String` | Display text |
| `href` | `String?` | Link URL (null for current page) |
| `icon` | `Component?` | Optional icon |

## Separators

```dart
// Chevron (default)
ArcaneBreadcrumbs(
  items: items,
  separator: BreadcrumbSeparator.chevron,
)

// Slash
ArcaneBreadcrumbs(
  items: items,
  separator: BreadcrumbSeparator.slash,
)

// Arrow
ArcaneBreadcrumbs(
  items: items,
  separator: BreadcrumbSeparator.arrow,
)

// Dot
ArcaneBreadcrumbs(
  items: items,
  separator: BreadcrumbSeparator.dot,
)
```

## Sizes

```dart
// Small
ArcaneBreadcrumbs(
  items: items,
  size: BreadcrumbSize.sm,
)

// Medium (default)
ArcaneBreadcrumbs(
  items: items,
  size: BreadcrumbSize.md,
)

// Large
ArcaneBreadcrumbs(
  items: items,
  size: BreadcrumbSize.lg,
)
```

## With Home Icon

```dart
ArcaneBreadcrumbs(
  items: items,
  showHome: true,
)
```

## With Icons

```dart
ArcaneBreadcrumbs(
  items: [
    BreadcrumbItem(
      label: 'Dashboard',
      href: '/dashboard',
      icon: ArcaneIcon.home(),
    ),
    BreadcrumbItem(
      label: 'Settings',
      href: '/dashboard/settings',
      icon: ArcaneIcon.settings(),
    ),
    BreadcrumbItem(label: 'Profile'),
  ],
)
```

## Truncation

```dart
// Show max 4 items with ellipsis
ArcaneBreadcrumbs(
  items: longPath,
  maxItems: 4,
)
```

## Examples

### E-commerce Navigation

```dart
ArcaneBreadcrumbs(
  items: [
    BreadcrumbItem(label: 'Home', href: '/'),
    BreadcrumbItem(label: 'Electronics', href: '/electronics'),
    BreadcrumbItem(label: 'Phones', href: '/electronics/phones'),
    BreadcrumbItem(label: 'iPhone 15 Pro'),
  ],
  separator: BreadcrumbSeparator.chevron,
)
```

### Documentation Path

```dart
ArcaneBreadcrumbs(
  items: [
    BreadcrumbItem(label: 'Docs', href: '/docs'),
    BreadcrumbItem(label: 'Components', href: '/docs/components'),
    BreadcrumbItem(label: 'Navigation', href: '/docs/components/navigation'),
    BreadcrumbItem(label: 'Breadcrumbs'),
  ],
  showHome: true,
)
```

## Related Components

- [ArcanePagination](/arcane_jaspr/docs/navigation/arcane-pagination) - Page navigation
- [ArcaneSidebar](/arcane_jaspr/docs/navigation/arcane-sidebar) - Sidebar navigation
