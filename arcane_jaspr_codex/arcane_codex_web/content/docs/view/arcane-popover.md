---
title: ArcanePopover
description: Floating content panel
layout: docs
component: popover
---

# ArcanePopover

A floating content panel that appears relative to a trigger element, useful for menus, tooltips with rich content, or contextual information.

## Basic Usage

```dart
ArcanePopover(
  trigger: ArcaneButton.secondary(
    label: 'Open Menu',
    onPressed: () {},
  ),
  content: MenuContent(),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `trigger` | `Component` | required | Trigger element |
| `content` | `Component` | required | Popover content |
| `position` | `PopoverPosition` | `bottom` | Position relative to trigger |
| `triggerType` | `PopoverTrigger` | `click` | Trigger behavior |
| `isOpen` | `bool?` | `null` | Controlled open state |
| `onOpenChange` | `ValueChanged<bool>?` | `null` | Open state callback |
| `showArrow` | `bool` | `true` | Show arrow pointer |
| `closeOnOutsideClick` | `bool` | `true` | Close when clicking outside |
| `closeOnEscape` | `bool` | `true` | Close on Escape key |
| `offset` | `int` | `8` | Offset from trigger |
| `openDelay` | `int` | `0` | Delay before opening (ms, hover mode) |
| `closeDelay` | `int` | `0` | Delay before closing (ms, hover mode) |

## Positions

```dart
// Top
ArcanePopover(
  trigger: trigger,
  content: content,
  position: PopoverPosition.top,
)

// Bottom (default)
ArcanePopover(
  trigger: trigger,
  content: content,
  position: PopoverPosition.bottom,
)

// Left
ArcanePopover(
  trigger: trigger,
  content: content,
  position: PopoverPosition.left,
)

// Right
ArcanePopover(
  trigger: trigger,
  content: content,
  position: PopoverPosition.right,
)

// Bottom Start
ArcanePopover(
  trigger: trigger,
  content: content,
  position: PopoverPosition.bottomStart,
)

// Bottom End
ArcanePopover(
  trigger: trigger,
  content: content,
  position: PopoverPosition.bottomEnd,
)
```

## Trigger Types

```dart
// Click (default)
ArcanePopover(
  trigger: trigger,
  content: content,
  triggerType: PopoverTrigger.click,
)

// Hover
ArcanePopover(
  trigger: trigger,
  content: content,
  triggerType: PopoverTrigger.hover,
)

// Manual control
ArcanePopover(
  trigger: trigger,
  content: content,
  triggerType: PopoverTrigger.manual,
  isOpen: isOpen,
  onOpenChange: (open) => setState(() => isOpen = open),
)
```

## Without Arrow

```dart
ArcanePopover(
  trigger: trigger,
  content: content,
  showArrow: false,
)
```

## Examples

### Dropdown Menu

```dart
ArcanePopover(
  trigger: ArcaneButton.secondary(
    label: 'Options',
    onPressed: () {},
  ),
  position: PopoverPosition.bottomStart,
  content: ArcaneColumn(
    gapSize: Gap.xs,
    children: [
      MenuButton(label: 'Edit', icon: ArcaneIcon.edit()),
      MenuButton(label: 'Duplicate', icon: ArcaneIcon.plus()),
      MenuButton(label: 'Delete', icon: ArcaneIcon.trash()),
    ],
  ),
)
```

### User Profile Popover

```dart
ArcanePopover(
  trigger: ArcaneAvatar(initials: 'JD'),
  position: PopoverPosition.bottomEnd,
  content: ArcaneColumn(
    gapSize: Gap.sm,
    children: [
      ArcaneRow(
        gapSize: Gap.sm,
        children: [
          ArcaneAvatar(initials: 'JD'),
          ArcaneColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ArcaneText('John Doe', weight: FontWeight.bold),
              ArcaneText('john@example.com', color: TextColor.muted),
            ],
          ),
        ],
      ),
      ArcaneDivider(),
      MenuButton(label: 'Profile', icon: ArcaneIcon.user()),
      MenuButton(label: 'Settings', icon: ArcaneIcon.settings()),
      MenuButton(label: 'Sign Out', icon: ArcaneIcon.logout()),
    ],
  ),
)
```

### Info Popover

```dart
ArcanePopover(
  trigger: ArcaneIconButton(
    icon: ArcaneIcon.info(),
    onPressed: () {},
  ),
  triggerType: PopoverTrigger.hover,
  position: PopoverPosition.top,
  content: ArcaneDiv(
    styles: const ArcaneStyleData(maxWidth: MaxWidth.xs),
    children: [
      ArcaneText(
        'This is helpful information about the feature.',
        color: TextColor.muted,
      ),
    ],
  ),
)
```

## Hover with Delays

When using `hover` trigger, you can add delays for a better user experience:

```dart
ArcanePopover(
  trigger: trigger,
  content: content,
  triggerType: PopoverTrigger.hover,
  openDelay: 200,  // Wait 200ms before showing
  closeDelay: 300, // Wait 300ms before hiding
)
```

## Related Components

- [ArcaneHovercard](/arcane_jaspr/docs/view/arcane-hovercard) - Hover-only card with delays
- [ArcaneDropdownMenu](/arcane_jaspr/docs/navigation/arcane-dropdown-menu) - Dropdown menu
- [ArcaneTooltip](/arcane_jaspr/docs/view/arcane-tooltip) - Simple tooltip
