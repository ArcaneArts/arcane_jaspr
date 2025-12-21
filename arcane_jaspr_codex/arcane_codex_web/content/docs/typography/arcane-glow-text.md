---
title: ArcaneGlowText
description: Text with glowing effect
layout: docs
component: glow-text
---

# ArcaneGlowText

A text component that displays text with a glowing effect, perfect for dark themes and emphasis.

## Basic Usage

```dart
ArcaneGlowText(
  text: 'Glowing Text',
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `text` | `String` | required | Text content |
| `color` | `String?` | `accent` | Glow color |
| `intensity` | `GlowIntensity` | `medium` | Glow strength |
| `fontSize` | `FontSize?` | `null` | Text size |
| `fontWeight` | `FontWeight?` | `null` | Text weight |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Glow Intensity

```dart
// Subtle glow
ArcaneGlowText(
  text: 'Subtle Glow',
  intensity: GlowIntensity.low,
)

// Medium glow (default)
ArcaneGlowText(
  text: 'Medium Glow',
  intensity: GlowIntensity.medium,
)

// Strong glow
ArcaneGlowText(
  text: 'Strong Glow',
  intensity: GlowIntensity.high,
)

// Intense glow
ArcaneGlowText(
  text: 'Intense Glow',
  intensity: GlowIntensity.intense,
)
```

## Custom Colors

```dart
// Accent color (default)
ArcaneGlowText(
  text: 'Accent Glow',
  color: 'var(--accent-500)',
)

// Success green
ArcaneGlowText(
  text: 'Success Glow',
  color: '#10B981',
)

// Warning orange
ArcaneGlowText(
  text: 'Warning Glow',
  color: '#F59E0B',
)

// Error red
ArcaneGlowText(
  text: 'Error Glow',
  color: '#EF4444',
)

// Purple
ArcaneGlowText(
  text: 'Purple Glow',
  color: '#8B5CF6',
)
```

## Examples

### Hero Title

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    background: Background.dark,
    padding: PaddingPreset.xl2,
    textAlign: TextAlign.center,
  ),
  children: [
    ArcaneGlowText(
      text: 'The Future is Here',
      fontSize: FontSize.xl4,
      fontWeight: FontWeight.bold,
      intensity: GlowIntensity.high,
    ),
    ArcaneGutter(size: GutterSize.md),
    ArcaneText(
      'Experience the next generation',
      styles: const ArcaneStyleData(textColor: TextColor.muted),
    ),
  ],
)
```

### Status Indicator

```dart
ArcaneRow(
  gap: Gap.sm,
  crossAxisAlignment: AlignItems.center,
  children: [
    ArcaneGlowText(
      text: '●',
      color: '#10B981',
      intensity: GlowIntensity.high,
    ),
    ArcaneText('System Online'),
  ],
)
```

### Gaming UI

```dart
ArcaneCard(
  styles: const ArcaneStyleData(
    background: Background.dark,
  ),
  child: ArcaneColumn(
    crossAxisAlignment: AlignItems.center,
    gap: Gap.lg,
    children: [
      ArcaneGlowText(
        text: 'LEVEL UP',
        fontSize: FontSize.xl3,
        fontWeight: FontWeight.bold,
        color: '#F59E0B',
        intensity: GlowIntensity.intense,
      ),
      ArcaneGlowText(
        text: '+500 XP',
        fontSize: FontSize.xl,
        color: '#10B981',
        intensity: GlowIntensity.medium,
      ),
    ],
  ),
)
```

### Neon Sign Effect

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    background: Background.dark,
    padding: PaddingPreset.xl2,
  ),
  children: [
    ArcaneGlowText(
      text: 'OPEN',
      fontSize: FontSize.xl4,
      fontWeight: FontWeight.bold,
      color: '#EF4444',
      intensity: GlowIntensity.intense,
    ),
  ],
)
```

### Feature Highlight

```dart
ArcaneRow(
  gap: Gap.lg,
  children: [
    ArcaneCard(
      styles: const ArcaneStyleData(background: Background.dark),
      child: ArcaneColumn(
        crossAxisAlignment: AlignItems.center,
        children: [
          ArcaneGlowText(
            text: '99.9%',
            fontSize: FontSize.xl2,
            fontWeight: FontWeight.bold,
            color: '#10B981',
          ),
          ArcaneText('Uptime'),
        ],
      ),
    ),
    ArcaneCard(
      styles: const ArcaneStyleData(background: Background.dark),
      child: ArcaneColumn(
        crossAxisAlignment: AlignItems.center,
        children: [
          ArcaneGlowText(
            text: '<50ms',
            fontSize: FontSize.xl2,
            fontWeight: FontWeight.bold,
            color: '#3B82F6',
          ),
          ArcaneText('Latency'),
        ],
      ),
    ),
  ],
)
```

### Countdown Timer

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    background: Background.dark,
    padding: PaddingPreset.xl,
    textAlign: TextAlign.center,
  ),
  children: [
    ArcaneText('Launch in'),
    ArcaneGutter(size: GutterSize.md),
    ArcaneRow(
      mainAxisAlignment: JustifyContent.center,
      gap: Gap.lg,
      children: [
        ArcaneGlowText(text: '02', fontSize: FontSize.xl3, fontWeight: FontWeight.bold),
        ArcaneGlowText(text: ':', fontSize: FontSize.xl3),
        ArcaneGlowText(text: '15', fontSize: FontSize.xl3, fontWeight: FontWeight.bold),
        ArcaneGlowText(text: ':', fontSize: FontSize.xl3),
        ArcaneGlowText(text: '42', fontSize: FontSize.xl3, fontWeight: FontWeight.bold),
      ],
    ),
  ],
)
```

## Related Components

- [ArcaneGradientText](/arcane_jaspr/docs/typography/arcane-gradient-text) - Gradient text
- [ArcaneHeadline](/arcane_jaspr/docs/typography/arcane-headline) - Large headlines
- [ArcaneText](/arcane_jaspr/docs/typography/arcane-text) - Basic text
