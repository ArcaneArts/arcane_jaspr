---
title: ArcaneContextMenu
description: Right-click context menu
layout: docs
component: context-menu
---

# ArcaneContextMenu

Context menu that appears on right-click.

## Basic Usage

```dart
ArcaneContextMenu(
  trigger: ArcaneCard(child: content),
  items: [
    ContextMenuItem(label: 'Edit', onSelect: () => edit()),
    ContextMenuItem(label: 'Copy', onSelect: () => copy()),
    ContextMenuItem.separator(),
    ContextMenuItem(label: 'Delete', destructive: true, onSelect: () => delete()),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `trigger` | `Component` | required | Element to right-click |
| `items` | `List<ContextMenuItem>` | required | Menu items |

## ContextMenuItem

```dart
ContextMenuItem(
  label: 'Edit',
  icon: ArcaneIcon.edit,
  shortcut: '⌘E',
  onSelect: () => handleEdit(),
  disabled: false,
  destructive: false,
  submenu: [...],
)
```

## With Icons and Shortcuts

```dart
ArcaneContextMenu(
  trigger: FileItem(),
  items: [
    ContextMenuItem(
      label: 'Open',
      icon: ArcaneIcon.folderOpen,
      shortcut: '⌘O',
      onSelect: () => openFile(),
    ),
    ContextMenuItem(
      label: 'Rename',
      icon: ArcaneIcon.edit,
      shortcut: 'F2',
      onSelect: () => renameFile(),
    ),
    ContextMenuItem.separator(),
    ContextMenuItem(
      label: 'Delete',
      icon: ArcaneIcon.trash,
      shortcut: '⌫',
      destructive: true,
      onSelect: () => deleteFile(),
    ),
  ],
)
```

## With Submenus

```dart
ArcaneContextMenu(
  trigger: element,
  items: [
    ContextMenuItem(
      label: 'Share',
      icon: ArcaneIcon.share,
      submenu: [
        ContextMenuItem(label: 'Email', onSelect: shareEmail),
        ContextMenuItem(label: 'Link', onSelect: shareLink),
        ContextMenuItem(label: 'Twitter', onSelect: shareTwitter),
      ],
    ),
    ContextMenuItem(
      label: 'Export',
      submenu: [
        ContextMenuItem(label: 'PDF', onSelect: exportPdf),
        ContextMenuItem(label: 'PNG', onSelect: exportPng),
        ContextMenuItem(label: 'SVG', onSelect: exportSvg),
      ],
    ),
  ],
)
```

## Disabled Items

```dart
ArcaneContextMenu(
  trigger: element,
  items: [
    ContextMenuItem(label: 'Cut', shortcut: '⌘X', onSelect: cut),
    ContextMenuItem(label: 'Copy', shortcut: '⌘C', onSelect: copy),
    ContextMenuItem(
      label: 'Paste',
      shortcut: '⌘V',
      disabled: !hasClipboardContent,
      onSelect: paste,
    ),
  ],
)
```

## Features

- Appears at cursor position
- Submenus with nested items
- Separators for grouping
- Disabled items
- Destructive item styling
- Keyboard shortcut hints
- Click outside to close
- Escape key to close
