import 'package:arcane_jaspr/core/rendering/base/chart_render_base.dart';

class NeonChart extends ChartRenderBase {
  const NeonChart(super.props, {super.key});

  @override
  String get cssClass => 'neon-chart';

  @override
  Map<String, String> get rootStyles => const <String, String>{
    'display': 'flex',
    'flex-direction': 'column',
    'gap': '0.875rem',
    'padding': '1.25rem',
    'border': '1px solid var(--neon-panel-border)',
    'clip-path': 'var(--neon-clip-md)',
    'background': 'var(--neon-panel-surface)',
    'box-shadow': 'var(--neon-shadow-md), inset 0 1px 0 var(--neon-inset)',
    'backdrop-filter': 'blur(6px)',
  };

  @override
  Map<String, String> get titleStyles => const <String, String>{
    'font-family': 'var(--font-heading)',
    'font-size': 'var(--font-size-md)',
    'font-weight': 'var(--font-weight-semibold)',
    'letter-spacing': '0.04em',
    'color': 'var(--card-foreground)',
  };

  @override
  Map<String, String> get descriptionStyles => const <String, String>{
    'font-size': 'var(--font-size-sm)',
    'color': 'var(--muted-foreground)',
  };

  @override
  Map<String, String> get pointRowStyles => const <String, String>{
    'display': 'flex',
    'align-items': 'center',
    'gap': '0.625rem',
  };

  @override
  Map<String, String> get pointLabelStyles => const <String, String>{
    'width': '5rem',
    'font-size': 'var(--font-size-xs)',
    'color': 'var(--muted-foreground)',
  };

  @override
  Map<String, String> get trackStyles => const <String, String>{
    'height': '0.5rem',
    'flex': '1',
    'clip-path': 'var(--neon-clip-xs)',
    'background': 'color-mix(in srgb, var(--foreground) 10%, transparent)',
    'border': '1px solid color-mix(in srgb, var(--neon-accent) 18%, transparent)',
    'overflow': 'hidden',
  };

  @override
  Map<String, String> fillStyles(String width) => <String, String>{
    'height': '100%',
    'width': width,
    'background': props.color,
    'box-shadow': '0 0 14px color-mix(in srgb, var(--neon-accent) 38%, transparent)',
  };

  @override
  Map<String, String> get pointValueStyles => const <String, String>{
    'font-size': 'var(--font-size-xs)',
    'font-weight': 'var(--font-weight-medium)',
    'font-variant-numeric': 'tabular-nums',
    'color': 'var(--foreground)',
  };
}
