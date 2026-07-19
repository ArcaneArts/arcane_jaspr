import 'package:arcane_jaspr/core/rendering/base/static_table_render_base.dart';

/// ShadCN Static Table renderer.
class ShadcnStaticTable extends StaticTableRenderBase {
  const ShadcnStaticTable(super.props, {super.key});

  @override
  String get classPrefix => 'arcane';

  @override
  Map<String, String> get containerStyles => const <String, String>{
    'overflow-x': 'auto',
    'border': '1px solid var(--border)',
    'border-radius': 'var(--radius)',
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
  Map<String, String> headerCellStyles(String textAlign) => <String, String>{
    'padding': '1rem 1.5rem',
    'text-align': textAlign,
    'font-weight': 'var(--font-weight-semibold)',
    'color': 'var(--foreground)',
    'white-space': 'nowrap',
  };

  @override
  Map<String, String> rowStyles(int rowIndex) => <String, String>{
    'background-color': props.striped && rowIndex.isOdd
        ? 'var(--muted)'
        : 'var(--card)',
    if (props.showDividers && rowIndex < props.rows.length - 1)
      'border-bottom': '1px solid var(--border)',
  };
}

/// ShadCN Key-Value Table renderer.
class ShadcnKeyValueTable extends KeyValueTableRenderBase {
  const ShadcnKeyValueTable(super.props, {super.key});

  @override
  String get classPrefix => 'arcane';

  @override
  Map<String, String> get containerStyles => const <String, String>{
    'border': '1px solid var(--border)',
    'border-radius': 'var(--radius)',
    'overflow': 'hidden',
  };

  @override
  String get dividerBorder => '1px solid var(--border)';

  @override
  Map<String, String> get keyLeadingStyles => const <String, String>{
    'padding': '1rem 1.5rem',
    'background-color': 'var(--muted)',
    'font-weight': 'var(--font-weight-medium)',
    'color': 'var(--foreground)',
    'font-size': 'var(--font-size-sm)',
  };

  @override
  Map<String, String> get valueStyles => const <String, String>{
    'flex': '1',
    'padding': '1rem 1.5rem',
    'background-color': 'var(--card)',
    'color': 'var(--foreground)',
    'font-size': 'var(--font-size-sm)',
  };
}
