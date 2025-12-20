---
title: ArcaneGradientText
description: Text with gradient color effects
layout: docs
component: gradient-text
---

# ArcaneGradientText

A text component that displays text with gradient color effects for eye-catching headlines and emphasis.

## Basic Usage

```dart
ArcaneGradientText(
  text: 'Gradient Text',
  gradient: ['#3B82F6', '#8B5CF6'],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `text` | `String` | required | Text content |
| `gradient` | `List<String>` | required | Gradient color stops |
| `direction` | `GradientDirection` | `horizontal` | Gradient direction |
| `fontSize` | `FontSize?` | `null` | Text size |
| `fontWeight` | `FontWeight?` | `null` | Text weight |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Gradient Directions

```dart
// Horizontal (left to right)
ArcaneGradientText(
  text: 'Horizontal Gradient',
  gradient: ['#3B82F6', '#8B5CF6'],
  direction: GradientDirection.horizontal,
)

// Vertical (top to bottom)
ArcaneGradientText(
  text: 'Vertical Gradient',
  gradient: ['#3B82F6', '#8B5CF6'],
  direction: GradientDirection.vertical,
)

// Diagonal
ArcaneGradientText(
  text: 'Diagonal Gradient',
  gradient: ['#3B82F6', '#8B5CF6'],
  direction: GradientDirection.diagonal,
)
```

## Multiple Color Stops

```dart
ArcaneGradientText(
  text: 'Rainbow Text',
  gradient: ['#EF4444', '#F59E0B', '#10B981', '#3B82F6', '#8B5CF6'],
)
```

## Examples

### Hero Headline

```dart
ArcaneColumn(
  crossAxisAlignment: AlignItems.center,
  children: [
    ArcaneGradientText(
      text: 'Build the Future',
      gradient: ['var(--accent-400)', 'var(--accent-600)'],
      fontSize: FontSize.xl4,
      fontWeight: FontWeight.bold,
    ),
    ArcaneSubheadline(text: 'The next generation of web development'),
  ],
)
```

### Brand Accent

```dart
ArcaneRow(
  crossAxisAlignment: AlignItems.center,
  gap: Gap.sm,
  children: [
    ArcaneText('Welcome to'),
    ArcaneGradientText(
      text: 'Arcane',
      gradient: ['#10B981', '#3B82F6'],
      fontWeight: FontWeight.bold,
    ),
  ],
)
```

### Feature Highlight

```dart
ArcaneCard(
  child: ArcaneColumn(
    crossAxisAlignment: AlignItems.center,
    gap: Gap.md,
    children: [
      span([text('⚡')]),
      ArcaneGradientText(
        text: 'Lightning Fast',
        gradient: ['#F59E0B', '#EF4444'],
        fontSize: FontSize.xl,
        fontWeight: FontWeight.semibold,
      ),
      ArcaneText('Optimized for performance'),
    ],
  ),
)
```

### Section Title

```dart
ArcaneSection(
  children: [
    ArcaneContainer(
      children: [
        ArcaneColumn(
          crossAxisAlignment: AlignItems.center,
          gap: Gap.md,
          children: [
            ArcaneGradientText(
              text: 'Powerful Features',
              gradient: ['#8B5CF6', '#EC4899'],
              fontSize: FontSize.xl3,
              fontWeight: FontWeight.bold,
            ),
            ArcaneSubheadline(
              text: 'Everything you need in one place',
            ),
          ],
        ),
      ],
    ),
  ],
)
```

### Animated Gradient

```dart
ArcaneGradientText(
  text: 'Animated',
  gradient: ['#3B82F6', '#8B5CF6', '#EC4899', '#3B82F6'],
  styles: const ArcaneStyleData(
    raw: {
      'background-size': '200% auto',
      'animation': 'gradient 3s linear infinite',
    },
  ),
)
```

### CTA Button Text

```dart
ArcaneButton(
  onPressed: () {},
  styles: const ArcaneStyleData(
    background: Background.transparent,
    border: Border.accent,
  ),
  child: ArcaneGradientText(
    text: 'Get Started Free',
    gradient: ['var(--accent-400)', 'var(--accent-600)'],
    fontWeight: FontWeight.semibold,
  ),
)
```

### Logo Text

```dart
ArcaneRow(
  crossAxisAlignment: AlignItems.center,
  gap: Gap.xs,
  children: [
    span([text('🔮')]),
    ArcaneGradientText(
      text: 'Arcane',
      gradient: ['#10B981', '#3B82F6'],
      fontSize: FontSize.xl,
      fontWeight: FontWeight.bold,
    ),
  ],
)
```

## Related Components

- [ArcaneGlowText](/docs/typography/arcane-glow-text) - Glowing text effect
- [ArcaneHeadline](/docs/typography/arcane-headline) - Large headlines
- [ArcaneText](/docs/typography/arcane-text) - Basic text
