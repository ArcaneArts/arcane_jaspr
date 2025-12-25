---
title: ArcaneCommand
description: Command palette for quick actions
layout: docs
component: command
---

# ArcaneCommand

Command palette (cmdk-style) for quick actions and navigation.

## Basic Usage

```dart
ArcaneCommand(
  isOpen: showCommand,
  onClose: () => setState(() => showCommand = false),
  groups: [
    CommandGroup(
      heading: 'Actions',
      items: [
        CommandItem(
          label: 'New Document',
          shortcut: '⌘N',
          onSelect: () => createDoc(),
        ),
        CommandItem(
          label: 'Search',
          shortcut: '⌘K',
          onSelect: () => openSearch(),
        ),
      ],
    ),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `isOpen` | `bool` | `false` | Whether palette is open |
| `onClose` | `Function()?` | - | Called when should close |
| `groups` | `List<CommandGroup>` | required | Command groups |
| `placeholder` | `String` | `'Type a command...'` | Search placeholder |
| `emptyMessage` | `String` | `'No results found.'` | Empty state message |
| `onSearch` | `Function(String)?` | - | Called on search |
| `filterFn` | `Function?` | - | Custom filter function |

## CommandGroup

```dart
CommandGroup(
  heading: 'Navigation',
  items: [...],
)
```

## CommandItem

```dart
CommandItem(
  label: 'Go to Dashboard',
  icon: ArcaneIcon.home,
  shortcut: '⌘D',
  onSelect: () => navigate('/dashboard'),
  disabled: false,
  keywords: ['home', 'main'],
)
```

## Multiple Groups

```dart
ArcaneCommand(
  isOpen: showCommand,
  onClose: () => setState(() => showCommand = false),
  groups: [
    CommandGroup(
      heading: 'Navigation',
      items: [
        CommandItem(label: 'Dashboard', icon: icon, onSelect: goToDashboard),
        CommandItem(label: 'Settings', icon: icon, onSelect: goToSettings),
        CommandItem(label: 'Profile', icon: icon, onSelect: goToProfile),
      ],
    ),
    CommandGroup(
      heading: 'Actions',
      items: [
        CommandItem(label: 'New Project', shortcut: '⌘N', onSelect: newProject),
        CommandItem(label: 'Import', shortcut: '⌘I', onSelect: import_),
        CommandItem(label: 'Export', shortcut: '⌘E', onSelect: export_),
      ],
    ),
    CommandGroup(
      heading: 'Help',
      items: [
        CommandItem(label: 'Documentation', onSelect: openDocs),
        CommandItem(label: 'Keyboard Shortcuts', shortcut: '?', onSelect: showShortcuts),
        CommandItem(label: 'Contact Support', onSelect: contactSupport),
      ],
    ),
  ],
)
```

## With Icons

```dart
ArcaneCommand(
  isOpen: showCommand,
  onClose: close,
  groups: [
    CommandGroup(
      heading: 'Files',
      items: [
        CommandItem(
          label: 'New File',
          icon: span([Component.text('📄')]),
          shortcut: '⌘N',
          onSelect: newFile,
        ),
        CommandItem(
          label: 'Open File',
          icon: span([Component.text('📂')]),
          shortcut: '⌘O',
          onSelect: openFile,
        ),
        CommandItem(
          label: 'Save',
          icon: span([Component.text('💾')]),
          shortcut: '⌘S',
          onSelect: save,
        ),
      ],
    ),
  ],
)
```

## Triggering the Palette

```dart
// Listen for keyboard shortcut
document.addEventListener('keydown', (e) {
  if (e.metaKey && e.key === 'k') {
    e.preventDefault();
    setState(() => showCommand = true);
  }
});

// Or use a button
ArcaneButton(
  label: 'Search...',
  onPressed: () => setState(() => showCommand = true),
)
```

## Features

- Search filtering with keyboard navigation
- Command groups with headings
- Keyboard shortcut hints
- Empty state message
- Overlay with click-outside-to-close
- Arrow key navigation
- Enter to select
- Escape to close
