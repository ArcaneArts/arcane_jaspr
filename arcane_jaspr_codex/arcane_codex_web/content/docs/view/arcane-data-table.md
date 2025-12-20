---
title: ArcaneDataTable
description: Full-featured data table with sorting and selection
layout: docs
---

# ArcaneDataTable

A comprehensive data table component with sorting, selection, pagination, and custom cell rendering.

## Basic Usage

```dart
ArcaneDataTable(
  columns: [
    DataColumn(label: 'Name'),
    DataColumn(label: 'Email'),
    DataColumn(label: 'Role'),
  ],
  rows: [
    DataRow(cells: [
      ArcaneText('John Doe'),
      ArcaneText('john@example.com'),
      ArcaneText('Admin'),
    ]),
    DataRow(cells: [
      ArcaneText('Jane Smith'),
      ArcaneText('jane@example.com'),
      ArcaneText('User'),
    ]),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `columns` | `List<DataColumn>` | required | Table columns |
| `rows` | `List<DataRow>` | required | Table rows |
| `sortColumn` | `int?` | `null` | Sorted column index |
| `sortAscending` | `bool` | `true` | Sort direction |
| `onSort` | `Function(int, bool)?` | `null` | Sort handler |
| `selectable` | `bool` | `false` | Enable row selection |
| `selectedRows` | `Set<int>?` | `null` | Selected row indices |
| `onRowSelected` | `Function(int, bool)?` | `null` | Selection handler |
| `emptyState` | `Component?` | `null` | Empty content |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## DataColumn Properties

```dart
DataColumn(
  label: 'Column Name',
  width: '200px',           // Fixed width
  sortable: true,           // Enable sorting
  alignment: Alignment.end, // Cell alignment
)
```

## DataRow Properties

```dart
DataRow(
  cells: [...],
  isSelected: false,
  onPressed: () {},  // Row click handler
)
```

## Sortable Table

```dart
ArcaneDataTable(
  columns: [
    DataColumn(label: 'Name', sortable: true),
    DataColumn(label: 'Date', sortable: true),
    DataColumn(label: 'Amount', sortable: true),
  ],
  rows: rows,
  sortColumn: currentSortColumn,
  sortAscending: sortAscending,
  onSort: (columnIndex, ascending) {
    setState(() {
      currentSortColumn = columnIndex;
      sortAscending = ascending;
      sortData();
    });
  },
)
```

## Selectable Rows

```dart
ArcaneDataTable(
  columns: columns,
  rows: rows,
  selectable: true,
  selectedRows: selectedRowIndices,
  onRowSelected: (index, selected) {
    setState(() {
      if (selected) {
        selectedRowIndices.add(index);
      } else {
        selectedRowIndices.remove(index);
      }
    });
  },
)
```

## Examples

### User Table

```dart
ArcaneDataTable(
  columns: [
    DataColumn(label: 'User', width: '250px'),
    DataColumn(label: 'Email'),
    DataColumn(label: 'Role', width: '120px'),
    DataColumn(label: 'Status', width: '100px'),
    DataColumn(label: 'Actions', width: '100px', alignment: Alignment.end),
  ],
  rows: users.map((user) => DataRow(
    cells: [
      ArcaneRow(
        gap: Gap.sm,
        children: [
          ArcaneAvatar(imageUrl: user.avatar, size: AvatarSize.small),
          ArcaneText(user.name),
        ],
      ),
      ArcaneText(user.email),
      ArcaneBadge(label: user.role),
      ArcaneBadge(
        label: user.status,
        variant: user.isActive ? BadgeVariant.success : BadgeVariant.secondary,
      ),
      ArcaneRow(
        gap: Gap.xs,
        mainAxisAlignment: JustifyContent.end,
        children: [
          ArcaneIconButton(icon: span([text('✏')]), onPressed: () => edit(user)),
          ArcaneIconButton(icon: span([text('🗑')]), onPressed: () => delete(user)),
        ],
      ),
    ],
  )).toList(),
)
```

### Order Table

```dart
ArcaneDataTable(
  columns: [
    DataColumn(label: 'Order', sortable: true),
    DataColumn(label: 'Customer', sortable: true),
    DataColumn(label: 'Date', sortable: true),
    DataColumn(label: 'Total', sortable: true, alignment: Alignment.end),
    DataColumn(label: 'Status'),
  ],
  rows: orders.map((order) => DataRow(
    cells: [
      ArcaneText('#${order.id}'),
      ArcaneText(order.customerName),
      ArcaneText(formatDate(order.date)),
      ArcaneText('\$${order.total.toStringAsFixed(2)}'),
      ArcaneBadge(
        label: order.status,
        variant: getStatusVariant(order.status),
      ),
    ],
  )).toList(),
  sortColumn: sortColumn,
  sortAscending: sortAscending,
  onSort: handleSort,
)
```

### With Pagination

```dart
ArcaneColumn(
  gap: Gap.md,
  children: [
    ArcaneDataTable(
      columns: columns,
      rows: paginatedRows,
    ),
    ArcaneRow(
      mainAxisAlignment: JustifyContent.spaceBetween,
      children: [
        ArcaneText('Showing ${startIndex + 1}-${endIndex} of ${totalRows}'),
        ArcaneRow(
          gap: Gap.sm,
          children: [
            ArcaneButton.ghost(
              label: 'Previous',
              isDisabled: currentPage == 1,
              onPressed: previousPage,
            ),
            for (var page in pageNumbers)
              ArcaneButton(
                label: '$page',
                variant: page == currentPage
                    ? ButtonVariant.primary
                    : ButtonVariant.ghost,
                onPressed: () => goToPage(page),
              ),
            ArcaneButton.ghost(
              label: 'Next',
              isDisabled: currentPage == totalPages,
              onPressed: nextPage,
            ),
          ],
        ),
      ],
    ),
  ],
)
```

### Empty State

```dart
ArcaneDataTable(
  columns: columns,
  rows: [],
  emptyState: ArcaneEmptyState(
    icon: span([text('📋')]),
    title: 'No data',
    description: 'Add items to see them here',
  ),
)
```

### With Actions Header

```dart
ArcaneCard(
  child: ArcaneColumn(
    children: [
      ArcaneRow(
        mainAxisAlignment: JustifyContent.spaceBetween,
        styles: const ArcaneStyleData(
          padding: PaddingPreset.md,
        ),
        children: [
          ArcaneHeading(text: 'Users'),
          ArcaneRow(
            gap: Gap.sm,
            children: [
              ArcaneSearch(placeholder: 'Search users...', onSearch: search),
              ArcaneButton.primary(label: 'Add User', onPressed: addUser),
            ],
          ),
        ],
      ),
      ArcaneDataTable(
        columns: columns,
        rows: filteredRows,
      ),
    ],
  ),
)
```

## Related Components

- [ArcaneStaticTable](/docs/view/arcane-static-table) - Simple table
- [ArcaneKeyValueTable](/docs/view/arcane-key-value-table) - Key-value pairs
- [ArcaneEmptyState](/docs/view/arcane-empty-state) - Empty placeholder
