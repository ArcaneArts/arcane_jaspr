---
title: ArcaneChip
description: Interactive chip for filtering and selection
layout: docs
component: chip
---

# ArcaneChip

An interactive chip component for filters, tags, and selections with optional remove action.

## Basic Usage

```dart
ArcaneChip(label: 'React')
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `label` | `String` | required | Chip text |
| `onPressed` | `VoidCallback?` | `null` | Click handler |
| `onRemove` | `VoidCallback?` | `null` | Remove handler |
| `isSelected` | `bool` | `false` | Selected state |
| `leading` | `Component?` | `null` | Leading icon |
| `trailing` | `Component?` | `null` | Trailing widget |
| `variant` | `ChipVariant` | `default_` | Color variant |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Variants

```dart
// Default
ArcaneChip(label: 'Default', variant: ChipVariant.default_)

// Primary
ArcaneChip(label: 'Primary', variant: ChipVariant.primary)

// Secondary
ArcaneChip(label: 'Secondary', variant: ChipVariant.secondary)

// Outline
ArcaneChip(label: 'Outline', variant: ChipVariant.outline)
```

## Selected State

```dart
ArcaneChip(
  label: 'Selected',
  isSelected: true,
  onPressed: () => toggle(),
)
```

## With Remove Button

```dart
ArcaneChip(
  label: 'Removable',
  onRemove: () => removeChip(),
)
```

## With Leading Icon

```dart
ArcaneChip(
  label: 'JavaScript',
  leading: span([text('📜')]),
)
```

## Examples

### Filter Chips

```dart
ArcaneFlow(
  gap: Gap.sm,
  children: [
    for (var filter in filters)
      ArcaneChip(
        label: filter.name,
        isSelected: selectedFilters.contains(filter.id),
        onPressed: () => toggleFilter(filter.id),
      ),
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
      gap: Gap.sm,
      children: [
        for (var tag in selectedTags)
          ArcaneChip(
            label: tag,
            onRemove: () => removeTag(tag),
          ),
      ],
    ),
  ],
)
```

### Technology Stack

```dart
ArcaneFlow(
  gap: Gap.sm,
  children: [
    ArcaneChip(label: 'Dart', leading: span([text('🎯')])),
    ArcaneChip(label: 'Flutter', leading: span([text('📱')])),
    ArcaneChip(label: 'Jaspr', leading: span([text('🌐')])),
    ArcaneChip(label: 'Arcane', leading: span([text('🔮')])),
  ],
)
```

### Category Selection

```dart
ArcaneFlow(
  gap: Gap.sm,
  children: [
    ArcaneChip(
      label: 'All',
      isSelected: category == 'all',
      onPressed: () => setCategory('all'),
    ),
    ArcaneChip(
      label: 'Technology',
      isSelected: category == 'tech',
      onPressed: () => setCategory('tech'),
    ),
    ArcaneChip(
      label: 'Business',
      isSelected: category == 'business',
      onPressed: () => setCategory('business'),
    ),
    ArcaneChip(
      label: 'Design',
      isSelected: category == 'design',
      onPressed: () => setCategory('design'),
    ),
  ],
)
```

### User Input Tags

```dart
ArcaneColumn(
  gap: Gap.md,
  children: [
    ArcaneFlow(
      gap: Gap.sm,
      children: [
        for (var tag in tags)
          ArcaneChip(
            label: tag,
            onRemove: () => removeTag(tag),
          ),
      ],
    ),
    ArcaneRow(
      gap: Gap.sm,
      children: [
        ArcaneExpanded(
          child: ArcaneTextInput(
            placeholder: 'Add tag...',
            controller: tagController,
          ),
        ),
        ArcaneButton.ghost(
          label: 'Add',
          onPressed: addTag,
        ),
      ],
    ),
  ],
)
```

### Status Chips

```dart
ArcaneFlow(
  gap: Gap.sm,
  children: [
    ArcaneChip(
      label: 'Completed',
      variant: ChipVariant.primary,
      isSelected: statusFilter.contains('completed'),
      onPressed: () => toggleStatus('completed'),
    ),
    ArcaneChip(
      label: 'In Progress',
      variant: ChipVariant.primary,
      isSelected: statusFilter.contains('in_progress'),
      onPressed: () => toggleStatus('in_progress'),
    ),
    ArcaneChip(
      label: 'Pending',
      variant: ChipVariant.primary,
      isSelected: statusFilter.contains('pending'),
      onPressed: () => toggleStatus('pending'),
    ),
  ],
)
```

### Multi-select Chips

```dart
ArcaneColumn(
  gap: Gap.md,
  children: [
    ArcaneText('Select interests:'),
    ArcaneFlow(
      gap: Gap.sm,
      children: [
        for (var interest in allInterests)
          ArcaneChip(
            label: interest,
            isSelected: selectedInterests.contains(interest),
            onPressed: () => toggleInterest(interest),
          ),
      ],
    ),
    ArcaneText(
      '${selectedInterests.length} selected',
      styles: const ArcaneStyleData(
        fontSize: FontSize.sm,
        textColor: TextColor.muted,
      ),
    ),
  ],
)
```

## Related Components

- [ArcaneChipGroup](/docs/view/arcane-chip-group) - Group of chips
- [ArcaneBadge](/docs/view/arcane-badge) - Static badge
- [ArcaneFlow](/docs/layout/arcane-flow) - Wrapping layout
