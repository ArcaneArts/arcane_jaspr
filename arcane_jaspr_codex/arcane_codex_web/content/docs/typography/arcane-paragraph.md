---
title: ArcaneParagraph
description: Block-level paragraph text component
layout: docs
component: paragraph
---

# ArcaneParagraph

A block-level text component for paragraphs with proper line height and spacing.

## Basic Usage

```dart
ArcaneParagraph(
  text: 'This is a paragraph of text that will wrap naturally across multiple lines with appropriate line height for readability.',
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `text` | `String` | required | Paragraph content |
| `size` | `ParagraphSize` | `medium` | Text size |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## Sizes

```dart
// Small
ArcaneParagraph(
  text: 'Small paragraph text for compact layouts.',
  size: ParagraphSize.small,
)

// Medium (default)
ArcaneParagraph(
  text: 'Medium paragraph text for most content.',
  size: ParagraphSize.medium,
)

// Large
ArcaneParagraph(
  text: 'Large paragraph text for emphasis.',
  size: ParagraphSize.large,
)
```

## Examples

### Article Content

```dart
ArcaneContainer(
  maxWidth: ContainerMaxWidth.md,
  children: [
    ArcaneHeading(text: 'Getting Started'),
    ArcaneParagraph(
      text: 'Welcome to Arcane, a comprehensive UI component library for building modern web applications with Jaspr. This guide will walk you through the installation process and basic concepts.',
    ),
    ArcaneParagraph(
      text: 'Arcane provides over 235 pre-built components, from simple buttons to complex data tables, all styled with a cohesive design system inspired by modern SaaS applications.',
    ),
  ],
)
```

### Lead Paragraph

```dart
ArcaneColumn(
  gap: Gap.md,
  children: [
    ArcaneParagraph(
      text: 'Arcane is the definitive UI toolkit for Jaspr developers.',
      size: ParagraphSize.large,
      styles: const ArcaneStyleData(
        fontWeight: FontWeight.medium,
      ),
    ),
    ArcaneParagraph(
      text: 'Build beautiful, responsive applications with our comprehensive component library. Every component is designed with accessibility in mind.',
    ),
  ],
)
```

### Blog Post

```dart
ArcaneColumn(
  gap: Gap.lg,
  children: [
    ArcaneHeadline(text: 'Why We Built Arcane'),
    ArcaneRow(
      gap: Gap.sm,
      children: [
        ArcaneAvatar(imageUrl: '/author.jpg', size: AvatarSize.small),
        ArcaneText('John Doe • Jan 15, 2024'),
      ],
    ),
    ArcaneParagraph(
      text: 'When we started building applications with Jaspr, we found ourselves recreating the same UI components over and over. We needed a solution that would let us focus on building features instead of reinventing the wheel.',
      size: ParagraphSize.large,
    ),
    ArcaneParagraph(
      text: 'That is why we created Arcane. Our goal was to build a comprehensive component library that provides everything you need to create beautiful, functional web applications.',
    ),
    ArcaneParagraph(
      text: 'Each component is carefully designed to work seamlessly with the others, following a consistent design language that makes your applications look professional out of the box.',
    ),
  ],
)
```

### Feature Description

```dart
ArcaneRow(
  gap: Gap.lg,
  children: [
    ArcaneExpanded(
      child: ArcaneColumn(
        gap: Gap.md,
        children: [
          ArcaneHeading(text: 'Real-time Collaboration'),
          ArcaneParagraph(
            text: 'Work together with your team in real-time. See changes instantly as they happen, with automatic conflict resolution and version history.',
          ),
          ArcaneButton.primary(label: 'Learn More', onPressed: () {}),
        ],
      ),
    ),
    ArcaneExpanded(
      child: ArcaneImage(src: '/feature-collab.png'),
    ),
  ],
)
```

### Muted Paragraph

```dart
ArcaneParagraph(
  text: 'Note: This feature is currently in beta and may change in future releases.',
  size: ParagraphSize.small,
  styles: const ArcaneStyleData(
    textColor: TextColor.muted,
    fontStyle: FontStyle.italic,
  ),
)
```

### Centered Content

```dart
ArcaneSection(
  children: [
    ArcaneContainer(
      maxWidth: ContainerMaxWidth.md,
      children: [
        ArcaneColumn(
          crossAxisAlignment: AlignItems.center,
          gap: Gap.md,
          children: [
            ArcaneHeading(text: 'Our Mission'),
            ArcaneParagraph(
              text: 'We believe that building great software should be accessible to everyone. Our mission is to provide developers with the tools they need to create beautiful, functional applications without spending weeks on UI implementation.',
              styles: const ArcaneStyleData(
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    ),
  ],
)
```

## Related Components

- [ArcaneText](/docs/typography/arcane-text) - Basic text display
- [ArcaneBodyText](/docs/typography/arcane-body-text) - Body text variant
- [ArcaneRichText](/docs/typography/arcane-rich-text) - Rich text with formatting
