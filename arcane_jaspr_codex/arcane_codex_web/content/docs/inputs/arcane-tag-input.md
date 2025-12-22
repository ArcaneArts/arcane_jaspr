---
title: ArcaneTagInput
description: Tag input for collecting multiple values
layout: docs
component: tag-input
---

# ArcaneTagInput

A tag input component for entering and managing multiple values like tags, labels, or categories.

## Basic Usage

```dart
ArcaneTagInput(
  tags: ['React', 'Vue', 'Angular'],
  onTagsChanged: (tags) {
    setState(() => selectedTags = tags);
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `tags` | `List<String>` | required | Current list of tags |
| `onTagsChanged` | `ValueChanged<List<String>>?` | `null` | Callback when tags change |
| `placeholder` | `String` | `'Add tag...'` | Placeholder text |
| `style` | `TagInputStyle` | `outline` | Visual style variant |
| `size` | `TagInputSize` | `md` | Size variant |
| `maxTags` | `int?` | `null` | Maximum number of tags |
| `allowDuplicates` | `bool` | `false` | Allow duplicate tags |
| `disabled` | `bool` | `false` | Disable interaction |

## Style Variants

```dart
// Outline (default)
ArcaneTagInput(
  tags: tags,
  style: TagInputStyle.outline,
  onTagsChanged: (t) => setState(() => tags = t),
)

// Filled
ArcaneTagInput(
  tags: tags,
  style: TagInputStyle.filled,
  onTagsChanged: (t) => setState(() => tags = t),
)

// Ghost
ArcaneTagInput(
  tags: tags,
  style: TagInputStyle.ghost,
  onTagsChanged: (t) => setState(() => tags = t),
)
```

## With Max Tags

```dart
ArcaneTagInput(
  tags: skills,
  maxTags: 5,
  placeholder: 'Add up to 5 skills...',
  onTagsChanged: (t) => setState(() => skills = t),
)
```

## Size Variants

```dart
// Small
ArcaneTagInput(
  tags: tags,
  size: TagInputSize.sm,
  onTagsChanged: onTagsChanged,
)

// Medium (default)
ArcaneTagInput(
  tags: tags,
  size: TagInputSize.md,
  onTagsChanged: onTagsChanged,
)

// Large
ArcaneTagInput(
  tags: tags,
  size: TagInputSize.lg,
  onTagsChanged: onTagsChanged,
)
```

## Examples

### Skills Input

```dart
ArcaneColumn(
  gapSize: Gap.sm,
  children: [
    ArcaneText('Skills'),
    ArcaneTagInput(
      tags: skills,
      placeholder: 'Add skills...',
      maxTags: 10,
      onTagsChanged: (t) => setState(() => skills = t),
    ),
    ArcaneText(
      '${skills.length}/10 skills added',
      color: TextColor.muted,
    ),
  ],
)
```

### Filter Tags

```dart
ArcaneRow(
  gapSize: Gap.md,
  children: [
    ArcaneText('Filters:'),
    Expanded(
      child: ArcaneTagInput(
        tags: filters,
        style: TagInputStyle.filled,
        onTagsChanged: (t) => setState(() => filters = t),
      ),
    ),
    ArcaneButton.secondary(
      label: 'Clear All',
      onPressed: () => setState(() => filters = []),
    ),
  ],
)
```

## Related Components

- [ArcaneChip](/arcane_jaspr/docs/view/arcane-chip) - Individual chip component
- [ArcaneTextInput](/arcane_jaspr/docs/inputs/arcane-text-input) - Single text input
