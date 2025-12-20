---
title: ArcaneColumn
description: Vertical flex layout container
layout: docs
component: column
---

# ArcaneColumn

A convenience component for vertical flex layouts. Automatically applies `display: flex` and `flex-direction: column`.

## Basic Usage

```dart
ArcaneColumn(
  children: [
    ArcaneText('First'),
    ArcaneText('Second'),
    ArcaneText('Third'),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `children` | `List<Component>` | `[]` | Child components |
| `gap` | `Gap?` | `null` | Space between children |
| `mainAxisAlignment` | `JustifyContent?` | `null` | Vertical alignment |
| `crossAxisAlignment` | `AlignItems?` | `null` | Horizontal alignment |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## With Gap

```dart
ArcaneColumn(
  gap: Gap.md,
  children: [
    ArcaneTextInput(label: 'First Name'),
    ArcaneTextInput(label: 'Last Name'),
    ArcaneTextInput(label: 'Email'),
  ],
)
```

## Alignment

### Main Axis (Vertical)

```dart
// Center vertically
ArcaneColumn(
  mainAxisAlignment: JustifyContent.center,
  styles: const ArcaneStyleData(minHeightCustom: '400px'),
  children: [
    ArcaneHeading(text: 'Centered'),
    ArcaneText('Vertically centered content'),
  ],
)

// Space between
ArcaneColumn(
  mainAxisAlignment: JustifyContent.spaceBetween,
  styles: const ArcaneStyleData(heightCustom: '100vh'),
  children: [
    ArcaneHeader(...),
    ArcaneDiv(children: [...]),
    ArcaneFooter(...),
  ],
)
```

### Cross Axis (Horizontal)

```dart
// Center horizontally
ArcaneColumn(
  crossAxisAlignment: AlignItems.center,
  gap: Gap.md,
  children: [
    ArcaneAvatar(size: AvatarSize.large),
    ArcaneHeading(text: 'John Doe'),
    ArcaneText('Software Developer'),
  ],
)

// Stretch to fill width
ArcaneColumn(
  crossAxisAlignment: AlignItems.stretch,
  gap: Gap.md,
  children: [
    ArcaneButton(label: 'Full Width', onPressed: () {}),
    ArcaneButton.ghost(label: 'Full Width', onPressed: () {}),
  ],
)

// Start aligned (left)
ArcaneColumn(
  crossAxisAlignment: AlignItems.start,
  gap: Gap.sm,
  children: [
    ArcaneBadge(label: 'New'),
    ArcaneHeading(text: 'Feature'),
    ArcaneText('Description text'),
  ],
)
```

## Examples

### Login Form

```dart
ArcaneColumn(
  gap: Gap.lg,
  crossAxisAlignment: AlignItems.stretch,
  styles: const ArcaneStyleData(
    maxWidthCustom: '400px',
    margin: Margin.auto,
  ),
  children: [
    ArcaneColumn(
      crossAxisAlignment: AlignItems.center,
      gap: Gap.sm,
      children: [
        ArcaneHeading(text: 'Welcome Back'),
        ArcaneText('Sign in to your account'),
      ],
    ),
    ArcaneTextInput(label: 'Email'),
    ArcaneTextInput(label: 'Password', type: TextInputType.password),
    ArcaneButton.primary(label: 'Sign In', onPressed: () {}),
    ArcaneRow(
      mainAxisAlignment: JustifyContent.center,
      gap: Gap.xs,
      children: [
        ArcaneText("Don't have an account?"),
        ArcaneButton.link(label: 'Sign Up', onPressed: () {}),
      ],
    ),
  ],
)
```

### Sidebar Navigation

```dart
ArcaneColumn(
  gap: Gap.xs,
  crossAxisAlignment: AlignItems.stretch,
  styles: const ArcaneStyleData(
    padding: PaddingPreset.md,
    widthCustom: '250px',
    background: Background.surface,
  ),
  children: [
    ArcaneSidebarItem(label: 'Dashboard', icon: '🏠', isActive: true),
    ArcaneSidebarItem(label: 'Projects', icon: '📁'),
    ArcaneSidebarItem(label: 'Team', icon: '👥'),
    ArcaneSidebarItem(label: 'Settings', icon: '⚙'),
    ArcaneSpacer(),
    ArcaneSidebarItem(label: 'Logout', icon: '🚪'),
  ],
)
```

### Card Content

```dart
ArcaneCard(
  child: ArcaneColumn(
    gap: Gap.md,
    crossAxisAlignment: AlignItems.start,
    children: [
      ArcaneBadge(label: 'Featured'),
      ArcaneHeading(text: 'Article Title'),
      ArcaneParagraph(text: 'Article preview text goes here...'),
      ArcaneRow(
        gap: Gap.sm,
        children: [
          ArcaneAvatar(size: AvatarSize.small),
          ArcaneColumn(
            gap: Gap.xs,
            children: [
              ArcaneText('Author Name'),
              ArcaneText('Jan 15, 2024'),
            ],
          ),
        ],
      ),
    ],
  ),
)
```

### Full Page Layout

```dart
ArcaneColumn(
  mainAxisAlignment: JustifyContent.spaceBetween,
  styles: const ArcaneStyleData(
    minHeightCustom: '100vh',
  ),
  children: [
    ArcaneHeader(
      title: 'My App',
      actions: [...],
    ),
    ArcaneExpanded(
      child: ArcaneContainer(
        children: [
          // Main content
        ],
      ),
    ),
    ArcaneFooter(
      children: [...],
    ),
  ],
)
```

### Stacked Cards

```dart
ArcaneColumn(
  gap: Gap.lg,
  children: [
    for (var item in items)
      ArcaneCard(
        child: ArcaneRow(
          mainAxisAlignment: JustifyContent.spaceBetween,
          crossAxisAlignment: AlignItems.center,
          children: [
            ArcaneColumn(
              crossAxisAlignment: AlignItems.start,
              children: [
                ArcaneText(item.title),
                ArcaneText(item.subtitle),
              ],
            ),
            ArcaneButton.ghost(label: 'View', onPressed: () {}),
          ],
        ),
      ),
  ],
)
```

## Related Components

- [ArcaneRow](/docs/layout/arcane-row) - Horizontal flex layout
- [ArcaneDiv](/docs/layout/arcane-div) - Generic div with full control
- [ArcaneSpacer](/docs/layout/arcane-spacer) - Flexible space filler
