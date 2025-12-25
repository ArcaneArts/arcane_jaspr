---
title: ArcaneMarquee
description: Infinite scrolling marquee with optional fade edges
layout: docs
component: marquee
---

# ArcaneMarquee

An infinite scrolling marquee/carousel component with automatic content duplication for seamless looping.

## Basic Usage

```dart
ArcaneMarquee(
  children: [
    for (final item in items) ItemCard(item),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `children` | `List<Component>` | required | Content to scroll |
| `duration` | `String` | `'30s'` | Animation duration |
| `showFadeEdges` | `bool` | `true` | Show fade edge overlays |
| `pauseOnHover` | `bool` | `true` | Pause animation on hover |
| `gap` | `String?` | `null` | Gap between items |
| `fadeColor` | `String?` | `null` | Fade edge color |

## Examples

### Logo Carousel

```dart
ArcaneMarquee(
  duration: '20s',
  showFadeEdges: true,
  children: [
    for (final logo in partnerLogos)
      ArcaneImage(src: logo.url, alt: logo.name),
  ],
)
```

### Tech Stack Display

```dart
ArcaneMarquee(
  duration: '25s',
  pauseOnHover: true,
  children: [
    for (final tech in ['React', 'Vue', 'Angular', 'Svelte', 'Next.js'])
      ArcaneDiv(
        styles: const ArcaneStyleData(
          padding: PaddingPreset.md,
          background: Background.surface,
          borderRadius: Radius.md,
          border: BorderPreset.subtle,
        ),
        children: [ArcaneText(tech)],
      ),
  ],
)
```

### Testimonials Marquee

```dart
ArcaneMarquee(
  duration: '40s',
  showFadeEdges: true,
  children: [
    for (final testimonial in testimonials)
      ArcaneCard(
        children: [
          ArcaneText(testimonial.quote),
          ArcaneAuthorCard(
            name: testimonial.author,
            role: testimonial.role,
          ),
        ],
      ),
  ],
)
```

## Reverse Direction

Use `ArcaneMarqueeReverse` for opposite scroll direction:

```dart
ArcaneColumn(
  children: [
    ArcaneMarquee(children: [...]),
    ArcaneMarqueeReverse(children: [...]),
  ],
)
```

## Related Components

- [ArcaneFadeEdge](/docs/view/arcane-fade-edge) - Standalone fade edges
- [ArcaneLogoCarousel](/docs/layout/arcane-logo-carousel) - Logo-specific carousel
