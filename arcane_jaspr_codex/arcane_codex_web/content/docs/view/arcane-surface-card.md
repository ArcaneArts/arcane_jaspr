---
title: ArcaneSurfaceCard
description: Card with surface effects like blur, frosted glass, and gradients
layout: docs
component: surface-card
---

# ArcaneSurfaceCard

A card component with various surface effects including blur, frosted glass, and gradients.

## Basic Usage

```dart
ArcaneSurfaceCard(
  effect: SurfaceEffect.frosted,
  child: ArcaneText('Frosted Glass Card'),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `child` | `Component` | required | Card content |
| `effect` | `SurfaceEffect` | `none` | Surface effect type |
| `blurAmount` | `double` | `10.0` | Blur intensity |
| `backgroundOpacity` | `double` | `0.8` | Background opacity (0-1) |
| `backgroundColor` | `String?` | `null` | Custom background color |
| `gradientColors` | `List<String>?` | `null` | Gradient colors |
| `gradientAngle` | `int` | `135` | Gradient angle in degrees |
| `borderRadius` | `String?` | `null` | Border radius |
| `showBorder` | `bool` | `true` | Show border |
| `padding` | `String?` | `null` | Custom padding |
| `shadow` | `ShadowIntensity` | `md` | Shadow intensity |

## SurfaceEffect Options

- `none` - Plain surface (no effect)
- `blur` - Subtle blur effect
- `frosted` - Frosted glass effect
- `glass` - Full glassmorphism
- `ice` - Crystal/ice effect
- `gradient` - Gradient background

## Factory Constructors

### Blur Effect

```dart
ArcaneSurfaceCard.blur(
  blurAmount: 10,
  child: CardContent(),
)
```

### Frosted Glass

```dart
ArcaneSurfaceCard.frosted(
  blurAmount: 12,
  backgroundOpacity: 0.6,
  child: CardContent(),
)
```

### Glass Effect

```dart
ArcaneSurfaceCard.glass(
  blurAmount: 16,
  backgroundOpacity: 0.4,
  child: CardContent(),
)
```

### Gradient

```dart
ArcaneSurfaceCard.gradient(
  gradientColors: ['#10b981', '#3b82f6'],
  gradientAngle: 135,
  child: CardContent(),
)
```

## Shadow Intensity

```dart
ArcaneSurfaceCard.frosted(
  shadow: ShadowIntensity.none,  // No shadow
  child: CardContent(),
)

ArcaneSurfaceCard.frosted(
  shadow: ShadowIntensity.lg,  // Large shadow
  child: CardContent(),
)

ArcaneSurfaceCard.frosted(
  shadow: ShadowIntensity.xl,  // Extra large shadow
  child: CardContent(),
)
```

## Examples

### Feature Card

```dart
ArcaneSurfaceCard.glass(
  child: ArcaneColumn(
    gapSize: Gap.md,
    children: [
      ArcaneText('✨', size: FontSize.xl),
      ArcaneText('Premium Feature', weight: FontWeight.bold),
      ArcaneText(
        'Unlock advanced capabilities',
        color: TextColor.muted,
      ),
    ],
  ),
)
```

### Hero Banner

```dart
ArcaneSurfaceCard.gradient(
  gradientColors: ['#8b5cf6', '#ec4899'],
  padding: '48px',
  child: ArcaneColumn(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ArcaneHeadline('Welcome'),
      ArcaneText('Experience the future of web apps'),
      ArcaneButton.primary(
        label: 'Get Started',
        onPressed: () {},
      ),
    ],
  ),
)
```

## Related Components

- [ArcaneCard](/arcane_jaspr/docs/layout/arcane-card) - Basic card component
- [ArcaneBox](/arcane_jaspr/docs/layout/arcane-box) - Styled box container
