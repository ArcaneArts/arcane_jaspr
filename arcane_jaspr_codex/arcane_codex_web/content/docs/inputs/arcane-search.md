---
title: ArcaneSearch
description: Specialized search input with clear functionality
layout: docs
component: search
---

# ArcaneSearch

A specialized search input with built-in search icon, clear button, and search-specific behavior.

## Basic Usage

```dart
ArcaneSearch(
  placeholder: 'Search...',
  onChanged: (value) {
    setState(() => searchQuery = value);
  },
  onSubmit: (value) {
    performSearch(value);
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `String?` | `null` | Current search value |
| `placeholder` | `String?` | `'Search...'` | Placeholder text |
| `onChanged` | `ValueChanged<String>?` | `null` | Value change handler |
| `onSubmit` | `ValueChanged<String>?` | `null` | Submit handler (Enter) |
| `onClear` | `VoidCallback?` | `null` | Clear button handler |
| `isLoading` | `bool` | `false` | Show loading indicator |
| `autofocus` | `bool` | `false` | Auto-focus on mount |
| `size` | `SearchSize` | `medium` | Input size |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## Sizes

```dart
// Small
ArcaneSearch(
  size: SearchSize.small,
  placeholder: 'Search...',
  onChanged: (v) {},
)

// Medium (default)
ArcaneSearch(
  size: SearchSize.medium,
  placeholder: 'Search...',
  onChanged: (v) {},
)

// Large
ArcaneSearch(
  size: SearchSize.large,
  placeholder: 'Search...',
  onChanged: (v) {},
)
```

## Loading State

Show a loading indicator during search:

```dart
ArcaneSearch(
  value: query,
  isLoading: isSearching,
  onChanged: (v) {
    setState(() => query = v);
    debounceSearch(v);
  },
)
```

## Clear Functionality

```dart
ArcaneSearch(
  value: query,
  onChanged: (v) => setState(() => query = v),
  onClear: () {
    setState(() => query = '');
    clearResults();
  },
)
```

## Examples

### Header Search

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    alignItems: AlignItems.center,
    gap: Gap.lg,
  ),
  children: [
    ArcaneText('Logo'),
    ArcaneSearch(
      value: searchQuery,
      placeholder: 'Search products...',
      styles: const ArcaneStyleData(
        widthCustom: '300px',
      ),
      onChanged: (v) => setState(() => searchQuery = v),
      onSubmit: (v) => navigateToSearch(v),
    ),
    // Other nav items...
  ],
)
```

### Search with Results

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    gap: Gap.md,
  ),
  children: [
    ArcaneSearch(
      value: query,
      isLoading: isSearching,
      autofocus: true,
      onChanged: (v) {
        setState(() => query = v);
        if (v.length >= 2) {
          searchDebounced(v);
        }
      },
      onClear: () {
        setState(() {
          query = '';
          results = [];
        });
      },
    ),

    // Results
    if (results.isNotEmpty)
      ArcaneDiv(
        styles: const ArcaneStyleData(
          background: Background.surface,
          borderRadius: Radius.lg,
          border: BorderPreset.subtle,
        ),
        children: [
          for (final result in results)
            _buildResultItem(result),
        ],
      ),
  ],
)
```

### Filter Bar with Search

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    gap: Gap.md,
    alignItems: AlignItems.center,
    padding: PaddingPreset.md,
    background: Background.surface,
    borderRadius: Radius.lg,
  ),
  children: [
    ArcaneSearch(
      value: search,
      placeholder: 'Filter items...',
      size: SearchSize.small,
      onChanged: (v) => setState(() => search = v),
      styles: const ArcaneStyleData(flexGrow: 1),
    ),
    ArcaneSelect<String>(
      value: category,
      placeholder: 'Category',
      options: categoryOptions,
      onChanged: (v) => setState(() => category = v),
    ),
    ArcaneSelect<String>(
      value: sortBy,
      placeholder: 'Sort',
      options: sortOptions,
      onChanged: (v) => setState(() => sortBy = v),
    ),
  ],
)
```

### Command Palette Style

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    maxWidth: MaxWidth.form,
    margin: MarginPreset.autoX,
  ),
  children: [
    ArcaneSearch(
      value: command,
      placeholder: 'Type a command or search...',
      size: SearchSize.large,
      autofocus: true,
      onChanged: (v) => filterCommands(v),
      onSubmit: (v) => executeCommand(v),
    ),
    if (filteredCommands.isNotEmpty)
      ArcaneDiv(
        styles: const ArcaneStyleData(
          margin: MarginPreset.topSm,
          background: Background.card,
          borderRadius: Radius.lg,
          border: BorderPreset.subtle,
          overflow: Overflow.hidden,
        ),
        children: [
          for (final cmd in filteredCommands)
            _buildCommandItem(cmd),
        ],
      ),
  ],
)
```

## Related Components

- [ArcaneTextInput](/arcane_jaspr/docs/inputs/arcane-text-input) - General text input
- [ArcaneSelect](/arcane_jaspr/docs/inputs/arcane-select) - Dropdown selection
