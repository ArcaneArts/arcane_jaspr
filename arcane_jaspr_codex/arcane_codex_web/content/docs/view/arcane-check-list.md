---
title: ArcaneCheckList
description: Lists with checkmark icons for features and benefits
layout: docs
component: check-list
---

# ArcaneCheckList

List components with checkmark icons for displaying features, benefits, requirements, and pricing inclusions.

## Basic Usage

```dart
ArcaneCheckList(
  items: [
    'Unlimited API calls',
    'Priority support',
    'Custom integrations',
  ],
)
```

## Components

### ArcaneCheckItem

Single item with icon and text:

```dart
ArcaneCheckItem(
  text: 'Feature included',
  icon: CheckStyle.check,
)
```

### ArcaneCheckList

List of items with consistent styling:

```dart
ArcaneCheckList(
  items: ['Item 1', 'Item 2', 'Item 3'],
)
```

### ArcaneFeatureRow

Feature row with included/excluded state:

```dart
ArcaneFeatureRow(
  feature: 'Custom domain',
  included: true,
)
```

## Properties

### ArcaneCheckItem

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `text` | `String` | required | Item text |
| `icon` | `CheckStyle` | `check` | Icon style |
| `iconColor` | `String?` | `null` | Custom icon color |
| `textColor` | `String?` | `null` | Custom text color |
| `fontSize` | `String?` | `null` | Custom font size |
| `gap` | `String?` | `null` | Icon-text gap |

### ArcaneCheckList

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `items` | `List<String>` | required | List of items |
| `icon` | `CheckStyle` | `check` | Icon style for all items |
| `iconColor` | `String?` | `null` | Icon color |
| `textColor` | `String?` | `null` | Text color |
| `gap` | `String?` | `null` | Gap between items |

### ArcaneFeatureRow

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `feature` | `String` | required | Feature name |
| `included` | `bool` | required | Whether feature is included |
| `includedColor` | `String?` | `null` | Color when included |
| `excludedColor` | `String?` | `null` | Color when excluded |

## Icon Styles

```dart
CheckStyle.check   // ✓
CheckStyle.bullet  // •
CheckStyle.arrow   // →
CheckStyle.plus    // +
CheckStyle.star    // ★
```

## Variants

### Brand Colored

```dart
ArcaneCheckList.brand(
  items: [
    'Shared models across web and server',
    'Type-safe API calls',
    'Hot reload in development',
  ],
)
```

### Success Colored

```dart
ArcaneCheckList.success(
  items: [
    'All tests passing',
    'Build successful',
    'Deployed to production',
  ],
)
```

## Examples

### Pricing Card Features

```dart
ArcaneColumn(
  gapSize: Gap.sm,
  children: [
    ArcaneFeatureRow(feature: 'Unlimited projects', included: true),
    ArcaneFeatureRow(feature: '10GB storage', included: true),
    ArcaneFeatureRow(feature: 'Priority support', included: true),
    ArcaneFeatureRow(feature: 'Custom domain', included: false),
    ArcaneFeatureRow(feature: 'White-label', included: false),
  ],
)
```

### Benefits List

```dart
ArcaneCheckList.brand(
  items: [
    'No credit card required',
    'Free forever for small teams',
    'Cancel anytime',
  ],
)
```

### Requirements Checklist

```dart
ArcaneColumn(
  gapSize: Gap.xs,
  children: [
    ArcaneCheckItem(
      text: 'Node.js 18+',
      icon: CheckStyle.check,
      iconColor: ArcaneColors.success,
    ),
    ArcaneCheckItem(
      text: 'npm or yarn',
      icon: CheckStyle.check,
      iconColor: ArcaneColors.success,
    ),
    ArcaneCheckItem(
      text: 'Git installed',
      icon: CheckStyle.check,
      iconColor: ArcaneColors.success,
    ),
  ],
)
```

## Related Components

- [ArcaneBadge](/docs/view/arcane-badge) - Status badges
- [ArcaneIcon](/docs/view/arcane-icon) - Custom icons
