---
title: ArcaneFeatureCard
description: Feature showcase card with icon and description
layout: docs
component: feature-card
---

# ArcaneFeatureCard

A card component designed for showcasing features with icon, title, and description.

## Basic Usage

```dart
ArcaneFeatureCard(
  icon: span([text('⚡')]),
  title: 'Fast Performance',
  description: 'Optimized for speed and efficiency',
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `icon` | `Component` | required | Feature icon |
| `title` | `String` | required | Feature title |
| `description` | `String?` | `null` | Feature description |
| `action` | `Component?` | `null` | Action button |
| `variant` | `FeatureCardVariant` | `default_` | Card style |
| `onPressed` | `VoidCallback?` | `null` | Click handler |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Variants

```dart
// Default
ArcaneFeatureCard(
  variant: FeatureCardVariant.default_,
  icon: span([text('⚡')]),
  title: 'Feature',
  description: 'Description',
)

// Outlined
ArcaneFeatureCard(
  variant: FeatureCardVariant.outlined,
  icon: span([text('⚡')]),
  title: 'Feature',
  description: 'Description',
)

// Filled
ArcaneFeatureCard(
  variant: FeatureCardVariant.filled,
  icon: span([text('⚡')]),
  title: 'Feature',
  description: 'Description',
)
```

## With Action

```dart
ArcaneFeatureCard(
  icon: span([text('📚')]),
  title: 'Documentation',
  description: 'Comprehensive guides and API reference',
  action: ArcaneButton.link(
    label: 'Learn More →',
    onPressed: () => goToDocs(),
  ),
)
```

## Clickable Card

```dart
ArcaneFeatureCard(
  icon: span([text('🔧')]),
  title: 'Settings',
  description: 'Configure your preferences',
  onPressed: () => goToSettings(),
)
```

## Examples

### Features Grid

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.grid,
    gridTemplateColumns: 'repeat(3, 1fr)',
    gap: Gap.lg,
  ),
  children: [
    ArcaneFeatureCard(
      icon: span([text('⚡')]),
      title: 'Lightning Fast',
      description: 'Optimized rendering for smooth performance',
    ),
    ArcaneFeatureCard(
      icon: span([text('🎨')]),
      title: 'Beautiful Design',
      description: 'Modern, clean aesthetic that looks great',
    ),
    ArcaneFeatureCard(
      icon: span([text('🔒')]),
      title: 'Secure',
      description: 'Built with security best practices',
    ),
    ArcaneFeatureCard(
      icon: span([text('📱')]),
      title: 'Responsive',
      description: 'Works perfectly on any screen size',
    ),
    ArcaneFeatureCard(
      icon: span([text('🧩')]),
      title: 'Modular',
      description: 'Use only what you need',
    ),
    ArcaneFeatureCard(
      icon: span([text('🌐')]),
      title: 'Accessible',
      description: 'WCAG compliant components',
    ),
  ],
)
```

### Landing Page Section

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
            ArcaneHeadline(text: 'Why Choose Arcane?'),
            ArcaneSubheadline(text: 'Everything you need to build amazing apps'),
          ],
        ),
        ArcaneGutter(size: GutterSize.xl),
        ArcaneDiv(
          styles: const ArcaneStyleData(
            display: Display.grid,
            gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))',
            gap: Gap.lg,
          ),
          children: [
            for (var feature in features)
              ArcaneFeatureCard(
                icon: feature.icon,
                title: feature.title,
                description: feature.description,
                action: ArcaneButton.link(
                  label: 'Learn more',
                  onPressed: () => learnMore(feature.id),
                ),
              ),
          ],
        ),
      ],
    ),
  ],
)
```

### Horizontal Feature Cards

```dart
ArcaneColumn(
  gap: Gap.md,
  children: [
    for (var feature in features)
      ArcaneCard(
        child: ArcaneRow(
          gap: Gap.lg,
          children: [
            ArcaneDiv(
              styles: const ArcaneStyleData(
                widthCustom: '64px',
                heightCustom: '64px',
                borderRadius: Radius.lg,
                background: Background.accent,
                display: Display.flex,
                justifyContent: JustifyContent.center,
                alignItems: AlignItems.center,
                fontSize: FontSize.xl2,
              ),
              children: [feature.icon],
            ),
            ArcaneExpanded(
              child: ArcaneColumn(
                crossAxisAlignment: AlignItems.start,
                gap: Gap.xs,
                children: [
                  ArcaneHeading(text: feature.title, level: HeadingLevel.h3),
                  ArcaneText(feature.description),
                ],
              ),
            ),
          ],
        ),
      ),
  ],
)
```

### With Custom Icon Container

```dart
ArcaneFeatureCard(
  icon: ArcaneDiv(
    styles: const ArcaneStyleData(
      widthCustom: '48px',
      heightCustom: '48px',
      borderRadius: Radius.lg,
      raw: {
        'background': 'linear-gradient(135deg, #3B82F6, #8B5CF6)',
      },
      display: Display.flex,
      justifyContent: JustifyContent.center,
      alignItems: AlignItems.center,
    ),
    children: [span([text('🚀')])],
  ),
  title: 'Quick Setup',
  description: 'Get started in under 5 minutes',
)
```

### Comparison Features

```dart
ArcaneRow(
  gap: Gap.lg,
  children: [
    ArcaneExpanded(
      child: ArcaneColumn(
        gap: Gap.md,
        children: [
          ArcaneHeading(text: 'Free'),
          for (var feature in freeFeatures)
            ArcaneFeatureCard(
              icon: span([text('✓')]),
              title: feature,
              variant: FeatureCardVariant.outlined,
            ),
        ],
      ),
    ),
    ArcaneExpanded(
      child: ArcaneColumn(
        gap: Gap.md,
        children: [
          ArcaneHeading(text: 'Pro'),
          for (var feature in proFeatures)
            ArcaneFeatureCard(
              icon: span([text('✓')]),
              title: feature,
              variant: FeatureCardVariant.filled,
            ),
        ],
      ),
    ),
  ],
)
```

## Related Components

- [ArcaneCard](/arcane_jaspr/docs/layout/arcane-card) - Basic card
- [ArcanePricingCard](/arcane_jaspr/docs/view/arcane-pricing-card) - Pricing card
- [ArcaneTestimonialCard](/arcane_jaspr/docs/view/arcane-testimonial-card) - Testimonial card
