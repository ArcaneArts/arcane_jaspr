---
title: ArcaneActionSheet
description: Mobile-style action menu with options
layout: docs
component: action-sheet
---

# ArcaneActionSheet

A mobile-style action sheet with a list of options.

## Basic Usage

```dart
ArcaneActionSheet(
  isOpen: isOpen,
  onClose: () => close(),
  actions: [
    ActionSheetItem(label: 'Edit', onTap: () => edit()),
    ActionSheetItem(label: 'Share', onTap: () => share()),
    ActionSheetItem(label: 'Delete', onTap: () => delete(), isDestructive: true),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `isOpen` | `bool` | required | Whether sheet is visible |
| `onClose` | `VoidCallback?` | `null` | Close handler |
| `actions` | `List<ActionSheetItem>` | required | Action items |
| `title` | `String?` | `null` | Header title |
| `message` | `String?` | `null` | Description text |
| `cancelLabel` | `String` | `'Cancel'` | Cancel button text |

## With Title and Message

```dart
ArcaneActionSheet(
  isOpen: isOpen,
  onClose: () => close(),
  title: 'Delete Item',
  message: 'This action cannot be undone.',
  actions: [
    ActionSheetItem(
      label: 'Delete',
      onTap: () => confirmDelete(),
      isDestructive: true,
    ),
  ],
)
```

## Action Item Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `label` | `String` | required | Action text |
| `onTap` | `VoidCallback?` | `null` | Tap handler |
| `isDestructive` | `bool` | `false` | Red destructive style |
| `icon` | `Component?` | `null` | Leading icon |

## With Icons

```dart
ArcaneActionSheet(
  isOpen: isOpen,
  onClose: () => close(),
  actions: [
    ActionSheetItem(
      icon: ArcaneText('📝'),
      label: 'Edit',
      onTap: () => edit(),
    ),
    ActionSheetItem(
      icon: ArcaneText('📤'),
      label: 'Share',
      onTap: () => share(),
    ),
    ActionSheetItem(
      icon: ArcaneText('🗑'),
      label: 'Delete',
      onTap: () => delete(),
      isDestructive: true,
    ),
  ],
)
```

## Examples

### Photo Options

```dart
ArcaneActionSheet(
  isOpen: showPhotoOptions,
  onClose: () => close(),
  title: 'Change Photo',
  actions: [
    ActionSheetItem(
      label: 'Take Photo',
      onTap: () => takePhoto(),
    ),
    ActionSheetItem(
      label: 'Choose from Library',
      onTap: () => pickFromGallery(),
    ),
    ActionSheetItem(
      label: 'Remove Photo',
      onTap: () => removePhoto(),
      isDestructive: true,
    ),
  ],
)
```

## Related Components

- [ArcaneSheet](/arcane_jaspr/docs/layout/arcane-sheet) - Generic sheet component
- [ArcaneDialog](/arcane_jaspr/docs/feedback/arcane-dialog) - Modal dialog
- [ArcaneDropdownMenu](/arcane_jaspr/docs/navigation/arcane-dropdown-menu) - Desktop dropdown
