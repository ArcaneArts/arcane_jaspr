---
title: ArcaneIconButton
description: Compact icon-only button component
layout: docs
component: icon-button
---

# ArcaneIconButton

A compact button that displays only an icon, ideal for toolbars, action menus, and space-constrained interfaces.

## Basic Usage

```dart
ArcaneIconButton(
  icon: span([text('✕')]),
  onPressed: () {
    print('Icon button pressed');
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `icon` | `Component` | required | Icon to display |
| `onPressed` | `VoidCallback?` | `null` | Click handler |
| `size` | `IconButtonSize` | `medium` | Button size |
| `variant` | `IconButtonVariant` | `ghost` | Visual variant |
| `isDisabled` | `bool` | `false` | Disable interaction |
| `tooltip` | `String?` | `null` | Tooltip text |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## Variants

### Ghost (Default)

Minimal, transparent background:

```dart
ArcaneIconButton(
  icon: span([text('🔍')]),
  variant: IconButtonVariant.ghost,
  onPressed: () {},
)
```

### Filled

Solid background:

```dart
ArcaneIconButton(
  icon: span([text('➕')]),
  variant: IconButtonVariant.filled,
  onPressed: () {},
)
```

### Outline

Bordered with transparent background:

```dart
ArcaneIconButton(
  icon: span([text('⚙')]),
  variant: IconButtonVariant.outline,
  onPressed: () {},
)
```

## Sizes

```dart
// Small
ArcaneIconButton(
  icon: span([text('✓')]),
  size: IconButtonSize.small,
  onPressed: () {},
)

// Medium (default)
ArcaneIconButton(
  icon: span([text('✓')]),
  size: IconButtonSize.medium,
  onPressed: () {},
)

// Large
ArcaneIconButton(
  icon: span([text('✓')]),
  size: IconButtonSize.large,
  onPressed: () {},
)
```

## With Tooltip

```dart
ArcaneIconButton(
  icon: span([text('🗑')]),
  tooltip: 'Delete item',
  onPressed: () {},
)
```

## Examples

### Toolbar

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    gap: Gap.xs,
    padding: PaddingPreset.sm,
    background: Background.surface,
    borderRadius: Radius.md,
  ),
  children: [
    ArcaneIconButton(
      icon: span([text('B')]),
      tooltip: 'Bold',
      onPressed: () => toggleBold(),
    ),
    ArcaneIconButton(
      icon: span([text('I')]),
      tooltip: 'Italic',
      onPressed: () => toggleItalic(),
    ),
    ArcaneIconButton(
      icon: span([text('U')]),
      tooltip: 'Underline',
      onPressed: () => toggleUnderline(),
    ),
    ArcaneDivider(direction: DividerDirection.vertical),
    ArcaneIconButton(
      icon: span([text('🔗')]),
      tooltip: 'Insert link',
      onPressed: () => insertLink(),
    ),
  ],
)
```

### Card Actions

```dart
ArcaneCard(
  children: [
    // Card content...
    ArcaneDiv(
      styles: const ArcaneStyleData(
        display: Display.flex,
        justifyContent: JustifyContent.flexEnd,
        gap: Gap.sm,
      ),
      children: [
        ArcaneIconButton(
          icon: span([text('✏')]),
          tooltip: 'Edit',
          onPressed: () => editItem(),
        ),
        ArcaneIconButton(
          icon: span([text('🗑')]),
          tooltip: 'Delete',
          onPressed: () => deleteItem(),
        ),
      ],
    ),
  ],
)
```

### Table Row Actions

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    gap: Gap.xs,
  ),
  children: [
    ArcaneIconButton(
      icon: span([text('👁')]),
      size: IconButtonSize.small,
      tooltip: 'View',
      onPressed: () => viewItem(id),
    ),
    ArcaneIconButton(
      icon: span([text('✏')]),
      size: IconButtonSize.small,
      tooltip: 'Edit',
      onPressed: () => editItem(id),
    ),
    ArcaneIconButton(
      icon: span([text('⋮')]),
      size: IconButtonSize.small,
      tooltip: 'More',
      onPressed: () => showMenu(id),
    ),
  ],
)
```

## Related Components

- [ArcaneButton](/docs/inputs/arcane-button) - Full button with label
- [ArcaneCloseButton](/docs/inputs/arcane-close-button) - Close/dismiss button
- [ArcaneFAB](/docs/inputs/arcane-fab) - Floating action button
