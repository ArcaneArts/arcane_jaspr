---
title: ArcaneTimeline
description: Vertical timeline for displaying chronological events
layout: docs
---

# ArcaneTimeline

A vertical timeline component for displaying chronological events or process steps.

## Basic Usage

```dart
ArcaneTimeline(
  items: [
    ArcaneTimelineItem(
      title: 'Event 1',
      description: 'First event description',
    ),
    ArcaneTimelineItem(
      title: 'Event 2',
      description: 'Second event description',
    ),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `items` | `List<ArcaneTimelineItem>` | required | Timeline items |
| `variant` | `TimelineVariant` | `default_` | Visual style |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## ArcaneTimelineItem Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `title` | `String` | required | Item title |
| `description` | `String?` | `null` | Item description |
| `date` | `String?` | `null` | Date/time string |
| `icon` | `Component?` | `null` | Custom icon |
| `status` | `TimelineStatus` | `default_` | Item status |
| `content` | `Component?` | `null` | Custom content |

## Status Types

```dart
// Default (neutral)
ArcaneTimelineItem(title: 'Event', status: TimelineStatus.default_)

// Complete
ArcaneTimelineItem(title: 'Done', status: TimelineStatus.complete)

// Current (active)
ArcaneTimelineItem(title: 'In Progress', status: TimelineStatus.current)

// Pending
ArcaneTimelineItem(title: 'Upcoming', status: TimelineStatus.pending)

// Error
ArcaneTimelineItem(title: 'Failed', status: TimelineStatus.error)
```

## With Dates

```dart
ArcaneTimeline(
  items: [
    ArcaneTimelineItem(
      title: 'Order Placed',
      description: 'Your order has been received',
      date: 'Jan 15, 2024 at 10:30 AM',
      status: TimelineStatus.complete,
    ),
    ArcaneTimelineItem(
      title: 'Processing',
      description: 'Your order is being prepared',
      date: 'Jan 15, 2024 at 11:00 AM',
      status: TimelineStatus.current,
    ),
    ArcaneTimelineItem(
      title: 'Shipped',
      description: 'Order will be shipped',
      status: TimelineStatus.pending,
    ),
  ],
)
```

## Custom Icons

```dart
ArcaneTimeline(
  items: [
    ArcaneTimelineItem(
      title: 'Order Confirmed',
      icon: span([text('✓')]),
      status: TimelineStatus.complete,
    ),
    ArcaneTimelineItem(
      title: 'Shipped',
      icon: span([text('📦')]),
      status: TimelineStatus.current,
    ),
    ArcaneTimelineItem(
      title: 'Delivered',
      icon: span([text('🏠')]),
      status: TimelineStatus.pending,
    ),
  ],
)
```

## Examples

### Order Tracking

```dart
ArcaneCard(
  child: ArcaneColumn(
    gap: Gap.md,
    children: [
      ArcaneHeading(text: 'Order Status'),
      ArcaneTimeline(
        items: [
          ArcaneTimelineItem(
            title: 'Order Confirmed',
            description: 'Your order #12345 has been confirmed',
            date: 'Jan 15, 2024',
            icon: span([text('✓')]),
            status: TimelineStatus.complete,
          ),
          ArcaneTimelineItem(
            title: 'Processing',
            description: 'Items are being prepared for shipping',
            date: 'Jan 16, 2024',
            icon: span([text('📦')]),
            status: TimelineStatus.complete,
          ),
          ArcaneTimelineItem(
            title: 'Shipped',
            description: 'Your package is on its way',
            date: 'Jan 17, 2024',
            icon: span([text('🚚')]),
            status: TimelineStatus.current,
          ),
          ArcaneTimelineItem(
            title: 'Delivered',
            description: 'Expected delivery',
            date: 'Jan 19, 2024',
            icon: span([text('🏠')]),
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
    for (var activity in activities)
      ArcaneTimelineItem(
        title: activity.action,
        description: activity.details,
        date: formatRelativeTime(activity.timestamp),
        icon: ArcaneAvatar(
          imageUrl: activity.user.avatar,
          size: AvatarSize.xs,
        ),
      ),
  ],
)
```

### Process Steps

```dart
ArcaneTimeline(
  items: [
    ArcaneTimelineItem(
      title: 'Step 1: Sign Up',
      description: 'Create your free account',
      icon: span([text('1')]),
      status: TimelineStatus.complete,
    ),
    ArcaneTimelineItem(
      title: 'Step 2: Verify Email',
      description: 'Confirm your email address',
      icon: span([text('2')]),
      status: TimelineStatus.complete,
    ),
    ArcaneTimelineItem(
      title: 'Step 3: Complete Profile',
      description: 'Add your details',
      icon: span([text('3')]),
      status: TimelineStatus.current,
    ),
    ArcaneTimelineItem(
      title: 'Step 4: Start Using',
      description: 'Explore all features',
      icon: span([text('4')]),
      status: TimelineStatus.pending,
    ),
  ],
)
```

### Project History

```dart
ArcaneTimeline(
  items: [
    ArcaneTimelineItem(
      title: 'Project Created',
      date: 'Jan 1, 2024',
      content: ArcaneCard(
        child: ArcaneColumn(
          gap: Gap.sm,
          children: [
            ArcaneText('Initial project setup'),
            ArcaneFlow(
              gap: Gap.sm,
              children: [
                ArcaneBadge(label: 'planning'),
              ],
            ),
          ],
        ),
      ),
    ),
    ArcaneTimelineItem(
      title: 'Design Phase Complete',
      date: 'Jan 15, 2024',
      content: ArcaneCard(
        child: ArcaneColumn(
          gap: Gap.sm,
          children: [
            ArcaneText('Finalized UI/UX designs'),
            ArcaneImage(src: '/design-preview.png'),
          ],
        ),
      ),
    ),
    ArcaneTimelineItem(
      title: 'Development Started',
      date: 'Jan 20, 2024',
      status: TimelineStatus.current,
    ),
  ],
)
```

### Changelog

```dart
ArcaneTimeline(
  items: [
    ArcaneTimelineItem(
      title: 'v2.0.0',
      date: 'Jan 20, 2024',
      content: ArcaneColumn(
        gap: Gap.sm,
        crossAxisAlignment: AlignItems.start,
        children: [
          ArcaneBadge(label: 'Major Release', variant: BadgeVariant.primary),
          ArcaneText('Complete redesign with new components'),
        ],
      ),
    ),
    ArcaneTimelineItem(
      title: 'v1.5.0',
      date: 'Dec 10, 2023',
      content: ArcaneColumn(
        gap: Gap.sm,
        crossAxisAlignment: AlignItems.start,
        children: [
          ArcaneBadge(label: 'Feature'),
          ArcaneText('Added dark mode support'),
        ],
      ),
    ),
  ],
)
```

## Related Components

- [ArcaneCard](/docs/layout/arcane-card) - Card container
- [ArcaneStatusIndicator](/docs/view/arcane-status-indicator) - Status dots
- [ArcaneDivider](/docs/view/arcane-divider) - Visual separator
