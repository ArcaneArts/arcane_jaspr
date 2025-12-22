---
title: ArcaneTreeView
description: Hierarchical tree structure display
layout: docs
component: tree-view
---

# ArcaneTreeView

A tree view component for displaying hierarchical data with expand/collapse functionality.

## Basic Usage

```dart
ArcaneTreeView(
  nodes: [
    TreeNode(
      id: 'src',
      label: 'src',
      children: [
        TreeNode(id: 'main', label: 'main.dart'),
        TreeNode(id: 'app', label: 'app.dart'),
      ],
    ),
    TreeNode(id: 'pubspec', label: 'pubspec.yaml'),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `nodes` | `List<TreeNode>` | required | Tree nodes |
| `style` | `TreeViewStyle` | `lines` | Visual style |
| `selectionMode` | `TreeSelectionMode` | `none` | Selection behavior |
| `selectedIds` | `Set<String>` | `{}` | Selected node IDs |
| `expandedIds` | `Set<String>` | `{}` | Expanded node IDs |
| `onSelectionChanged` | `ValueChanged<Set<String>>?` | `null` | Selection callback |
| `onExpansionChanged` | `ValueChanged<Set<String>>?` | `null` | Expansion callback |
| `onNodeTap` | `ValueChanged<TreeNode>?` | `null` | Node tap callback |

## TreeNode Properties

| Property | Type | Description |
|----------|------|-------------|
| `id` | `String` | Unique identifier |
| `label` | `String` | Display label |
| `icon` | `Component?` | Node icon |
| `children` | `List<TreeNode>` | Child nodes |
| `isExpanded` | `bool` | Initial expansion state |
| `isDisabled` | `bool` | Disable node |

## Style Variants

```dart
// Lines (default)
ArcaneTreeView(
  nodes: nodes,
  style: TreeViewStyle.lines,
)

// Clean
ArcaneTreeView(
  nodes: nodes,
  style: TreeViewStyle.clean,
)

// Compact
ArcaneTreeView(
  nodes: nodes,
  style: TreeViewStyle.compact,
)
```

## Selection Modes

```dart
// No selection (default)
ArcaneTreeView(
  nodes: nodes,
  selectionMode: TreeSelectionMode.none,
)

// Single selection
ArcaneTreeView(
  nodes: nodes,
  selectionMode: TreeSelectionMode.single,
  selectedIds: {selectedId},
  onSelectionChanged: (ids) => setState(() => selectedId = ids.first),
)

// Multiple selection
ArcaneTreeView(
  nodes: nodes,
  selectionMode: TreeSelectionMode.multiple,
  selectedIds: selectedIds,
  onSelectionChanged: (ids) => setState(() => selectedIds = ids),
)
```

## With Icons

```dart
ArcaneTreeView(
  nodes: [
    TreeNode(
      id: 'src',
      label: 'src',
      icon: ArcaneIcon.folder(),
      children: [
        TreeNode(
          id: 'main.dart',
          label: 'main.dart',
          icon: ArcaneIcon.file(),
        ),
      ],
    ),
  ],
)
```

## Examples

### File Explorer

```dart
ArcaneTreeView(
  nodes: [
    TreeNode(
      id: 'project',
      label: 'my_project',
      icon: ArcaneIcon.folder(),
      children: [
        TreeNode(
          id: 'lib',
          label: 'lib',
          icon: ArcaneIcon.folder(),
          children: [
            TreeNode(id: 'main', label: 'main.dart', icon: ArcaneIcon.file()),
            TreeNode(id: 'app', label: 'app.dart', icon: ArcaneIcon.file()),
          ],
        ),
        TreeNode(id: 'pubspec', label: 'pubspec.yaml', icon: ArcaneIcon.file()),
        TreeNode(id: 'readme', label: 'README.md', icon: ArcaneIcon.file()),
      ],
    ),
  ],
  style: TreeViewStyle.lines,
  selectionMode: TreeSelectionMode.single,
  onNodeTap: (node) => openFile(node.id),
)
```

### Category Browser

```dart
ArcaneTreeView(
  nodes: [
    TreeNode(
      id: 'electronics',
      label: 'Electronics',
      children: [
        TreeNode(
          id: 'phones',
          label: 'Phones',
          children: [
            TreeNode(id: 'iphone', label: 'iPhone'),
            TreeNode(id: 'android', label: 'Android'),
          ],
        ),
        TreeNode(id: 'laptops', label: 'Laptops'),
      ],
    ),
    TreeNode(
      id: 'clothing',
      label: 'Clothing',
      children: [
        TreeNode(id: 'mens', label: "Men's"),
        TreeNode(id: 'womens', label: "Women's"),
      ],
    ),
  ],
  selectionMode: TreeSelectionMode.single,
  onSelectionChanged: (ids) => filterByCategory(ids.first),
)
```

## Related Components

- [ArcaneAccordion](/arcane_jaspr/docs/view/arcane-accordion) - Collapsible sections
- [ArcaneSidebar](/arcane_jaspr/docs/navigation/arcane-sidebar) - Sidebar navigation
