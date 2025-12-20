---
title: ArcaneDivider
description: Horizontal divider line for visual separation
layout: docs
---

# ArcaneDivider

A horizontal rule component for visually separating content sections.

## Basic Usage

```dart
ArcaneDivider()
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `label` | `String?` | `null` | Center label text |
| `variant` | `DividerVariant` | `subtle` | Line style |
| `spacing` | `DividerSpacing` | `md` | Vertical margin |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Variants

```dart
// Subtle (default)
ArcaneDivider(variant: DividerVariant.subtle)

// Default
ArcaneDivider(variant: DividerVariant.default_)

// Strong
ArcaneDivider(variant: DividerVariant.strong)

// Dashed
ArcaneDivider(variant: DividerVariant.dashed)
```

## With Label

```dart
ArcaneDivider(label: 'or')
```

## Spacing

```dart
// No spacing
ArcaneDivider(spacing: DividerSpacing.none)

// Small
ArcaneDivider(spacing: DividerSpacing.sm)

// Medium (default)
ArcaneDivider(spacing: DividerSpacing.md)

// Large
ArcaneDivider(spacing: DividerSpacing.lg)

// Extra large
ArcaneDivider(spacing: DividerSpacing.xl)
```

## Examples

### Form Sections

```dart
ArcaneColumn(
  gap: Gap.lg,
  children: [
    ArcaneColumn(
      gap: Gap.md,
      children: [
        ArcaneHeading(text: 'Personal Info', level: HeadingLevel.h3),
        ArcaneTextInput(label: 'Name'),
        ArcaneTextInput(label: 'Email'),
      ],
    ),
    ArcaneDivider(),
    ArcaneColumn(
      gap: Gap.md,
      children: [
        ArcaneHeading(text: 'Password', level: HeadingLevel.h3),
        ArcaneTextInput(label: 'Current Password'),
        ArcaneTextInput(label: 'New Password'),
      ],
    ),
  ],
)
```

### Login Options

```dart
ArcaneColumn(
  gap: Gap.lg,
  children: [
    ArcaneButton.primary(
      label: 'Sign in with Email',
      isFullWidth: true,
      onPressed: () {},
    ),
    ArcaneDivider(label: 'or continue with'),
    ArcaneRow(
      gap: Gap.md,
      children: [
        ArcaneExpanded(
          child: ArcaneButton.ghost(
            label: 'Google',
            onPressed: () {},
          ),
        ),
        ArcaneExpanded(
          child: ArcaneButton.ghost(
            label: 'GitHub',
            onPressed: () {},
          ),
        ),
      ],
    ),
  ],
)
```

### Dropdown Menu

```dart
ArcaneDropdownMenu(
  children: [
    ArcaneDropdownItem(label: 'Profile', onPressed: () {}),
    ArcaneDropdownItem(label: 'Settings', onPressed: () {}),
    ArcaneDivider(spacing: DividerSpacing.sm),
    ArcaneDropdownItem(label: 'Sign Out', onPressed: () {}),
  ],
)
```

### Card Sections

```dart
ArcaneCard(
  child: ArcaneColumn(
    children: [
      ArcaneRow(
        mainAxisAlignment: JustifyContent.spaceBetween,
        children: [
          ArcaneHeading(text: 'Order Summary'),
          ArcaneText('#12345'),
        ],
      ),
      ArcaneDivider(),
      ArcaneColumn(
        gap: Gap.sm,
        children: [
          ArcaneRow(
            mainAxisAlignment: JustifyContent.spaceBetween,
            children: [ArcaneText('Subtotal'), ArcaneText('\$99.00')],
          ),
          ArcaneRow(
            mainAxisAlignment: JustifyContent.spaceBetween,
            children: [ArcaneText('Shipping'), ArcaneText('\$5.00')],
          ),
        ],
      ),
      ArcaneDivider(),
      ArcaneRow(
        mainAxisAlignment: JustifyContent.spaceBetween,
        children: [
          ArcaneText('Total', styles: const ArcaneStyleData(fontWeight: FontWeight.bold)),
          ArcaneText('\$104.00', styles: const ArcaneStyleData(fontWeight: FontWeight.bold)),
        ],
      ),
    ],
  ),
)
```

### List Items

```dart
ArcaneColumn(
  children: [
    for (var i = 0; i < items.length; i++) ...[
      ArcaneRow(
        mainAxisAlignment: JustifyContent.spaceBetween,
        styles: const ArcaneStyleData(padding: PaddingPreset.md),
        children: [
          ArcaneText(items[i].name),
          ArcaneText(items[i].price),
        ],
      ),
      if (i < items.length - 1) ArcaneDivider(spacing: DividerSpacing.none),
    ],
  ],
)
```

### Section Break

```dart
ArcaneColumn(
  children: [
    ArcaneSection(
      children: [/* Content */],
    ),
    ArcaneDivider(variant: DividerVariant.strong),
    ArcaneSection(
      children: [/* Content */],
    ),
  ],
)
```

## Related Components

- [ArcaneVerticalDivider](/docs/view/arcane-vertical-divider) - Vertical divider
- [ArcaneGutter](/docs/layout/arcane-gutter) - Spacing without line
- [ArcaneSection](/docs/layout/arcane-section) - Section wrapper
