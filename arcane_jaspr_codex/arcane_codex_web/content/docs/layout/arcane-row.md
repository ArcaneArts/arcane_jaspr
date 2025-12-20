---
title: ArcaneRow
description: Horizontal flex layout container
layout: docs
---

# ArcaneRow

A convenience component for horizontal flex layouts. Automatically applies `display: flex` and `flex-direction: row`.

## Basic Usage

```dart
ArcaneRow(
  children: [
    ArcaneText('Left'),
    ArcaneText('Center'),
    ArcaneText('Right'),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `children` | `List<Component>` | `[]` | Child components |
| `gap` | `Gap?` | `null` | Space between children |
| `mainAxisAlignment` | `JustifyContent?` | `null` | Horizontal alignment |
| `crossAxisAlignment` | `AlignItems?` | `null` | Vertical alignment |
| `wrap` | `bool` | `false` | Allow wrapping |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## With Gap

```dart
ArcaneRow(
  gap: Gap.md,
  children: [
    ArcaneButton(label: 'One', onPressed: () {}),
    ArcaneButton(label: 'Two', onPressed: () {}),
    ArcaneButton(label: 'Three', onPressed: () {}),
  ],
)
```

## Alignment

### Main Axis (Horizontal)

```dart
// Space between items
ArcaneRow(
  mainAxisAlignment: JustifyContent.spaceBetween,
  children: [
    ArcaneText('Left'),
    ArcaneText('Right'),
  ],
)

// Center items
ArcaneRow(
  mainAxisAlignment: JustifyContent.center,
  gap: Gap.md,
  children: [
    ArcaneButton(label: 'OK', onPressed: () {}),
    ArcaneButton.ghost(label: 'Cancel', onPressed: () {}),
  ],
)

// End aligned
ArcaneRow(
  mainAxisAlignment: JustifyContent.end,
  gap: Gap.sm,
  children: [
    ArcaneText('Actions:'),
    ArcaneIconButton(icon: span([text('✏')]), onPressed: () {}),
    ArcaneIconButton(icon: span([text('🗑')]), onPressed: () {}),
  ],
)
```

### Cross Axis (Vertical)

```dart
// Center vertically
ArcaneRow(
  crossAxisAlignment: AlignItems.center,
  gap: Gap.md,
  children: [
    ArcaneAvatar(imageUrl: '/user.jpg'),
    ArcaneText('Username'),
  ],
)

// Stretch to fill
ArcaneRow(
  crossAxisAlignment: AlignItems.stretch,
  gap: Gap.md,
  styles: const ArcaneStyleData(heightCustom: '200px'),
  children: [
    ArcaneCard(child: ArcaneText('Full height')),
    ArcaneCard(child: ArcaneText('Full height')),
  ],
)
```

## Wrap

```dart
ArcaneRow(
  wrap: true,
  gap: Gap.sm,
  children: [
    for (var tag in tags)
      ArcaneBadge(label: tag),
  ],
)
```

## Examples

### Header Bar

```dart
ArcaneRow(
  mainAxisAlignment: JustifyContent.spaceBetween,
  crossAxisAlignment: AlignItems.center,
  styles: const ArcaneStyleData(
    padding: PaddingPreset.md,
    background: Background.surface,
    borderBottom: Border.subtle,
  ),
  children: [
    ArcaneText('Logo'),
    ArcaneRow(
      gap: Gap.lg,
      children: [
        ArcaneNavLink(label: 'Home', href: '/'),
        ArcaneNavLink(label: 'About', href: '/about'),
        ArcaneNavLink(label: 'Contact', href: '/contact'),
      ],
    ),
    ArcaneButton.primary(label: 'Sign Up', onPressed: () {}),
  ],
)
```

### Form Actions

```dart
ArcaneRow(
  mainAxisAlignment: JustifyContent.end,
  gap: Gap.md,
  styles: const ArcaneStyleData(
    marginTop: Spacing.lg,
    paddingTop: Spacing.lg,
    borderTop: Border.subtle,
  ),
  children: [
    ArcaneButton.ghost(label: 'Cancel', onPressed: () {}),
    ArcaneButton.primary(label: 'Save Changes', onPressed: () {}),
  ],
)
```

### Stat Cards

```dart
ArcaneRow(
  gap: Gap.lg,
  children: [
    ArcaneExpanded(
      child: ArcaneCard(
        child: ArcaneColumn(
          children: [
            ArcaneText('Users'),
            ArcaneHeading(text: '1,234'),
          ],
        ),
      ),
    ),
    ArcaneExpanded(
      child: ArcaneCard(
        child: ArcaneColumn(
          children: [
            ArcaneText('Revenue'),
            ArcaneHeading(text: '\$45,678'),
          ],
        ),
      ),
    ),
    ArcaneExpanded(
      child: ArcaneCard(
        child: ArcaneColumn(
          children: [
            ArcaneText('Orders'),
            ArcaneHeading(text: '892'),
          ],
        ),
      ),
    ),
  ],
)
```

### Icon with Text

```dart
ArcaneRow(
  crossAxisAlignment: AlignItems.center,
  gap: Gap.sm,
  children: [
    span([text('📧')]),
    ArcaneText('contact@example.com'),
  ],
)
```

## Related Components

- [ArcaneColumn](/docs/layout/arcane-column) - Vertical flex layout
- [ArcaneDiv](/docs/layout/arcane-div) - Generic div with full control
- [ArcaneFlow](/docs/layout/arcane-flow) - Auto-wrapping flex container
