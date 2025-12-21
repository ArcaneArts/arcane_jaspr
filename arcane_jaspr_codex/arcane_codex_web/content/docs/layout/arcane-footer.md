---
title: ArcaneFooter
description: Website footer component with common layouts
layout: docs
component: footer
---

# ArcaneFooter

A pre-styled footer component for website pages with support for navigation links, social icons, and copyright text.

## Basic Usage

```dart
ArcaneFooter(
  copyright: '© 2024 Company Name',
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `copyright` | `String?` | `null` | Copyright text |
| `links` | `List<FooterLink>?` | `null` | Navigation links |
| `columns` | `List<FooterColumn>?` | `null` | Multi-column layout |
| `socialLinks` | `List<SocialLink>?` | `null` | Social media links |
| `children` | `List<Component>?` | `null` | Custom content |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Simple Footer

```dart
ArcaneFooter(
  copyright: '© 2024 Acme Inc. All rights reserved.',
  links: [
    FooterLink(label: 'Privacy', href: '/privacy'),
    FooterLink(label: 'Terms', href: '/terms'),
    FooterLink(label: 'Contact', href: '/contact'),
  ],
)
```

## With Social Links

```dart
ArcaneFooter(
  copyright: '© 2024 Company',
  links: [
    FooterLink(label: 'About', href: '/about'),
    FooterLink(label: 'Blog', href: '/blog'),
  ],
  socialLinks: [
    SocialLink(platform: SocialPlatform.twitter, url: 'https://twitter.com/...'),
    SocialLink(platform: SocialPlatform.github, url: 'https://github.com/...'),
    SocialLink(platform: SocialPlatform.linkedin, url: 'https://linkedin.com/...'),
  ],
)
```

## Multi-Column Footer

```dart
ArcaneFooter(
  columns: [
    FooterColumn(
      title: 'Product',
      links: [
        FooterLink(label: 'Features', href: '/features'),
        FooterLink(label: 'Pricing', href: '/pricing'),
        FooterLink(label: 'Integrations', href: '/integrations'),
      ],
    ),
    FooterColumn(
      title: 'Company',
      links: [
        FooterLink(label: 'About', href: '/about'),
        FooterLink(label: 'Blog', href: '/blog'),
        FooterLink(label: 'Careers', href: '/careers'),
      ],
    ),
    FooterColumn(
      title: 'Resources',
      links: [
        FooterLink(label: 'Documentation', href: '/docs'),
        FooterLink(label: 'Help Center', href: '/help'),
        FooterLink(label: 'Community', href: '/community'),
      ],
    ),
    FooterColumn(
      title: 'Legal',
      links: [
        FooterLink(label: 'Privacy', href: '/privacy'),
        FooterLink(label: 'Terms', href: '/terms'),
        FooterLink(label: 'Cookies', href: '/cookies'),
      ],
    ),
  ],
  copyright: '© 2024 Company. All rights reserved.',
  socialLinks: [
    SocialLink(platform: SocialPlatform.twitter, url: '...'),
    SocialLink(platform: SocialPlatform.github, url: '...'),
  ],
)
```

## Examples

### Custom Footer

```dart
ArcaneFooter(
  children: [
    ArcaneContainer(
      children: [
        ArcaneRow(
          mainAxisAlignment: JustifyContent.spaceBetween,
          crossAxisAlignment: AlignItems.center,
          children: [
            ArcaneColumn(
              crossAxisAlignment: AlignItems.start,
              gap: Gap.sm,
              children: [
                ArcaneText('MyApp'),
                ArcaneText('Building the future'),
              ],
            ),
            ArcaneRow(
              gap: Gap.lg,
              children: [
                ArcaneNavLink(label: 'Home', href: '/'),
                ArcaneNavLink(label: 'Features', href: '/features'),
                ArcaneNavLink(label: 'Pricing', href: '/pricing'),
                ArcaneNavLink(label: 'Contact', href: '/contact'),
              ],
            ),
            ArcaneThemeToggle(
              isDark: isDark,
              onToggle: toggleTheme,
            ),
          ],
        ),
        ArcaneGutter(size: GutterSize.lg),
        ArcaneDivider(),
        ArcaneGutter(size: GutterSize.md),
        ArcaneRow(
          mainAxisAlignment: JustifyContent.spaceBetween,
          children: [
            ArcaneText('© 2024 MyApp'),
            ArcaneRow(
              gap: Gap.md,
              children: [
                ArcaneIconButton(icon: span([text('𝕏')]), onPressed: () {}),
                ArcaneIconButton(icon: span([text('🐙')]), onPressed: () {}),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
)
```

### Newsletter Footer

```dart
ArcaneFooter(
  children: [
    ArcaneContainer(
      children: [
        ArcaneRow(
          gap: Gap.xl2,
          crossAxisAlignment: AlignItems.start,
          children: [
            ArcaneExpanded(
              flex: 2,
              child: ArcaneColumn(
                crossAxisAlignment: AlignItems.start,
                gap: Gap.md,
                children: [
                  ArcaneHeading(text: 'Stay Updated'),
                  ArcaneText('Get the latest news and updates.'),
                  ArcaneRow(
                    gap: Gap.sm,
                    children: [
                      ArcaneExpanded(
                        child: ArcaneTextInput(placeholder: 'Enter email'),
                      ),
                      ArcaneButton.primary(label: 'Subscribe', onPressed: () {}),
                    ],
                  ),
                ],
              ),
            ),
            ArcaneExpanded(
              child: ArcaneColumn(
                crossAxisAlignment: AlignItems.start,
                gap: Gap.sm,
                children: [
                  ArcaneText('Quick Links'),
                  ArcaneNavLink(label: 'Documentation', href: '/docs'),
                  ArcaneNavLink(label: 'Support', href: '/support'),
                  ArcaneNavLink(label: 'Status', href: '/status'),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  ],
  copyright: '© 2024 Company',
)
```

### Minimal Footer

```dart
ArcaneFooter(
  styles: const ArcaneStyleData(
    padding: PaddingPreset.md,
    borderTop: Border.subtle,
  ),
  children: [
    ArcaneContainer(
      children: [
        ArcaneRow(
          mainAxisAlignment: JustifyContent.center,
          gap: Gap.lg,
          children: [
            ArcaneText('© 2024'),
            ArcaneNavLink(label: 'Privacy', href: '/privacy'),
            ArcaneNavLink(label: 'Terms', href: '/terms'),
          ],
        ),
      ],
    ),
  ],
)
```

## Related Components

- [ArcaneHeader](/arcane_jaspr/docs/navigation/arcane-header) - Page header
- [ArcaneSection](/arcane_jaspr/docs/layout/arcane-section) - Section wrapper
- [ArcaneSocialLinks](/arcane_jaspr/docs/view/arcane-social-links) - Social icons
