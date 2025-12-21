---
title: ArcaneExpanded
description: Flex child that expands to fill available space
layout: docs
component: expanded
---

# ArcaneExpanded

A wrapper that makes its child expand to fill available space in a flex container, with configurable flex factor.

## Basic Usage

```dart
ArcaneRow(
  children: [
    ArcaneExpanded(
      child: ArcaneTextInput(placeholder: 'Search...'),
    ),
    ArcaneButton(label: 'Search', onPressed: () {}),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `child` | `Component` | required | Content to expand |
| `flex` | `int` | `1` | Flex grow factor |

## With Custom Flex

```dart
ArcaneRow(
  gap: Gap.md,
  children: [
    ArcaneExpanded(
      flex: 2,
      child: ArcaneCard(child: ArcaneText('2/3 width')),
    ),
    ArcaneExpanded(
      flex: 1,
      child: ArcaneCard(child: ArcaneText('1/3 width')),
    ),
  ],
)
```

## Examples

### Two Column Layout

```dart
ArcaneRow(
  gap: Gap.lg,
  styles: const ArcaneStyleData(
    alignItems: AlignItems.stretch,
  ),
  children: [
    ArcaneExpanded(
      flex: 1,
      child: ArcaneColumn(
        gap: Gap.md,
        children: [
          ArcaneHeading(text: 'Sidebar'),
          ArcaneSidebarItem(label: 'Item 1'),
          ArcaneSidebarItem(label: 'Item 2'),
        ],
      ),
    ),
    ArcaneExpanded(
      flex: 3,
      child: ArcaneColumn(
        gap: Gap.md,
        children: [
          ArcaneHeading(text: 'Main Content'),
          ArcaneParagraph(text: 'Content goes here...'),
        ],
      ),
    ),
  ],
)
```

### Search Bar

```dart
ArcaneRow(
  gap: Gap.sm,
  children: [
    ArcaneExpanded(
      child: ArcaneTextInput(
        placeholder: 'Search products...',
        leading: span([text('🔍')]),
      ),
    ),
    ArcaneSelect(
      value: category,
      options: [
        SelectOption(value: 'all', label: 'All'),
        SelectOption(value: 'electronics', label: 'Electronics'),
        SelectOption(value: 'clothing', label: 'Clothing'),
      ],
      onChanged: (v) => setState(() => category = v),
    ),
    ArcaneButton.primary(label: 'Search', onPressed: () {}),
  ],
)
```

### Equal Width Cards

```dart
ArcaneRow(
  gap: Gap.lg,
  children: [
    ArcaneExpanded(
      child: ArcaneCard(
        child: ArcaneColumn(
          crossAxisAlignment: AlignItems.center,
          children: [
            ArcaneHeading(text: 'Basic'),
            ArcaneText('\$9/mo'),
            ArcaneButton(label: 'Select', onPressed: () {}),
          ],
        ),
      ),
    ),
    ArcaneExpanded(
      child: ArcaneCard(
        child: ArcaneColumn(
          crossAxisAlignment: AlignItems.center,
          children: [
            ArcaneHeading(text: 'Pro'),
            ArcaneText('\$29/mo'),
            ArcaneButton.primary(label: 'Select', onPressed: () {}),
          ],
        ),
      ),
    ),
    ArcaneExpanded(
      child: ArcaneCard(
        child: ArcaneColumn(
          crossAxisAlignment: AlignItems.center,
          children: [
            ArcaneHeading(text: 'Enterprise'),
            ArcaneText('Custom'),
            ArcaneButton.ghost(label: 'Contact', onPressed: () {}),
          ],
        ),
      ),
    ),
  ],
)
```

### Dashboard Stats

```dart
ArcaneRow(
  gap: Gap.md,
  children: [
    ArcaneExpanded(
      child: ArcaneCard(
        child: ArcaneColumn(
          children: [
            ArcaneText('Revenue'),
            ArcaneHeading(text: '\$45,231'),
            ArcaneText('+12% from last month'),
          ],
        ),
      ),
    ),
    ArcaneExpanded(
      child: ArcaneCard(
        child: ArcaneColumn(
          children: [
            ArcaneText('Users'),
            ArcaneHeading(text: '2,350'),
            ArcaneText('+180 new'),
          ],
        ),
      ),
    ),
    ArcaneExpanded(
      child: ArcaneCard(
        child: ArcaneColumn(
          children: [
            ArcaneText('Orders'),
            ArcaneHeading(text: '1,234'),
            ArcaneText('+5% this week'),
          ],
        ),
      ),
    ),
  ],
)
```

### Form with Submit

```dart
ArcaneColumn(
  gap: Gap.md,
  children: [
    ArcaneRow(
      gap: Gap.md,
      children: [
        ArcaneExpanded(
          child: ArcaneTextInput(label: 'First Name'),
        ),
        ArcaneExpanded(
          child: ArcaneTextInput(label: 'Last Name'),
        ),
      ],
    ),
    ArcaneTextInput(label: 'Email'),
    ArcaneRow(
      children: [
        ArcaneExpanded(
          child: ArcaneButton.primary(
            label: 'Submit',
            onPressed: () {},
          ),
        ),
      ],
    ),
  ],
)
```

## Related Components

- [ArcaneSpacer](/arcane_jaspr/docs/layout/arcane-spacer) - Empty space filler
- [ArcaneRow](/arcane_jaspr/docs/layout/arcane-row) - Horizontal flex layout
- [ArcaneColumn](/arcane_jaspr/docs/layout/arcane-column) - Vertical flex layout
