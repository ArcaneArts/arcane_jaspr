---
title: ArcaneHeroSection
description: Full-width hero section for landing pages
layout: docs
component: hero-section
---

# ArcaneHeroSection

A pre-styled section component for creating impactful hero areas on landing pages with centered content and optional backgrounds.

## Basic Usage

```dart
ArcaneHeroSection(
  title: 'Welcome to Our Platform',
  subtitle: 'Build faster, ship smarter',
  cta: ArcaneButton.primary(
    label: 'Get Started',
    onPressed: () {},
  ),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `title` | `String` | required | Main headline |
| `subtitle` | `String?` | `null` | Supporting text |
| `cta` | `Component?` | `null` | Call-to-action button(s) |
| `secondaryCta` | `Component?` | `null` | Secondary action |
| `background` | `HeroBackground?` | `null` | Background style |
| `height` | `HeroHeight?` | `large` | Section height |
| `alignment` | `HeroAlignment?` | `center` | Content alignment |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Heights

```dart
// Small
ArcaneHeroSection(
  height: HeroHeight.small,
  title: 'Page Title',
)

// Medium
ArcaneHeroSection(
  height: HeroHeight.medium,
  title: 'Medium Hero',
)

// Large (default)
ArcaneHeroSection(
  height: HeroHeight.large,
  title: 'Large Hero',
)

// Full screen
ArcaneHeroSection(
  height: HeroHeight.fullScreen,
  title: 'Full Screen Hero',
)
```

## Alignment

```dart
// Left aligned
ArcaneHeroSection(
  alignment: HeroAlignment.left,
  title: 'Left Aligned',
  subtitle: 'Content aligned to the left',
)

// Center (default)
ArcaneHeroSection(
  alignment: HeroAlignment.center,
  title: 'Centered',
  subtitle: 'Content centered',
)

// Right aligned
ArcaneHeroSection(
  alignment: HeroAlignment.right,
  title: 'Right Aligned',
  subtitle: 'Content aligned to the right',
)
```

## Examples

### Landing Page Hero

```dart
ArcaneHeroSection(
  height: HeroHeight.large,
  title: 'Build Beautiful Web Apps',
  subtitle: 'A comprehensive UI library for Jaspr with 235+ components',
  cta: ArcaneButton.primary(
    label: 'Get Started',
    size: ButtonSize.large,
    onPressed: () {},
  ),
  secondaryCta: ArcaneButton.ghost(
    label: 'View Docs',
    size: ButtonSize.large,
    onPressed: () {},
  ),
)
```

### With Background Image

```dart
ArcaneHeroSection(
  height: HeroHeight.fullScreen,
  background: HeroBackground.image('/hero-bg.jpg'),
  title: 'Welcome',
  subtitle: 'Discover something amazing',
  cta: ArcaneButton.primary(label: 'Explore', onPressed: () {}),
  styles: const ArcaneStyleData(
    textColor: TextColor.onPrimary,
  ),
)
```

### Gradient Background

```dart
ArcaneHeroSection(
  background: HeroBackground.gradient([
    'var(--accent-900)',
    'var(--accent-700)',
  ]),
  title: 'Premium Features',
  subtitle: 'Unlock the full potential',
  cta: ArcaneButton(label: 'Upgrade Now', onPressed: () {}),
)
```

### Split Hero

```dart
ArcaneHeroSection(
  height: HeroHeight.medium,
  alignment: HeroAlignment.left,
  children: [
    ArcaneContainer(
      children: [
        ArcaneRow(
          gap: Gap.xl2,
          crossAxisAlignment: AlignItems.center,
          children: [
            ArcaneExpanded(
              child: ArcaneColumn(
                crossAxisAlignment: AlignItems.start,
                gap: Gap.lg,
                children: [
                  ArcaneHeadline(text: 'The Future is Here'),
                  ArcaneSubheadline(text: 'Revolutionary technology...'),
                  ArcaneRow(
                    gap: Gap.md,
                    children: [
                      ArcaneButton.primary(label: 'Try Free', onPressed: () {}),
                      ArcaneButton.ghost(label: 'Watch Demo', onPressed: () {}),
                    ],
                  ),
                ],
              ),
            ),
            ArcaneExpanded(
              child: ArcaneImage(src: '/hero-image.png'),
            ),
          ],
        ),
      ],
    ),
  ],
)
```

### Minimal Hero

```dart
ArcaneHeroSection(
  height: HeroHeight.small,
  background: HeroBackground.surface,
  title: 'Documentation',
  subtitle: 'Everything you need to get started',
)
```

### With Stats

```dart
ArcaneHeroSection(
  title: 'Trusted by Developers',
  subtitle: 'Join thousands of developers building with Arcane',
  cta: ArcaneButton.primary(label: 'Start Building', onPressed: () {}),
  children: [
    ArcaneGutter(size: GutterSize.xl),
    ArcaneRow(
      mainAxisAlignment: JustifyContent.center,
      gap: Gap.xl2,
      children: [
        ArcaneColumn(
          crossAxisAlignment: AlignItems.center,
          children: [
            ArcaneHeading(text: '10K+'),
            ArcaneText('Developers'),
          ],
        ),
        ArcaneColumn(
          crossAxisAlignment: AlignItems.center,
          children: [
            ArcaneHeading(text: '235+'),
            ArcaneText('Components'),
          ],
        ),
        ArcaneColumn(
          crossAxisAlignment: AlignItems.center,
          children: [
            ArcaneHeading(text: '99%'),
            ArcaneText('Satisfaction'),
          ],
        ),
      ],
    ),
  ],
)
```

## Related Components

- [ArcaneSection](/arcane_jaspr/docs/layout/arcane-section) - Generic section
- [ArcaneContainer](/arcane_jaspr/docs/layout/arcane-container) - Centered container
- [ArcaneHeadline](/arcane_jaspr/docs/typography/arcane-headline) - Large headlines
