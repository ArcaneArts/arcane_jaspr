import 'package:arcane_jaspr/core/props/data_table_props.dart';
import 'package:arcane_jaspr/core/rendering/base/data_table_render_base.dart';

/// Neon DataTable renderer.
class NeonDataTable<T> extends DataTableRenderBase<T> {
  const NeonDataTable(super.props, {super.key});

  @override
  String get classPrefix => 'neon';

  @override
  String get emptyPadding => '60px 30px';

  @override
  Map<String, String> get containerStyles => const <String, String>{
    'overflow-x': 'auto',
    'border': '1px solid var(--neon-panel-border)',
    'clip-path': 'var(--neon-clip-md)',
    'background': 'var(--neon-panel-surface)',
    'box-shadow': 'var(--neon-shadow-md), inset 0 1px 0 var(--neon-inset)',
  };

  @override
  Map<String, String> get tableStyles => const <String, String>{
    'width': '100%',
    'border-collapse': 'collapse',
    'font-size': 'var(--font-size-sm)',
    'font-variant-numeric': 'tabular-nums',
  };

  @override
  Map<String, String> theadBaseStyles() => const <String, String>{
    'background': 'var(--neon-panel-tint)',
    'border-bottom': '1px solid var(--neon-control-border-strong)',
  };

  @override
  String get cellPadding => '14px 20px';

  @override
  String get selectAllWidth => '56px';

  @override
  Map<String, String>? get checkboxStyles => const <String, String>{
    'accent-color': 'var(--neon-accent)',
  };

  @override
  Map<String, String> headerCellStyles(DataColumnProps<T> column) =>
      <String, String>{
        'padding': '14px 20px',
        'text-align': column.align.css,
        'font-family': 'var(--font-heading)',
        'font-size': 'var(--font-size-xs)',
        'font-weight': 'var(--font-weight-semibold)',
        'letter-spacing': '0.12em',
        'text-transform': 'uppercase',
        'color': 'var(--muted-foreground)',
        'white-space': 'nowrap',
        if (column.width != null) 'width': '${column.width}px',
      };

  @override
  Map<String, String> rowStyles(bool isSelected, bool isClickable) =>
      <String, String>{
        'background': isSelected
            ? 'color-mix(in srgb, var(--neon-accent) 12%, transparent)'
            : 'transparent',
        if (props.showDividers)
          'border-bottom':
              '1px solid color-mix(in srgb, var(--neon-panel-border) 60%, transparent)',
        if (isClickable) 'cursor': 'pointer',
        'transition': 'background-color 140ms ease',
      };

  @override
  Map<String, String>? get bodyStyles => null;
}
