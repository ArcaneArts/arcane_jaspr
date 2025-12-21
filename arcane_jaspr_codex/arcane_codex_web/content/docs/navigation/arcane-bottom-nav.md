---
title: ArcaneBottomNav
description: Mobile bottom navigation bar
layout: docs
component: bottom-nav
---

# ArcaneBottomNav

A bottom navigation bar component for mobile-first navigation patterns.

## Basic Usage

```dart
ArcaneBottomNav(
  items: [
    ArcaneBottomNavItem(
      icon: span([text('🏠')]),
      label: 'Home',
      href: '/',
    ),
    ArcaneBottomNavItem(
      icon: span([text('🔍')]),
      label: 'Search',
      href: '/search',
    ),
    ArcaneBottomNavItem(
      icon: span([text('👤')]),
      label: 'Profile',
      href: '/profile',
    ),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `items` | `List<ArcaneBottomNavItem>` | required | Navigation items |
| `currentIndex` | `int` | `0` | Active item index |
| `onTap` | `Function(int)?` | `null` | Item tap callback |
| `variant` | `BottomNavVariant` | `default_` | Visual style |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## ArcaneBottomNavItem Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `icon` | `Component` | required | Item icon |
| `label` | `String` | required | Item label |
| `href` | `String?` | `null` | Navigation URL |
| `badge` | `Component?` | `null` | Badge component |
| `isActive` | `bool` | `false` | Active state |

## With Badges

```dart
ArcaneBottomNav(
  items: [
    ArcaneBottomNavItem(
      icon: span([text('🏠')]),
      label: 'Home',
      href: '/',
      isActive: true,
    ),
    ArcaneBottomNavItem(
      icon: span([text('💬')]),
      label: 'Messages',
      href: '/messages',
      badge: ArcaneBadge(label: '5', variant: BadgeVariant.error),
    ),
    ArcaneBottomNavItem(
      icon: span([text('🔔')]),
      label: 'Notifications',
      href: '/notifications',
      badge: ArcaneBadge(label: '12'),
    ),
    ArcaneBottomNavItem(
      icon: span([text('👤')]),
      label: 'Profile',
      href: '/profile',
    ),
  ],
)
```

## Variants

```dart
// Default style
ArcaneBottomNav(
  variant: BottomNavVariant.default_,
  items: items,
)

// Minimal style
ArcaneBottomNav(
  variant: BottomNavVariant.minimal,
  items: items,
)

// Floating style
ArcaneBottomNav(
  variant: BottomNavVariant.floating,
  items: items,
)
```

## Examples

### Mobile App Navigation

```dart
ArcaneScreen(
  body: PageContent(),
  bottomNavigation: ArcaneBottomNav(
    items: [
      ArcaneBottomNavItem(
        icon: span([text('🏠')]),
        label: 'Home',
        href: '/',
        isActive: currentPage == 'home',
      ),
      ArcaneBottomNavItem(
        icon: span([text('🔍')]),
        label: 'Explore',
        href: '/explore',
        isActive: currentPage == 'explore',
      ),
      ArcaneBottomNavItem(
        icon: span([text('➕')]),
        label: 'Create',
        href: '/create',
        isActive: currentPage == 'create',
      ),
      ArcaneBottomNavItem(
        icon: span([text('📥')]),
        label: 'Inbox',
        href: '/inbox',
        isActive: currentPage == 'inbox',
        badge: unreadCount > 0 ? ArcaneBadge(label: '$unreadCount') : null,
      ),
      ArcaneBottomNavItem(
        icon: span([text('👤')]),
        label: 'Profile',
        href: '/profile',
        isActive: currentPage == 'profile',
      ),
    ],
  ),
)
```

### E-Commerce App

```dart
ArcaneBottomNav(
  items: [
    ArcaneBottomNavItem(
      icon: span([text('🏠')]),
      label: 'Shop',
      href: '/shop',
    ),
    ArcaneBottomNavItem(
      icon: span([text('🔍')]),
      label: 'Search',
      href: '/search',
    ),
    ArcaneBottomNavItem(
      icon: span([text('🛒')]),
      label: 'Cart',
      href: '/cart',
      badge: cartCount > 0
          ? ArcaneBadge(label: '$cartCount', variant: BadgeVariant.primary)
          : null,
    ),
    ArcaneBottomNavItem(
      icon: span([text('❤️')]),
      label: 'Wishlist',
      href: '/wishlist',
    ),
    ArcaneBottomNavItem(
      icon: span([text('👤')]),
      label: 'Account',
      href: '/account',
    ),
  ],
)
```

### Social Media App

```dart
ArcaneBottomNav(
  variant: BottomNavVariant.minimal,
  items: [
    ArcaneBottomNavItem(
      icon: span([text('🏠')]),
      label: 'Feed',
      href: '/feed',
      isActive: true,
    ),
    ArcaneBottomNavItem(
      icon: span([text('🔍')]),
      label: 'Discover',
      href: '/discover',
    ),
    ArcaneBottomNavItem(
      icon: span([text('➕')]),
      label: 'Post',
      href: '/post',
    ),
    ArcaneBottomNavItem(
      icon: span([text('💬')]),
      label: 'Messages',
      href: '/messages',
      badge: ArcaneBadge(label: '3'),
    ),
    ArcaneBottomNavItem(
      icon: ArcaneAvatar(imageUrl: user.avatar, size: AvatarSize.xs),
      label: 'Profile',
      href: '/profile',
    ),
  ],
)
```

### Fixed Position Usage

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    position: Position.fixed,
    bottom: '0',
    left: '0',
    right: '0',
    raw: {
      'z-index': '1000',
    },
  ),
  children: [
    ArcaneBottomNav(
      items: navItems,
    ),
  ],
)
```

### Responsive Navigation

```dart
// Show bottom nav only on mobile
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.block,
    raw: {
      '@media (min-width: 768px)': {
        'display': 'none',
      },
    },
  ),
  children: [
    ArcaneBottomNav(items: navItems),
  ],
)
```

## Related Components

- [ArcaneHeader](/arcane_jaspr/docs/navigation/arcane-header) - Top navigation
- [ArcaneSidebar](/arcane_jaspr/docs/navigation/arcane-sidebar) - Side navigation
- [ArcaneMobileMenu](/arcane_jaspr/docs/navigation/arcane-mobile-menu) - Mobile menu overlay
