---
title: ArcaneDropdownMenu
description: Contextual dropdown menu with items
layout: docs
---

# ArcaneDropdownMenu

A dropdown menu component that displays a list of actions when triggered.

## Basic Usage

```dart
ArcaneDropdownMenu(
  trigger: ArcaneButton.secondary(label: 'Options'),
  items: [
    ArcaneDropdownItem(label: 'Edit', onPressed: edit),
    ArcaneDropdownItem(label: 'Duplicate', onPressed: duplicate),
    ArcaneDropdownItem(label: 'Delete', onPressed: delete),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `trigger` | `Component` | required | Trigger element |
| `items` | `List<Component>` | required | Menu items |
| `align` | `DropdownAlign` | `start` | Menu alignment |
| `position` | `DropdownPosition` | `bottom` | Menu position |
| `width` | `String?` | `null` | Custom width |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## ArcaneDropdownItem Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `label` | `String` | required | Item text |
| `icon` | `Component?` | `null` | Leading icon |
| `onPressed` | `VoidCallback?` | `null` | Click handler |
| `href` | `String?` | `null` | Navigation URL |
| `isDestructive` | `bool` | `false` | Destructive style |
| `isDisabled` | `bool` | `false` | Disabled state |

## With Icons

```dart
ArcaneDropdownMenu(
  trigger: ArcaneIconButton(icon: span([text('⋮')])),
  items: [
    ArcaneDropdownItem(
      icon: span([text('✏️')]),
      label: 'Edit',
      onPressed: edit,
    ),
    ArcaneDropdownItem(
      icon: span([text('📋')]),
      label: 'Copy',
      onPressed: copy,
    ),
    ArcaneDropdownItem(
      icon: span([text('🔗')]),
      label: 'Share',
      onPressed: share,
    ),
    ArcaneDivider(),
    ArcaneDropdownItem(
      icon: span([text('🗑️')]),
      label: 'Delete',
      onPressed: delete,
      isDestructive: true,
    ),
  ],
)
```

## Alignment

```dart
// Start aligned (default)
ArcaneDropdownMenu(
  align: DropdownAlign.start,
  trigger: Trigger(),
  items: items,
)

// End aligned
ArcaneDropdownMenu(
  align: DropdownAlign.end,
  trigger: Trigger(),
  items: items,
)

// Center aligned
ArcaneDropdownMenu(
  align: DropdownAlign.center,
  trigger: Trigger(),
  items: items,
)
```

## Position

```dart
// Bottom (default)
ArcaneDropdownMenu(
  position: DropdownPosition.bottom,
  trigger: Trigger(),
  items: items,
)

// Top
ArcaneDropdownMenu(
  position: DropdownPosition.top,
  trigger: Trigger(),
  items: items,
)

// Left
ArcaneDropdownMenu(
  position: DropdownPosition.left,
  trigger: Trigger(),
  items: items,
)

// Right
ArcaneDropdownMenu(
  position: DropdownPosition.right,
  trigger: Trigger(),
  items: items,
)
```

## With Sections

```dart
ArcaneDropdownMenu(
  trigger: ArcaneButton.secondary(label: 'Actions'),
  items: [
    ArcaneDropdownSection(
      title: 'Edit',
      children: [
        ArcaneDropdownItem(label: 'Undo', onPressed: undo),
        ArcaneDropdownItem(label: 'Redo', onPressed: redo),
      ],
    ),
    ArcaneDivider(),
    ArcaneDropdownSection(
      title: 'View',
      children: [
        ArcaneDropdownItem(label: 'Zoom In', onPressed: zoomIn),
        ArcaneDropdownItem(label: 'Zoom Out', onPressed: zoomOut),
      ],
    ),
  ],
)
```

## Examples

### User Profile Menu

```dart
ArcaneDropdownMenu(
  trigger: ArcaneRow(
    gap: Gap.sm,
    children: [
      ArcaneAvatar(imageUrl: user.avatar, size: AvatarSize.sm),
      ArcaneText(user.name),
      span([text('▼')]),
    ],
  ),
  items: [
    ArcaneDropdownItem(
      icon: span([text('👤')]),
      label: 'Profile',
      href: '/profile',
    ),
    ArcaneDropdownItem(
      icon: span([text('⚙️')]),
      label: 'Settings',
      href: '/settings',
    ),
    ArcaneDropdownItem(
      icon: span([text('❓')]),
      label: 'Help',
      href: '/help',
    ),
    ArcaneDivider(),
    ArcaneDropdownItem(
      icon: span([text('🚪')]),
      label: 'Sign Out',
      onPressed: signOut,
    ),
  ],
)
```

### Table Row Actions

```dart
ArcaneDataTable(
  columns: [...],
  rows: [
    for (var item in items)
      DataRow(cells: [
        ArcaneText(item.name),
        ArcaneText(item.status),
        ArcaneDropdownMenu(
          trigger: ArcaneIconButton(icon: span([text('⋮')])),
          align: DropdownAlign.end,
          items: [
            ArcaneDropdownItem(
              icon: span([text('👁️')]),
              label: 'View',
              onPressed: () => view(item),
            ),
            ArcaneDropdownItem(
              icon: span([text('✏️')]),
              label: 'Edit',
              onPressed: () => edit(item),
            ),
            ArcaneDivider(),
            ArcaneDropdownItem(
              icon: span([text('🗑️')]),
              label: 'Delete',
              onPressed: () => delete(item),
              isDestructive: true,
            ),
          ],
        ),
      ]),
  ],
)
```

### File Operations

```dart
ArcaneDropdownMenu(
  trigger: ArcaneButton.secondary(
    leadingIcon: span([text('📁')]),
    label: 'File',
  ),
  width: '200px',
  items: [
    ArcaneDropdownItem(
      icon: span([text('📄')]),
      label: 'New File',
      onPressed: newFile,
    ),
    ArcaneDropdownItem(
      icon: span([text('📂')]),
      label: 'Open...',
      onPressed: openFile,
    ),
    ArcaneDivider(),
    ArcaneDropdownItem(
      icon: span([text('💾')]),
      label: 'Save',
      onPressed: save,
    ),
    ArcaneDropdownItem(
      icon: span([text('📥')]),
      label: 'Save As...',
      onPressed: saveAs,
    ),
    ArcaneDivider(),
    ArcaneDropdownItem(
      icon: span([text('🖨️')]),
      label: 'Print',
      onPressed: print,
    ),
  ],
)
```

### Sort Options

```dart
ArcaneDropdownMenu(
  trigger: ArcaneButton.ghost(
    leadingIcon: span([text('↕️')]),
    label: 'Sort by: $currentSort',
  ),
  items: [
    ArcaneDropdownItem(
      label: 'Name',
      icon: currentSort == 'name' ? span([text('✓')]) : null,
      onPressed: () => sortBy('name'),
    ),
    ArcaneDropdownItem(
      label: 'Date',
      icon: currentSort == 'date' ? span([text('✓')]) : null,
      onPressed: () => sortBy('date'),
    ),
    ArcaneDropdownItem(
      label: 'Size',
      icon: currentSort == 'size' ? span([text('✓')]) : null,
      onPressed: () => sortBy('size'),
    ),
    ArcaneDropdownItem(
      label: 'Type',
      icon: currentSort == 'type' ? span([text('✓')]) : null,
      onPressed: () => sortBy('type'),
    ),
  ],
)
```

## Related Components

- [ArcaneButton](/docs/inputs/arcane-button) - Button trigger
- [ArcaneSelect](/docs/inputs/arcane-select) - Form select input
- [ArcaneMegaMenu](/docs/navigation/arcane-mega-menu) - Large navigation menu
