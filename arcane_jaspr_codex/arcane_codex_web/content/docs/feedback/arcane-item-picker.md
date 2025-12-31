---
title: ArcaneItemPicker
description: Dialog for selecting from a list of items
layout: docs
component: item-picker
---

# ArcaneItemPicker

A dialog component for selecting an item from a list of options.

## Basic Usage

```dart
ArcaneItemPicker<String>(
  isOpen: showPicker,
  items: ['Small', 'Medium', 'Large'],
  onClose: () => setState(() => showPicker = false),
  onSelect: (item) {
    setState(() {
      selectedSize = item;
      showPicker = false;
    });
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `isOpen` | `bool` | required | Whether dialog is visible |
| `items` | `List<T>` | required | Items to select from |
| `onClose` | `VoidCallback?` | `null` | Close handler |
| `onSelect` | `ValueChanged<T>` | required | Selection handler |
| `title` | `String` | `'Select Item'` | Dialog title |
| `selectedItem` | `T?` | `null` | Currently selected item |
| `itemBuilder` | `Widget Function(T)?` | `null` | Custom item builder |
| `searchable` | `bool` | `false` | Enable search filter |

## With Selected Item

```dart
ArcaneItemPicker<String>(
  isOpen: showPicker,
  items: sizes,
  selectedItem: currentSize,
  title: 'Select Size',
  onClose: () => close(),
  onSelect: (size) => selectSize(size),
)
```

## Searchable List

```dart
ArcaneItemPicker<Country>(
  isOpen: showCountryPicker,
  items: countries,
  searchable: true,
  title: 'Select Country',
  itemBuilder: (country) => ArcaneRow(
    gapSize: Gap.sm,
    children: [
      ArcaneText(country.flag),
      ArcaneText(country.name),
    ],
  ),
  onClose: () => close(),
  onSelect: (country) => selectCountry(country),
)
```

## Custom Item Builder

```dart
ArcaneItemPicker<User>(
  isOpen: showUserPicker,
  items: users,
  title: 'Assign To',
  itemBuilder: (user) => ArcaneRow(
    gapSize: Gap.md,
    children: [
      ArcaneAvatar(
        imageUrl: user.avatarUrl,
        initials: user.initials,
        size: 32,
      ),
      ArcaneColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ArcaneText(user.name),
          ArcaneText(user.email, size: FontSize.sm, color: TextColor.muted),
        ],
      ),
    ],
  ),
  onClose: () => close(),
  onSelect: (user) => assignTo(user),
)
```

## Examples

### Category Selection

```dart
ArcaneButton.secondary(
  label: 'Select Category',
  onPressed: () => setState(() => showCategoryPicker = true),
),
ArcaneItemPicker<String>(
  isOpen: showCategoryPicker,
  items: ['Technology', 'Design', 'Business', 'Lifestyle'],
  selectedItem: selectedCategory,
  title: 'Select Category',
  onClose: () => setState(() => showCategoryPicker = false),
  onSelect: (category) {
    setState(() {
      selectedCategory = category;
      showCategoryPicker = false;
    });
  },
)
```

### Priority Picker

```dart
ArcaneItemPicker<Priority>(
  isOpen: showPriorityPicker,
  items: Priority.values,
  selectedItem: taskPriority,
  title: 'Set Priority',
  itemBuilder: (priority) => ArcaneRow(
    gapSize: Gap.sm,
    children: [
      ArcaneDiv(
        styles: ArcaneStyleData(
          widthCustom: '12px',
          heightCustom: '12px',
          borderRadius: Radius.full,
          background: priority.color,
        ),
        children: [],
      ),
      ArcaneText(priority.label),
    ],
  ),
  onClose: () => close(),
  onSelect: (priority) => setPriority(priority),
)
```

## Related Components

- [ArcaneSelector](/arcane_jaspr/docs/inputs/arcane-selector) - Inline selector dropdown
- [ArcaneDialog](/arcane_jaspr/docs/feedback/arcane-dialog) - Generic dialog
- [ArcaneSelect](/arcane_jaspr/docs/inputs/arcane-select) - Native select input
