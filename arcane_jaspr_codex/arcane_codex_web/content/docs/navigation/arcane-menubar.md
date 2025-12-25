---
title: ArcaneMenubar
description: Horizontal application menu bar
layout: docs
component: menubar
---

# ArcaneMenubar

Horizontal menu bar like in desktop applications.

## Basic Usage

```dart
ArcaneMenubar(
  items: [
    MenubarItem(
      label: 'File',
      menu: [
        MenuItem(label: 'New', shortcut: '⌘N', onSelect: () => newFile()),
        MenuItem(label: 'Open', shortcut: '⌘O', onSelect: () => open()),
        MenuItem.separator(),
        MenuItem(label: 'Save', shortcut: '⌘S', onSelect: () => save()),
      ],
    ),
    MenubarItem(
      label: 'Edit',
      menu: [
        MenuItem(label: 'Undo', shortcut: '⌘Z', onSelect: () => undo()),
        MenuItem(label: 'Redo', shortcut: '⇧⌘Z', onSelect: () => redo()),
      ],
    ),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `items` | `List<MenubarItem>` | required | Top-level menu items |

## MenubarItem

```dart
MenubarItem(
  label: 'File',
  icon: ArcaneIcon.file,
  menu: [...],
)
```

## MenuItem

```dart
MenuItem(
  label: 'New',
  icon: ArcaneIcon.plus,
  shortcut: '⌘N',
  onSelect: () => createNew(),
  disabled: false,
  destructive: false,
  submenu: [...],
)

MenuItem.separator()
```

## Complete Example

```dart
ArcaneMenubar(
  items: [
    MenubarItem(
      label: 'File',
      menu: [
        MenuItem(label: 'New File', shortcut: '⌘N', onSelect: newFile),
        MenuItem(label: 'New Window', shortcut: '⇧⌘N', onSelect: newWindow),
        MenuItem.separator(),
        MenuItem(label: 'Open...', shortcut: '⌘O', onSelect: open),
        MenuItem(
          label: 'Open Recent',
          submenu: [
            MenuItem(label: 'document.txt', onSelect: () => openRecent(0)),
            MenuItem(label: 'notes.md', onSelect: () => openRecent(1)),
            MenuItem.separator(),
            MenuItem(label: 'Clear Recent', onSelect: clearRecent),
          ],
        ),
        MenuItem.separator(),
        MenuItem(label: 'Save', shortcut: '⌘S', onSelect: save),
        MenuItem(label: 'Save As...', shortcut: '⇧⌘S', onSelect: saveAs),
        MenuItem.separator(),
        MenuItem(label: 'Close', shortcut: '⌘W', onSelect: close),
      ],
    ),
    MenubarItem(
      label: 'Edit',
      menu: [
        MenuItem(label: 'Undo', shortcut: '⌘Z', onSelect: undo),
        MenuItem(label: 'Redo', shortcut: '⇧⌘Z', onSelect: redo),
        MenuItem.separator(),
        MenuItem(label: 'Cut', shortcut: '⌘X', onSelect: cut),
        MenuItem(label: 'Copy', shortcut: '⌘C', onSelect: copy),
        MenuItem(label: 'Paste', shortcut: '⌘V', onSelect: paste),
        MenuItem.separator(),
        MenuItem(label: 'Find...', shortcut: '⌘F', onSelect: find),
        MenuItem(label: 'Replace...', shortcut: '⌥⌘F', onSelect: replace),
      ],
    ),
    MenubarItem(
      label: 'View',
      menu: [
        MenuItem(label: 'Zoom In', shortcut: '⌘+', onSelect: zoomIn),
        MenuItem(label: 'Zoom Out', shortcut: '⌘-', onSelect: zoomOut),
        MenuItem(label: 'Reset Zoom', shortcut: '⌘0', onSelect: resetZoom),
        MenuItem.separator(),
        MenuItem(label: 'Full Screen', shortcut: '⌃⌘F', onSelect: fullScreen),
      ],
    ),
    MenubarItem(
      label: 'Help',
      menu: [
        MenuItem(label: 'Documentation', onSelect: openDocs),
        MenuItem(label: 'Keyboard Shortcuts', shortcut: '⌘/', onSelect: showShortcuts),
        MenuItem.separator(),
        MenuItem(label: 'About', onSelect: showAbout),
      ],
    ),
  ],
)
```

## Features

- Desktop app-style menu structure
- Hover to switch between open menus
- Click to toggle dropdown
- Submenus with nested items
- Keyboard shortcuts display
- Separators for grouping
- Disabled and destructive items
