---
title: ArcaneFlow
description: Auto-wrapping flex container for flowing layouts
layout: docs
component: flow
---

# ArcaneFlow

A flex container that automatically wraps children when they exceed the container width, perfect for tags, chips, or responsive button groups.

## Basic Usage

```dart
ArcaneFlow(
  children: [
    ArcaneBadge(label: 'React'),
    ArcaneBadge(label: 'Vue'),
    ArcaneBadge(label: 'Angular'),
    ArcaneBadge(label: 'Svelte'),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `children` | `List<Component>` | `[]` | Flow children |
| `gap` | `Gap?` | `sm` | Space between items |
| `rowGap` | `Gap?` | `null` | Vertical gap between rows |
| `alignment` | `JustifyContent?` | `null` | Horizontal alignment |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## With Gap

```dart
ArcaneFlow(
  gap: Gap.md,
  children: [
    for (var tag in tags)
      ArcaneBadge(label: tag),
  ],
)
```

## With Row Gap

```dart
ArcaneFlow(
  gap: Gap.sm,
  rowGap: Gap.md,
  children: [
    for (var skill in skills)
      ArcaneChip(label: skill),
  ],
)
```

## Alignment

```dart
// Center aligned
ArcaneFlow(
  alignment: JustifyContent.center,
  gap: Gap.sm,
  children: [
    ArcaneButton(label: 'Option 1', onPressed: () {}),
    ArcaneButton(label: 'Option 2', onPressed: () {}),
    ArcaneButton(label: 'Option 3', onPressed: () {}),
  ],
)

// Space between
ArcaneFlow(
  alignment: JustifyContent.spaceBetween,
  children: [...],
)
```

## Examples

### Tag Cloud

```dart
ArcaneFlow(
  gap: Gap.sm,
  children: [
    ArcaneBadge(label: 'JavaScript'),
    ArcaneBadge(label: 'TypeScript'),
    ArcaneBadge(label: 'Python'),
    ArcaneBadge(label: 'Rust'),
    ArcaneBadge(label: 'Go'),
    ArcaneBadge(label: 'Dart'),
    ArcaneBadge(label: 'Swift'),
    ArcaneBadge(label: 'Kotlin'),
  ],
)
```

### Filter Chips

```dart
ArcaneFlow(
  gap: Gap.sm,
  children: [
    ArcaneChip(
      label: 'All',
      isSelected: filter == 'all',
      onPressed: () => setFilter('all'),
    ),
    ArcaneChip(
      label: 'Active',
      isSelected: filter == 'active',
      onPressed: () => setFilter('active'),
    ),
    ArcaneChip(
      label: 'Completed',
      isSelected: filter == 'completed',
      onPressed: () => setFilter('completed'),
    ),
    ArcaneChip(
      label: 'Archived',
      isSelected: filter == 'archived',
      onPressed: () => setFilter('archived'),
    ),
  ],
)
```

### Social Links

```dart
ArcaneFlow(
  alignment: JustifyContent.center,
  gap: Gap.md,
  children: [
    ArcaneIconButton(icon: span([text('𝕏')]), onPressed: () {}),
    ArcaneIconButton(icon: span([text('📘')]), onPressed: () {}),
    ArcaneIconButton(icon: span([text('📸')]), onPressed: () {}),
    ArcaneIconButton(icon: span([text('💼')]), onPressed: () {}),
    ArcaneIconButton(icon: span([text('🐙')]), onPressed: () {}),
  ],
)
```

### Selected Tags

```dart
ArcaneColumn(
  gap: Gap.sm,
  crossAxisAlignment: AlignItems.start,
  children: [
    ArcaneText('Selected tags:'),
    ArcaneFlow(
      gap: Gap.xs,
      children: [
        for (var tag in selectedTags)
          ArcaneChip(
            label: tag,
            trailing: span([text('×')]),
            onPressed: () => removeTag(tag),
          ),
        if (selectedTags.isEmpty)
          ArcaneText('No tags selected'),
      ],
    ),
  ],
)
```

### Responsive Button Group

```dart
ArcaneFlow(
  gap: Gap.sm,
  alignment: JustifyContent.center,
  children: [
    ArcaneButton(label: 'Save', onPressed: () {}),
    ArcaneButton.ghost(label: 'Preview', onPressed: () {}),
    ArcaneButton.ghost(label: 'Schedule', onPressed: () {}),
    ArcaneButton.destructive(label: 'Delete', onPressed: () {}),
  ],
)
```

### Avatar List

```dart
ArcaneFlow(
  gap: Gap.sm,
  children: [
    for (var user in teamMembers)
      ArcaneTooltip(
        content: user.name,
        child: ArcaneAvatar(
          imageUrl: user.avatar,
          size: AvatarSize.small,
        ),
      ),
    ArcaneIconButton(
      icon: span([text('+')]),
      size: IconButtonSize.small,
      onPressed: addMember,
    ),
  ],
)
```

### Category Pills

```dart
ArcaneFlow(
  gap: Gap.sm,
  rowGap: Gap.sm,
  styles: const ArcaneStyleData(
    padding: PaddingPreset.md,
    background: Background.surface,
    borderRadius: Radius.lg,
  ),
  children: [
    for (var category in categories)
      ArcaneButton(
        label: category.name,
        variant: selectedCategory == category.id
            ? ButtonVariant.primary
            : ButtonVariant.ghost,
        size: ButtonSize.small,
        onPressed: () => selectCategory(category.id),
      ),
  ],
)
```

## Related Components

- [ArcaneRow](/docs/layout/arcane-row) - Horizontal flex (no wrap)
- [ArcaneChipGroup](/docs/view/arcane-chip-group) - Specialized chip flow
- [ArcaneDiv](/docs/layout/arcane-div) - Generic layout div
