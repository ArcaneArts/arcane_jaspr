---
title: ArcaneHeadline
description: Large display headline for hero sections
layout: docs
component: headline
---

# ArcaneHeadline

A large, impactful headline component designed for hero sections and major page titles.

## Basic Usage

```dart
ArcaneHeadline(text: 'Build Amazing Products')
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `text` | `String` | required | Headline text |
| `size` | `HeadlineSize` | `large` | Display size |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## Sizes

```dart
// Medium
ArcaneHeadline(
  text: 'Medium Headline',
  size: HeadlineSize.medium,
)

// Large (default)
ArcaneHeadline(
  text: 'Large Headline',
  size: HeadlineSize.large,
)

// Extra Large
ArcaneHeadline(
  text: 'XL Headline',
  size: HeadlineSize.xl,
)

// 2XL
ArcaneHeadline(
  text: 'Massive Headline',
  size: HeadlineSize.xl2,
)
```

## Examples

### Hero Section

```dart
ArcaneHeroSection(
  children: [
    ArcaneContainer(
      styles: const ArcaneStyleData(
        textAlign: TextAlign.center,
      ),
      children: [
        ArcaneHeadline(
          text: 'Ship Faster, Build Better',
          size: HeadlineSize.xl,
        ),
        ArcaneSubheadline(
          text: 'The complete UI toolkit for modern web applications',
        ),
        ArcaneGutter(size: GutterSize.lg),
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
)
```

### Landing Page Header

```dart
ArcaneColumn(
  crossAxisAlignment: AlignItems.center,
  gap: Gap.lg,
  children: [
    ArcaneBadge(label: 'New Release'),
    ArcaneHeadline(
      text: 'Introducing Arcane 2.0',
      size: HeadlineSize.xl2,
      styles: const ArcaneStyleData(
        textAlign: TextAlign.center,
      ),
    ),
    ArcaneSubheadline(
      text: 'A complete redesign with 235+ components',
      styles: const ArcaneStyleData(
        textAlign: TextAlign.center,
        maxWidthCustom: '600px',
      ),
    ),
  ],
)
```

### Feature Section

```dart
ArcaneSection(
  id: 'features',
  children: [
    ArcaneContainer(
      children: [
        ArcaneColumn(
          crossAxisAlignment: AlignItems.center,
          gap: Gap.md,
          children: [
            ArcaneHeadline(
              text: 'Everything You Need',
              size: HeadlineSize.large,
              styles: const ArcaneStyleData(
                textAlign: TextAlign.center,
              ),
            ),
            ArcaneSubheadline(
              text: 'Build complete applications with our comprehensive toolkit',
              styles: const ArcaneStyleData(
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        ArcaneGutter(size: GutterSize.xl),
        // Feature cards...
      ],
    ),
  ],
)
```

### Gradient Headline

```dart
ArcaneHeadline(
  text: 'The Future is Here',
  size: HeadlineSize.xl,
  styles: const ArcaneStyleData(
    raw: {
      'background': 'linear-gradient(90deg, var(--accent-400), var(--accent-600))',
      '-webkit-background-clip': 'text',
      '-webkit-text-fill-color': 'transparent',
    },
  ),
)
```

### Split Layout

```dart
ArcaneRow(
  gap: Gap.xl2,
  crossAxisAlignment: AlignItems.center,
  children: [
    ArcaneExpanded(
      child: ArcaneColumn(
        crossAxisAlignment: AlignItems.start,
        gap: Gap.lg,
        children: [
          ArcaneHeadline(
            text: 'Design. Build. Launch.',
            size: HeadlineSize.large,
          ),
          ArcaneSubheadline(
            text: 'Create stunning interfaces in minutes, not months.',
          ),
          ArcaneButton.primary(label: 'Start Free', onPressed: () {}),
        ],
      ),
    ),
    ArcaneExpanded(
      child: ArcaneImage(src: '/hero-illustration.svg'),
    ),
  ],
)
```

### Pricing Header

```dart
ArcaneColumn(
  crossAxisAlignment: AlignItems.center,
  gap: Gap.md,
  children: [
    ArcaneHeadline(
      text: 'Simple, Transparent Pricing',
      size: HeadlineSize.large,
    ),
    ArcaneSubheadline(
      text: 'No hidden fees. Cancel anytime.',
    ),
    ArcaneGutter(size: GutterSize.md),
    ArcaneToggleButtonGroup<String>(
      value: billingCycle,
      options: [
        ToggleOption(value: 'monthly', label: 'Monthly'),
        ToggleOption(value: 'yearly', label: 'Yearly (Save 20%)'),
      ],
      onChanged: (v) => setState(() => billingCycle = v),
    ),
  ],
)
```

## Related Components

- [ArcaneSubheadline](/arcane_jaspr/docs/typography/arcane-subheadline) - Subtitle text
- [ArcaneHeading](/arcane_jaspr/docs/typography/arcane-heading) - Section headings
- [ArcaneGradientText](/arcane_jaspr/docs/typography/arcane-gradient-text) - Gradient text
