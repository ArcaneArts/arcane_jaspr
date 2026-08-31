import 'package:arcane_jaspr/flutter.dart';

enum DataTableTextAlign {
  left,
  center,
  right;

  String get css => switch (this) {
    DataTableTextAlign.left => 'left',
    DataTableTextAlign.center => 'center',
    DataTableTextAlign.right => 'right',
  };
}

/// Data column definition.
class DataColumnProps<T> {
  final String header;
  final Widget Function(T item) builder;
  final DataTableTextAlign align;
  final double? width;
  final bool sortable;

  const DataColumnProps({
    required this.header,
    required this.builder,
    this.align = DataTableTextAlign.left,
    this.width,
    this.sortable = false,
  });
}

/// Data table component properties.
class DataTableProps<T> {
  final List<T> items;
  final List<DataColumnProps<T>> columns;
  final void Function(T item)? onRowTap;
  final bool selectable;
  final Set<T> selectedItems;
  final bool showDividers;
  final bool showHeader;
  final bool stickyHeader;
  final String emptyMessage;
  final void Function(T item)? onToggleSelection;
  final void Function()? onToggleSelectAll;

  const DataTableProps({
    required this.items,
    required this.columns,
    this.onRowTap,
    this.selectable = false,
    this.selectedItems = const {},
    this.showDividers = true,
    this.showHeader = true,
    this.stickyHeader = false,
    this.emptyMessage = 'No data available',
    this.onToggleSelection,
    this.onToggleSelectAll,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for data table components.
mixin DataTableRendererContract {
  Widget dataTable<T>(DataTableProps<T> props);
}
