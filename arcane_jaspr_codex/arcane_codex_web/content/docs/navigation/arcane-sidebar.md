---
title: ArcaneSidebar
description: Vertical side navigation panel
layout: docs
---

# ArcaneSidebar

A vertical sidebar component for application navigation with support for groups, icons, and collapsible sections.

## Basic Usage

```dart
ArcaneSidebar(
  children: [
    ArcaneSidebarItem(label: 'Dashboard', href: '/dashboard'),
    ArcaneSidebarItem(label: 'Projects', href: '/projects'),
    ArcaneSidebarItem(label: 'Settings', href: '/settings'),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `children` | `List<Component>` | required | Sidebar content |
| `header` | `Component?` | `null` | Header component |
| `footer` | `Component?` | `null` | Footer component |
| `width` | `String` | `'280px'` | Sidebar width |
| `collapsed` | `bool` | `false` | Collapsed state |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## ArcaneSidebarItem Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `label` | `String` | required | Item text |
| `href` | `String?` | `null` | Navigation URL |
| `icon` | `Component?` | `null` | Leading icon |
| `isActive` | `bool` | `false` | Active state |
| `badge` | `Component?` | `null` | Trailing badge |
| `onPressed` | `VoidCallback?` | `null` | Click handler |

## With Icons

```dart
ArcaneSidebar(
  children: [
    ArcaneSidebarItem(
      icon: span([text('🏠')]),
      label: 'Home',
      href: '/',
    ),
    ArcaneSidebarItem(
      icon: span([text('📊')]),
      label: 'Analytics',
      href: '/analytics',
    ),
    ArcaneSidebarItem(
      icon: span([text('⚙️')]),
      label: 'Settings',
      href: '/settings',
    ),
  ],
)
```

## Grouped Navigation

```dart
ArcaneSidebar(
  children: [
    ArcaneSidebarGroup(
      title: 'Main',
      children: [
        ArcaneSidebarItem(icon: span([text('🏠')]), label: 'Dashboard', href: '/'),
        ArcaneSidebarItem(icon: span([text('📁')]), label: 'Projects', href: '/projects'),
      ],
    ),
    ArcaneSidebarGroup(
      title: 'Analytics',
      children: [
        ArcaneSidebarItem(icon: span([text('📊')]), label: 'Overview', href: '/analytics'),
        ArcaneSidebarItem(icon: span([text('📈')]), label: 'Reports', href: '/reports'),
      ],
    ),
    ArcaneSidebarGroup(
      title: 'Settings',
      children: [
        ArcaneSidebarItem(icon: span([text('👤')]), label: 'Profile', href: '/profile'),
        ArcaneSidebarItem(icon: span([text('⚙️')]), label: 'Preferences', href: '/settings'),
      ],
    ),
  ],
)
```

## With Header and Footer

```dart
ArcaneSidebar(
  header: ArcaneDiv(
    styles: const ArcaneStyleData(
      padding: PaddingPreset.lg,
      borderBottom: BorderPreset.subtle,
    ),
    children: [
      ArcaneRow(
        gap: Gap.sm,
        children: [
          ArcaneAvatar(imageUrl: user.avatar),
          ArcaneColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
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
      ),
    ],
  ),
  children: [
    ArcaneSidebarItem(label: 'Dashboard', href: '/dashboard'),
    ArcaneSidebarItem(label: 'Projects', href: '/projects'),
    ArcaneSidebarItem(label: 'Settings', href: '/settings'),
  ],
  footer: ArcaneDiv(
    styles: const ArcaneStyleData(
      padding: PaddingPreset.md,
      borderTop: BorderPreset.subtle,
    ),
    children: [
      ArcaneSidebarItem(
        icon: span([text('🚪')]),
        label: 'Sign Out',
        onPressed: signOut,
      ),
    ],
  ),
)
```

## With Badges

```dart
ArcaneSidebar(
  children: [
    ArcaneSidebarItem(
      icon: span([text('📥')]),
      label: 'Inbox',
      href: '/inbox',
      badge: ArcaneBadge(label: '12', variant: BadgeVariant.primary),
    ),
    ArcaneSidebarItem(
      icon: span([text('📤')]),
      label: 'Sent',
      href: '/sent',
    ),
    ArcaneSidebarItem(
      icon: span([text('⭐')]),
      label: 'Starred',
      href: '/starred',
      badge: ArcaneBadge(label: '3'),
    ),
  ],
)
```

## Examples

### Dashboard Sidebar

```dart
ArcaneSidebar(
  header: ArcaneDiv(
    styles: const ArcaneStyleData(padding: PaddingPreset.lg),
    children: [
      ArcaneGradientText(text: 'Arcane'),
    ],
  ),
  children: [
    ArcaneSidebarGroup(
      title: 'Overview',
      children: [
        ArcaneSidebarItem(
          icon: span([text('📊')]),
          label: 'Dashboard',
          href: '/dashboard',
          isActive: true,
        ),
        ArcaneSidebarItem(
          icon: span([text('📈')]),
          label: 'Analytics',
          href: '/analytics',
        ),
      ],
    ),
    ArcaneSidebarGroup(
      title: 'Management',
      children: [
        ArcaneSidebarItem(
          icon: span([text('👥')]),
          label: 'Users',
          href: '/users',
          badge: ArcaneBadge(label: 'New'),
        ),
        ArcaneSidebarItem(
          icon: span([text('📁')]),
          label: 'Projects',
          href: '/projects',
        ),
        ArcaneSidebarItem(
          icon: span([text('📋')]),
          label: 'Tasks',
          href: '/tasks',
        ),
      ],
    ),
    ArcaneSidebarGroup(
      title: 'System',
      children: [
        ArcaneSidebarItem(
          icon: span([text('⚙️')]),
          label: 'Settings',
          href: '/settings',
        ),
        ArcaneSidebarItem(
          icon: span([text('❓')]),
          label: 'Help',
          href: '/help',
        ),
      ],
    ),
  ],
  footer: ArcaneDiv(
    styles: const ArcaneStyleData(padding: PaddingPreset.md),
    children: [
      ArcaneRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ArcaneThemeToggle(),
          ArcaneButton.ghost(
            label: 'Sign Out',
            onPressed: signOut,
          ),
        ],
      ),
    ],
  ),
)
```

### Documentation Sidebar

```dart
ArcaneSidebar(
  header: ArcaneDiv(
    styles: const ArcaneStyleData(padding: PaddingPreset.lg),
    children: [
      a(href: '/', [
        ArcaneText('Documentation'),
      ]),
    ],
  ),
  children: [
    ArcaneSidebarGroup(
      title: 'Getting Started',
      children: [
        ArcaneSidebarItem(label: 'Introduction', href: '/docs'),
        ArcaneSidebarItem(label: 'Installation', href: '/docs/installation'),
        ArcaneSidebarItem(label: 'Quick Start', href: '/docs/quick-start'),
      ],
    ),
    ArcaneSidebarGroup(
      title: 'Components',
      children: [
        ArcaneSidebarItem(label: 'Button', href: '/docs/button'),
        ArcaneSidebarItem(label: 'Input', href: '/docs/input'),
        ArcaneSidebarItem(label: 'Card', href: '/docs/card'),
      ],
    ),
  ],
)
```

### Collapsible Sidebar

```dart
ArcaneSidebar(
  collapsed: isCollapsed,
  width: isCollapsed ? '64px' : '280px',
  children: [
    ArcaneSidebarItem(
      icon: span([text('🏠')]),
      label: isCollapsed ? '' : 'Home',
      href: '/',
    ),
    ArcaneSidebarItem(
      icon: span([text('📊')]),
      label: isCollapsed ? '' : 'Analytics',
      href: '/analytics',
    ),
  ],
  footer: ArcaneIconButton(
    icon: span([text(isCollapsed ? '→' : '←')]),
    onPressed: toggleSidebar,
  ),
)
```

## Related Components

- [ArcaneSidebarItem](/docs/navigation/arcane-sidebar-item) - Sidebar navigation item
- [ArcaneSidebarGroup](/docs/navigation/arcane-sidebar-group) - Sidebar section group
- [ArcaneHeader](/docs/navigation/arcane-header) - Application header
