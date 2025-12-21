---
title: ArcaneHeader
description: Application header with navigation and branding
layout: docs
component: header
---

# ArcaneHeader

A responsive application header component with logo, navigation links, and action buttons.

## Basic Usage

```dart
ArcaneHeader(
  logo: ArcaneText('MyApp'),
  navItems: [
    ArcaneNavItem(label: 'Home', href: '/'),
    ArcaneNavItem(label: 'About', href: '/about'),
    ArcaneNavItem(label: 'Contact', href: '/contact'),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `logo` | `Component` | required | Logo/brand component |
| `navItems` | `List<ArcaneNavItem>` | `[]` | Navigation items |
| `actions` | `List<Component>` | `[]` | Action buttons |
| `variant` | `HeaderVariant` | `default_` | Visual style |
| `sticky` | `bool` | `false` | Stick to top |
| `transparent` | `bool` | `false` | Transparent background |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Variants

```dart
// Default header
ArcaneHeader(
  variant: HeaderVariant.default_,
  logo: Logo(),
  navItems: navItems,
)

// Minimal header
ArcaneHeader(
  variant: HeaderVariant.minimal,
  logo: Logo(),
  navItems: navItems,
)

// Centered logo
ArcaneHeader(
  variant: HeaderVariant.centered,
  logo: Logo(),
  navItems: navItems,
)
```

## Sticky Header

```dart
ArcaneHeader(
  sticky: true,
  logo: ArcaneText('MyApp'),
  navItems: [
    ArcaneNavItem(label: 'Home', href: '/'),
    ArcaneNavItem(label: 'Features', href: '/features'),
    ArcaneNavItem(label: 'Pricing', href: '/pricing'),
  ],
)
```

## Transparent Header

```dart
ArcaneHeader(
  transparent: true,
  logo: ArcaneText('MyApp'),
  navItems: navItems,
  styles: const ArcaneStyleData(
    position: Position.absolute,
    top: '0',
    left: '0',
    right: '0',
  ),
)
```

## With Actions

```dart
ArcaneHeader(
  logo: ArcaneText('MyApp'),
  navItems: [
    ArcaneNavItem(label: 'Features', href: '/features'),
    ArcaneNavItem(label: 'Pricing', href: '/pricing'),
    ArcaneNavItem(label: 'Docs', href: '/docs'),
  ],
  actions: [
    ArcaneButton.secondary(
      label: 'Sign In',
      onPressed: signIn,
    ),
    ArcaneButton.primary(
      label: 'Get Started',
      onPressed: getStarted,
    ),
  ],
)
```

## Examples

### Marketing Site Header

```dart
ArcaneHeader(
  sticky: true,
  logo: ArcaneRow(
    gap: Gap.sm,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ArcaneGradientText(text: 'Arcane'),
    ],
  ),
  navItems: [
    ArcaneNavItem(label: 'Features', href: '/features'),
    ArcaneNavItem(label: 'Pricing', href: '/pricing'),
    ArcaneNavItem(label: 'Docs', href: '/docs'),
    ArcaneNavItem(label: 'Blog', href: '/blog'),
  ],
  actions: [
    ArcaneThemeToggle(),
    ArcaneButton.secondary(label: 'Sign In', onPressed: signIn),
    ArcaneButton.primary(label: 'Get Started', onPressed: start),
  ],
)
```

### App Header with User Menu

```dart
ArcaneHeader(
  logo: ArcaneText('Dashboard'),
  navItems: [
    ArcaneNavItem(label: 'Overview', href: '/dashboard'),
    ArcaneNavItem(label: 'Analytics', href: '/analytics'),
    ArcaneNavItem(label: 'Settings', href: '/settings'),
  ],
  actions: [
    ArcaneIconButton(
      icon: span([text('🔔')]),
      onPressed: showNotifications,
    ),
    ArcaneDropdownMenu(
      trigger: ArcaneAvatar(imageUrl: user.avatar),
      items: [
        ArcaneDropdownItem(label: 'Profile', onPressed: goToProfile),
        ArcaneDropdownItem(label: 'Settings', onPressed: goToSettings),
        ArcaneDivider(),
        ArcaneDropdownItem(label: 'Sign Out', onPressed: signOut),
      ],
    ),
  ],
)
```

### Documentation Header

```dart
ArcaneHeader(
  logo: ArcaneRow(
    gap: Gap.sm,
    children: [
      ArcaneText('MyLib'),
      ArcaneBadge(label: 'v2.0'),
    ],
  ),
  navItems: [
    ArcaneNavItem(label: 'Docs', href: '/docs', isActive: true),
    ArcaneNavItem(label: 'API', href: '/api'),
    ArcaneNavItem(label: 'Examples', href: '/examples'),
  ],
  actions: [
    ArcaneSearch(placeholder: 'Search docs...'),
    ArcaneLink(href: 'https://github.com/...', child: span([text('GitHub')])),
  ],
)
```

### Mobile-Responsive Header

```dart
ArcaneHeader(
  logo: ArcaneText('MyApp'),
  navItems: navItems,
  actions: [
    // Shown on desktop
    ArcaneDiv(
      styles: const ArcaneStyleData(
        display: Display.none,
        raw: {'@media (min-width: 768px)': {'display': 'flex'}},
      ),
      children: [
        ArcaneButton.primary(label: 'Sign In', onPressed: signIn),
      ],
    ),
    // Mobile menu trigger
    ArcaneMobileMenu(
      trigger: ArcaneHamburgerButton(),
      items: navItems,
    ),
  ],
)
```

## Related Components

- [ArcaneNavItem](/arcane_jaspr/docs/navigation/arcane-nav-item) - Navigation link item
- [ArcaneSidebar](/arcane_jaspr/docs/navigation/arcane-sidebar) - Side navigation
- [ArcaneMobileMenu](/arcane_jaspr/docs/navigation/arcane-mobile-menu) - Mobile navigation
