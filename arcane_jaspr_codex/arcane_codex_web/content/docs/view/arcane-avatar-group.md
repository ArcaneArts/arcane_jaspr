---
title: ArcaneAvatarGroup
description: Stacked avatar display with overflow indicator
layout: docs
component: avatar-group
---

# ArcaneAvatarGroup

A component for displaying multiple avatars in a stacked layout with overflow handling.

## Basic Usage

```dart
ArcaneAvatarGroup(
  avatars: [
    ArcaneAvatar(initials: 'AB'),
    ArcaneAvatar(initials: 'CD'),
    ArcaneAvatar(initials: 'EF'),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `avatars` | `List<ArcaneAvatar>` | required | Avatar components |
| `maxVisible` | `int` | `3` | Max avatars before +N |
| `overlap` | `double` | `12` | Overlap amount in px |
| `direction` | `StackDirection` | `toRight` | Stack direction |

## Stack Directions

### Stack to Right (Default)

```dart
ArcaneAvatarGroup.toRight(
  avatars: avatarList,
  maxVisible: 4,
)
```

### Stack to Left

```dart
ArcaneAvatarGroup.toLeft(
  avatars: avatarList,
  maxVisible: 4,
)
```

## With Overflow

```dart
ArcaneAvatarGroup(
  avatars: [
    ArcaneAvatar(initials: 'AB'),
    ArcaneAvatar(initials: 'CD'),
    ArcaneAvatar(initials: 'EF'),
    ArcaneAvatar(initials: 'GH'),
    ArcaneAvatar(initials: 'IJ'),
    ArcaneAvatar(initials: 'KL'),
  ],
  maxVisible: 3,  // Shows: AB, CD, EF, +3
)
```

# ArcaneAvatarBadge

A status badge that can be positioned on an avatar.

## Basic Usage

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(position: Position.relative),
  children: [
    ArcaneAvatar(initials: 'JD'),
    ArcaneAvatarBadge.online(),
  ],
)
```

## Factory Constructors

### Online Status

```dart
ArcaneAvatarBadge.online()  // Green dot
```

### Busy Status

```dart
ArcaneAvatarBadge.busy()  // Red dot
```

### Away Status

```dart
ArcaneAvatarBadge.away()  // Yellow dot
```

### Offline Status

```dart
ArcaneAvatarBadge.offline()  // Gray dot
```

## Custom Badge

```dart
ArcaneAvatarBadge(
  status: AvatarBadgeStatus.custom,
  color: '#10b981',
  pulse: true,
)
```

## Examples

### Team Members

```dart
ArcaneColumn(
  gapSize: Gap.md,
  children: [
    ArcaneText('Team Members', weight: FontWeight.bold),
    ArcaneAvatarGroup.toRight(
      avatars: teamMembers.map((m) => ArcaneAvatar(
        imageUrl: m.avatarUrl,
        initials: m.initials,
      )).toList(),
      maxVisible: 5,
    ),
  ],
)
```

### User Status List

```dart
for (final user in users)
  ArcaneRow(
    gapSize: Gap.md,
    children: [
      ArcaneDiv(
        styles: const ArcaneStyleData(position: Position.relative),
        children: [
          ArcaneAvatar(initials: user.initials),
          ArcaneAvatarBadge(status: user.status),
        ],
      ),
      ArcaneText(user.name),
    ],
  ),
```

## Related Components

- [ArcaneAvatar](/arcane_jaspr/docs/view/arcane-avatar) - Single avatar component
- [ArcaneBadge](/arcane_jaspr/docs/view/arcane-badge) - Generic badge component
