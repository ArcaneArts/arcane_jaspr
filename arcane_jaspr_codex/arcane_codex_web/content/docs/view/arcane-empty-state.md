---
title: ArcaneEmptyState
description: Placeholder for empty content areas
layout: docs
---

# ArcaneEmptyState

A placeholder component for displaying when lists, tables, or content areas are empty.

## Basic Usage

```dart
ArcaneEmptyState(
  title: 'No items yet',
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `title` | `String` | required | Main message |
| `description` | `String?` | `null` | Supporting text |
| `icon` | `Component?` | `null` | Display icon |
| `action` | `Component?` | `null` | Action button |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## With Description

```dart
ArcaneEmptyState(
  title: 'No projects found',
  description: 'Create your first project to get started',
)
```

## With Icon

```dart
ArcaneEmptyState(
  icon: span([text('📁')]),
  title: 'No files',
  description: 'Upload files to see them here',
)
```

## With Action

```dart
ArcaneEmptyState(
  icon: span([text('📝')]),
  title: 'No tasks yet',
  description: 'Create your first task to get started',
  action: ArcaneButton.primary(
    label: 'Create Task',
    onPressed: createTask,
  ),
)
```

## Examples

### Empty Project List

```dart
if (projects.isEmpty)
  ArcaneEmptyState(
    icon: span([text('📁')]),
    title: 'No projects',
    description: 'Get started by creating your first project',
    action: ArcaneButton.primary(
      label: 'New Project',
      leading: span([text('+')]),
      onPressed: createProject,
    ),
  )
else
  ProjectList(projects: projects),
```

### Search No Results

```dart
ArcaneEmptyState(
  icon: span([text('🔍')]),
  title: 'No results found',
  description: 'Try adjusting your search or filters',
  action: ArcaneButton.ghost(
    label: 'Clear filters',
    onPressed: clearFilters,
  ),
)
```

### Empty Inbox

```dart
ArcaneEmptyState(
  icon: span([text('📬')]),
  title: 'Your inbox is empty',
  description: 'Messages you receive will appear here',
)
```

### Empty Cart

```dart
ArcaneEmptyState(
  icon: span([text('🛒')]),
  title: 'Your cart is empty',
  description: 'Add items to your cart to see them here',
  action: ArcaneButton.primary(
    label: 'Continue Shopping',
    onPressed: goToProducts,
  ),
)
```

### Empty Notifications

```dart
ArcaneEmptyState(
  icon: span([text('🔔')]),
  title: 'No notifications',
  description: "You're all caught up!",
)
```

### Empty Table

```dart
ArcaneCard(
  child: ArcaneColumn(
    children: [
      ArcaneRow(
        mainAxisAlignment: JustifyContent.spaceBetween,
        children: [
          ArcaneHeading(text: 'Team Members'),
          ArcaneButton.primary(
            label: 'Add Member',
            size: ButtonSize.small,
            onPressed: addMember,
          ),
        ],
      ),
      ArcaneDivider(),
      if (members.isEmpty)
        ArcaneEmptyState(
          icon: span([text('👥')]),
          title: 'No team members',
          description: 'Invite your team to collaborate',
          action: ArcaneButton.ghost(
            label: 'Invite',
            onPressed: inviteMember,
          ),
        )
      else
        MemberTable(members: members),
    ],
  ),
)
```

### Empty Dashboard

```dart
ArcaneCenter(
  styles: const ArcaneStyleData(
    minHeightCustom: '400px',
  ),
  child: ArcaneEmptyState(
    icon: span([text('📊')]),
    title: 'No data to display',
    description: 'Connect a data source to see your analytics',
    action: ArcaneRow(
      gap: Gap.md,
      mainAxisAlignment: JustifyContent.center,
      children: [
        ArcaneButton.ghost(label: 'Learn More', onPressed: learnMore),
        ArcaneButton.primary(label: 'Connect Data', onPressed: connectData),
      ],
    ),
  ),
)
```

### Custom Styled Empty State

```dart
ArcaneEmptyState(
  icon: ArcaneDiv(
    styles: const ArcaneStyleData(
      widthCustom: '64px',
      heightCustom: '64px',
      borderRadius: Radius.circle,
      background: Background.accent,
      display: Display.flex,
      justifyContent: JustifyContent.center,
      alignItems: AlignItems.center,
      fontSize: FontSize.xl2,
    ),
    children: [span([text('✨')])],
  ),
  title: 'Start Something Amazing',
  description: 'Create your first masterpiece',
  action: ArcaneButton.primary(
    label: 'Get Started',
    size: ButtonSize.large,
    onPressed: getStarted,
  ),
)
```

## Related Components

- [ArcaneLoadingState](/docs/view/arcane-loading-state) - Loading placeholder
- [ArcaneErrorState](/docs/view/arcane-error-state) - Error placeholder
- [ArcaneSkeleton](/docs/view/arcane-skeleton) - Skeleton loading
