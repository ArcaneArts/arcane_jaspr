---
title: ArcaneMegaMenu
description: Large navigation menu with sections and rich content
layout: docs
---

# ArcaneMegaMenu

A large dropdown navigation menu with support for multiple sections, icons, and rich content.

## Basic Usage

```dart
ArcaneMegaMenu(
  trigger: ArcaneButton.ghost(label: 'Products'),
  sections: [
    ArcaneMegaMenuSection(
      title: 'Categories',
      items: [
        ArcaneMegaMenuItem(label: 'Electronics', href: '/electronics'),
        ArcaneMegaMenuItem(label: 'Clothing', href: '/clothing'),
        ArcaneMegaMenuItem(label: 'Home & Garden', href: '/home'),
      ],
    ),
    ArcaneMegaMenuSection(
      title: 'Featured',
      items: [
        ArcaneMegaMenuItem(label: 'New Arrivals', href: '/new'),
        ArcaneMegaMenuItem(label: 'Best Sellers', href: '/best'),
        ArcaneMegaMenuItem(label: 'Sale', href: '/sale'),
      ],
    ),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `trigger` | `Component` | required | Trigger element |
| `sections` | `List<ArcaneMegaMenuSection>` | required | Menu sections |
| `footer` | `Component?` | `null` | Menu footer |
| `width` | `String?` | `null` | Custom width |
| `columns` | `int` | `3` | Number of columns |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## ArcaneMegaMenuSection Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `title` | `String` | required | Section title |
| `items` | `List<ArcaneMegaMenuItem>` | required | Section items |
| `icon` | `Component?` | `null` | Section icon |

## ArcaneMegaMenuItem Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `label` | `String` | required | Item label |
| `href` | `String?` | `null` | Navigation URL |
| `description` | `String?` | `null` | Item description |
| `icon` | `Component?` | `null` | Item icon |
| `badge` | `Component?` | `null` | Item badge |
| `onPressed` | `VoidCallback?` | `null` | Click handler |

## With Icons and Descriptions

```dart
ArcaneMegaMenu(
  trigger: ArcaneButton.ghost(label: 'Solutions'),
  sections: [
    ArcaneMegaMenuSection(
      title: 'For Teams',
      items: [
        ArcaneMegaMenuItem(
          icon: span([text('👥')]),
          label: 'Collaboration',
          description: 'Work together seamlessly',
          href: '/collaboration',
        ),
        ArcaneMegaMenuItem(
          icon: span([text('📊')]),
          label: 'Analytics',
          description: 'Data-driven insights',
          href: '/analytics',
        ),
        ArcaneMegaMenuItem(
          icon: span([text('🔒')]),
          label: 'Security',
          description: 'Enterprise-grade protection',
          href: '/security',
        ),
      ],
    ),
    ArcaneMegaMenuSection(
      title: 'For Developers',
      items: [
        ArcaneMegaMenuItem(
          icon: span([text('⚡')]),
          label: 'API',
          description: 'RESTful and GraphQL APIs',
          href: '/api',
        ),
        ArcaneMegaMenuItem(
          icon: span([text('📚')]),
          label: 'Documentation',
          description: 'Comprehensive guides',
          href: '/docs',
        ),
        ArcaneMegaMenuItem(
          icon: span([text('🛠️')]),
          label: 'SDKs',
          description: 'Client libraries',
          href: '/sdks',
        ),
      ],
    ),
  ],
)
```

## With Footer

```dart
ArcaneMegaMenu(
  trigger: ArcaneButton.ghost(label: 'Resources'),
  sections: [
    ArcaneMegaMenuSection(
      title: 'Learn',
      items: [
        ArcaneMegaMenuItem(label: 'Documentation', href: '/docs'),
        ArcaneMegaMenuItem(label: 'Tutorials', href: '/tutorials'),
        ArcaneMegaMenuItem(label: 'Examples', href: '/examples'),
      ],
    ),
    ArcaneMegaMenuSection(
      title: 'Community',
      items: [
        ArcaneMegaMenuItem(label: 'Discord', href: '/discord'),
        ArcaneMegaMenuItem(label: 'GitHub', href: '/github'),
        ArcaneMegaMenuItem(label: 'Twitter', href: '/twitter'),
      ],
    ),
  ],
  footer: ArcaneDiv(
    styles: const ArcaneStyleData(
      padding: PaddingPreset.md,
      backgroundColor: BackgroundColor.secondary,
      borderTop: BorderPreset.subtle,
    ),
    children: [
      ArcaneRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ArcaneText('Need help?'),
          ArcaneButton.link(label: 'Contact Support', href: '/support'),
        ],
      ),
    ],
  ),
)
```

## With Badges

```dart
ArcaneMegaMenu(
  trigger: ArcaneButton.ghost(label: 'Products'),
  sections: [
    ArcaneMegaMenuSection(
      title: 'Platform',
      items: [
        ArcaneMegaMenuItem(
          label: 'Core',
          href: '/core',
        ),
        ArcaneMegaMenuItem(
          label: 'Enterprise',
          href: '/enterprise',
          badge: ArcaneBadge(label: 'New', variant: BadgeVariant.primary),
        ),
        ArcaneMegaMenuItem(
          label: 'Cloud',
          href: '/cloud',
          badge: ArcaneBadge(label: 'Beta', variant: BadgeVariant.warning),
        ),
      ],
    ),
  ],
)
```

## Examples

### SaaS Navigation

```dart
ArcaneHeader(
  logo: ArcaneText('SaaSApp'),
  navItems: [
    ArcaneMegaMenu(
      trigger: ArcaneNavItem(label: 'Product'),
      columns: 3,
      sections: [
        ArcaneMegaMenuSection(
          title: 'Features',
          items: [
            ArcaneMegaMenuItem(
              icon: span([text('📊')]),
              label: 'Analytics',
              description: 'Track your metrics',
              href: '/features/analytics',
            ),
            ArcaneMegaMenuItem(
              icon: span([text('🤖')]),
              label: 'Automation',
              description: 'Automate workflows',
              href: '/features/automation',
            ),
            ArcaneMegaMenuItem(
              icon: span([text('🔗')]),
              label: 'Integrations',
              description: 'Connect your tools',
              href: '/features/integrations',
            ),
          ],
        ),
        ArcaneMegaMenuSection(
          title: 'Solutions',
          items: [
            ArcaneMegaMenuItem(
              icon: span([text('🏢')]),
              label: 'Enterprise',
              description: 'For large teams',
              href: '/enterprise',
            ),
            ArcaneMegaMenuItem(
              icon: span([text('🚀')]),
              label: 'Startups',
              description: 'For growing companies',
              href: '/startups',
            ),
            ArcaneMegaMenuItem(
              icon: span([text('👤')]),
              label: 'Freelancers',
              description: 'For individuals',
              href: '/freelancers',
            ),
          ],
        ),
        ArcaneMegaMenuSection(
          title: 'Resources',
          items: [
            ArcaneMegaMenuItem(
              icon: span([text('📚')]),
              label: 'Documentation',
              href: '/docs',
            ),
            ArcaneMegaMenuItem(
              icon: span([text('🎓')]),
              label: 'Tutorials',
              href: '/tutorials',
            ),
            ArcaneMegaMenuItem(
              icon: span([text('📹')]),
              label: 'Webinars',
              href: '/webinars',
            ),
          ],
        ),
      ],
      footer: ArcaneDiv(
        styles: const ArcaneStyleData(
          padding: PaddingPreset.md,
          backgroundColor: BackgroundColor.secondary,
        ),
        children: [
          ArcaneRow(
            gap: Gap.lg,
            children: [
              ArcaneFeatureCard(
                icon: span([text('🆕')]),
                title: 'What\'s New',
                description: 'See our latest features',
                href: '/changelog',
              ),
              ArcaneFeatureCard(
                icon: span([text('📅')]),
                title: 'Book a Demo',
                description: 'See the platform in action',
                href: '/demo',
              ),
            ],
          ),
        ],
      ),
    ),
    ArcaneNavItem(label: 'Pricing', href: '/pricing'),
    ArcaneNavItem(label: 'Customers', href: '/customers'),
    ArcaneNavItem(label: 'Company', href: '/company'),
  ],
)
```

### E-Commerce Categories

```dart
ArcaneMegaMenu(
  trigger: ArcaneNavItem(label: 'Shop'),
  columns: 4,
  sections: [
    ArcaneMegaMenuSection(
      title: 'Women',
      icon: span([text('👗')]),
      items: [
        ArcaneMegaMenuItem(label: 'Dresses', href: '/women/dresses'),
        ArcaneMegaMenuItem(label: 'Tops', href: '/women/tops'),
        ArcaneMegaMenuItem(label: 'Pants', href: '/women/pants'),
        ArcaneMegaMenuItem(label: 'Accessories', href: '/women/accessories'),
      ],
    ),
    ArcaneMegaMenuSection(
      title: 'Men',
      icon: span([text('👔')]),
      items: [
        ArcaneMegaMenuItem(label: 'Shirts', href: '/men/shirts'),
        ArcaneMegaMenuItem(label: 'Pants', href: '/men/pants'),
        ArcaneMegaMenuItem(label: 'Suits', href: '/men/suits'),
        ArcaneMegaMenuItem(label: 'Accessories', href: '/men/accessories'),
      ],
    ),
    ArcaneMegaMenuSection(
      title: 'Kids',
      icon: span([text('👶')]),
      items: [
        ArcaneMegaMenuItem(label: 'Girls', href: '/kids/girls'),
        ArcaneMegaMenuItem(label: 'Boys', href: '/kids/boys'),
        ArcaneMegaMenuItem(label: 'Baby', href: '/kids/baby'),
        ArcaneMegaMenuItem(label: 'Toys', href: '/kids/toys'),
      ],
    ),
    ArcaneMegaMenuSection(
      title: 'Featured',
      icon: span([text('⭐')]),
      items: [
        ArcaneMegaMenuItem(
          label: 'New Arrivals',
          href: '/new',
          badge: ArcaneBadge(label: 'New'),
        ),
        ArcaneMegaMenuItem(
          label: 'Best Sellers',
          href: '/best-sellers',
        ),
        ArcaneMegaMenuItem(
          label: 'Sale',
          href: '/sale',
          badge: ArcaneBadge(label: 'Up to 50% off', variant: BadgeVariant.error),
        ),
      ],
    ),
  ],
)
```

### Developer Docs Navigation

```dart
ArcaneMegaMenu(
  trigger: ArcaneNavItem(label: 'Developers'),
  sections: [
    ArcaneMegaMenuSection(
      title: 'Get Started',
      items: [
        ArcaneMegaMenuItem(
          icon: span([text('📖')]),
          label: 'Introduction',
          description: 'Learn the basics',
          href: '/docs/intro',
        ),
        ArcaneMegaMenuItem(
          icon: span([text('🚀')]),
          label: 'Quick Start',
          description: '5-minute setup guide',
          href: '/docs/quickstart',
        ),
        ArcaneMegaMenuItem(
          icon: span([text('📝')]),
          label: 'Tutorials',
          description: 'Step-by-step guides',
          href: '/docs/tutorials',
        ),
      ],
    ),
    ArcaneMegaMenuSection(
      title: 'API Reference',
      items: [
        ArcaneMegaMenuItem(
          icon: span([text('🔗')]),
          label: 'REST API',
          href: '/api/rest',
        ),
        ArcaneMegaMenuItem(
          icon: span([text('📊')]),
          label: 'GraphQL',
          href: '/api/graphql',
        ),
        ArcaneMegaMenuItem(
          icon: span([text('🔌')]),
          label: 'Webhooks',
          href: '/api/webhooks',
        ),
      ],
    ),
    ArcaneMegaMenuSection(
      title: 'SDKs',
      items: [
        ArcaneMegaMenuItem(label: 'JavaScript', href: '/sdk/js'),
        ArcaneMegaMenuItem(label: 'Python', href: '/sdk/python'),
        ArcaneMegaMenuItem(label: 'Go', href: '/sdk/go'),
        ArcaneMegaMenuItem(label: 'Ruby', href: '/sdk/ruby'),
      ],
    ),
  ],
  footer: ArcaneDiv(
    styles: const ArcaneStyleData(padding: PaddingPreset.md),
    children: [
      ArcaneRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ArcaneLink(
            href: '/status',
            child: ArcaneRow(
              gap: Gap.xs,
              children: [
                ArcaneStatusIndicator(status: 'online'),
                ArcaneText('API Status: Operational'),
              ],
            ),
          ),
          ArcaneLink(href: '/changelog', child: ArcaneText('Changelog')),
        ],
      ),
    ],
  ),
)
```

## Related Components

- [ArcaneDropdownMenu](/docs/navigation/arcane-dropdown-menu) - Simple dropdown
- [ArcaneHeader](/docs/navigation/arcane-header) - Application header
- [ArcaneNavItem](/docs/navigation/arcane-nav-item) - Navigation link
