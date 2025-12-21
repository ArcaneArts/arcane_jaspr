---
title: ArcaneAccordion
description: Collapsible content sections
layout: docs
component: accordion
---

# ArcaneAccordion

An accordion component for organizing content into collapsible sections.

## Basic Usage

```dart
ArcaneAccordion(
  items: [
    ArcaneAccordionItem(
      title: 'Section 1',
      content: ArcaneText('Content for section 1'),
    ),
    ArcaneAccordionItem(
      title: 'Section 2',
      content: ArcaneText('Content for section 2'),
    ),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `items` | `List<ArcaneAccordionItem>` | required | Accordion items |
| `allowMultiple` | `bool` | `false` | Allow multiple open |
| `defaultOpenIndex` | `int?` | `null` | Initially open item |
| `variant` | `AccordionVariant` | `default_` | Visual style |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## ArcaneAccordionItem Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `title` | `String` | required | Header text |
| `content` | `Component` | required | Expandable content |
| `icon` | `Component?` | `null` | Leading icon |
| `isDisabled` | `bool` | `false` | Disable item |

## Allow Multiple Open

```dart
ArcaneAccordion(
  allowMultiple: true,
  items: [
    ArcaneAccordionItem(title: 'Item 1', content: Content1()),
    ArcaneAccordionItem(title: 'Item 2', content: Content2()),
    ArcaneAccordionItem(title: 'Item 3', content: Content3()),
  ],
)
```

## Default Open

```dart
ArcaneAccordion(
  defaultOpenIndex: 0,
  items: [
    ArcaneAccordionItem(title: 'Open by default', content: Content()),
    ArcaneAccordionItem(title: 'Closed', content: Content()),
  ],
)
```

## With Icons

```dart
ArcaneAccordion(
  items: [
    ArcaneAccordionItem(
      icon: span([text('📋')]),
      title: 'General',
      content: GeneralContent(),
    ),
    ArcaneAccordionItem(
      icon: span([text('🔒')]),
      title: 'Security',
      content: SecurityContent(),
    ),
    ArcaneAccordionItem(
      icon: span([text('🔔')]),
      title: 'Notifications',
      content: NotificationContent(),
    ),
  ],
)
```

## Examples

### FAQ Section

```dart
ArcaneSection(
  id: 'faq',
  children: [
    ArcaneContainer(
      maxWidth: ContainerMaxWidth.md,
      children: [
        ArcaneHeadline(
          text: 'Frequently Asked Questions',
          styles: const ArcaneStyleData(textAlign: TextAlign.center),
        ),
        ArcaneGutter(size: GutterSize.xl),
        ArcaneAccordion(
          items: [
            ArcaneAccordionItem(
              title: 'What is Arcane?',
              content: ArcaneParagraph(
                text: 'Arcane is a comprehensive UI component library for building web applications with Jaspr.',
              ),
            ),
            ArcaneAccordionItem(
              title: 'How do I get started?',
              content: ArcaneColumn(
                gap: Gap.md,
                children: [
                  ArcaneParagraph(text: 'Getting started is easy:'),
                  ArcaneCodeSnippet(
                    language: 'bash',
                    code: 'dart pub add arcane_jaspr',
                  ),
                ],
              ),
            ),
            ArcaneAccordionItem(
              title: 'Is Arcane free to use?',
              content: ArcaneParagraph(
                text: 'Yes! Arcane is open source and free to use in personal and commercial projects.',
              ),
            ),
          ],
        ),
      ],
    ),
  ],
)
```

### Settings Panel

```dart
ArcaneCard(
  child: ArcaneAccordion(
    allowMultiple: true,
    items: [
      ArcaneAccordionItem(
        icon: span([text('👤')]),
        title: 'Profile Settings',
        content: ArcaneColumn(
          gap: Gap.md,
          children: [
            ArcaneTextInput(label: 'Display Name'),
            ArcaneTextArea(label: 'Bio'),
            ArcaneButton.primary(label: 'Save', onPressed: saveProfile),
          ],
        ),
      ),
      ArcaneAccordionItem(
        icon: span([text('🔔')]),
        title: 'Notification Preferences',
        content: ArcaneColumn(
          gap: Gap.md,
          children: [
            ArcaneToggleSwitch(label: 'Email notifications', value: emailNotifs),
            ArcaneToggleSwitch(label: 'Push notifications', value: pushNotifs),
            ArcaneToggleSwitch(label: 'SMS notifications', value: smsNotifs),
          ],
        ),
      ),
      ArcaneAccordionItem(
        icon: span([text('🎨')]),
        title: 'Appearance',
        content: ArcaneColumn(
          gap: Gap.md,
          children: [
            ArcaneToggleButtonGroup<String>(
              value: theme,
              options: [
                ToggleOption(value: 'light', label: 'Light'),
                ToggleOption(value: 'dark', label: 'Dark'),
                ToggleOption(value: 'system', label: 'System'),
              ],
              onChanged: setTheme,
            ),
          ],
        ),
      ),
    ],
  ),
)
```

### Product Details

```dart
ArcaneAccordion(
  items: [
    ArcaneAccordionItem(
      title: 'Description',
      content: ArcaneParagraph(text: product.description),
    ),
    ArcaneAccordionItem(
      title: 'Specifications',
      content: ArcaneKeyValueTable(items: product.specs),
    ),
    ArcaneAccordionItem(
      title: 'Shipping & Returns',
      content: ArcaneColumn(
        gap: Gap.md,
        children: [
          ArcaneParagraph(text: 'Free shipping on orders over \$50'),
          ArcaneParagraph(text: '30-day return policy'),
        ],
      ),
    ),
    ArcaneAccordionItem(
      title: 'Reviews (${product.reviewCount})',
      content: ArcaneColumn(
        gap: Gap.md,
        children: [
          for (var review in product.reviews.take(3))
            ReviewCard(review: review),
          ArcaneButton.link(label: 'View all reviews', onPressed: viewAllReviews),
        ],
      ),
    ),
  ],
)
```

### Navigation Menu

```dart
ArcaneAccordion(
  allowMultiple: true,
  items: [
    ArcaneAccordionItem(
      title: 'Products',
      content: ArcaneColumn(
        crossAxisAlignment: AlignItems.start,
        children: [
          ArcaneNavLink(label: 'All Products', href: '/products'),
          ArcaneNavLink(label: 'Featured', href: '/products/featured'),
          ArcaneNavLink(label: 'New Arrivals', href: '/products/new'),
        ],
      ),
    ),
    ArcaneAccordionItem(
      title: 'Resources',
      content: ArcaneColumn(
        crossAxisAlignment: AlignItems.start,
        children: [
          ArcaneNavLink(label: 'Documentation', href: '/docs'),
          ArcaneNavLink(label: 'Blog', href: '/blog'),
          ArcaneNavLink(label: 'Support', href: '/support'),
        ],
      ),
    ),
  ],
)
```

## Related Components

- [ArcaneExpander](/arcane_jaspr/docs/view/arcane-expander) - Single expandable section
- [ArcaneTabs](/arcane_jaspr/docs/layout/arcane-tabs) - Tabbed content
- [ArcaneCard](/arcane_jaspr/docs/layout/arcane-card) - Card container
