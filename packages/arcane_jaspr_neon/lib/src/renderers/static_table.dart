import 'package:arcane_jaspr/core/rendering/base/static_table_render_base.dart';

/// Neon Static Table renderer.
class NeonStaticTable extends StaticTableRenderBase {
  const NeonStaticTable(super.props, {super.key});

  @override
  String get classPrefix => 'neon';

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
  Map<String, String> headerCellStyles(String textAlign) => <String, String>{
    'padding': '1rem 1.5rem',
    'text-align': textAlign,
    'font-family': 'var(--font-heading)',
    'font-size': 'var(--font-size-xs)',
    'font-weight': 'var(--font-weight-semibold)',
    'letter-spacing': '0.12em',
    'text-transform': 'uppercase',
    'color': 'var(--muted-foreground)',
    'white-space': 'nowrap',
  };

  @override
  Map<String, String> rowStyles(int rowIndex) => <String, String>{
    'background': props.striped && rowIndex.isOdd
        ? 'color-mix(in srgb, var(--neon-accent) 4%, transparent)'
        : 'transparent',
    if (props.showDividers && rowIndex < props.rows.length - 1)
      'border-bottom':
          '1px solid color-mix(in srgb, var(--neon-panel-border) 60%, transparent)',
  };
}

/// Neon Key-Value Table renderer.
class NeonKeyValueTable extends KeyValueTableRenderBase {
  const NeonKeyValueTable(super.props, {super.key});

  @override
  String get classPrefix => 'neon';

  @override
  Map<String, String> get containerStyles => const <String, String>{
    'border': '1px solid var(--neon-panel-border)',
    'clip-path': 'var(--neon-clip-md)',
    'background': 'var(--neon-panel-surface)',
    'box-shadow': 'var(--neon-shadow-md), inset 0 1px 0 var(--neon-inset)',
    'overflow': 'hidden',
  };

  @override
  String get dividerBorder =>
      '1px solid color-mix(in srgb, var(--neon-panel-border) 60%, transparent)';

  @override
  Map<String, String> get keyLeadingStyles => const <String, String>{
    'padding': '1rem 1.5rem',
    'background': 'var(--neon-panel-tint)',
    'font-family': 'var(--font-heading)',
    'font-size': 'var(--font-size-xs)',
    'font-weight': 'var(--font-weight-semibold)',
    'letter-spacing': '0.08em',
    'text-transform': 'uppercase',
    'color': 'var(--muted-foreground)',
  };

  @override
  Map<String, String> get valueStyles => const <String, String>{
    'flex': '1',
    'padding': '1rem 1.5rem',
    'background': 'transparent',
    'color': 'var(--foreground)',
    'font-size': 'var(--font-size-sm)',
  };
}
