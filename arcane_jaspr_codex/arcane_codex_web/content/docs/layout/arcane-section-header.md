---
title: ArcaneSectionHeader
description: Reusable section headers with label, heading, and description
layout: docs
component: section-header
---

# ArcaneSectionHeader

A reusable section header component with an uppercase accent label, large heading text, and muted description.

## Basic Usage

```dart
ArcaneSectionHeader(
  label: 'Features',
  heading: 'Why Choose Us',
  description: 'Discover what makes our platform different.',
  align: SectionHeaderAlign.center,
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `label` | `String?` | `null` | Uppercase accent label |
| `heading` | `String` | required | Main heading text |
| `description` | `String?` | `null` | Description paragraph |
| `align` | `SectionHeaderAlign` | `center` | Text alignment |
| `labelColor` | `String?` | `null` | Custom label color |
| `headingColor` | `String?` | `null` | Custom heading color |
| `descriptionColor` | `String?` | `null` | Custom description color |
| `descriptionMaxWidth` | `String?` | `null` | Max width for description |

## Alignment

```dart
// Center aligned (default)
ArcaneSectionHeader(
  heading: 'Centered Header',
  align: SectionHeaderAlign.center,
)

// Left aligned
ArcaneSectionHeader.left(
  heading: 'Left Aligned',
  description: 'Content flows from the left.',
)

// Right aligned
ArcaneSectionHeader(
  heading: 'Right Aligned',
  align: SectionHeaderAlign.right,
)
```

## Examples

### Features Section

```dart
ArcaneSectionHeader(
  label: 'Features',
  heading: 'Everything You Need',
  description: 'Powerful tools to help you build faster and smarter.',
  align: SectionHeaderAlign.center,
)
```

### Pricing Section

```dart
ArcaneSectionHeader.left(
  label: 'Pricing',
  heading: 'Simple, Transparent Pricing',
  description: 'No hidden fees. No surprise charges. Cancel anytime.',
)
```

### Testimonials

```dart
ArcaneSectionHeader(
  label: 'Testimonials',
  heading: 'What Our Customers Say',
  align: SectionHeaderAlign.center,
)
```

## Related Components

- [ArcaneHeroSection](/docs/layout/arcane-hero-section) - Full hero sections
- [ArcaneHeadline](/docs/typography/arcane-headline) - Standalone headlines
