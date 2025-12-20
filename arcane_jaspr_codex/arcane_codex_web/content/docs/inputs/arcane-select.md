---
title: ArcaneSelect
description: Dropdown select component for choosing from options
layout: docs
---

# ArcaneSelect

A styled dropdown select component for choosing from a list of options.

## Basic Usage

```dart
ArcaneSelect<String>(
  value: selectedValue,
  options: [
    ArcaneSelectOption(value: 'option1', label: 'Option 1'),
    ArcaneSelectOption(value: 'option2', label: 'Option 2'),
    ArcaneSelectOption(value: 'option3', label: 'Option 3'),
  ],
  onChanged: (value) {
    setState(() => selectedValue = value);
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `T?` | `null` | Currently selected value |
| `options` | `List<ArcaneSelectOption<T>>` | required | Available options |
| `onChanged` | `ValueChanged<T?>?` | `null` | Selection change handler |
| `label` | `String?` | `null` | Field label |
| `placeholder` | `String?` | `null` | Placeholder when no selection |
| `isDisabled` | `bool` | `false` | Disable the select |
| `isRequired` | `bool` | `false` | Mark as required |
| `error` | `String?` | `null` | Error message |
| `hint` | `String?` | `null` | Hint text below select |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## ArcaneSelectOption

Each option requires a value and label:

```dart
ArcaneSelectOption<String>(
  value: 'us',
  label: 'United States',
  isDisabled: false,  // Optional: disable specific option
)
```

## With Label and Placeholder

```dart
ArcaneSelect<String>(
  label: 'Country',
  placeholder: 'Select a country...',
  value: selectedCountry,
  options: [
    ArcaneSelectOption(value: 'us', label: 'United States'),
    ArcaneSelectOption(value: 'uk', label: 'United Kingdom'),
    ArcaneSelectOption(value: 'ca', label: 'Canada'),
    ArcaneSelectOption(value: 'au', label: 'Australia'),
  ],
  onChanged: (value) => setState(() => selectedCountry = value),
)
```

## With Hint

```dart
ArcaneSelect<String>(
  label: 'Plan',
  value: selectedPlan,
  hint: 'Choose the plan that best fits your needs',
  options: [
    ArcaneSelectOption(value: 'free', label: 'Free'),
    ArcaneSelectOption(value: 'pro', label: 'Pro - \$9/month'),
    ArcaneSelectOption(value: 'team', label: 'Team - \$29/month'),
  ],
  onChanged: (value) => setState(() => selectedPlan = value),
)
```

## Error State

```dart
ArcaneSelect<String>(
  label: 'Category',
  value: null,
  error: 'Please select a category',
  isRequired: true,
  options: categories,
  onChanged: (value) => setState(() => selectedCategory = value),
)
```

## Disabled Options

```dart
ArcaneSelect<String>(
  label: 'Plan',
  value: selectedPlan,
  options: [
    ArcaneSelectOption(value: 'free', label: 'Free'),
    ArcaneSelectOption(value: 'pro', label: 'Pro'),
    ArcaneSelectOption(
      value: 'enterprise',
      label: 'Enterprise (Contact Sales)',
      isDisabled: true,
    ),
  ],
  onChanged: (value) => setState(() => selectedPlan = value),
)
```

## Disabled State

```dart
ArcaneSelect<String>(
  label: 'Region',
  value: 'us-east',
  isDisabled: true,
  options: regions,
  onChanged: null,
)
```

## Examples

### Form with Multiple Selects

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    gap: Gap.lg,
  ),
  children: [
    ArcaneSelect<String>(
      label: 'Country',
      value: country,
      placeholder: 'Select country',
      options: countries,
      onChanged: (v) => setState(() {
        country = v;
        state = null; // Reset state when country changes
      }),
    ),
    ArcaneSelect<String>(
      label: 'State/Province',
      value: state,
      placeholder: 'Select state',
      isDisabled: country == null,
      options: getStatesForCountry(country),
      onChanged: (v) => setState(() => state = v),
    ),
  ],
)
```

### Filter Select

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    gap: Gap.md,
    alignItems: AlignItems.flexEnd,
  ),
  children: [
    ArcaneSelect<String>(
      label: 'Status',
      value: statusFilter,
      options: [
        ArcaneSelectOption(value: null, label: 'All'),
        ArcaneSelectOption(value: 'active', label: 'Active'),
        ArcaneSelectOption(value: 'pending', label: 'Pending'),
        ArcaneSelectOption(value: 'completed', label: 'Completed'),
      ],
      onChanged: (v) => setState(() => statusFilter = v),
    ),
    ArcaneSelect<String>(
      label: 'Sort By',
      value: sortBy,
      options: [
        ArcaneSelectOption(value: 'newest', label: 'Newest First'),
        ArcaneSelectOption(value: 'oldest', label: 'Oldest First'),
        ArcaneSelectOption(value: 'name', label: 'Name A-Z'),
      ],
      onChanged: (v) => setState(() => sortBy = v),
    ),
  ],
)
```

### Enum-Based Select

```dart
enum Priority { low, medium, high, urgent }

ArcaneSelect<Priority>(
  label: 'Priority',
  value: priority,
  options: Priority.values.map((p) => ArcaneSelectOption(
    value: p,
    label: p.name.toUpperCase(),
  )).toList(),
  onChanged: (v) => setState(() => priority = v),
)
```

## Related Components

- [ArcaneSelector](/docs/inputs/arcane-selector) - Custom selector component
- [ArcaneRadio](/docs/inputs/arcane-radio) - Radio button selection
- [ArcaneCycleButton](/docs/inputs/arcane-cycle-button) - Cycle through options
