---
title: ArcanePagination
description: Page navigation controls
layout: docs
component: pagination
---

# ArcanePagination

A pagination component for navigating through pages of content.

## Basic Usage

```dart
ArcanePagination(
  currentPage: 1,
  totalPages: 10,
  onPageChange: (page) {
    setState(() => currentPage = page);
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `currentPage` | `int` | required | Current page (1-indexed) |
| `totalPages` | `int` | required | Total number of pages |
| `onPageChange` | `void Function(int)?` | `null` | Page change callback |
| `style` | `PaginationStyle` | `outline` | Visual style |
| `size` | `PaginationSize` | `md` | Size variant |
| `siblingCount` | `int` | `1` | Pages shown around current |
| `showFirstLast` | `bool` | `true` | Show first/last buttons |
| `showPrevNext` | `bool` | `true` | Show prev/next buttons |

## Style Variants

```dart
// Outline (default)
ArcanePagination(
  currentPage: currentPage,
  totalPages: 10,
  style: PaginationStyle.outline,
  onPageChange: onPageChange,
)

// Filled
ArcanePagination(
  currentPage: currentPage,
  totalPages: 10,
  style: PaginationStyle.filled,
  onPageChange: onPageChange,
)

// Ghost
ArcanePagination(
  currentPage: currentPage,
  totalPages: 10,
  style: PaginationStyle.ghost,
  onPageChange: onPageChange,
)

// Simple (prev/next only)
ArcanePagination(
  currentPage: currentPage,
  totalPages: 10,
  style: PaginationStyle.simple,
  onPageChange: onPageChange,
)
```

## Sizes

```dart
// Small
ArcanePagination(
  currentPage: currentPage,
  totalPages: 10,
  size: PaginationSize.sm,
  onPageChange: onPageChange,
)

// Medium (default)
ArcanePagination(
  currentPage: currentPage,
  totalPages: 10,
  size: PaginationSize.md,
  onPageChange: onPageChange,
)

// Large
ArcanePagination(
  currentPage: currentPage,
  totalPages: 10,
  size: PaginationSize.lg,
  onPageChange: onPageChange,
)
```

## Sibling Count

```dart
// Show more pages around current
ArcanePagination(
  currentPage: 5,
  totalPages: 20,
  siblingCount: 2, // Shows 3,4,5,6,7
  onPageChange: onPageChange,
)
```

## Without First/Last

```dart
ArcanePagination(
  currentPage: currentPage,
  totalPages: 10,
  showFirstLast: false,
  onPageChange: onPageChange,
)
```

## Without Prev/Next

```dart
ArcanePagination(
  currentPage: currentPage,
  totalPages: 10,
  showPrevNext: false,
  onPageChange: onPageChange,
)
```

## Examples

### Table Pagination

```dart
ArcaneColumn(
  gapSize: Gap.md,
  children: [
    ArcaneDataTable(
      columns: columns,
      rows: paginatedRows,
    ),
    ArcaneRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ArcaneText(
          'Showing ${startIndex + 1}-${endIndex} of $totalItems',
          color: TextColor.muted,
        ),
        ArcanePagination(
          currentPage: currentPage,
          totalPages: totalPages,
          onPageChange: (page) {
            setState(() => currentPage = page);
            fetchPage(page);
          },
        ),
      ],
    ),
  ],
)
```

### Simple Navigation

```dart
ArcanePagination(
  currentPage: articlePage,
  totalPages: articleCount,
  style: PaginationStyle.simple,
  onPageChange: (page) => navigateToArticle(page),
)
```

### Gallery Pagination

```dart
ArcaneRow(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    ArcanePagination(
      currentPage: imageIndex,
      totalPages: images.length,
      style: PaginationStyle.ghost,
      showFirstLast: false,
      onPageChange: (page) => setState(() => imageIndex = page),
    ),
  ],
)
```

## Related Components

- [ArcaneBreadcrumbs](/arcane_jaspr/docs/navigation/arcane-breadcrumbs) - Breadcrumb navigation
- [ArcaneDataTable](/arcane_jaspr/docs/view/arcane-data-table) - Data table
