---
title: ArcaneSelector
description: Flexible dropdown selector with multi-select, search, and rich options
layout: docs
component: selector
---

# ArcaneSelector

A highly customizable dropdown selector with support for single/multi-select, search, loading states, and rich option rendering.

## Basic Usage

```dart
ArcaneSelector<String>(
  label: 'Country',
  value: selectedCountry,
  options: [
    ArcaneSelectorOption(value: 'us', label: 'United States'),
    ArcaneSelectorOption(value: 'uk', label: 'United Kingdom'),
    ArcaneSelectorOption(value: 'ca', label: 'Canada'),
  ],
  onChanged: (value) => setState(() => selectedCountry = value),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `options` | `List<ArcaneSelectorOption<T>>` | required | Available options |
| `value` | `T?` | `null` | Selected value (single select) |
| `values` | `List<T>?` | `null` | Selected values (multi-select) |
| `onChanged` | `Function(T)?` | `null` | Selection callback (single) |
| `onMultiChanged` | `Function(List<T>)?` | `null` | Selection callback (multi) |
| `placeholder` | `String` | `'Select...'` | Placeholder text |
| `disabled` | `bool` | `false` | Disable interaction |
| `clearable` | `bool` | `false` | Allow clearing selection |
| `searchable` | `bool` | `false` | Enable search filtering |
| `multiSelect` | `bool` | `false` | Enable multi-selection |
| `label` | `String?` | `null` | Field label |
| `helperText` | `String?` | `null` | Helper text below selector |
| `error` | `String?` | `null` | Error message |
| `size` | `SelectorSize` | `md` | Size variant (sm, md, lg) |
| `required` | `bool` | `false` | Show required indicator |
| `loading` | `bool` | `false` | Show loading state |
| `maxDropdownHeight` | `String?` | `'300px'` | Max dropdown height |
| `maxSelections` | `int?` | `null` | Limit for multi-select |
| `dropdownDirection` | `DropdownDirection` | `down` | Dropdown opens up/down |
| `prefix` | `Component?` | `null` | Prefix icon/component |
| `showCheckboxes` | `bool` | `true` | Show checkboxes in multi-select |
| `showSelectedCount` | `bool` | `true` | Show count badge in multi-select |
| `closeOnSelect` | `bool` | `true` | Close after selection |

## Size Variants

```dart
// Small
ArcaneSelector<String>(
  size: SelectorSize.sm,
  options: [...],
)

// Medium (default)
ArcaneSelector<String>(
  size: SelectorSize.md,
  options: [...],
)

// Large
ArcaneSelector<String>(
  size: SelectorSize.lg,
  options: [...],
)
```

## Searchable Selector

Enable search filtering to quickly find options:

```dart
ArcaneSelector<String>(
  label: 'Select a country',
  searchable: true,
  searchPlaceholder: 'Type to search...',
  options: countries.map((c) => ArcaneSelectorOption(
    value: c.code,
    label: c.name,
    searchKeywords: [c.code, c.continent], // Extra search terms
  )).toList(),
  onChanged: (value) => setState(() => selected = value),
)
```

## Multi-Select

Allow users to select multiple options:

```dart
ArcaneSelector<String>(
  label: 'Select skills',
  multiSelect: true,
  values: selectedSkills,
  maxSelections: 5,  // Optional limit
  showCheckboxes: true,
  closeOnSelect: false,  // Keep open for multiple selections
  clearable: true,
  options: [
    ArcaneSelectorOption(value: 'dart', label: 'Dart'),
    ArcaneSelectorOption(value: 'flutter', label: 'Flutter'),
    ArcaneSelectorOption(value: 'react', label: 'React'),
    ArcaneSelectorOption(value: 'nodejs', label: 'Node.js'),
    ArcaneSelectorOption(value: 'python', label: 'Python'),
  ],
  onMultiChanged: (values) => setState(() => selectedSkills = values),
)
```

## Rich Options

Add subtitles, descriptions, and icons to options:

```dart
ArcaneSelector<String>(
  label: 'Select plan',
  value: selectedPlan,
  options: [
    ArcaneSelectorOption(
      value: 'free',
      label: 'Free',
      subtitle: 'Basic features',
      description: '\$0/mo',
    ),
    ArcaneSelectorOption(
      value: 'pro',
      label: 'Professional',
      subtitle: 'Advanced features',
      description: '\$19/mo',
    ),
    ArcaneSelectorOption(
      value: 'enterprise',
      label: 'Enterprise',
      subtitle: 'Custom solutions',
      description: 'Contact us',
      disabled: true,  // Disabled option
    ),
  ],
  onChanged: (v) => setState(() => selectedPlan = v),
)
```

## Loading State

Show a loading spinner while fetching options:

```dart
ArcaneSelector<String>(
  label: 'Select user',
  loading: isLoading,
  loadingText: 'Fetching users...',
  options: users,
  onChanged: (v) => handleSelection(v),
)
```

## With Validation

Show error messages and required indicator:

```dart
ArcaneSelector<String>(
  label: 'Department',
  required: true,
  value: department,
  error: department == null ? 'Please select a department' : null,
  helperText: 'Select your primary department',
  options: [
    ArcaneSelectorOption(value: 'eng', label: 'Engineering'),
    ArcaneSelectorOption(value: 'design', label: 'Design'),
    ArcaneSelectorOption(value: 'marketing', label: 'Marketing'),
  ],
  onChanged: (v) => setState(() => department = v),
)
```

## Dropdown Direction

Control which direction the dropdown opens:

```dart
// Opens upward (useful near bottom of page)
ArcaneSelector<String>(
  dropdownDirection: DropdownDirection.up,
  options: [...],
)

// Opens downward (default)
ArcaneSelector<String>(
  dropdownDirection: DropdownDirection.down,
  options: [...],
)
```

## With Prefix Icon

Add a prefix component before the selected value:

```dart
ArcaneSelector<String>(
  label: 'Currency',
  prefix: ArcaneIcon.dollarSign,
  options: [
    ArcaneSelectorOption(value: 'usd', label: 'US Dollar'),
    ArcaneSelectorOption(value: 'eur', label: 'Euro'),
    ArcaneSelectorOption(value: 'gbp', label: 'British Pound'),
  ],
  onChanged: (v) => setState(() => currency = v),
)
```

## Custom Filter Function

Implement custom search logic:

```dart
ArcaneSelector<User>(
  searchable: true,
  filterFn: (option, query) {
    final user = users.firstWhere((u) => u.id == option.value);
    return user.name.toLowerCase().contains(query.toLowerCase()) ||
           user.email.toLowerCase().contains(query.toLowerCase()) ||
           user.department.toLowerCase().contains(query.toLowerCase());
  },
  options: users.map((u) => ArcaneSelectorOption(
    value: u.id,
    label: u.name,
    subtitle: u.email,
  )).toList(),
  onChanged: (v) => handleSelection(v),
)
```

## ArcaneSelectorOption Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `T` | required | The option value |
| `label` | `String` | required | Display text |
| `subtitle` | `String?` | `null` | Secondary text below label |
| `description` | `String?` | `null` | Text on the right side |
| `icon` | `Component?` | `null` | Icon before label |
| `disabled` | `bool` | `false` | Disable this option |
| `group` | `String?` | `null` | Group name for organization |
| `searchKeywords` | `List<String>?` | `null` | Additional search terms |

## Related Components

- [ArcaneSelect](/arcane_jaspr/docs/inputs/arcane-select) - Native HTML select
- [ArcaneCycleButton](/arcane_jaspr/docs/inputs/arcane-cycle-button) - Cycle through options
- [ArcaneRadio](/arcane_jaspr/docs/inputs/arcane-radio) - Radio button selection
