import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Tree node data
class TreeNode {
  /// Unique identifier
  final String id;

  /// Display label
  final String label;

  /// Optional icon
  final Component? icon;

  /// Child nodes
  final List<TreeNode> children;

  /// Whether node is disabled
  final bool disabled;

  /// Custom data attached to the node
  final dynamic data;

  const TreeNode({
    required this.id,
    required this.label,
    this.icon,
    this.children = const [],
    this.disabled = false,
    this.data,
  });

  bool get hasChildren => children.isNotEmpty;
}

/// Tree view style variants
enum TreeViewStyle {
  /// Default tree style with lines
  lines,

  /// Clean style without lines
  clean,

  /// Compact style
  compact,
}

/// Tree view selection mode
enum TreeSelectionMode {
  /// No selection
  none,

  /// Single node selection
  single,

  /// Multiple node selection
  multiple,
}

/// Hierarchical tree view component
///
/// Displays hierarchical data in a collapsible tree structure.
///
/// ```dart
/// ArcaneTreeView(
///   nodes: [
///     TreeNode(
///       id: 'src',
///       label: 'src',
///       icon: Text('📁'),
///       children: [
///         TreeNode(id: 'main', label: 'main.dart', icon: Text('📄')),
///       ],
///     ),
///   ],
///   onNodeSelect: (node) => print('Selected: ${node.label}'),
/// )
/// ```
class ArcaneTreeView extends StatefulComponent {
  /// Tree nodes
  final List<TreeNode> nodes;

  /// Callback when a node is selected
  final void Function(TreeNode node)? onNodeSelect;

  /// Callback when a node is expanded/collapsed
  final void Function(TreeNode node, bool expanded)? onNodeToggle;

  /// Style variant
  final TreeViewStyle style;

  /// Selection mode
  final TreeSelectionMode selectionMode;

  /// Initially expanded node IDs
  final Set<String> initiallyExpanded;

  /// Selected node IDs
  final Set<String> selectedNodes;

  /// Whether all nodes are initially expanded
  final bool expandAll;

  const ArcaneTreeView({
    required this.nodes,
    this.onNodeSelect,
    this.onNodeToggle,
    this.style = TreeViewStyle.lines,
    this.selectionMode = TreeSelectionMode.single,
    this.initiallyExpanded = const {},
    this.selectedNodes = const {},
    this.expandAll = false,
    super.key,
  });

  @override
  State<ArcaneTreeView> createState() => _ArcaneTreeViewState();
}

class _ArcaneTreeViewState extends State<ArcaneTreeView> {
  late Set<String> _expandedNodes;
  late Set<String> _selectedNodes;

  @override
  void initState() {
    super.initState();
    _expandedNodes = {...component.initiallyExpanded};
    _selectedNodes = {...component.selectedNodes};

    if (component.expandAll) {
      _expandAllNodes(component.nodes);
    }
  }

  void _expandAllNodes(List<TreeNode> nodes) {
    for (final node in nodes) {
      if (node.hasChildren) {
        _expandedNodes.add(node.id);
        _expandAllNodes(node.children);
      }
    }
  }

  void _toggleExpand(TreeNode node) {
    setState(() {
      if (_expandedNodes.contains(node.id)) {
        _expandedNodes.remove(node.id);
      } else {
        _expandedNodes.add(node.id);
      }
    });
    component.onNodeToggle?.call(node, _expandedNodes.contains(node.id));
  }

  void _selectNode(TreeNode node) {
    if (node.disabled) return;

    setState(() {
      if (component.selectionMode == TreeSelectionMode.single) {
        _selectedNodes = {node.id};
      } else if (component.selectionMode == TreeSelectionMode.multiple) {
        if (_selectedNodes.contains(node.id)) {
          _selectedNodes.remove(node.id);
        } else {
          _selectedNodes.add(node.id);
        }
      }
    });
    component.onNodeSelect?.call(node);
  }

  @override
  Component build(BuildContext context) {
    return div(
      attributes: {'role': 'tree'},
      styles: const Styles(raw: {
        'font-size': ArcaneTypography.fontSm,
      }),
      [
        for (final node in component.nodes)
          _buildNode(node, 0),
      ],
    );
  }

  Component _buildNode(TreeNode node, int level) {
    final isExpanded = _expandedNodes.contains(node.id);
    final isSelected = _selectedNodes.contains(node.id);
    final indent = 20 * level;

    final showLines = component.style == TreeViewStyle.lines;
    final isCompact = component.style == TreeViewStyle.compact;

    return div(
      styles: const Styles(raw: {}),
      [
        // Node row
        div(
          attributes: {
            'role': 'treeitem',
            if (node.hasChildren) 'aria-expanded': isExpanded ? 'true' : 'false',
            'aria-selected': isSelected ? 'true' : 'false',
          },
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'padding': isCompact ? '4px 8px' : '6px 12px',
            'padding-left': '${indent + 12}px',
            'cursor': node.disabled ? 'not-allowed' : 'pointer',
            'opacity': node.disabled ? '0.5' : '1',
            'background': isSelected ? ArcaneColors.surfaceVariant : 'transparent',
            'border-radius': ArcaneRadius.sm,
            'transition': ArcaneEffects.transitionFast,
            'user-select': 'none',
          }),
          events: {
            'click': (_) {
              if (node.hasChildren) {
                _toggleExpand(node);
              }
              _selectNode(node);
            },
          },
          [
            // Expand/collapse icon
            if (node.hasChildren)
              span(
                styles: Styles(raw: {
                  'display': 'inline-flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': '16px',
                  'height': '16px',
                  'margin-right': ArcaneSpacing.xs,
                  'font-size': '10px',
                  'color': ArcaneColors.muted,
                  'transform': isExpanded ? 'rotate(90deg)' : 'rotate(0deg)',
                  'transition': 'transform 0.2s ease',
                }),
                [text('▶')],
              )
            else if (showLines)
              const span(
                styles: Styles(raw: {
                  'width': '16px',
                  'margin-right': ArcaneSpacing.xs,
                }),
                [],
              ),

            // Node icon
            if (node.icon != null)
              span(
                styles: const Styles(raw: {
                  'margin-right': ArcaneSpacing.xs,
                  'display': 'inline-flex',
                  'align-items': 'center',
                }),
                [node.icon!],
              ),

            // Node label
            span(
              styles: Styles(raw: {
                'color': isSelected ? ArcaneColors.accent : ArcaneColors.onSurface,
                'font-weight': isSelected
                    ? ArcaneTypography.weightMedium
                    : ArcaneTypography.weightNormal,
              }),
              [text(node.label)],
            ),
          ],
        ),

        // Children
        if (node.hasChildren && isExpanded)
          div(
            attributes: {'role': 'group'},
            styles: Styles(raw: {
              if (showLines) 'border-left': '1px solid ${ArcaneColors.border}',
              if (showLines) 'margin-left': '${indent + 20}px',
            }),
            [
              for (final child in node.children)
                _buildNode(child, showLines ? 0 : level + 1),
            ],
          ),
      ],
    );
  }
}