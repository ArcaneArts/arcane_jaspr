import 'package:arcane_jaspr/core/props/data_table_props.dart';
import 'package:arcane_jaspr/core/rendering/base/data_table_render_base.dart';

/// ShadCN DataTable renderer.
///
/// Outputs data table HTML matching the ShadCN/ui design language.
/// Reference: https://ui.shadcn.com/docs/components/data-table
class ShadcnDataTable<T> extends DataTableRenderBase<T> {
  const ShadcnDataTable(super.props, {super.key});

  @override
  String get classPrefix => 'arcane';

  @override
  String get emptyPadding => '48px 24px';

  @override
  Map<String, String> get containerStyles => const <String, String>{
    'overflow-x': 'auto',
    'border': '1px solid var(--border)',
    'border-radius': 'var(--radius-md)',
  };

  @override
  Map<String, String> get tableStyles => const <String, String>{
    'width': '100%',
    'border-collapse': 'collapse',
    'font-size': 'var(--font-size-sm)',
  };

  @override
  Map<String, String> theadBaseStyles() => const <String, String>{
    'background-color': 'var(--muted)',
  };

  @override
  String get cellPadding => '12px 16px';

  @override
  String get selectAllWidth => '48px';

  @override
  Map<String, String>? get checkboxStyles => null;

  @override
  Map<String, String> headerCellStyles(DataColumnProps<T> column) =>
      <String, String>{
        'padding': '12px 16px',
        'text-align': column.align.css,
        'font-weight': 'var(--font-weight-medium)',
        'color': 'var(--muted-foreground)',
        'white-space': 'nowrap',
        if (column.width != null) 'width': '${column.width}px',
      };

  @override
  Map<String, String> rowStyles(bool isSelected, bool isClickable) =>
      <String, String>{
        'background-color': isSelected ? 'var(--muted)' : 'var(--background)',
        if (props.showDividers) 'border-bottom': '1px solid var(--border)',
        if (isClickable) 'cursor': 'pointer',
        'transition': 'background-color var(--transition)',
      };

  @override
  Map<String, String>? get bodyStyles => const <String, String>{};
}
