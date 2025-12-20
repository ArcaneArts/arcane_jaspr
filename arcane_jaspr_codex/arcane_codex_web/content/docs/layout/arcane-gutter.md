---
title: ArcaneGutter
description: Vertical spacing element between sections
layout: docs
---

# ArcaneGutter

A simple spacing component that adds vertical space between elements, useful for creating consistent visual separation.

## Basic Usage

```dart
ArcaneColumn(
  children: [
    ArcaneSection(children: [...]),
    ArcaneGutter(),
    ArcaneSection(children: [...]),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `size` | `GutterSize` | `md` | Vertical spacing amount |

## Sizes

```dart
// Extra small
ArcaneGutter(size: GutterSize.xs)

// Small
ArcaneGutter(size: GutterSize.sm)

// Medium (default)
ArcaneGutter(size: GutterSize.md)

// Large
ArcaneGutter(size: GutterSize.lg)

// Extra large
ArcaneGutter(size: GutterSize.xl)

// 2XL
ArcaneGutter(size: GutterSize.xl2)
```

## Examples

### Page Sections

```dart
ArcaneColumn(
  children: [
    ArcaneSection(
      children: [
        ArcaneContainer(
          children: [
            ArcaneHeadline(text: 'Hero Title'),
            ArcaneSubheadline(text: 'Hero subtitle'),
          ],
        ),
      ],
    ),
    ArcaneGutter(size: GutterSize.xl),
    ArcaneSection(
      children: [
        ArcaneContainer(
          children: [
            ArcaneHeading(text: 'Features'),
            // Feature cards...
          ],
        ),
      ],
    ),
    ArcaneGutter(size: GutterSize.xl),
    ArcaneSection(
      children: [
        ArcaneContainer(
          children: [
            ArcaneHeading(text: 'Testimonials'),
            // Testimonial cards...
          ],
        ),
      ],
    ),
  ],
)
```

### Form Sections

```dart
ArcaneColumn(
  children: [
    ArcaneColumn(
      gap: Gap.md,
      children: [
        ArcaneHeading(text: 'Account'),
        ArcaneTextInput(label: 'Email'),
        ArcaneTextInput(label: 'Password'),
      ],
    ),
    ArcaneGutter(size: GutterSize.lg),
    ArcaneColumn(
      gap: Gap.md,
      children: [
        ArcaneHeading(text: 'Profile'),
        ArcaneTextInput(label: 'Display Name'),
        ArcaneTextArea(label: 'Bio'),
      ],
    ),
    ArcaneGutter(size: GutterSize.lg),
    ArcaneButton.primary(label: 'Save', onPressed: () {}),
  ],
)
```

### Card Groups

```dart
ArcaneColumn(
  children: [
    ArcaneText('Popular'),
    ArcaneGutter(size: GutterSize.sm),
    ArcaneRow(
      gap: Gap.md,
      children: [
        for (var item in popularItems)
          ArcaneCard(child: ...),
      ],
    ),
    ArcaneGutter(size: GutterSize.xl),
    ArcaneText('Recent'),
    ArcaneGutter(size: GutterSize.sm),
    ArcaneRow(
      gap: Gap.md,
      children: [
        for (var item in recentItems)
          ArcaneCard(child: ...),
      ],
    ),
  ],
)
```

### Article Layout

```dart
ArcaneContainer(
  maxWidth: ContainerMaxWidth.md,
  children: [
    ArcaneHeadline(text: 'Article Title'),
    ArcaneGutter(size: GutterSize.sm),
    ArcaneRow(
      gap: Gap.sm,
      children: [
        ArcaneAvatar(size: AvatarSize.small),
        ArcaneText('Author Name'),
        ArcaneText('•'),
        ArcaneText('Jan 15, 2024'),
      ],
    ),
    ArcaneGutter(size: GutterSize.lg),
    ArcaneParagraph(text: 'First paragraph...'),
    ArcaneGutter(size: GutterSize.md),
    ArcaneParagraph(text: 'Second paragraph...'),
    ArcaneGutter(size: GutterSize.xl),
    ArcaneDivider(),
    ArcaneGutter(size: GutterSize.md),
    ArcaneHeading(text: 'Related Articles'),
  ],
)
```

## Related Components

- [ArcaneSpacer](/docs/layout/arcane-spacer) - Flex space filler
- [ArcaneDivider](/docs/view/arcane-divider) - Visual divider line
- [ArcaneSection](/docs/layout/arcane-section) - Section with spacing
