---
title: ArcaneCard
description: Versatile card container with shadow and styling
layout: docs
---

# ArcaneCard

A container component styled as a card with background, border, shadow, and optional interactive states.

## Basic Usage

```dart
ArcaneCard(
  child: ArcaneText('Card content'),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `child` | `Component` | required | Card content |
| `padding` | `PaddingPreset?` | `md` | Internal padding |
| `shadow` | `Shadow?` | `sm` | Shadow depth |
| `borderRadius` | `Radius?` | `lg` | Corner radius |
| `isClickable` | `bool` | `false` | Enable hover effects |
| `onPressed` | `VoidCallback?` | `null` | Click handler |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Shadow Levels

```dart
// No shadow
ArcaneCard(
  shadow: Shadow.none,
  child: ArcaneText('Flat card'),
)

// Small shadow (default)
ArcaneCard(
  shadow: Shadow.sm,
  child: ArcaneText('Subtle shadow'),
)

// Medium shadow
ArcaneCard(
  shadow: Shadow.md,
  child: ArcaneText('Medium shadow'),
)

// Large shadow
ArcaneCard(
  shadow: Shadow.lg,
  child: ArcaneText('Prominent shadow'),
)

// Extra large shadow
ArcaneCard(
  shadow: Shadow.xl,
  child: ArcaneText('Elevated card'),
)
```

## Clickable Card

```dart
ArcaneCard(
  isClickable: true,
  onPressed: () => navigateToDetail(),
  child: ArcaneColumn(
    gap: Gap.sm,
    children: [
      ArcaneHeading(text: 'Click Me'),
      ArcaneText('Hover to see effect'),
    ],
  ),
)
```

## Examples

### Feature Card

```dart
ArcaneCard(
  padding: PaddingPreset.lg,
  child: ArcaneColumn(
    crossAxisAlignment: AlignItems.start,
    gap: Gap.md,
    children: [
      ArcaneDiv(
        styles: const ArcaneStyleData(
          widthCustom: '48px',
          heightCustom: '48px',
          borderRadius: Radius.lg,
          background: Background.accent,
          display: Display.flex,
          justifyContent: JustifyContent.center,
          alignItems: AlignItems.center,
        ),
        children: [span([text('⚡')])],
      ),
      ArcaneHeading(text: 'Fast Performance'),
      ArcaneText('Optimized for speed with minimal bundle size.'),
    ],
  ),
)
```

### Product Card

```dart
ArcaneCard(
  padding: PaddingPreset.none,
  isClickable: true,
  onPressed: () => viewProduct(product),
  child: ArcaneColumn(
    children: [
      ArcaneDiv(
        styles: const ArcaneStyleData(
          heightCustom: '200px',
          borderRadius: Radius.lgTop,
          overflow: Overflow.hidden,
        ),
        children: [
          ArcaneImage(src: product.image, fit: ImageFit.cover),
        ],
      ),
      ArcanePadding(
        padding: PaddingPreset.md,
        child: ArcaneColumn(
          crossAxisAlignment: AlignItems.start,
          gap: Gap.xs,
          children: [
            ArcaneText(product.name),
            ArcaneRow(
              mainAxisAlignment: JustifyContent.spaceBetween,
              children: [
                ArcaneText('\$${product.price}'),
                ArcaneRatingStars(rating: product.rating),
              ],
            ),
          ],
        ),
      ),
    ],
  ),
)
```

### Stats Card

```dart
ArcaneCard(
  child: ArcaneColumn(
    gap: Gap.sm,
    children: [
      ArcaneRow(
        mainAxisAlignment: JustifyContent.spaceBetween,
        children: [
          ArcaneText('Total Revenue'),
          ArcaneIconButton(
            icon: span([text('⋮')]),
            size: IconButtonSize.small,
            onPressed: () {},
          ),
        ],
      ),
      ArcaneHeading(text: '\$45,231.89'),
      ArcaneRow(
        gap: Gap.xs,
        children: [
          ArcaneBadge(label: '+20.1%', variant: BadgeVariant.success),
          ArcaneText('from last month'),
        ],
      ),
    ],
  ),
)
```

### User Card

```dart
ArcaneCard(
  child: ArcaneRow(
    gap: Gap.md,
    children: [
      ArcaneAvatar(
        imageUrl: user.avatar,
        size: AvatarSize.large,
      ),
      ArcaneExpanded(
        child: ArcaneColumn(
          crossAxisAlignment: AlignItems.start,
          gap: Gap.xs,
          children: [
            ArcaneHeading(text: user.name),
            ArcaneText(user.email),
            ArcaneFlow(
              gap: Gap.xs,
              children: [
                for (var role in user.roles)
                  ArcaneBadge(label: role),
              ],
            ),
          ],
        ),
      ),
      ArcaneIconButton(
        icon: span([text('✏')]),
        onPressed: () => editUser(user),
      ),
    ],
  ),
)
```

### Pricing Card

```dart
ArcaneCard(
  padding: PaddingPreset.xl,
  styles: const ArcaneStyleData(
    border: Border.accent,
  ),
  child: ArcaneColumn(
    crossAxisAlignment: AlignItems.center,
    gap: Gap.lg,
    children: [
      ArcaneBadge(label: 'Popular'),
      ArcaneHeading(text: 'Pro'),
      ArcaneRow(
        crossAxisAlignment: AlignItems.end,
        gap: Gap.xs,
        children: [
          ArcaneHeadline(text: '\$29'),
          ArcaneText('/month'),
        ],
      ),
      ArcaneDivider(),
      ArcaneColumn(
        gap: Gap.sm,
        children: [
          ArcaneRow(gap: Gap.sm, children: [span([text('✓')]), ArcaneText('Unlimited projects')]),
          ArcaneRow(gap: Gap.sm, children: [span([text('✓')]), ArcaneText('Priority support')]),
          ArcaneRow(gap: Gap.sm, children: [span([text('✓')]), ArcaneText('Custom domains')]),
        ],
      ),
      ArcaneButton.primary(
        label: 'Get Started',
        isFullWidth: true,
        onPressed: () {},
      ),
    ],
  ),
)
```

### Card Grid

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.grid,
    gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))',
    gap: Gap.lg,
  ),
  children: [
    for (var item in items)
      ArcaneCard(
        isClickable: true,
        onPressed: () => viewItem(item),
        child: ArcaneColumn(
          crossAxisAlignment: AlignItems.start,
          gap: Gap.sm,
          children: [
            ArcaneHeading(text: item.title),
            ArcaneText(item.description),
          ],
        ),
      ),
  ],
)
```

## Related Components

- [ArcaneGlassCard](/docs/view/arcane-glass-card) - Glassmorphism card
- [ArcaneBox](/docs/layout/arcane-box) - Simple bordered container
- [ArcaneFeatureCard](/docs/view/arcane-feature-card) - Feature showcase card
