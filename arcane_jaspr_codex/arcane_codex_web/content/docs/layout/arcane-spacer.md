---
title: ArcaneSpacer
description: Flexible space filler for flex layouts
layout: docs
component: spacer
---

# ArcaneSpacer

A component that expands to fill available space in flex layouts, useful for pushing elements apart.

## Basic Usage

```dart
ArcaneRow(
  children: [
    ArcaneText('Left'),
    ArcaneSpacer(),
    ArcaneText('Right'),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `flex` | `int` | `1` | Flex grow factor |

## With Custom Flex

```dart
ArcaneRow(
  children: [
    ArcaneDiv(
      children: [ArcaneText('1x')],
    ),
    ArcaneSpacer(flex: 1),
    ArcaneDiv(
      children: [ArcaneText('2x')],
    ),
    ArcaneSpacer(flex: 2),
    ArcaneDiv(
      children: [ArcaneText('1x')],
    ),
  ],
)
```

## Examples

### Header with Spacer

```dart
ArcaneRow(
  crossAxisAlignment: AlignItems.center,
  styles: const ArcaneStyleData(
    padding: PaddingPreset.md,
    background: Background.surface,
  ),
  children: [
    ArcaneText('Logo'),
    ArcaneSpacer(),
    ArcaneRow(
      gap: Gap.md,
      children: [
        ArcaneNavLink(label: 'Home', href: '/'),
        ArcaneNavLink(label: 'About', href: '/about'),
        ArcaneButton.primary(label: 'Sign Up', onPressed: () {}),
      ],
    ),
  ],
)
```

### Sidebar with Spacer

```dart
ArcaneColumn(
  styles: const ArcaneStyleData(
    heightCustom: '100vh',
    padding: PaddingPreset.md,
    background: Background.surface,
  ),
  children: [
    ArcaneText('App Name'),
    ArcaneDiv(
      styles: const ArcaneStyleData(marginTop: Spacing.lg),
      children: [
        ArcaneSidebarItem(label: 'Dashboard', icon: '🏠'),
        ArcaneSidebarItem(label: 'Projects', icon: '📁'),
        ArcaneSidebarItem(label: 'Team', icon: '👥'),
      ],
    ),
    ArcaneSpacer(),
    ArcaneSidebarItem(label: 'Settings', icon: '⚙'),
    ArcaneSidebarItem(label: 'Logout', icon: '🚪'),
  ],
)
```

### Card Footer

```dart
ArcaneCard(
  child: ArcaneColumn(
    gap: Gap.md,
    children: [
      ArcaneHeading(text: 'Card Title'),
      ArcaneParagraph(text: 'Card content goes here...'),
      ArcaneRow(
        children: [
          ArcaneText('Price: \$99'),
          ArcaneSpacer(),
          ArcaneButton.primary(label: 'Buy', onPressed: () {}),
        ],
      ),
    ],
  ),
)
```

### Toolbar Layout

```dart
ArcaneRow(
  crossAxisAlignment: AlignItems.center,
  gap: Gap.sm,
  styles: const ArcaneStyleData(
    padding: PaddingPreset.sm,
    background: Background.surface,
    borderBottom: Border.subtle,
  ),
  children: [
    ArcaneIconButton(icon: span([text('←')]), onPressed: () {}),
    ArcaneIconButton(icon: span([text('→')]), onPressed: () {}),
    ArcaneIconButton(icon: span([text('↻')]), onPressed: () {}),
    ArcaneSpacer(),
    ArcaneSearch(placeholder: 'Search...'),
    ArcaneSpacer(),
    ArcaneIconButton(icon: span([text('⚙')]), onPressed: () {}),
    ArcaneAvatar(size: AvatarSize.small),
  ],
)
```

### Modal Footer

```dart
ArcaneDialog(
  title: 'Confirm Action',
  content: ArcaneText('Are you sure?'),
  footer: ArcaneRow(
    children: [
      ArcaneButton.ghost(label: 'Cancel', onPressed: () {}),
      ArcaneSpacer(),
      ArcaneButton.destructive(label: 'Delete', onPressed: () {}),
    ],
  ),
)
```

## Related Components

- [ArcaneRow](/arcane_jaspr/docs/layout/arcane-row) - Horizontal flex layout
- [ArcaneColumn](/arcane_jaspr/docs/layout/arcane-column) - Vertical flex layout
- [ArcaneExpanded](/arcane_jaspr/docs/layout/arcane-expanded) - Expanded flex child
