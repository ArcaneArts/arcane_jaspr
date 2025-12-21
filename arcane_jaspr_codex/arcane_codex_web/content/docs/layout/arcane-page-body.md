---
title: ArcanePageBody
description: Main content area wrapper with title and actions
layout: docs
component: page-body
---

# ArcanePageBody

A wrapper component for main page content that provides consistent structure with an optional title, description, and action buttons.

## Basic Usage

```dart
ArcanePageBody(
  title: 'Dashboard',
  children: [
    // Page content
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `children` | `List<Component>` | `[]` | Page content |
| `title` | `String?` | `null` | Page title |
| `description` | `String?` | `null` | Page description |
| `actions` | `List<Component>?` | `null` | Action buttons |
| `breadcrumbs` | `List<Breadcrumb>?` | `null` | Navigation breadcrumbs |
| `padding` | `PaddingPreset?` | `lg` | Content padding |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## With Actions

```dart
ArcanePageBody(
  title: 'Projects',
  description: 'Manage your projects',
  actions: [
    ArcaneButton.ghost(label: 'Export', onPressed: exportProjects),
    ArcaneButton.primary(
      label: 'New Project',
      leading: span([text('+')]),
      onPressed: createProject,
    ),
  ],
  children: [
    ProjectList(),
  ],
)
```

## With Breadcrumbs

```dart
ArcanePageBody(
  breadcrumbs: [
    Breadcrumb(label: 'Home', href: '/'),
    Breadcrumb(label: 'Projects', href: '/projects'),
    Breadcrumb(label: 'Settings'),
  ],
  title: 'Project Settings',
  children: [
    SettingsForm(),
  ],
)
```

## Examples

### Dashboard Page

```dart
ArcanePageBody(
  title: 'Dashboard',
  description: 'Welcome back, John!',
  actions: [
    ArcaneSelect(
      value: timeRange,
      options: [
        SelectOption(value: '7d', label: 'Last 7 days'),
        SelectOption(value: '30d', label: 'Last 30 days'),
        SelectOption(value: '90d', label: 'Last 90 days'),
      ],
      onChanged: (v) => setState(() => timeRange = v),
    ),
  ],
  children: [
    ArcaneRow(
      gap: Gap.lg,
      children: [
        ArcaneExpanded(
          child: ArcaneCard(
            child: ArcaneColumn(
              children: [
                ArcaneText('Total Revenue'),
                ArcaneHeading(text: '\$45,231.89'),
                ArcaneBadge(label: '+20.1%', variant: BadgeVariant.success),
              ],
            ),
          ),
        ),
        ArcaneExpanded(
          child: ArcaneCard(
            child: ArcaneColumn(
              children: [
                ArcaneText('Subscriptions'),
                ArcaneHeading(text: '2,350'),
                ArcaneBadge(label: '+180', variant: BadgeVariant.success),
              ],
            ),
          ),
        ),
        ArcaneExpanded(
          child: ArcaneCard(
            child: ArcaneColumn(
              children: [
                ArcaneText('Active Now'),
                ArcaneHeading(text: '573'),
                ArcaneBadge(label: '+201 since last hour'),
              ],
            ),
          ),
        ),
      ],
    ),
    ArcaneGutter(size: GutterSize.lg),
    ArcaneCard(
      child: ArcaneColumn(
        children: [
          ArcaneHeading(text: 'Overview'),
          // Chart component
        ],
      ),
    ),
  ],
)
```

### List Page

```dart
ArcanePageBody(
  title: 'Team Members',
  description: 'Manage your team and their permissions',
  actions: [
    ArcaneSearch(
      placeholder: 'Search members...',
      onSearch: filterMembers,
    ),
    ArcaneButton.primary(
      label: 'Invite Member',
      leading: span([text('+')]),
      onPressed: inviteMember,
    ),
  ],
  children: [
    ArcaneDataTable(
      columns: [
        DataColumn(label: 'Name'),
        DataColumn(label: 'Email'),
        DataColumn(label: 'Role'),
        DataColumn(label: 'Status'),
        DataColumn(label: 'Actions'),
      ],
      rows: members.map((m) => DataRow(cells: [
        ArcaneRow(
          gap: Gap.sm,
          children: [
            ArcaneAvatar(imageUrl: m.avatar, size: AvatarSize.small),
            ArcaneText(m.name),
          ],
        ),
        ArcaneText(m.email),
        ArcaneBadge(label: m.role),
        ArcaneStatusBadge(status: m.status),
        ArcaneRow(
          gap: Gap.xs,
          children: [
            ArcaneIconButton(icon: span([text('✏')]), onPressed: () => edit(m)),
            ArcaneIconButton(icon: span([text('🗑')]), onPressed: () => delete(m)),
          ],
        ),
      ])).toList(),
    ),
  ],
)
```

### Settings Page

```dart
ArcanePageBody(
  breadcrumbs: [
    Breadcrumb(label: 'Dashboard', href: '/'),
    Breadcrumb(label: 'Settings'),
  ],
  title: 'Settings',
  children: [
    ArcaneTabs(
      tabs: [
        ArcaneTab(
          label: 'General',
          content: GeneralSettings(),
        ),
        ArcaneTab(
          label: 'Notifications',
          content: NotificationSettings(),
        ),
        ArcaneTab(
          label: 'Security',
          content: SecuritySettings(),
        ),
        ArcaneTab(
          label: 'Billing',
          content: BillingSettings(),
        ),
      ],
    ),
  ],
)
```

### Empty State

```dart
ArcanePageBody(
  title: 'Projects',
  actions: [
    ArcaneButton.primary(label: 'New Project', onPressed: createProject),
  ],
  children: [
    if (projects.isEmpty)
      ArcaneEmptyState(
        icon: span([text('📁')]),
        title: 'No projects yet',
        description: 'Create your first project to get started',
        action: ArcaneButton.primary(
          label: 'Create Project',
          onPressed: createProject,
        ),
      )
    else
      ProjectGrid(projects: projects),
  ],
)
```

## Related Components

- [ArcaneDashboardLayout](/arcane_jaspr/docs/layout/arcane-dashboard-layout) - Dashboard layout
- [ArcaneContainer](/arcane_jaspr/docs/layout/arcane-container) - Centered container
- [ArcaneSection](/arcane_jaspr/docs/layout/arcane-section) - Section wrapper
