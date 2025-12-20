---
title: ArcaneSection
description: Semantic section wrapper with consistent spacing
layout: docs
---

# ArcaneSection

A semantic section component that wraps content in an HTML `<section>` element with built-in spacing and styling.

## Basic Usage

```dart
ArcaneSection(
  children: [
    ArcaneHeading(text: 'Features'),
    ArcaneParagraph(text: 'Our amazing features...'),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `children` | `List<Component>` | `[]` | Section content |
| `id` | `String?` | `null` | Section anchor ID |
| `spacing` | `SectionSpacing` | `lg` | Vertical padding |
| `background` | `Background?` | `null` | Background style |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Spacing Options

```dart
// No spacing
ArcaneSection(
  spacing: SectionSpacing.none,
  children: [...],
)

// Small spacing
ArcaneSection(
  spacing: SectionSpacing.sm,
  children: [...],
)

// Medium spacing
ArcaneSection(
  spacing: SectionSpacing.md,
  children: [...],
)

// Large spacing (default)
ArcaneSection(
  spacing: SectionSpacing.lg,
  children: [...],
)

// Extra large spacing
ArcaneSection(
  spacing: SectionSpacing.xl,
  children: [...],
)
```

## With Background

```dart
ArcaneSection(
  background: Background.surface,
  children: [
    ArcaneContainer(
      children: [
        ArcaneHeading(text: 'Highlighted Section'),
        ArcaneParagraph(text: 'Content on a surface background.'),
      ],
    ),
  ],
)
```

## With Anchor ID

```dart
ArcaneSection(
  id: 'features',
  children: [
    ArcaneContainer(
      children: [
        ArcaneHeading(text: 'Features'),
        // Now linkable via #features
      ],
    ),
  ],
)
```

## Examples

### Landing Page Sections

```dart
ArcaneColumn(
  children: [
    // Hero Section
    ArcaneSection(
      spacing: SectionSpacing.xl,
      id: 'hero',
      children: [
        ArcaneContainer(
          styles: const ArcaneStyleData(
            textAlign: TextAlign.center,
          ),
          children: [
            ArcaneHeadline(text: 'Build Faster'),
            ArcaneSubheadline(text: 'Modern UI for Jaspr'),
            ArcaneRow(
              mainAxisAlignment: JustifyContent.center,
              gap: Gap.md,
              children: [
                ArcaneButton.primary(label: 'Get Started', onPressed: () {}),
                ArcaneButton.ghost(label: 'Learn More', onPressed: () {}),
              ],
            ),
          ],
        ),
      ],
    ),

    // Features Section
    ArcaneSection(
      id: 'features',
      background: Background.surface,
      children: [
        ArcaneContainer(
          children: [
            ArcaneHeading(text: 'Features'),
            ArcaneDiv(
              styles: const ArcaneStyleData(
                display: Display.grid,
                gridTemplateColumns: 'repeat(3, 1fr)',
                gap: Gap.lg,
              ),
              children: [
                ArcaneFeatureCard(title: 'Fast', icon: '⚡'),
                ArcaneFeatureCard(title: 'Flexible', icon: '🔧'),
                ArcaneFeatureCard(title: 'Beautiful', icon: '✨'),
              ],
            ),
          ],
        ),
      ],
    ),

    // Testimonials Section
    ArcaneSection(
      id: 'testimonials',
      children: [
        ArcaneContainer(
          children: [
            ArcaneHeading(text: 'What People Say'),
            // Testimonial cards...
          ],
        ),
      ],
    ),
  ],
)
```

### Alternating Backgrounds

```dart
ArcaneColumn(
  children: [
    ArcaneSection(
      children: [
        ArcaneContainer(children: [/* Content */]),
      ],
    ),
    ArcaneSection(
      background: Background.surface,
      children: [
        ArcaneContainer(children: [/* Content */]),
      ],
    ),
    ArcaneSection(
      children: [
        ArcaneContainer(children: [/* Content */]),
      ],
    ),
    ArcaneSection(
      background: Background.surface,
      children: [
        ArcaneContainer(children: [/* Content */]),
      ],
    ),
  ],
)
```

### Documentation Page

```dart
ArcaneColumn(
  children: [
    ArcaneSection(
      id: 'overview',
      spacing: SectionSpacing.md,
      children: [
        ArcaneHeading(text: 'Overview'),
        ArcaneParagraph(text: '...'),
      ],
    ),
    ArcaneSection(
      id: 'installation',
      spacing: SectionSpacing.md,
      children: [
        ArcaneHeading(text: 'Installation'),
        ArcaneCodeSnippet(code: 'dart pub add arcane_jaspr'),
      ],
    ),
    ArcaneSection(
      id: 'usage',
      spacing: SectionSpacing.md,
      children: [
        ArcaneHeading(text: 'Usage'),
        // Usage examples...
      ],
    ),
  ],
)
```

### CTA Section

```dart
ArcaneSection(
  spacing: SectionSpacing.xl,
  styles: const ArcaneStyleData(
    background: Background.accent,
    textAlign: TextAlign.center,
  ),
  children: [
    ArcaneContainer(
      maxWidth: ContainerMaxWidth.md,
      children: [
        ArcaneHeading(text: 'Ready to get started?'),
        ArcaneParagraph(text: 'Join thousands of developers using Arcane.'),
        ArcaneButton(
          label: 'Start Free Trial',
          onPressed: () {},
          styles: const ArcaneStyleData(
            marginTop: Spacing.lg,
          ),
        ),
      ],
    ),
  ],
)
```

## Related Components

- [ArcaneDiv](/docs/layout/arcane-div) - Generic layout div
- [ArcaneContainer](/docs/layout/arcane-container) - Centered container
- [ArcaneHeroSection](/docs/layout/arcane-hero-section) - Hero section variant
