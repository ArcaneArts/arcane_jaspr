---
title: ArcaneTooltip
description: Contextual information popup on hover
layout: docs
component: tooltip
---

# ArcaneTooltip

A tooltip component that displays contextual information when hovering over an element. Features smooth animations, an arrow pointer, and support for all four positions.

**Aliases:** `ArcaneTooltip`, `ATooltip`

## Basic Usage

```dart
ArcaneTooltip(
  content: 'Helpful information',
  child: ArcaneButton(label: 'Hover me', onPressed: () {}),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `content` | `String` | required | Tooltip text |
| `child` | `Component` | required | Trigger element |
| `position` | `TooltipPosition` | `top` | Tooltip position |
| `maxWidth` | `double` | `250` | Maximum tooltip width |

## Positions

```dart
// Top (default)
ArcaneTooltip(
  position: TooltipPosition.top,
  content: 'Above the element',
  child: ArcaneButton.secondary(label: 'Top'),
)

// Bottom
ArcaneTooltip(
  position: TooltipPosition.bottom,
  content: 'Below the element',
  child: ArcaneButton.secondary(label: 'Bottom'),
)

// Left
ArcaneTooltip(
  position: TooltipPosition.left,
  content: 'To the left',
  child: ArcaneButton.secondary(label: 'Left'),
)

// Right
ArcaneTooltip(
  position: TooltipPosition.right,
  content: 'To the right',
  child: ArcaneButton.secondary(label: 'Right'),
)
```

## Info Tooltip

An info icon with a built-in tooltip:

```dart
ArcaneInfoTooltip(
  content: 'This field is required for form submission',
)
```

## Custom Content Tooltip

For tooltips with custom content (not just text):

```dart
ArcaneTooltipCustom(
  position: TooltipPosition.bottom,
  tooltipContent: ArcaneColumn(
    children: [
      ArcaneText('User Info', weight: FontWeight.w600),
      ArcaneText('john@example.com'),
    ],
  ),
  child: ArcaneAvatar(name: 'John Doe'),
)
```

## Examples

### Icon Button Tooltips

```dart
ArcaneRow(
  gapSize: Gap.sm,
  children: [
    ArcaneTooltip(
      content: 'Copy to clipboard',
      child: ArcaneIconButton(icon: ArcaneIcon.copy(), onPressed: copy),
    ),
    ArcaneTooltip(
      content: 'Settings',
      child: ArcaneIconButton(icon: ArcaneIcon.settings(), onPressed: openSettings),
    ),
  ],
)
```

### Form Field Help

```dart
ArcaneRow(
  gapSize: Gap.sm,
  children: [
    ArcaneText('Email'),
    ArcaneInfoTooltip(
      content: 'We will never share your email',
    ),
  ],
)
```

### Disabled Button Explanation

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

### Keyboard Shortcut Hint

```dart
ArcaneTooltip(
  content: 'Search (Cmd+K)',
  child: ArcaneSearch(placeholder: 'Search...'),
)
```

## Visual Features

- **Arrow pointer** - Points to the trigger element
- **Smooth animation** - Fades in with subtle transform
- **Dark background** - High contrast for readability
- **Responsive positioning** - Adapts to all four directions

## Static Site Support

The JavaScript fallback system fully supports tooltips:
- Binds hover events to `.arcane-tooltip-trigger` elements
- Creates tooltip with arrow dynamically if needed
- Supports all four positions
- Smooth opacity and transform animations

## Related Components

- [ArcaneHovercard](/arcane_jaspr/docs/view/arcane-hovercard) - Rich content on hover
- [ArcanePopover](/arcane_jaspr/docs/view/arcane-popover) - Clickable popup content
