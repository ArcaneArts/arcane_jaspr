---
title: ArcaneSheet
description: Modal sheet that slides in from screen edges
layout: docs
component: sheet
---

# ArcaneSheet

A modal sheet component that slides in from the edge of the screen.

## Basic Usage

```dart
ArcaneSheet(
  isOpen: isSheetOpen,
  onClose: () => setState(() => isSheetOpen = false),
  child: SheetContent(),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `isOpen` | `bool` | required | Whether sheet is visible |
| `onClose` | `VoidCallback?` | `null` | Close handler |
| `position` | `SheetPosition` | `bottom` | Slide-in direction |
| `child` | `Component` | required | Sheet content |
| `title` | `String?` | `null` | Header title |
| `showClose` | `bool` | `true` | Show close button |
| `maxWidth` | `String?` | `null` | Max width for side sheets |
| `maxHeight` | `String?` | `null` | Max height for bottom sheets |

## Positions

### Bottom Sheet (Default)

```dart
ArcaneSheet(
  isOpen: isOpen,
  position: SheetPosition.bottom,
  title: 'Options',
  onClose: () => close(),
  child: OptionsList(),
)
```

### Right Sheet (Side Panel)

```dart
ArcaneSheet(
  isOpen: isOpen,
  position: SheetPosition.right,
  title: 'Details',
  maxWidth: '400px',
  onClose: () => close(),
  child: DetailsPanel(),
)
```

### Left Sheet

```dart
ArcaneSheet(
  isOpen: isOpen,
  position: SheetPosition.left,
  title: 'Navigation',
  maxWidth: '280px',
  onClose: () => close(),
  child: NavContent(),
)
```

### Top Sheet

```dart
ArcaneSheet(
  isOpen: isOpen,
  position: SheetPosition.top,
  title: 'Notifications',
  maxHeight: '300px',
  onClose: () => close(),
  child: NotificationsList(),
)
```

## Examples

### Settings Panel

```dart
ArcaneButton.secondary(
  label: 'Settings',
  onPressed: () => setState(() => showSettings = true),
),
ArcaneSheet(
  isOpen: showSettings,
  position: SheetPosition.right,
  title: 'Settings',
  maxWidth: '360px',
  onClose: () => setState(() => showSettings = false),
  child: SettingsForm(),
)
```

### Mobile Menu

```dart
ArcaneSheet(
  isOpen: showMenu,
  position: SheetPosition.bottom,
  maxHeight: '80vh',
  onClose: () => close(),
  child: ArcaneColumn(
    children: [
      for (final item in menuItems)
        ArcaneTile(
          title: item.label,
          onTap: () {
            close();
            navigate(item.route);
          },
        ),
    ],
  ),
)
```

## Related Components

- [ArcaneActionSheet](/arcane_jaspr/docs/layout/arcane-action-sheet) - Mobile action menu
- [ArcaneDrawer](/arcane_jaspr/docs/layout/arcane-drawer) - Persistent side drawer
- [ArcaneDialog](/arcane_jaspr/docs/feedback/arcane-dialog) - Modal dialog
