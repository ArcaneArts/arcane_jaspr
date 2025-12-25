---
title: ArcaneCombobox
description: Autocomplete dropdown with search filtering
layout: docs
component: combobox
---

# ArcaneCombobox

Autocomplete dropdown with search filtering for selecting from a list of options.

## Basic Usage

```dart
ArcaneCombobox<String>(
  options: [
    ComboboxOption(value: 'apple', label: 'Apple'),
    ComboboxOption(value: 'banana', label: 'Banana'),
    ComboboxOption(value: 'cherry', label: 'Cherry'),
  ],
  value: selectedFruit,
  onChanged: (fruit) => setState(() => selectedFruit = fruit),
  placeholder: 'Select a fruit...',
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `options` | `List<ComboboxOption<T>>` | required | Available options |
| `value` | `T?` | - | Currently selected value |
| `onChanged` | `Function(T?)?` | - | Called when selection changes |
| `placeholder` | `String?` | - | Placeholder text |
| `searchPlaceholder` | `String?` | - | Search input placeholder |
| `searchable` | `bool` | `true` | Show search input |
| `displayValue` | `Function(T)?` | - | Custom display function |
| `filterFn` | `Function?` | - | Custom filter function |
| `emptyMessage` | `String` | `'No results found'` | Empty state message |
| `disabled` | `bool` | `false` | Disable combobox |
| `error` | `String?` | - | Error message |
| `label` | `String?` | - | Label above combobox |
| `size` | `ComboboxSize` | `md` | Size variant |

## ComboboxOption

```dart
ComboboxOption(
  value: 'apple',
  label: 'Apple',
  description: 'A red fruit',
  icon: ArcaneIcon.fruit,
  disabled: false,
  keywords: ['red', 'fruit'],
)
```

## With Descriptions

```dart
ArcaneCombobox<String>(
  options: [
    ComboboxOption(
      value: 'npm',
      label: 'npm',
      description: 'Node Package Manager',
    ),
    ComboboxOption(
      value: 'yarn',
      label: 'Yarn',
      description: 'Fast, reliable dependency management',
    ),
  ],
  value: selectedPm,
  onChanged: (pm) => setState(() => selectedPm = pm),
)
```

## Custom Filtering

```dart
ArcaneCombobox<User>(
  options: users.map((u) => ComboboxOption(
    value: u,
    label: u.name,
    keywords: [u.email, u.department],
  )).toList(),
  filterFn: (option, query) {
    return option.label.toLowerCase().contains(query.toLowerCase()) ||
           option.keywords?.any((k) => k.contains(query)) ?? false;
  },
  onChanged: (user) => selectUser(user),
)
```

## Features

- Type-ahead search filtering
- Keyboard navigation (arrow keys, enter, escape)
- Option descriptions and icons
- Custom filter functions
- Empty state message
