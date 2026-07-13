import 'package:arcane_jaspr/flutter.dart';

/// Tree node data.
class TreeNodeData {
  final String id;
  final String label;
  final Widget? icon;
  final List<TreeNodeData> children;
  final bool disabled;
  final Object? data;

  const TreeNodeData({
    required this.id,
    required this.label,
    this.icon,
    this.children = const [],
    this.disabled = false,
    this.data,
  });

  bool get hasChildren => children.isNotEmpty;
}

enum TreeViewStyle {
  lines,
  clean,
  compact,
}

enum TreeSelectionMode {
  none,
  single,
  multiple,
}

/// Tree view component properties.
class TreeViewProps {
  final List<TreeNodeData> nodes;
  final void Function(TreeNodeData node)? onNodeSelect;
  final void Function(TreeNodeData node, bool expanded)? onNodeToggle;
  final TreeViewStyle style;
  final TreeSelectionMode selectionMode;
  final Set<String> initiallyExpanded;
  final Set<String> selectedNodes;
  final bool expandAll;

  const TreeViewProps({
    required this.nodes,
    this.onNodeSelect,
    this.onNodeToggle,
    this.style = TreeViewStyle.lines,
    this.selectionMode = TreeSelectionMode.single,
    this.initiallyExpanded = const {},
    this.selectedNodes = const {},
    this.expandAll = false,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for tree view components.
mixin TreeViewRendererContract {
  Widget treeView(TreeViewProps props);
}
