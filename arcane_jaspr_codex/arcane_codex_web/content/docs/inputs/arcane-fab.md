---
title: ArcaneFAB
description: Floating action button for primary actions
layout: docs
---

# ArcaneFAB

A floating action button (FAB) for primary or promoted actions. Typically positioned in the bottom-right corner of the screen.

## Basic Usage

```dart
ArcaneFAB(
  icon: span([text('➕')]),
  onPressed: () {
    createNewItem();
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `icon` | `Component` | required | Icon to display |
| `onPressed` | `VoidCallback?` | `null` | Click handler |
| `label` | `String?` | `null` | Extended FAB label |
| `size` | `FABSize` | `regular` | FAB size |
| `variant` | `FABVariant` | `primary` | Visual variant |
| `tooltip` | `String?` | `null` | Tooltip text |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## Variants

### Primary (Default)

```dart
ArcaneFAB(
  icon: span([text('➕')]),
  variant: FABVariant.primary,
  onPressed: () {},
)
```

### Secondary

```dart
ArcaneFAB(
  icon: span([text('✏')]),
  variant: FABVariant.secondary,
  onPressed: () {},
)
```

### Surface

```dart
ArcaneFAB(
  icon: span([text('⬆')]),
  variant: FABVariant.surface,
  onPressed: () {},
)
```

## Sizes

```dart
// Small
ArcaneFAB(
  icon: span([text('➕')]),
  size: FABSize.small,
  onPressed: () {},
)

// Regular (default)
ArcaneFAB(
  icon: span([text('➕')]),
  size: FABSize.regular,
  onPressed: () {},
)

// Large
ArcaneFAB(
  icon: span([text('➕')]),
  size: FABSize.large,
  onPressed: () {},
)
```

## Extended FAB

Add a label for more context:

```dart
ArcaneFAB(
  icon: span([text('➕')]),
  label: 'Create',
  onPressed: () {},
)
```

## Examples

### Fixed Position FAB

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    position: Position.fixed,
    raw: {
      'bottom': '24px',
      'right': '24px',
    },
    zIndex: ZIndex.fab,
  ),
  children: [
    ArcaneFAB(
      icon: span([text('➕')]),
      tooltip: 'Add new item',
      onPressed: () => openCreateDialog(),
    ),
  ],
)
```

### Multiple FABs

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    position: Position.fixed,
    raw: {
      'bottom': '24px',
      'right': '24px',
    },
    display: Display.flex,
    flexDirection: FlexDirection.column,
    gap: Gap.md,
    alignItems: AlignItems.flexEnd,
  ),
  children: [
    // Secondary FABs (smaller)
    ArcaneFAB(
      icon: span([text('✏')]),
      size: FABSize.small,
      variant: FABVariant.secondary,
      tooltip: 'Edit',
      onPressed: () => edit(),
    ),
    ArcaneFAB(
      icon: span([text('📤')]),
      size: FABSize.small,
      variant: FABVariant.secondary,
      tooltip: 'Share',
      onPressed: () => share(),
    ),
    // Primary FAB
    ArcaneFAB(
      icon: span([text('➕')]),
      tooltip: 'Create new',
      onPressed: () => create(),
    ),
  ],
)
```

### Extended FAB with Scroll Behavior

```dart
ArcaneFAB(
  icon: span([text('✏')]),
  label: isScrolled ? null : 'Compose',  // Collapse on scroll
  onPressed: () => compose(),
)
```

### Page with FAB

```dart
ArcaneScreen(
  children: [
    // Main content
    ArcaneDiv(
      styles: const ArcaneStyleData(
        padding: PaddingPreset.xl,
      ),
      children: [
        // Page content...
      ],
    ),

    // FAB
    ArcaneDiv(
      styles: const ArcaneStyleData(
        position: Position.fixed,
        raw: {'bottom': '24px', 'right': '24px'},
      ),
      children: [
        ArcaneFAB(
          icon: span([text('➕')]),
          label: 'New Project',
          onPressed: () => createProject(),
        ),
      ],
    ),
  ],
)
```

## Related Components

- [ArcaneButton](/docs/inputs/arcane-button) - Standard button
- [ArcaneIconButton](/docs/inputs/arcane-icon-button) - Icon-only button
