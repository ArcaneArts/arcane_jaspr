---
title: ArcaneCenter
description: Convenience component for centering content
layout: docs
component: center
---

# ArcaneCenter

A helper component that centers its child both horizontally and vertically within its container.

## Basic Usage

```dart
ArcaneCenter(
  child: ArcaneText('Centered content'),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `child` | `Component` | required | Content to center |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Examples

### Full Screen Centered

```dart
ArcaneCenter(
  styles: const ArcaneStyleData(
    minHeightCustom: '100vh',
  ),
  child: ArcaneColumn(
    crossAxisAlignment: AlignItems.center,
    gap: Gap.md,
    children: [
      ArcaneLoader(),
      ArcaneText('Loading...'),
    ],
  ),
)
```

### Centered Card

```dart
ArcaneCenter(
  styles: const ArcaneStyleData(
    minHeightCustom: '400px',
    background: Background.surface,
  ),
  child: ArcaneCard(
    styles: const ArcaneStyleData(
      maxWidthCustom: '400px',
      padding: PaddingPreset.xl,
    ),
    child: ArcaneColumn(
      crossAxisAlignment: AlignItems.center,
      gap: Gap.md,
      children: [
        span([text('🎉')]),
        ArcaneHeading(text: 'Welcome!'),
        ArcaneText('You have been successfully registered.'),
        ArcaneButton.primary(label: 'Continue', onPressed: () {}),
      ],
    ),
  ),
)
```

### Placeholder Content

```dart
ArcaneCenter(
  styles: const ArcaneStyleData(
    heightCustom: '300px',
    border: Border.dashed,
    borderRadius: Radius.lg,
  ),
  child: ArcaneColumn(
    crossAxisAlignment: AlignItems.center,
    gap: Gap.sm,
    children: [
      span([text('📷')]),
      ArcaneText('Drop image here'),
    ],
  ),
)
```

### Error State

```dart
ArcaneCenter(
  styles: const ArcaneStyleData(
    minHeightCustom: '60vh',
  ),
  child: ArcaneColumn(
    crossAxisAlignment: AlignItems.center,
    gap: Gap.lg,
    children: [
      ArcaneDiv(
        styles: const ArcaneStyleData(
          fontSize: FontSize.xl4,
        ),
        children: [span([text('❌')])],
      ),
      ArcaneHeading(text: 'Something went wrong'),
      ArcaneText('Please try again later'),
      ArcaneButton(label: 'Retry', onPressed: () {}),
    ],
  ),
)
```

### Login Page

```dart
ArcaneCenter(
  styles: const ArcaneStyleData(
    minHeightCustom: '100vh',
    padding: PaddingPreset.lg,
    background: Background.default_,
  ),
  child: ArcaneCard(
    styles: const ArcaneStyleData(
      widthCustom: '100%',
      maxWidthCustom: '400px',
      padding: PaddingPreset.xl,
    ),
    child: ArcaneColumn(
      gap: Gap.lg,
      children: [
        ArcaneColumn(
          crossAxisAlignment: AlignItems.center,
          gap: Gap.sm,
          children: [
            ArcaneHeading(text: 'Sign In'),
            ArcaneText('Enter your credentials'),
          ],
        ),
        ArcaneTextInput(label: 'Email'),
        ArcaneTextInput(label: 'Password', type: TextInputType.password),
        ArcaneButton.primary(
          label: 'Sign In',
          onPressed: () {},
          isFullWidth: true,
        ),
      ],
    ),
  ),
)
```

### Empty List State

```dart
ArcaneCenter(
  styles: const ArcaneStyleData(
    padding: PaddingPreset.xl2,
  ),
  child: ArcaneEmptyState(
    icon: span([text('📝')]),
    title: 'No items yet',
    description: 'Create your first item to get started',
    action: ArcaneButton.primary(
      label: 'Create Item',
      onPressed: () {},
    ),
  ),
)
```

## Related Components

- [ArcaneDiv](/arcane_jaspr/docs/layout/arcane-div) - Generic layout div
- [ArcaneContainer](/arcane_jaspr/docs/layout/arcane-container) - Centered container with max-width
- [ArcaneColumn](/arcane_jaspr/docs/layout/arcane-column) - Vertical flex layout
