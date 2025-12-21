---
title: ArcaneMobileMenu
description: Mobile navigation overlay menu
layout: docs
component: mobile-menu
---

# ArcaneMobileMenu

A full-screen mobile navigation menu that slides in from the side.

## Basic Usage

```dart
ArcaneMobileMenu(
  trigger: ArcaneHamburgerButton(),
  items: [
    ArcaneMobileNavItem(label: 'Home', href: '/'),
    ArcaneMobileNavItem(label: 'About', href: '/about'),
    ArcaneMobileNavItem(label: 'Services', href: '/services'),
    ArcaneMobileNavItem(label: 'Contact', href: '/contact'),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `trigger` | `Component` | required | Trigger element |
| `items` | `List<Component>` | required | Menu items |
| `header` | `Component?` | `null` | Menu header |
| `footer` | `Component?` | `null` | Menu footer |
| `position` | `MobileMenuPosition` | `left` | Slide direction |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## ArcaneMobileNavItem Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `label` | `String` | required | Item text |
| `href` | `String?` | `null` | Navigation URL |
| `icon` | `Component?` | `null` | Leading icon |
| `onPressed` | `VoidCallback?` | `null` | Click handler |
| `children` | `List<ArcaneMobileNavItem>?` | `null` | Nested items |

## With Icons

```dart
ArcaneMobileMenu(
  trigger: ArcaneHamburgerButton(),
  items: [
    ArcaneMobileNavItem(
      icon: span([text('🏠')]),
      label: 'Home',
      href: '/',
    ),
    ArcaneMobileNavItem(
      icon: span([text('📦')]),
      label: 'Products',
      href: '/products',
    ),
    ArcaneMobileNavItem(
      icon: span([text('💼')]),
      label: 'Services',
      href: '/services',
    ),
    ArcaneMobileNavItem(
      icon: span([text('📧')]),
      label: 'Contact',
      href: '/contact',
    ),
  ],
)
```

## Position

```dart
// Left (default)
ArcaneMobileMenu(
  position: MobileMenuPosition.left,
  trigger: ArcaneHamburgerButton(),
  items: items,
)

// Right
ArcaneMobileMenu(
  position: MobileMenuPosition.right,
  trigger: ArcaneHamburgerButton(),
  items: items,
)

// Top (slide down)
ArcaneMobileMenu(
  position: MobileMenuPosition.top,
  trigger: ArcaneHamburgerButton(),
  items: items,
)
```

## With Header and Footer

```dart
ArcaneMobileMenu(
  trigger: ArcaneHamburgerButton(),
  header: ArcaneDiv(
    styles: const ArcaneStyleData(
      padding: PaddingPreset.lg,
      borderBottom: BorderPreset.subtle,
    ),
    children: [
      ArcaneGradientText(text: 'Arcane'),
    ],
  ),
  items: [
    ArcaneMobileNavItem(label: 'Home', href: '/'),
    ArcaneMobileNavItem(label: 'Features', href: '/features'),
    ArcaneMobileNavItem(label: 'Pricing', href: '/pricing'),
    ArcaneMobileNavItem(label: 'Docs', href: '/docs'),
  ],
  footer: ArcaneDiv(
    styles: const ArcaneStyleData(
      padding: PaddingPreset.lg,
      borderTop: BorderPreset.subtle,
    ),
    children: [
      ArcaneColumn(
        gap: Gap.md,
        children: [
          ArcaneButton.primary(
            label: 'Get Started',
            onPressed: getStarted,
            isFullWidth: true,
          ),
          ArcaneButton.secondary(
            label: 'Sign In',
            onPressed: signIn,
            isFullWidth: true,
          ),
        ],
      ),
    ],
  ),
)
```

## Nested Navigation

```dart
ArcaneMobileMenu(
  trigger: ArcaneHamburgerButton(),
  items: [
    ArcaneMobileNavItem(label: 'Home', href: '/'),
    ArcaneMobileNavItem(
      label: 'Products',
      children: [
        ArcaneMobileNavItem(label: 'All Products', href: '/products'),
        ArcaneMobileNavItem(label: 'Featured', href: '/products/featured'),
        ArcaneMobileNavItem(label: 'New Arrivals', href: '/products/new'),
        ArcaneMobileNavItem(label: 'Sale', href: '/products/sale'),
      ],
    ),
    ArcaneMobileNavItem(
      label: 'Resources',
      children: [
        ArcaneMobileNavItem(label: 'Documentation', href: '/docs'),
        ArcaneMobileNavItem(label: 'Blog', href: '/blog'),
        ArcaneMobileNavItem(label: 'Support', href: '/support'),
      ],
    ),
    ArcaneMobileNavItem(label: 'Contact', href: '/contact'),
  ],
)
```

## Examples

### Marketing Site Mobile Nav

```dart
ArcaneMobileMenu(
  trigger: ArcaneDiv(
    styles: const ArcaneStyleData(
      display: Display.flex,
      raw: {
        '@media (min-width: 768px)': {
          'display': 'none',
        },
      },
    ),
    children: [ArcaneHamburgerButton()],
  ),
  header: ArcaneDiv(
    styles: const ArcaneStyleData(padding: PaddingPreset.lg),
    children: [
      ArcaneRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ArcaneGradientText(text: 'Arcane'),
          ArcaneCloseButton(onPressed: closeMenu),
        ],
      ),
    ],
  ),
  items: [
    ArcaneMobileNavItem(
      icon: span([text('✨')]),
      label: 'Features',
      href: '/features',
    ),
    ArcaneMobileNavItem(
      icon: span([text('💰')]),
      label: 'Pricing',
      href: '/pricing',
    ),
    ArcaneMobileNavItem(
      icon: span([text('📚')]),
      label: 'Documentation',
      href: '/docs',
    ),
    ArcaneMobileNavItem(
      icon: span([text('📝')]),
      label: 'Blog',
      href: '/blog',
    ),
  ],
  footer: ArcaneDiv(
    styles: const ArcaneStyleData(padding: PaddingPreset.lg),
    children: [
      ArcaneColumn(
        gap: Gap.md,
        children: [
          ArcaneButton.primary(
            label: 'Start Free Trial',
            onPressed: startTrial,
            isFullWidth: true,
          ),
          ArcaneRow(
            mainAxisAlignment: MainAxisAlignment.center,
            gap: Gap.sm,
            children: [
              ArcaneText('Already have an account?'),
              ArcaneLink(href: '/login', child: ArcaneText('Sign in')),
            ],
          ),
        ],
      ),
    ],
  ),
)
```

### E-Commerce Mobile Nav

```dart
ArcaneMobileMenu(
  trigger: ArcaneHamburgerButton(),
  position: MobileMenuPosition.right,
  header: ArcaneDiv(
    styles: const ArcaneStyleData(padding: PaddingPreset.md),
    children: [
      ArcaneRow(
        gap: Gap.md,
        children: [
          ArcaneAvatar(imageUrl: user?.avatar),
          if (user != null)
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
            )
          else
            ArcaneButton.secondary(
              label: 'Sign In',
              onPressed: signIn,
            ),
        ],
      ),
    ],
  ),
  items: [
    ArcaneMobileNavItem(
      icon: span([text('🏠')]),
      label: 'Home',
      href: '/',
    ),
    ArcaneMobileNavItem(
      icon: span([text('👕')]),
      label: 'Shop',
      children: [
        ArcaneMobileNavItem(label: 'New Arrivals', href: '/new'),
        ArcaneMobileNavItem(label: 'Best Sellers', href: '/best-sellers'),
        ArcaneMobileNavItem(label: 'Sale', href: '/sale'),
      ],
    ),
    ArcaneMobileNavItem(
      icon: span([text('❤️')]),
      label: 'Wishlist',
      href: '/wishlist',
    ),
    ArcaneMobileNavItem(
      icon: span([text('📦')]),
      label: 'Orders',
      href: '/orders',
    ),
  ],
  footer: ArcaneDiv(
    styles: const ArcaneStyleData(padding: PaddingPreset.md),
    children: [
      ArcaneRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ArcaneThemeToggle(),
          ArcaneIconButton(
            icon: span([text('⚙️')]),
            onPressed: openSettings,
          ),
        ],
      ),
    ],
  ),
)
```

### Dashboard Mobile Nav

```dart
ArcaneMobileMenu(
  trigger: ArcaneHamburgerButton(),
  items: [
    ArcaneMobileNavItem(
      icon: span([text('📊')]),
      label: 'Dashboard',
      href: '/dashboard',
    ),
    ArcaneMobileNavItem(
      icon: span([text('📈')]),
      label: 'Analytics',
      href: '/analytics',
    ),
    ArcaneMobileNavItem(
      icon: span([text('👥')]),
      label: 'Users',
      href: '/users',
    ),
    ArcaneMobileNavItem(
      icon: span([text('⚙️')]),
      label: 'Settings',
      children: [
        ArcaneMobileNavItem(label: 'General', href: '/settings'),
        ArcaneMobileNavItem(label: 'Security', href: '/settings/security'),
        ArcaneMobileNavItem(label: 'Billing', href: '/settings/billing'),
      ],
    ),
  ],
  footer: ArcaneDiv(
    styles: const ArcaneStyleData(padding: PaddingPreset.md),
    children: [
      ArcaneButton.ghost(
        leadingIcon: span([text('🚪')]),
        label: 'Sign Out',
        onPressed: signOut,
        isFullWidth: true,
      ),
    ],
  ),
)
```

## Related Components

- [ArcaneHamburgerButton](/arcane_jaspr/docs/inputs/arcane-hamburger-button) - Menu trigger button
- [ArcaneHeader](/arcane_jaspr/docs/navigation/arcane-header) - Application header
- [ArcaneBottomNav](/arcane_jaspr/docs/navigation/arcane-bottom-nav) - Bottom navigation
