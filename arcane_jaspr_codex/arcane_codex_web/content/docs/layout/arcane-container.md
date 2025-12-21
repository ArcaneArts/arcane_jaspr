---
title: ArcaneContainer
description: Centered container with max-width constraints
layout: docs
component: container
---

# ArcaneContainer

A layout component that centers content with a maximum width, commonly used for page-level content containment.

## Basic Usage

```dart
ArcaneContainer(
  children: [
    ArcaneHeading(text: 'Page Content'),
    ArcaneParagraph(text: 'Content is centered with max-width.'),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `children` | `List<Component>` | `[]` | Child components |
| `maxWidth` | `ContainerMaxWidth` | `lg` | Maximum width constraint |
| `padding` | `PaddingPreset?` | `null` | Container padding |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Max Width Sizes

```dart
// Extra small (max-width: 480px)
ArcaneContainer(
  maxWidth: ContainerMaxWidth.xs,
  children: [...],
)

// Small (max-width: 640px)
ArcaneContainer(
  maxWidth: ContainerMaxWidth.sm,
  children: [...],
)

// Medium (max-width: 768px)
ArcaneContainer(
  maxWidth: ContainerMaxWidth.md,
  children: [...],
)

// Large (max-width: 1024px) - Default
ArcaneContainer(
  maxWidth: ContainerMaxWidth.lg,
  children: [...],
)

// Extra large (max-width: 1280px)
ArcaneContainer(
  maxWidth: ContainerMaxWidth.xl,
  children: [...],
)

// 2XL (max-width: 1536px)
ArcaneContainer(
  maxWidth: ContainerMaxWidth.xl2,
  children: [...],
)

// Full width (no max-width)
ArcaneContainer(
  maxWidth: ContainerMaxWidth.full,
  children: [...],
)
```

## With Padding

```dart
ArcaneContainer(
  maxWidth: ContainerMaxWidth.lg,
  padding: PaddingPreset.xl,
  children: [
    ArcaneHeading(text: 'Padded Container'),
    ArcaneParagraph(text: 'Content with comfortable padding.'),
  ],
)
```

## Examples

### Page Layout

```dart
ArcaneContainer(
  maxWidth: ContainerMaxWidth.xl,
  padding: PaddingPreset.lg,
  children: [
    ArcaneHeading(text: 'Dashboard'),
    ArcaneDiv(
      styles: const ArcaneStyleData(
        display: Display.grid,
        gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))',
        gap: Gap.lg,
      ),
      children: [
        ArcaneCard(child: ArcaneText('Card 1')),
        ArcaneCard(child: ArcaneText('Card 2')),
        ArcaneCard(child: ArcaneText('Card 3')),
      ],
    ),
  ],
)
```

### Narrow Content

```dart
ArcaneContainer(
  maxWidth: ContainerMaxWidth.sm,
  padding: PaddingPreset.xl,
  children: [
    ArcaneHeading(text: 'Sign In'),
    ArcaneTextInput(label: 'Email'),
    ArcaneTextInput(label: 'Password', type: TextInputType.password),
    ArcaneButton.primary(label: 'Sign In', onPressed: () {}),
  ],
)
```

### Blog Post

```dart
ArcaneContainer(
  maxWidth: ContainerMaxWidth.md,
  padding: PaddingPreset.xl,
  styles: const ArcaneStyleData(
    paddingTop: Spacing.xl3,
    paddingBottom: Spacing.xl3,
  ),
  children: [
    ArcaneHeadline(text: 'Article Title'),
    ArcaneDiv(
      styles: const ArcaneStyleData(
        display: Display.flex,
        gap: Gap.sm,
        marginBottom: Spacing.lg,
      ),
      children: [
        ArcaneBadge(label: 'Tutorial'),
        ArcaneText('5 min read'),
      ],
    ),
    ArcaneParagraph(text: 'Article content goes here...'),
  ],
)
```

### Hero Section

```dart
ArcaneContainer(
  maxWidth: ContainerMaxWidth.xl,
  styles: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    alignItems: AlignItems.center,
    textAlign: TextAlign.center,
    paddingTop: Spacing.xl4,
    paddingBottom: Spacing.xl4,
  ),
  children: [
    ArcaneHeadline(text: 'Build faster with Arcane'),
    ArcaneSubheadline(text: 'A comprehensive UI component library'),
    ArcaneDiv(
      styles: const ArcaneStyleData(
        display: Display.flex,
        gap: Gap.md,
        marginTop: Spacing.xl,
      ),
      children: [
        ArcaneButton.primary(label: 'Get Started', onPressed: () {}),
        ArcaneButton.ghost(label: 'Learn More', onPressed: () {}),
      ],
    ),
  ],
)
```

## Related Components

- [ArcaneDiv](/arcane_jaspr/docs/layout/arcane-div) - Basic layout div
- [ArcaneSection](/arcane_jaspr/docs/layout/arcane-section) - Semantic sections
- [ArcaneCenter](/arcane_jaspr/docs/layout/arcane-center) - Center alignment helper
