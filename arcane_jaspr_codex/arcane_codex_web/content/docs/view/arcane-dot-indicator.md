---
title: ArcaneDotIndicator
description: Dot indicators for carousels and page views
layout: docs
component: dot-indicator
---

# ArcaneDotIndicator

A dot indicator component commonly used for carousels, page views, and step indicators.

## Basic Usage

```dart
ArcaneDotIndicator(
  index: currentIndex,
  length: 5,
  onChanged: (index) => setState(() => currentIndex = index),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `index` | `int` | required | Current active index |
| `length` | `int` | required | Total number of dots |
| `onChanged` | `ValueChanged<int>?` | `null` | Index change handler |
| `size` | `DotIndicatorSize` | `md` | Dot size variant |
| `activeColor` | `String?` | `null` | Active dot color |
| `inactiveColor` | `String?` | `null` | Inactive dot color |

## Size Variants

```dart
ArcaneDotIndicator(
  index: 0,
  length: 4,
  size: DotIndicatorSize.sm,
)

ArcaneDotIndicator(
  index: 0,
  length: 4,
  size: DotIndicatorSize.md,  // Default
)

ArcaneDotIndicator(
  index: 0,
  length: 4,
  size: DotIndicatorSize.lg,
)
```

## Custom Colors

```dart
ArcaneDotIndicator(
  index: currentIndex,
  length: 5,
  activeColor: 'var(--arcane-accent)',
  inactiveColor: 'var(--arcane-surface-variant)',
  onChanged: (i) => setState(() => currentIndex = i),
)
```

## Examples

### Image Carousel

```dart
ArcaneColumn(
  children: [
    // Image display
    ArcaneDiv(
      styles: const ArcaneStyleData(
        widthCustom: '100%',
        heightCustom: '300px',
        borderRadius: Radius.lg,
        overflow: Overflow.hidden,
      ),
      children: [images[currentIndex]],
    ),
    // Dot indicator
    ArcaneDiv(
      styles: const ArcaneStyleData(
        margin: MarginPreset.topMd,
        display: Display.flex,
        justifyContent: JustifyContent.center,
      ),
      children: [
        ArcaneDotIndicator(
          index: currentIndex,
          length: images.length,
          onChanged: (i) => setState(() => currentIndex = i),
        ),
      ],
    ),
  ],
)
```

### Onboarding Flow

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    position: Position.absolute,
    bottom: '24px',
    left: '50%',
    raw: {'transform': 'translateX(-50%)'},
  ),
  children: [
    ArcaneDotIndicator(
      index: onboardingStep,
      length: 4,
      size: DotIndicatorSize.lg,
      onChanged: (i) => goToStep(i),
    ),
  ],
)
```

## Related Components

- [ArcaneStepIndicator](/arcane_jaspr/docs/view/arcane-step-indicator) - Labeled step indicator
- [ArcaneTabs](/arcane_jaspr/docs/layout/arcane-tabs) - Tabbed content
- [ArcaneSwitcher](/arcane_jaspr/docs/view/arcane-switcher) - Animated content switcher
