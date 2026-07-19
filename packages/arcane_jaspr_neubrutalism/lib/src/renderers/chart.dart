import 'package:arcane_jaspr/core/rendering/base/chart_render_base.dart';

class NeubrutalismChart extends ChartRenderBase {
  const NeubrutalismChart(super.props, {super.key});

  @override
  String get cssClass => 'neubrutalism-chart';

  @override
  Map<String, String> get rootStyles => const <String, String>{
    'display': 'flex',
    'flex-direction': 'column',
    'gap': '0.875rem',
    'padding': '1.25rem',
    'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
    'background': 'var(--nb-paper, var(--card))',
    'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
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
    'height': '14px',
    'flex': '1',
    'background': 'var(--nb-paper-soft, var(--card))',
    'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
    'overflow': 'hidden',
  };

  @override
  Map<String, String> fillStyles(String width) => <String, String>{
    'height': '100%',
    'width': width,
    'background': props.color,
  };

  @override
  Map<String, String> get pointValueStyles => const <String, String>{
    'font-size': 'var(--font-size-xs)',
    'font-weight': 'var(--font-weight-medium)',
    'font-variant-numeric': 'tabular-nums',
    'color': 'var(--foreground)',
  };
}
