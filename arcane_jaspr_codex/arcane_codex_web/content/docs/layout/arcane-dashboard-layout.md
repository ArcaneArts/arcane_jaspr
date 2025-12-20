---
title: ArcaneDashboardLayout
description: Complete dashboard layout with sidebar and header
layout: docs
component: dashboard-layout
---

# ArcaneDashboardLayout

A comprehensive dashboard layout component with sidebar navigation, header, and main content area.

## Basic Usage

```dart
ArcaneDashboardLayout(
  sidebar: MySidebar(),
  header: MyHeader(),
  child: DashboardContent(),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `child` | `Component` | required | Main content |
| `sidebar` | `Component?` | `null` | Sidebar navigation |
| `header` | `Component?` | `null` | Top header bar |
| `sidebarWidth` | `String?` | `250px` | Sidebar width |
| `sidebarCollapsed` | `bool` | `false` | Collapse sidebar |
| `collapsedWidth` | `String?` | `64px` | Collapsed sidebar width |
| `showMobileMenu` | `bool` | `false` | Show mobile menu |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## With Sidebar

```dart
ArcaneDashboardLayout(
  sidebar: ArcaneColumn(
    styles: const ArcaneStyleData(
      padding: PaddingPreset.md,
      background: Background.surface,
      heightCustom: '100%',
    ),
    children: [
      ArcaneText('Logo'),
      ArcaneGutter(size: GutterSize.lg),
      ArcaneSidebarItem(label: 'Dashboard', icon: '🏠', isActive: true),
      ArcaneSidebarItem(label: 'Projects', icon: '📁'),
      ArcaneSidebarItem(label: 'Team', icon: '👥'),
      ArcaneSidebarItem(label: 'Analytics', icon: '📊'),
      ArcaneSpacer(),
      ArcaneSidebarItem(label: 'Settings', icon: '⚙'),
    ],
  ),
  child: DashboardContent(),
)
```

## With Header

```dart
ArcaneDashboardLayout(
  header: ArcaneRow(
    mainAxisAlignment: JustifyContent.spaceBetween,
    crossAxisAlignment: AlignItems.center,
    styles: const ArcaneStyleData(
      padding: PaddingPreset.md,
      background: Background.surface,
      borderBottom: Border.subtle,
    ),
    children: [
      ArcaneSearch(placeholder: 'Search...'),
      ArcaneRow(
        gap: Gap.md,
        children: [
          ArcaneIconButton(icon: span([text('🔔')]), onPressed: () {}),
          ArcaneAvatar(imageUrl: '/user.jpg', size: AvatarSize.small),
        ],
      ),
    ],
  ),
  sidebar: MySidebar(),
  child: DashboardContent(),
)
```

## Collapsible Sidebar

```dart
class DashboardPage extends StatefulComponent {
  bool sidebarCollapsed = false;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield ArcaneDashboardLayout(
      sidebarCollapsed: sidebarCollapsed,
      sidebar: ArcaneColumn(
        children: [
          ArcaneIconButton(
            icon: span([text(sidebarCollapsed ? '→' : '←')]),
            onPressed: () => setState(() => sidebarCollapsed = !sidebarCollapsed),
          ),
          if (!sidebarCollapsed) ...[
            ArcaneSidebarItem(label: 'Dashboard', icon: '🏠'),
            ArcaneSidebarItem(label: 'Projects', icon: '📁'),
          ] else ...[
            ArcaneIconButton(icon: span([text('🏠')]), onPressed: () {}),
            ArcaneIconButton(icon: span([text('📁')]), onPressed: () {}),
          ],
        ],
      ),
      child: DashboardContent(),
    );
  }
}
```

## Examples

### Complete Dashboard

```dart
ArcaneDashboardLayout(
  header: ArcaneRow(
    mainAxisAlignment: JustifyContent.spaceBetween,
    crossAxisAlignment: AlignItems.center,
    styles: const ArcaneStyleData(
      padding: PaddingPreset.smMd,
      background: Background.surface,
      borderBottom: Border.subtle,
    ),
    children: [
      ArcaneRow(
        gap: Gap.md,
        children: [
          ArcaneHamburgerButton(onPressed: toggleMobileMenu),
          ArcaneHeading(text: 'Dashboard'),
        ],
      ),
      ArcaneRow(
        gap: Gap.md,
        children: [
          ArcaneSearch(placeholder: 'Search...'),
          ArcaneIconButton(icon: span([text('🔔')]), onPressed: () {}),
          ArcaneDropdownMenu(
            trigger: ArcaneAvatar(imageUrl: user.avatar),
            children: [
              ArcaneDropdownItem(label: 'Profile', onPressed: () {}),
              ArcaneDropdownItem(label: 'Settings', onPressed: () {}),
              ArcaneDivider(),
              ArcaneDropdownItem(label: 'Sign Out', onPressed: signOut),
            ],
          ),
        ],
      ),
    ],
  ),
  sidebar: ArcaneColumn(
    styles: const ArcaneStyleData(
      background: Background.surface,
      padding: PaddingPreset.md,
    ),
    children: [
      ArcaneRow(
        gap: Gap.sm,
        children: [
          span([text('🚀')]),
          ArcaneText('MyApp'),
        ],
      ),
      ArcaneGutter(size: GutterSize.lg),
      ArcaneSidebarGroup(
        title: 'Main',
        children: [
          ArcaneSidebarItem(label: 'Overview', icon: '📊', isActive: true),
          ArcaneSidebarItem(label: 'Projects', icon: '📁'),
          ArcaneSidebarItem(label: 'Tasks', icon: '✓'),
        ],
      ),
      ArcaneSidebarGroup(
        title: 'Team',
        children: [
          ArcaneSidebarItem(label: 'Members', icon: '👥'),
          ArcaneSidebarItem(label: 'Permissions', icon: '🔐'),
        ],
      ),
      ArcaneSpacer(),
      ArcaneSidebarItem(label: 'Settings', icon: '⚙'),
      ArcaneSidebarItem(label: 'Help', icon: '❓'),
    ],
  ),
  child: ArcanePageBody(
    title: 'Overview',
    actions: [
      ArcaneButton.primary(
        label: 'New Project',
        leading: span([text('+')]),
        onPressed: createProject,
      ),
    ],
    children: [
      ArcaneRow(
        gap: Gap.lg,
        children: [
          ArcaneExpanded(child: StatCard(title: 'Revenue', value: '\$45,231')),
          ArcaneExpanded(child: StatCard(title: 'Users', value: '2,350')),
          ArcaneExpanded(child: StatCard(title: 'Orders', value: '1,234')),
        ],
      ),
      ArcaneGutter(size: GutterSize.lg),
      ArcaneCard(
        child: ArcaneColumn(
          gap: Gap.md,
          children: [
            ArcaneHeading(text: 'Recent Activity'),
            ActivityList(),
          ],
        ),
      ),
    ],
  ),
)
```

### Mobile Responsive

```dart
ArcaneDashboardLayout(
  showMobileMenu: showMobileMenu,
  sidebar: MySidebar(),
  header: ArcaneRow(
    children: [
      ArcaneHamburgerButton(
        onPressed: () => setState(() => showMobileMenu = !showMobileMenu),
      ),
      ArcaneSpacer(),
      // Other header items...
    ],
  ),
  child: MainContent(),
)
```

## Related Components

- [ArcaneSidebar](/docs/navigation/arcane-sidebar) - Sidebar navigation
- [ArcaneHeader](/docs/navigation/arcane-header) - Header component
- [ArcanePageBody](/docs/layout/arcane-page-body) - Page content wrapper
