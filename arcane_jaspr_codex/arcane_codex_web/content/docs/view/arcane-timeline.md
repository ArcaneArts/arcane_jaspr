---
title: ArcaneTimeline
description: Display chronological events with multiple layout options
layout: docs
component: timeline
---

# ArcaneTimeline

A timeline component for displaying chronological events or process steps. Supports vertical, horizontal, and alternating layouts.

**Aliases:** `ArcaneTimeline`, `ATimeline`

## Basic Usage

```dart
ArcaneTimeline(
  items: [
    ArcaneTimelineItem(
      title: 'Step 1',
      description: 'First step completed',
      status: TimelineStatus.complete,
    ),
    ArcaneTimelineItem(
      title: 'Step 2',
      description: 'Currently in progress',
      status: TimelineStatus.current,
    ),
    ArcaneTimelineItem(
      title: 'Step 3',
      description: 'Coming soon',
      status: TimelineStatus.pending,
    ),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `items` | `List<ArcaneTimelineItem>` | required | Timeline items |
| `layout` | `TimelineLayout` | `vertical` | Layout type |
| `size` | `TimelineSize` | `md` | Component size |
| `showConnectors` | `bool` | `true` | Show connector lines |

## ArcaneTimelineItem Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `title` | `String` | required | Item title |
| `subtitle` | `String?` | `null` | Subtitle text |
| `description` | `String?` | `null` | Description text |
| `date` | `String?` | `null` | Date/time string |
| `icon` | `Component?` | `null` | Custom icon |
| `status` | `TimelineStatus` | `default_` | Item status |
| `content` | `Component?` | `null` | Custom content |

## Layouts

### Vertical (Default)

```dart
ArcaneTimeline.vertical(
  items: [
    ArcaneTimelineItem(
      title: 'Order Placed',
      description: 'Your order has been received',
      date: 'Jan 15, 2024',
      status: TimelineStatus.complete,
    ),
    ArcaneTimelineItem(
      title: 'Processing',
      description: 'Items are being prepared',
      date: 'Jan 16, 2024',
      status: TimelineStatus.current,
    ),
    ArcaneTimelineItem(
      title: 'Shipped',
      description: 'Package will be sent',
      status: TimelineStatus.pending,
    ),
  ],
)
```

### Horizontal

```dart
ArcaneTimeline.horizontal(
  items: [
    ArcaneTimelineItem(
      title: 'Q1 2024',
      description: 'Planning phase',
      status: TimelineStatus.complete,
    ),
    ArcaneTimelineItem(
      title: 'Q2 2024',
      description: 'Development',
      status: TimelineStatus.current,
    ),
    ArcaneTimelineItem(
      title: 'Q3 2024',
      description: 'Testing',
      status: TimelineStatus.pending,
    ),
    ArcaneTimelineItem(
      title: 'Q4 2024',
      description: 'Launch',
      status: TimelineStatus.pending,
    ),
  ],
)
```

### Alternating

Content alternates between left and right sides:

```dart
ArcaneTimeline.alternating(
  items: [
    ArcaneTimelineItem(
      title: 'Project Started',
      description: 'Initial planning and setup',
      date: 'Jan 1, 2024',
      status: TimelineStatus.complete,
    ),
    ArcaneTimelineItem(
      title: 'Design Complete',
      description: 'UI/UX finalized',
      date: 'Jan 15, 2024',
      status: TimelineStatus.complete,
    ),
    ArcaneTimelineItem(
      title: 'Development',
      description: 'Building the application',
      date: 'Feb 1, 2024',
      status: TimelineStatus.current,
    ),
    ArcaneTimelineItem(
      title: 'Launch',
      description: 'Go live',
      date: 'Mar 1, 2024',
      status: TimelineStatus.pending,
    ),
  ],
)
```

## Status Types

```dart
// Default (neutral)
ArcaneTimelineItem(title: 'Event', status: TimelineStatus.default_)

// Complete (green checkmark)
ArcaneTimelineItem(title: 'Done', status: TimelineStatus.complete)

// Current (accent color, pulsing dot)
ArcaneTimelineItem(title: 'In Progress', status: TimelineStatus.current)

// Pending (muted, empty)
ArcaneTimelineItem(title: 'Upcoming', status: TimelineStatus.pending)

// Error (red X)
ArcaneTimelineItem(title: 'Failed', status: TimelineStatus.error)
```

## Sizes

```dart
// Small
ArcaneTimeline(size: TimelineSize.sm, items: [...])

// Medium (default)
ArcaneTimeline(size: TimelineSize.md, items: [...])

// Large
ArcaneTimeline(size: TimelineSize.lg, items: [...])
```

## Custom Icons

```dart
ArcaneTimeline(
  items: [
    ArcaneTimelineItem(
      title: 'Order Confirmed',
      icon: ArcaneIcon.check(),
      status: TimelineStatus.complete,
    ),
    ArcaneTimelineItem(
      title: 'Shipped',
      icon: ArcaneIcon.truck(),
      status: TimelineStatus.current,
    ),
    ArcaneTimelineItem(
      title: 'Delivered',
      icon: ArcaneIcon.home(),
      status: TimelineStatus.pending,
    ),
  ],
)
```

## With Custom Content

```dart
ArcaneTimeline(
  items: [
    ArcaneTimelineItem(
      title: 'v2.0.0 Released',
      date: 'Jan 20, 2024',
      content: ArcaneCard(
        child: ArcaneColumn(
          gapSize: Gap.sm,
          children: [
            ArcaneBadge('Major Release', style: BadgeStyle.success),
            ArcaneText('Complete redesign with new components'),
          ],
        ),
      ),
    ),
  ],
)
```

## Examples

### Order Tracking

```dart
ArcaneCard(
  child: ArcaneColumn(
    gapSize: Gap.md,
    children: [
      ArcaneHeading(text: 'Order Status'),
      ArcaneTimeline(
        items: [
          ArcaneTimelineItem(
            title: 'Order Confirmed',
            description: 'Order #12345 confirmed',
            date: 'Jan 15, 10:30 AM',
            status: TimelineStatus.complete,
          ),
          ArcaneTimelineItem(
            title: 'Processing',
            description: 'Preparing your items',
            date: 'Jan 15, 11:00 AM',
            status: TimelineStatus.complete,
          ),
          ArcaneTimelineItem(
            title: 'Shipped',
            description: 'Package on its way',
            date: 'Jan 16, 2:00 PM',
            status: TimelineStatus.current,
          ),
          ArcaneTimelineItem(
            title: 'Delivered',
            description: 'Expected Jan 18',
            status: TimelineStatus.pending,
          ),
        ],
      ),
    ],
  ),
)
```

### Activity Feed

```dart
ArcaneTimeline(
  items: [
    ArcaneTimelineItem(
      title: 'John updated the document',
      date: '5 minutes ago',
      icon: ArcaneAvatar(initials: 'JD', size: AvatarSize.xs),
    ),
    ArcaneTimelineItem(
      title: 'Sarah commented',
      date: '1 hour ago',
      icon: ArcaneAvatar(initials: 'SA', size: AvatarSize.xs),
    ),
    ArcaneTimelineItem(
      title: 'File uploaded',
      date: '2 hours ago',
      icon: ArcaneIcon.file(),
    ),
  ],
)
```

## Related Components

- [ArcaneSteps](/arcane_jaspr/docs/view/arcane-steps) - Numbered process steps
- [ArcaneProgressBar](/arcane_jaspr/docs/view/arcane-progress-bar) - Progress indicator
- [ArcaneDivider](/arcane_jaspr/docs/view/arcane-divider) - Visual separator
