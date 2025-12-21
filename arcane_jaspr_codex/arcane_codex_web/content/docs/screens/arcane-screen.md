---
title: ArcaneScreen
description: Full-screen layout wrapper with optional navigation
layout: docs
component: screen
---

# ArcaneScreen

A full-screen layout component that provides structure for application screens with optional header, sidebar, and bottom navigation.

## Basic Usage

```dart
ArcaneScreen(
  body: YourPageContent(),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `body` | `Component` | required | Main content |
| `header` | `Component?` | `null` | Top header |
| `sidebar` | `Component?` | `null` | Side navigation |
| `bottomNavigation` | `Component?` | `null` | Bottom nav bar |
| `backgroundColor` | `BackgroundColor` | `primary` | Background color |
| `padding` | `PaddingPreset?` | `null` | Content padding |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## With Header

```dart
ArcaneScreen(
  header: ArcaneHeader(
    logo: ArcaneText('MyApp'),
    navItems: [
      ArcaneNavItem(label: 'Home', href: '/'),
      ArcaneNavItem(label: 'About', href: '/about'),
    ],
  ),
  body: PageContent(),
)
```

## With Sidebar

```dart
ArcaneScreen(
  sidebar: ArcaneSidebar(
    children: [
      ArcaneSidebarItem(label: 'Dashboard', href: '/'),
      ArcaneSidebarItem(label: 'Projects', href: '/projects'),
      ArcaneSidebarItem(label: 'Settings', href: '/settings'),
    ],
  ),
  body: PageContent(),
)
```

## With Bottom Navigation

```dart
ArcaneScreen(
  body: PageContent(),
  bottomNavigation: ArcaneBottomNav(
    items: [
      ArcaneBottomNavItem(icon: span([text('🏠')]), label: 'Home', href: '/'),
      ArcaneBottomNavItem(icon: span([text('🔍')]), label: 'Search', href: '/search'),
      ArcaneBottomNavItem(icon: span([text('👤')]), label: 'Profile', href: '/profile'),
    ],
  ),
)
```

## Full Layout

```dart
ArcaneScreen(
  header: ArcaneHeader(
    logo: ArcaneText('Dashboard'),
    actions: [
      ArcaneThemeToggle(),
      ArcaneAvatar(imageUrl: user.avatar),
    ],
  ),
  sidebar: ArcaneSidebar(
    children: [
      ArcaneSidebarItem(icon: span([text('📊')]), label: 'Overview', href: '/'),
      ArcaneSidebarItem(icon: span([text('📁')]), label: 'Projects', href: '/projects'),
      ArcaneSidebarItem(icon: span([text('⚙️')]), label: 'Settings', href: '/settings'),
    ],
  ),
  body: DashboardContent(),
)
```

## Examples

### Marketing Page

```dart
ArcaneScreen(
  header: ArcaneHeader(
    logo: ArcaneGradientText(text: 'Arcane'),
    navItems: [
      ArcaneNavItem(label: 'Features', href: '/features'),
      ArcaneNavItem(label: 'Pricing', href: '/pricing'),
      ArcaneNavItem(label: 'Docs', href: '/docs'),
    ],
    actions: [
      ArcaneButton.secondary(label: 'Sign In', onPressed: signIn),
      ArcaneButton.primary(label: 'Get Started', onPressed: getStarted),
    ],
  ),
  body: ArcaneColumn(
    children: [
      HeroSection(),
      FeaturesSection(),
      PricingSection(),
      CTASection(),
      ArcaneFooter(),
    ],
  ),
)
```

### Dashboard Screen

```dart
ArcaneScreen(
  header: ArcaneHeader(
    logo: ArcaneText('Analytics'),
    actions: [
      ArcaneSearch(placeholder: 'Search...'),
      ArcaneIconButton(icon: span([text('🔔')]), onPressed: showNotifications),
      ArcaneDropdownMenu(
        trigger: ArcaneAvatar(imageUrl: user.avatar),
        items: [
          ArcaneDropdownItem(label: 'Profile', href: '/profile'),
          ArcaneDropdownItem(label: 'Settings', href: '/settings'),
          ArcaneDivider(),
          ArcaneDropdownItem(label: 'Sign Out', onPressed: signOut),
        ],
      ),
    ],
  ),
  sidebar: ArcaneSidebar(
    header: ArcaneDiv(
      styles: const ArcaneStyleData(padding: PaddingPreset.md),
      children: [ArcaneSelect(options: workspaces, value: currentWorkspace)],
    ),
    children: [
      ArcaneSidebarGroup(
        title: 'Overview',
        children: [
          ArcaneSidebarItem(icon: span([text('📊')]), label: 'Dashboard', href: '/'),
          ArcaneSidebarItem(icon: span([text('📈')]), label: 'Analytics', href: '/analytics'),
        ],
      ),
      ArcaneSidebarGroup(
        title: 'Management',
        children: [
          ArcaneSidebarItem(icon: span([text('👥')]), label: 'Users', href: '/users'),
          ArcaneSidebarItem(icon: span([text('📁')]), label: 'Projects', href: '/projects'),
        ],
      ),
    ],
    footer: ArcaneSidebarItem(icon: span([text('⚙️')]), label: 'Settings', href: '/settings'),
  ),
  body: ArcanePageBody(
    header: ArcaneRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ArcaneHeadline(text: 'Dashboard'),
        ArcaneButton.primary(
          leadingIcon: span([text('➕')]),
          label: 'Add Widget',
          onPressed: addWidget,
        ),
      ],
    ),
    child: DashboardGrid(),
  ),
)
```

### Mobile App Screen

```dart
ArcaneScreen(
  body: ArcaneColumn(
    children: [
      // Custom mobile header
      ArcaneDiv(
        styles: const ArcaneStyleData(
          padding: PaddingPreset.md,
          raw: {'padding-top': 'env(safe-area-inset-top)'},
        ),
        children: [
          ArcaneRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ArcaneIconButton(icon: span([text('←')]), onPressed: goBack),
              ArcaneText('Profile'),
              ArcaneIconButton(icon: span([text('⚙️')]), onPressed: openSettings),
            ],
          ),
        ],
      ),
      // Main content
      ArcaneExpanded(
        child: ArcaneColumn(
          children: [
            ProfileHeader(),
            ProfileContent(),
          ],
        ),
      ),
    ],
  ),
  bottomNavigation: ArcaneBottomNav(
    items: [
      ArcaneBottomNavItem(icon: span([text('🏠')]), label: 'Home', href: '/'),
      ArcaneBottomNavItem(icon: span([text('🔍')]), label: 'Search', href: '/search'),
      ArcaneBottomNavItem(icon: span([text('➕')]), label: 'Create', href: '/create'),
      ArcaneBottomNavItem(icon: span([text('💬')]), label: 'Messages', href: '/messages'),
      ArcaneBottomNavItem(icon: span([text('👤')]), label: 'Profile', href: '/profile', isActive: true),
    ],
  ),
)
```

### Documentation Screen

```dart
ArcaneScreen(
  header: ArcaneHeader(
    logo: ArcaneRow(
      gap: Gap.sm,
      children: [
        ArcaneText('Docs'),
        ArcaneBadge(label: 'v2.0'),
      ],
    ),
    navItems: [
      ArcaneNavItem(label: 'Guide', href: '/docs'),
      ArcaneNavItem(label: 'API', href: '/api'),
      ArcaneNavItem(label: 'Examples', href: '/examples'),
    ],
    actions: [
      ArcaneSearch(placeholder: 'Search docs...'),
      ArcaneThemeToggle(),
    ],
  ),
  sidebar: DocsSidebar(currentPath: currentPath),
  body: ArcaneRow(
    children: [
      // Main content
      ArcaneExpanded(
        child: ArcanePageBody(
          maxWidth: '800px',
          child: DocContent(),
        ),
      ),
      // Table of contents
      ArcaneDiv(
        styles: const ArcaneStyleData(
          widthCustom: '240px',
          padding: PaddingPreset.lg,
          raw: {
            '@media (max-width: 1024px)': {'display': 'none'},
          },
        ),
        children: [TableOfContents()],
      ),
    ],
  ),
)
```

### Auth Screen

```dart
ArcaneScreen(
  backgroundColor: BackgroundColor.secondary,
  body: ArcaneCenter(
    child: ArcaneCard(
      styles: const ArcaneStyleData(
        maxWidthCustom: '400px',
        widthCustom: '100%',
      ),
      child: ArcaneColumn(
        gap: Gap.lg,
        children: [
          ArcaneCenter(
            child: ArcaneGradientText(text: 'Welcome Back'),
          ),
          LoginForm(),
          ArcaneDivider(label: 'or'),
          SocialLoginButtons(),
        ],
      ),
    ),
  ),
)
```

## Related Components

- [ArcaneHeader](/arcane_jaspr/docs/navigation/arcane-header) - Application header
- [ArcaneSidebar](/arcane_jaspr/docs/navigation/arcane-sidebar) - Side navigation
- [ArcaneBottomNav](/arcane_jaspr/docs/navigation/arcane-bottom-nav) - Bottom navigation
- [ArcanePageBody](/arcane_jaspr/docs/layout/arcane-page-body) - Page content wrapper
