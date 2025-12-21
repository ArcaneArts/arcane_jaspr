---
title: ArcaneSearchBar
description: Complete search bar with icon and dropdown results
layout: docs
---

# ArcaneSearchBar

A complete search bar component with built-in search icon and dropdown results container. Uses CSS variables for automatic theming.

## Usage

### Static Site (JavaScript Integration)

For static sites, use IDs to allow JavaScript to control search behavior:

```dart
ArcaneSearchBar(
  id: 'docs-search',
  resultsId: 'search-results',
  placeholder: 'Search docs...',
  width: '240px',
)
```

The component renders:
- An input with the specified `id`
- A dropdown container with the specified `resultsId`

Your JavaScript can then hook into these elements to populate results.

### Dynamic Site (Dart Callbacks)

For interactive sites, use callbacks:

```dart
ArcaneSearchBar(
  placeholder: 'Search...',
  onSearch: (query) {
    // Called on every keystroke
    setState(() {
      searchResults = performSearch(query);
    });
  },
  onSubmitted: (query) {
    // Called when Enter is pressed
    navigateToSearchPage(query);
  },
  results: searchResults,
)
```

### With Programmatic Results

```dart
ArcaneSearchBar(
  placeholder: 'Search components...',
  results: [
    ArcaneSearchResult(
      title: 'ArcaneButton',
      subtitle: 'Input Components',
      href: '/docs/inputs/arcane-button',
    ),
    ArcaneSearchResult(
      title: 'ArcaneCard',
      subtitle: 'Layout Components',
      href: '/docs/layout/arcane-card',
    ),
  ],
)
```

## Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `id` | `String?` | `null` | ID for the search input (for JS hooks) |
| `resultsId` | `String?` | `null` | ID for results container (for JS hooks) |
| `placeholder` | `String` | `'Search...'` | Placeholder text |
| `width` | `String` | `'240px'` | Width of the search bar |
| `iconSize` | `IconSize` | `IconSize.md` | Size of the search icon |
| `showDropdown` | `bool` | `true` | Whether to show the dropdown container |
| `dropdownMaxHeight` | `String` | `'300px'` | Max height of dropdown |
| `results` | `List<ArcaneSearchResult>?` | `null` | Search results to display |
| `onSearch` | `Function(String)?` | `null` | Callback when value changes |
| `onSubmitted` | `Function(String)?` | `null` | Callback when Enter is pressed |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## ArcaneSearchResult

```dart
ArcaneSearchResult(
  title: 'Result Title',     // Required
  subtitle: 'Category',      // Optional subtitle/category
  href: '/path/to/page',     // Optional URL (makes it a link)
  onTap: () {},              // Optional callback
)
```

## Theme Integration

The search bar uses CSS variables for automatic theming:

- `var(--arcane-surface)` - Background
- `var(--arcane-outline)` - Border
- `var(--arcane-on-surface)` - Text color
- `var(--arcane-on-surface-variant)` - Placeholder/icon color

No additional styling needed for theme support.

## Styling

Add custom styles via the `styles` prop:

```dart
ArcaneSearchBar(
  placeholder: 'Search...',
  styles: const ArcaneStyleData(
    margin: MarginPreset.rightMd,
  ),
)
```

## Alias

```dart
import 'package:arcane_jaspr/aliases.dart';

ASearchBar(
  placeholder: 'Search...',
)

ASearchResult(
  title: 'Result',
  href: '/path',
)
```

## Example: Full Search Implementation

```dart
class DocsSearch extends StatefulComponent {
  @override
  State<DocsSearch> createState() => _DocsSearchState();
}

class _DocsSearchState extends State<DocsSearch> {
  List<ArcaneSearchResult> _results = [];

  void _handleSearch(String query) {
    if (query.length < 2) {
      setState(() => _results = []);
      return;
    }

    // Filter your search index
    setState(() {
      _results = searchIndex
          .where((item) => item.title.toLowerCase().contains(query.toLowerCase()))
          .map((item) => ArcaneSearchResult(
                title: item.title,
                subtitle: item.category,
                href: item.href,
              ))
          .take(10)
          .toList();
    });
  }

  @override
  Component build(BuildContext context) {
    return ArcaneSearchBar(
      placeholder: 'Search docs...',
      onSearch: _handleSearch,
      results: _results,
    );
  }
}
```
