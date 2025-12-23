---
title: ArcaneHovercard
description: Hover-triggered floating card with rich interactive content
layout: docs
component: hovercard
---

# ArcaneHovercard

A floating card that appears on hover with rich, interactive content. Unlike tooltips, hovercards can contain interactive elements like buttons and links. The card stays open while hovering over either the trigger or the card itself.

## Basic Usage

```dart
ArcaneHovercard(
  trigger: ArcaneAvatar(initials: 'JD'),
  content: UserProfileCard(user: user),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `trigger` | `Component` | required | Element that triggers hover |
| `content` | `Component` | required | Content displayed in the hovercard |
| `position` | `HovercardPosition` | `top` | Position relative to trigger |
| `showArrow` | `bool` | `true` | Show arrow pointer |
| `openDelay` | `int` | `200` | Delay before opening (ms) |
| `closeDelay` | `int` | `300` | Delay before closing (ms) |
| `offset` | `int` | `8` | Distance from trigger (px) |
| `isOpen` | `bool?` | `null` | Controlled open state |
| `onOpenChange` | `ValueChanged<bool>?` | `null` | Open state callback |

## Positions

```dart
// Top (default)
ArcaneHovercard(
  trigger: trigger,
  content: content,
  position: HovercardPosition.top,
)

// Bottom
ArcaneHovercard(
  trigger: trigger,
  content: content,
  position: HovercardPosition.bottom,
)

// Left
ArcaneHovercard(
  trigger: trigger,
  content: content,
  position: HovercardPosition.left,
)

// Right
ArcaneHovercard(
  trigger: trigger,
  content: content,
  position: HovercardPosition.right,
)

// Start/End variants
ArcaneHovercard(
  trigger: trigger,
  content: content,
  position: HovercardPosition.topStart,
)

ArcaneHovercard(
  trigger: trigger,
  content: content,
  position: HovercardPosition.bottomEnd,
)
```

## Custom Delays

```dart
// Fast appearance
ArcaneHovercard(
  trigger: trigger,
  content: content,
  openDelay: 0,
  closeDelay: 100,
)

// Slow, deliberate hover
ArcaneHovercard(
  trigger: trigger,
  content: content,
  openDelay: 500,
  closeDelay: 500,
)
```

## Without Arrow

```dart
ArcaneHovercard(
  trigger: trigger,
  content: content,
  showArrow: false,
)
```

## Examples

### User Profile Card

```dart
ArcaneHovercard(
  trigger: ArcaneAvatar(initials: 'JD'),
  position: HovercardPosition.bottom,
  content: ArcaneColumn(
    gapSize: Gap.sm,
    children: [
      ArcaneRow(
        gapSize: Gap.sm,
        children: [
          ArcaneAvatar(initials: 'JD', size: AvatarSize.lg),
          ArcaneColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ArcaneText('John Doe', weight: FontWeight.bold),
              ArcaneText('Software Engineer', color: TextColor.muted),
            ],
          ),
        ],
      ),
      ArcaneDivider(),
      ArcaneRow(
        gapSize: Gap.sm,
        children: [
          ArcaneButton.secondary(
            label: 'View Profile',
            onPressed: () {},
          ),
          ArcaneButton.ghost(
            label: 'Message',
            onPressed: () {},
          ),
        ],
      ),
    ],
  ),
)
```

### Info Tooltip (Rich)

```dart
ArcaneHovercard(
  trigger: ArcaneIcon.info(),
  position: HovercardPosition.right,
  openDelay: 100,
  content: ArcaneDiv(
    styles: const ArcaneStyleData(maxWidth: MaxWidth.xs),
    children: [
      ArcaneText('Feature Info', weight: FontWeight.bold),
      ArcaneText(
        'This feature enables real-time collaboration with your team.',
        color: TextColor.muted,
      ),
      ArcaneLink(
        href: '/docs/feature',
        child: ArcaneText('Learn more', color: TextColor.accent),
      ),
    ],
  ),
)
```

### Repository Card

```dart
ArcaneHovercard(
  trigger: ArcaneText('@username/repo'),
  position: HovercardPosition.bottom,
  content: ArcaneColumn(
    gapSize: Gap.sm,
    children: [
      ArcaneRow(
        gapSize: Gap.sm,
        children: [
          ArcaneIcon.folder(),
          ArcaneText('my-awesome-repo', weight: FontWeight.bold),
        ],
      ),
      ArcaneText(
        'A collection of utilities for Dart development.',
        color: TextColor.muted,
      ),
      ArcaneRow(
        gapSize: Gap.md,
        children: [
          ArcaneRow(
            gapSize: Gap.xs,
            children: [
              ArcaneIcon.star(),
              ArcaneText('1.2k'),
            ],
          ),
          ArcaneRow(
            gapSize: Gap.xs,
            children: [
              ArcaneText('Dart'),
            ],
          ),
        ],
      ),
    ],
  ),
)
```

## Related Components

- [ArcanePopover](/arcane_jaspr/docs/view/arcane-popover) - Click/hover/manual triggered popover
- [ArcaneTooltip](/arcane_jaspr/docs/view/arcane-tooltip) - Simple text tooltip
