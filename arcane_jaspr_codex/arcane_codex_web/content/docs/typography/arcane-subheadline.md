---
title: ArcaneSubheadline
description: Supporting subtitle text for headlines
layout: docs
component: subheadline
---

# ArcaneSubheadline

A subtitle component designed to accompany headlines, providing additional context with muted styling.

## Basic Usage

```dart
ArcaneSubheadline(text: 'Supporting description text')
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `text` | `String` | required | Subtitle text |
| `size` | `SubheadlineSize` | `medium` | Text size |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## Sizes

```dart
// Small
ArcaneSubheadline(
  text: 'Small subtitle',
  size: SubheadlineSize.small,
)

// Medium (default)
ArcaneSubheadline(
  text: 'Medium subtitle',
  size: SubheadlineSize.medium,
)

// Large
ArcaneSubheadline(
  text: 'Large subtitle',
  size: SubheadlineSize.large,
)
```

## Examples

### Hero Subtitle

```dart
ArcaneColumn(
  crossAxisAlignment: AlignItems.center,
  gap: Gap.md,
  children: [
    ArcaneHeadline(text: 'Build Better Products'),
    ArcaneSubheadline(
      text: 'A comprehensive toolkit for creating modern web applications with Jaspr',
      size: SubheadlineSize.large,
      styles: const ArcaneStyleData(
        textAlign: TextAlign.center,
        maxWidthCustom: '700px',
      ),
    ),
  ],
)
```

### Section Header

```dart
ArcaneColumn(
  gap: Gap.sm,
  children: [
    ArcaneHeading(text: 'Features'),
    ArcaneSubheadline(
      text: 'Everything you need to build amazing applications',
    ),
  ],
)
```

### Card Header

```dart
ArcaneCard(
  child: ArcaneColumn(
    crossAxisAlignment: AlignItems.start,
    gap: Gap.md,
    children: [
      ArcaneHeading(text: 'Analytics'),
      ArcaneSubheadline(
        text: 'Track your performance metrics',
        size: SubheadlineSize.small,
      ),
      // Chart or content...
    ],
  ),
)
```

### Centered Section

```dart
ArcaneSection(
  children: [
    ArcaneContainer(
      children: [
        ArcaneColumn(
          crossAxisAlignment: AlignItems.center,
          gap: Gap.md,
          children: [
            ArcaneHeading(text: 'Trusted by Teams Worldwide'),
            ArcaneSubheadline(
              text: 'Join thousands of developers building with Arcane',
              styles: const ArcaneStyleData(
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        ArcaneGutter(size: GutterSize.xl),
        ArcaneLogoGrid(
          logos: [
            LogoItem(src: '/logos/company1.svg'),
            LogoItem(src: '/logos/company2.svg'),
            // More logos...
          ],
        ),
      ],
    ),
  ],
)
```

### Form Section

```dart
ArcaneColumn(
  crossAxisAlignment: AlignItems.start,
  gap: Gap.lg,
  children: [
    ArcaneColumn(
      crossAxisAlignment: AlignItems.start,
      gap: Gap.xs,
      children: [
        ArcaneHeading(text: 'Account Settings', level: HeadingLevel.h3),
        ArcaneSubheadline(
          text: 'Manage your account preferences and security settings',
          size: SubheadlineSize.small,
        ),
      ],
    ),
    ArcaneTextInput(label: 'Display Name'),
    ArcaneTextInput(label: 'Email'),
    ArcaneButton.primary(label: 'Save Changes', onPressed: () {}),
  ],
)
```

### Pricing Header

```dart
ArcaneColumn(
  crossAxisAlignment: AlignItems.center,
  gap: Gap.md,
  children: [
    ArcaneHeadline(text: 'Pricing Plans'),
    ArcaneSubheadline(
      text: 'Choose the plan that works best for you',
      size: SubheadlineSize.large,
    ),
    ArcaneSubheadline(
      text: 'All plans include a 14-day free trial',
      size: SubheadlineSize.small,
      styles: const ArcaneStyleData(
        textColor: TextColor.primary,
      ),
    ),
  ],
)
```

## Related Components

- [ArcaneHeadline](/arcane_jaspr/docs/typography/arcane-headline) - Large headlines
- [ArcaneHeading](/arcane_jaspr/docs/typography/arcane-heading) - Section headings
- [ArcaneText](/arcane_jaspr/docs/typography/arcane-text) - Basic text
