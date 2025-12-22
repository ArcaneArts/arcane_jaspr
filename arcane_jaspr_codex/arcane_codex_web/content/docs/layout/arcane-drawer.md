---
title: ArcaneDrawer
description: Slide-in side panel for navigation or content
layout: docs
component: drawer
---

# ArcaneDrawer

A slide-in panel component that appears from the edge of the screen, useful for navigation menus, settings panels, or additional content.

## Basic Usage

```dart
ArcaneDrawer(
  isOpen: isDrawerOpen,
  onClose: () => setState(() => isDrawerOpen = false),
  child: DrawerContent(),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `isOpen` | `bool` | required | Whether drawer is visible |
| `onClose` | `VoidCallback?` | `null` | Close callback |
| `child` | `Component` | required | Drawer content |
| `position` | `DrawerPosition` | `left` | Slide-in direction |
| `size` | `DrawerSize` | `md` | Drawer width/height |
| `title` | `String?` | `null` | Header title |
| `showBackdrop` | `bool` | `true` | Show overlay backdrop |
| `closeOnBackdrop` | `bool` | `true` | Close on backdrop click |
| `showCloseButton` | `bool` | `true` | Show close button |
| `header` | `Component?` | `null` | Custom header |
| `footer` | `Component?` | `null` | Footer content |

## Positions

```dart
// Left (default)
ArcaneDrawer(
  isOpen: isOpen,
  position: DrawerPosition.left,
  child: content,
)

// Right
ArcaneDrawer(
  isOpen: isOpen,
  position: DrawerPosition.right,
  child: content,
)

// Top
ArcaneDrawer(
  isOpen: isOpen,
  position: DrawerPosition.top,
  child: content,
)

// Bottom
ArcaneDrawer(
  isOpen: isOpen,
  position: DrawerPosition.bottom,
  child: content,
)
```

## Sizes

```dart
// Small (240px)
ArcaneDrawer(
  isOpen: isOpen,
  size: DrawerSize.sm,
  child: content,
)

// Medium (320px, default)
ArcaneDrawer(
  isOpen: isOpen,
  size: DrawerSize.md,
  child: content,
)

// Large (400px)
ArcaneDrawer(
  isOpen: isOpen,
  size: DrawerSize.lg,
  child: content,
)

// Extra large (480px)
ArcaneDrawer(
  isOpen: isOpen,
  size: DrawerSize.xl,
  child: content,
)

// Full screen
ArcaneDrawer(
  isOpen: isOpen,
  size: DrawerSize.full,
  child: content,
)
```

## With Title

```dart
ArcaneDrawer(
  isOpen: isOpen,
  onClose: closeDrawer,
  title: 'Settings',
  child: SettingsContent(),
)
```

## With Footer

```dart
ArcaneDrawer(
  isOpen: isOpen,
  onClose: closeDrawer,
  title: 'Filters',
  footer: ArcaneRow(
    gapSize: Gap.sm,
    children: [
      ArcaneButton.secondary(label: 'Reset', onPressed: reset),
      ArcaneButton.primary(label: 'Apply', onPressed: apply),
    ],
  ),
  child: FilterOptions(),
)
```

## Examples

### Navigation Drawer

```dart
ArcaneDrawer(
  isOpen: isMenuOpen,
  onClose: () => setState(() => isMenuOpen = false),
  title: 'Menu',
  child: ArcaneColumn(
    children: [
      DrawerNavItem(icon: ArcaneIcon.home(), label: 'Home'),
      DrawerNavItem(icon: ArcaneIcon.user(), label: 'Profile'),
      DrawerNavItem(icon: ArcaneIcon.settings(), label: 'Settings'),
    ],
  ),
)
```

### Cart Drawer

```dart
ArcaneDrawer(
  isOpen: isCartOpen,
  onClose: closeCart,
  position: DrawerPosition.right,
  size: DrawerSize.lg,
  title: 'Shopping Cart',
  footer: ArcaneColumn(
    gapSize: Gap.sm,
    children: [
      ArcaneRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ArcaneText('Total'),
          ArcaneText('\$99.00', weight: FontWeight.bold),
        ],
      ),
      ArcaneButton.primary(
        label: 'Checkout',
        onPressed: checkout,
      ),
    ],
  ),
  child: CartItemsList(),
)
```

## Related Components

- [ArcaneSidebar](/arcane_jaspr/docs/navigation/arcane-sidebar) - Fixed sidebar
- [ArcaneDialog](/arcane_jaspr/docs/feedback/arcane-dialog) - Modal dialog
