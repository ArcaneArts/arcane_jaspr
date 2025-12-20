---
title: ArcaneAvatar
description: User avatar with image or initials fallback
layout: docs
component: avatar
---

# ArcaneAvatar

A circular avatar component for displaying user profile images with fallback to initials.

## Basic Usage

```dart
ArcaneAvatar(
  imageUrl: '/user.jpg',
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `imageUrl` | `String?` | `null` | Image URL |
| `name` | `String?` | `null` | Name for initials fallback |
| `size` | `AvatarSize` | `medium` | Avatar size |
| `borderRadius` | `AvatarRadius` | `circle` | Shape |
| `status` | `AvatarStatus?` | `null` | Online status indicator |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Sizes

```dart
// Extra small
ArcaneAvatar(imageUrl: url, size: AvatarSize.xs)

// Small
ArcaneAvatar(imageUrl: url, size: AvatarSize.small)

// Medium (default)
ArcaneAvatar(imageUrl: url, size: AvatarSize.medium)

// Large
ArcaneAvatar(imageUrl: url, size: AvatarSize.large)

// Extra large
ArcaneAvatar(imageUrl: url, size: AvatarSize.xlarge)

// 2XL
ArcaneAvatar(imageUrl: url, size: AvatarSize.xl2)
```

## With Initials Fallback

```dart
// Will display "JD" if image fails or is not provided
ArcaneAvatar(
  name: 'John Doe',
  size: AvatarSize.medium,
)
```

## Status Indicator

```dart
// Online
ArcaneAvatar(
  imageUrl: '/user.jpg',
  status: AvatarStatus.online,
)

// Away
ArcaneAvatar(
  imageUrl: '/user.jpg',
  status: AvatarStatus.away,
)

// Busy
ArcaneAvatar(
  imageUrl: '/user.jpg',
  status: AvatarStatus.busy,
)

// Offline
ArcaneAvatar(
  imageUrl: '/user.jpg',
  status: AvatarStatus.offline,
)
```

## Shape

```dart
// Circle (default)
ArcaneAvatar(
  imageUrl: '/user.jpg',
  borderRadius: AvatarRadius.circle,
)

// Rounded square
ArcaneAvatar(
  imageUrl: '/user.jpg',
  borderRadius: AvatarRadius.rounded,
)
```

## Examples

### User List Item

```dart
ArcaneRow(
  gap: Gap.md,
  crossAxisAlignment: AlignItems.center,
  children: [
    ArcaneAvatar(
      imageUrl: user.avatar,
      name: user.name,
      size: AvatarSize.medium,
      status: user.isOnline ? AvatarStatus.online : AvatarStatus.offline,
    ),
    ArcaneColumn(
      crossAxisAlignment: AlignItems.start,
      children: [
        ArcaneText(user.name),
        ArcaneText(
          user.email,
          styles: const ArcaneStyleData(
            fontSize: FontSize.sm,
            textColor: TextColor.muted,
          ),
        ),
      ],
    ),
  ],
)
```

### Header Profile

```dart
ArcaneDropdownMenu(
  trigger: ArcaneAvatar(
    imageUrl: currentUser.avatar,
    size: AvatarSize.small,
  ),
  children: [
    ArcaneDropdownItem(label: 'Profile', onPressed: goToProfile),
    ArcaneDropdownItem(label: 'Settings', onPressed: goToSettings),
    ArcaneDivider(),
    ArcaneDropdownItem(label: 'Sign Out', onPressed: signOut),
  ],
)
```

### Profile Card

```dart
ArcaneCard(
  child: ArcaneColumn(
    crossAxisAlignment: AlignItems.center,
    gap: Gap.md,
    children: [
      ArcaneAvatar(
        imageUrl: user.avatar,
        name: user.name,
        size: AvatarSize.xl2,
      ),
      ArcaneHeading(text: user.name),
      ArcaneText(user.role),
      ArcaneFlow(
        gap: Gap.sm,
        children: [
          for (var skill in user.skills)
            ArcaneBadge(label: skill),
        ],
      ),
    ],
  ),
)
```

### Comment Author

```dart
ArcaneRow(
  gap: Gap.sm,
  crossAxisAlignment: AlignItems.start,
  children: [
    ArcaneAvatar(
      imageUrl: comment.author.avatar,
      name: comment.author.name,
      size: AvatarSize.small,
    ),
    ArcaneExpanded(
      child: ArcaneCard(
        child: ArcaneColumn(
          crossAxisAlignment: AlignItems.start,
          gap: Gap.xs,
          children: [
            ArcaneRow(
              gap: Gap.sm,
              children: [
                ArcaneText(comment.author.name),
                ArcaneText(
                  formatDate(comment.date),
                  styles: const ArcaneStyleData(
                    fontSize: FontSize.sm,
                    textColor: TextColor.muted,
                  ),
                ),
              ],
            ),
            ArcaneText(comment.text),
          ],
        ),
      ),
    ),
  ],
)
```

### Team Members

```dart
ArcaneRow(
  gap: Gap.sm,
  children: [
    for (var member in team.members.take(5))
      ArcaneAvatar(
        imageUrl: member.avatar,
        name: member.name,
        size: AvatarSize.small,
      ),
    if (team.members.length > 5)
      ArcaneAvatar(
        name: '+${team.members.length - 5}',
        size: AvatarSize.small,
      ),
  ],
)
```

## Related Components

- [ArcaneAvatarGroup](/docs/view/arcane-avatar-group) - Grouped avatars
- [ArcaneBadge](/docs/view/arcane-badge) - Status badges
- [ArcaneStatusIndicator](/docs/view/arcane-status-indicator) - Status dots
