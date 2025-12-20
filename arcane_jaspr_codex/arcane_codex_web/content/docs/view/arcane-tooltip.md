---
title: ArcaneTooltip
description: Contextual information popup on hover
layout: docs
---

# ArcaneTooltip

A tooltip component that displays contextual information when hovering over an element.

## Basic Usage

```dart
ArcaneTooltip(
  content: 'Helpful information',
  child: ArcaneIconButton(
    icon: span([text('❓')]),
    onPressed: () {},
  ),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `content` | `String` | required | Tooltip text |
| `child` | `Component` | required | Trigger element |
| `position` | `TooltipPosition` | `top` | Tooltip position |
| `delay` | `Duration?` | `200ms` | Show delay |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Positions

```dart
// Top (default)
ArcaneTooltip(
  position: TooltipPosition.top,
  content: 'Above the element',
  child: TriggerElement(),
)

// Bottom
ArcaneTooltip(
  position: TooltipPosition.bottom,
  content: 'Below the element',
  child: TriggerElement(),
)

// Left
ArcaneTooltip(
  position: TooltipPosition.left,
  content: 'To the left',
  child: TriggerElement(),
)

// Right
ArcaneTooltip(
  position: TooltipPosition.right,
  content: 'To the right',
  child: TriggerElement(),
)
```

## Examples

### Button Tooltip

```dart
ArcaneTooltip(
  content: 'Save your changes',
  child: ArcaneButton.primary(
    label: 'Save',
    onPressed: save,
  ),
)
```

### Icon Explanation

```dart
ArcaneRow(
  gap: Gap.sm,
  children: [
    ArcaneTooltip(
      content: 'Edit item',
      child: ArcaneIconButton(icon: span([text('✏')]), onPressed: edit),
    ),
    ArcaneTooltip(
      content: 'Delete item',
      child: ArcaneIconButton(icon: span([text('🗑')]), onPressed: delete),
    ),
    ArcaneTooltip(
      content: 'Share item',
      child: ArcaneIconButton(icon: span([text('↗')]), onPressed: share),
    ),
  ],
)
```

### Truncated Text

```dart
ArcaneTooltip(
  content: veryLongText,
  child: ArcaneText(
    truncatedText,
    styles: const ArcaneStyleData(
      textOverflow: TextOverflow.ellipsis,
      whiteSpace: WhiteSpace.nowrap,
      overflow: Overflow.hidden,
      maxWidthCustom: '200px',
    ),
  ),
)
```

### Disabled Button

```dart
ArcaneTooltip(
  content: 'Please complete the form first',
  child: ArcaneButton.primary(
    label: 'Submit',
    isDisabled: true,
    onPressed: () {},
  ),
)
```

### Table Cell Info

```dart
ArcaneDataTable(
  columns: [...],
  rows: [
    DataRow(cells: [
      ArcaneTooltip(
        content: 'john.doe@example.com',
        child: ArcaneRow(
          gap: Gap.sm,
          children: [
            ArcaneAvatar(imageUrl: user.avatar, size: AvatarSize.small),
            ArcaneText('John Doe'),
          ],
        ),
      ),
      // Other cells...
    ]),
  ],
)
```

### Keyboard Shortcut Hint

```dart
ArcaneTooltip(
  content: 'Search (⌘K)',
  child: ArcaneSearch(placeholder: 'Search...'),
)
```

### Status Explanation

```dart
ArcaneTooltip(
  content: 'User is currently active',
  position: TooltipPosition.right,
  child: ArcaneStatusIndicator(status: 'online'),
)
```

## Related Components

- [ArcaneInfoTooltip](/docs/view/arcane-info-tooltip) - Info icon with tooltip
- [ArcaneDropdownMenu](/docs/navigation/arcane-dropdown-menu) - Dropdown menu
