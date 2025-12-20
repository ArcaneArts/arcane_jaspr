---
title: ArcaneTile
description: Interactive tile component for grid layouts
layout: docs
component: tile
---

# ArcaneTile

A clickable tile component designed for grid layouts, suitable for navigation menus, feature grids, and dashboard widgets.

## Basic Usage

```dart
ArcaneTile(
  title: 'Settings',
  icon: span([text('⚙')]),
  onPressed: () => goToSettings(),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `title` | `String` | required | Tile title |
| `icon` | `Component?` | `null` | Leading icon |
| `description` | `String?` | `null` | Description text |
| `trailing` | `Component?` | `null` | Trailing widget |
| `onPressed` | `VoidCallback?` | `null` | Click handler |
| `isSelected` | `bool` | `false` | Selected state |
| `isDisabled` | `bool` | `false` | Disabled state |
| `size` | `TileSize` | `medium` | Tile size |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Sizes

```dart
// Small
ArcaneTile(
  size: TileSize.small,
  title: 'Small Tile',
  icon: span([text('📁')]),
  onPressed: () {},
)

// Medium (default)
ArcaneTile(
  size: TileSize.medium,
  title: 'Medium Tile',
  icon: span([text('📁')]),
  onPressed: () {},
)

// Large
ArcaneTile(
  size: TileSize.large,
  title: 'Large Tile',
  icon: span([text('📁')]),
  description: 'With description',
  onPressed: () {},
)
```

## With Description

```dart
ArcaneTile(
  icon: span([text('📊')]),
  title: 'Analytics',
  description: 'View your statistics',
  onPressed: () => goToAnalytics(),
)
```

## Selected State

```dart
ArcaneTile(
  icon: span([text('🏠')]),
  title: 'Dashboard',
  isSelected: currentPage == 'dashboard',
  onPressed: () => goToDashboard(),
)
```

## Examples

### Navigation Grid

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.grid,
    gridTemplateColumns: 'repeat(4, 1fr)',
    gap: Gap.md,
  ),
  children: [
    ArcaneTile(
      icon: span([text('🏠')]),
      title: 'Dashboard',
      isSelected: page == 'dashboard',
      onPressed: () => navigate('dashboard'),
    ),
    ArcaneTile(
      icon: span([text('📁')]),
      title: 'Projects',
      isSelected: page == 'projects',
      onPressed: () => navigate('projects'),
    ),
    ArcaneTile(
      icon: span([text('👥')]),
      title: 'Team',
      isSelected: page == 'team',
      onPressed: () => navigate('team'),
    ),
    ArcaneTile(
      icon: span([text('⚙')]),
      title: 'Settings',
      isSelected: page == 'settings',
      onPressed: () => navigate('settings'),
    ),
  ],
)
```

### Feature Grid

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.grid,
    gridTemplateColumns: 'repeat(3, 1fr)',
    gap: Gap.lg,
  ),
  children: [
    ArcaneTile(
      size: TileSize.large,
      icon: span([text('⚡')]),
      title: 'Fast Performance',
      description: 'Optimized for speed',
      onPressed: () => learnMore('performance'),
    ),
    ArcaneTile(
      size: TileSize.large,
      icon: span([text('🔒')]),
      title: 'Secure',
      description: 'Enterprise-grade security',
      onPressed: () => learnMore('security'),
    ),
    ArcaneTile(
      size: TileSize.large,
      icon: span([text('📱')]),
      title: 'Responsive',
      description: 'Works on all devices',
      onPressed: () => learnMore('responsive'),
    ),
  ],
)
```

### Quick Actions

```dart
ArcaneRow(
  gap: Gap.sm,
  children: [
    ArcaneTile(
      size: TileSize.small,
      icon: span([text('+')]),
      title: 'New',
      onPressed: createNew,
    ),
    ArcaneTile(
      size: TileSize.small,
      icon: span([text('📤')]),
      title: 'Export',
      onPressed: exportData,
    ),
    ArcaneTile(
      size: TileSize.small,
      icon: span([text('🔄')]),
      title: 'Sync',
      onPressed: syncData,
    ),
  ],
)
```

### App Launcher

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.grid,
    gridTemplateColumns: 'repeat(4, 80px)',
    gap: Gap.md,
    justifyContent: JustifyContent.center,
  ),
  children: [
    for (var app in apps)
      ArcaneTile(
        size: TileSize.small,
        icon: ArcaneImage(src: app.icon, width: 32, height: 32),
        title: app.name,
        onPressed: () => launchApp(app),
      ),
  ],
)
```

### Stat Tiles

```dart
ArcaneRow(
  gap: Gap.lg,
  children: [
    ArcaneExpanded(
      child: ArcaneTile(
        size: TileSize.large,
        icon: span([text('💰')]),
        title: 'Revenue',
        description: '\$45,231',
        trailing: ArcaneBadge(label: '+12%', variant: BadgeVariant.success),
        onPressed: viewRevenueDetails,
      ),
    ),
    ArcaneExpanded(
      child: ArcaneTile(
        size: TileSize.large,
        icon: span([text('👥')]),
        title: 'Users',
        description: '2,350',
        trailing: ArcaneBadge(label: '+8%', variant: BadgeVariant.success),
        onPressed: viewUserDetails,
      ),
    ),
  ],
)
```

## Related Components

- [ArcaneCard](/docs/layout/arcane-card) - Card container
- [ArcaneNavTile](/docs/navigation/arcane-nav-tile) - Navigation tile
- [ArcaneFeatureCard](/docs/view/arcane-feature-card) - Feature card
