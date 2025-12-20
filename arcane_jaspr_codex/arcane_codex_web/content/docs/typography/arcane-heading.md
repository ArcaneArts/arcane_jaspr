---
title: ArcaneHeading
description: Section heading component with semantic levels
layout: docs
---

# ArcaneHeading

A heading component for section titles with semantic HTML heading levels (h1-h6).

## Basic Usage

```dart
ArcaneHeading(text: 'Section Title')
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `text` | `String` | required | Heading text |
| `level` | `HeadingLevel` | `h2` | Semantic level (h1-h6) |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## Heading Levels

```dart
// H1 - Main page title
ArcaneHeading(text: 'Page Title', level: HeadingLevel.h1)

// H2 - Section title (default)
ArcaneHeading(text: 'Section Title', level: HeadingLevel.h2)

// H3 - Subsection
ArcaneHeading(text: 'Subsection', level: HeadingLevel.h3)

// H4 - Sub-subsection
ArcaneHeading(text: 'Sub-subsection', level: HeadingLevel.h4)

// H5 - Minor heading
ArcaneHeading(text: 'Minor Heading', level: HeadingLevel.h5)

// H6 - Smallest heading
ArcaneHeading(text: 'Smallest', level: HeadingLevel.h6)
```

## With Custom Styling

```dart
ArcaneHeading(
  text: 'Custom Heading',
  level: HeadingLevel.h2,
  styles: const ArcaneStyleData(
    textColor: TextColor.primary,
    letterSpacing: LetterSpacing.tight,
  ),
)
```

## Examples

### Page Header

```dart
ArcaneColumn(
  gap: Gap.sm,
  children: [
    ArcaneHeading(
      text: 'Dashboard',
      level: HeadingLevel.h1,
    ),
    ArcaneText(
      'Welcome back, manage your projects',
      styles: const ArcaneStyleData(
        textColor: TextColor.muted,
      ),
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
      ArcaneHeading(
        text: 'Recent Activity',
        level: HeadingLevel.h3,
      ),
      // Card content...
    ],
  ),
)
```

### Section with Anchor

```dart
ArcaneColumn(
  gap: Gap.md,
  children: [
    ArcaneDiv(
      id: 'features',
      children: [
        ArcaneHeading(
          text: 'Features',
          level: HeadingLevel.h2,
        ),
      ],
    ),
    // Feature content...
  ],
)
```

### Document Structure

```dart
ArcaneColumn(
  gap: Gap.lg,
  children: [
    ArcaneHeading(text: 'Documentation', level: HeadingLevel.h1),

    ArcaneSection(
      children: [
        ArcaneHeading(text: 'Getting Started', level: HeadingLevel.h2),
        ArcaneParagraph(text: 'Introduction content...'),

        ArcaneHeading(text: 'Installation', level: HeadingLevel.h3),
        ArcaneParagraph(text: 'Installation steps...'),

        ArcaneHeading(text: 'Configuration', level: HeadingLevel.h3),
        ArcaneParagraph(text: 'Configuration details...'),
      ],
    ),

    ArcaneSection(
      children: [
        ArcaneHeading(text: 'API Reference', level: HeadingLevel.h2),
        ArcaneParagraph(text: 'API documentation...'),
      ],
    ),
  ],
)
```

### With Badge

```dart
ArcaneRow(
  gap: Gap.sm,
  crossAxisAlignment: AlignItems.center,
  children: [
    ArcaneHeading(
      text: 'New Features',
      level: HeadingLevel.h2,
    ),
    ArcaneBadge(label: 'Beta', variant: BadgeVariant.secondary),
  ],
)
```

### Centered Heading

```dart
ArcaneHeading(
  text: 'Our Mission',
  level: HeadingLevel.h2,
  styles: const ArcaneStyleData(
    textAlign: TextAlign.center,
    marginBottom: Spacing.lg,
  ),
)
```

## Related Components

- [ArcaneHeadline](/docs/typography/arcane-headline) - Large display headlines
- [ArcaneSubheadline](/docs/typography/arcane-subheadline) - Subtitle text
- [ArcaneText](/docs/typography/arcane-text) - Basic text
