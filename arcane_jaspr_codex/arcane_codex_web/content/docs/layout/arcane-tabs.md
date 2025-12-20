---
title: ArcaneTabs
description: Tabbed interface for organizing content
layout: docs
---

# ArcaneTabs

A tabbed navigation component for organizing content into switchable panels.

## Basic Usage

```dart
ArcaneTabs(
  tabs: [
    ArcaneTab(label: 'Overview', content: OverviewPanel()),
    ArcaneTab(label: 'Settings', content: SettingsPanel()),
    ArcaneTab(label: 'Activity', content: ActivityPanel()),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `tabs` | `List<ArcaneTab>` | required | Tab definitions |
| `activeIndex` | `int?` | `0` | Controlled active tab |
| `onChanged` | `ValueChanged<int>?` | `null` | Tab change handler |
| `variant` | `TabsVariant` | `default_` | Visual style |
| `size` | `TabsSize` | `medium` | Tab size |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## ArcaneTab

```dart
ArcaneTab(
  label: 'Tab Label',       // Display text
  icon: span([text('🏠')]), // Optional leading icon
  content: YourContent(),   // Panel content
  isDisabled: false,        // Disable this tab
)
```

## Variants

```dart
// Default (underline)
ArcaneTabs(
  variant: TabsVariant.default_,
  tabs: [...],
)

// Boxed
ArcaneTabs(
  variant: TabsVariant.boxed,
  tabs: [...],
)

// Pills
ArcaneTabs(
  variant: TabsVariant.pills,
  tabs: [...],
)

// Underline
ArcaneTabs(
  variant: TabsVariant.underline,
  tabs: [...],
)
```

## Sizes

```dart
// Small
ArcaneTabs(
  size: TabsSize.small,
  tabs: [...],
)

// Medium (default)
ArcaneTabs(
  size: TabsSize.medium,
  tabs: [...],
)

// Large
ArcaneTabs(
  size: TabsSize.large,
  tabs: [...],
)
```

## Controlled Tabs

```dart
class MyComponent extends StatefulComponent {
  int activeTab = 0;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield ArcaneTabs(
      activeIndex: activeTab,
      onChanged: (index) {
        setState(() => activeTab = index);
      },
      tabs: [
        ArcaneTab(label: 'Tab 1', content: Tab1Content()),
        ArcaneTab(label: 'Tab 2', content: Tab2Content()),
        ArcaneTab(label: 'Tab 3', content: Tab3Content()),
      ],
    );
  }
}
```

## Examples

### Settings Page

```dart
ArcaneTabs(
  tabs: [
    ArcaneTab(
      label: 'Profile',
      icon: span([text('👤')]),
      content: ArcaneColumn(
        gap: Gap.md,
        children: [
          ArcaneTextInput(label: 'Name', value: user.name),
          ArcaneTextInput(label: 'Email', value: user.email),
          ArcaneTextArea(label: 'Bio', value: user.bio),
          ArcaneButton.primary(label: 'Save', onPressed: saveProfile),
        ],
      ),
    ),
    ArcaneTab(
      label: 'Security',
      icon: span([text('🔒')]),
      content: ArcaneColumn(
        gap: Gap.md,
        children: [
          ArcaneTextInput(label: 'Current Password', type: TextInputType.password),
          ArcaneTextInput(label: 'New Password', type: TextInputType.password),
          ArcaneButton.primary(label: 'Update Password', onPressed: updatePassword),
        ],
      ),
    ),
    ArcaneTab(
      label: 'Notifications',
      icon: span([text('🔔')]),
      content: ArcaneColumn(
        gap: Gap.md,
        children: [
          ArcaneToggleSwitch(label: 'Email notifications', value: emailNotifs),
          ArcaneToggleSwitch(label: 'Push notifications', value: pushNotifs),
        ],
      ),
    ),
  ],
)
```

### Dashboard Tabs

```dart
ArcaneTabs(
  variant: TabsVariant.pills,
  tabs: [
    ArcaneTab(
      label: 'Overview',
      content: ArcaneRow(
        gap: Gap.lg,
        children: [
          ArcaneExpanded(child: RevenueCard()),
          ArcaneExpanded(child: UsersCard()),
          ArcaneExpanded(child: OrdersCard()),
        ],
      ),
    ),
    ArcaneTab(
      label: 'Analytics',
      content: AnalyticsChart(),
    ),
    ArcaneTab(
      label: 'Reports',
      content: ReportsTable(),
    ),
  ],
)
```

### Product Details

```dart
ArcaneTabs(
  variant: TabsVariant.underline,
  tabs: [
    ArcaneTab(
      label: 'Description',
      content: ArcaneParagraph(text: product.description),
    ),
    ArcaneTab(
      label: 'Specifications',
      content: ArcaneKeyValueTable(
        items: product.specs.entries.map(
          (e) => KeyValue(key: e.key, value: e.value),
        ).toList(),
      ),
    ),
    ArcaneTab(
      label: 'Reviews (${product.reviewCount})',
      content: ArcaneColumn(
        gap: Gap.md,
        children: [
          for (var review in product.reviews)
            ReviewCard(review: review),
        ],
      ),
    ),
  ],
)
```

### Code Examples

```dart
ArcaneTabs(
  variant: TabsVariant.boxed,
  size: TabsSize.small,
  tabs: [
    ArcaneTab(
      label: 'Dart',
      content: ArcaneCodeSnippet(
        language: 'dart',
        code: dartCode,
      ),
    ),
    ArcaneTab(
      label: 'JavaScript',
      content: ArcaneCodeSnippet(
        language: 'javascript',
        code: jsCode,
      ),
    ),
    ArcaneTab(
      label: 'Python',
      content: ArcaneCodeSnippet(
        language: 'python',
        code: pythonCode,
      ),
    ),
  ],
)
```

### With Disabled Tab

```dart
ArcaneTabs(
  tabs: [
    ArcaneTab(label: 'Active', content: ActiveContent()),
    ArcaneTab(label: 'Pending', content: PendingContent()),
    ArcaneTab(
      label: 'Archived',
      content: ArchivedContent(),
      isDisabled: !hasArchiveAccess,
    ),
  ],
)
```

## Related Components

- [ArcaneToggleButtonGroup](/docs/inputs/arcane-toggle-button-group) - Button-style tabs
- [ArcaneAccordion](/docs/feedback/arcane-accordion) - Expandable sections
