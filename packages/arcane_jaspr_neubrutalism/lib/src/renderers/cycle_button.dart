import 'package:arcane_jaspr/core/props/cycle_button_props.dart';
import 'package:arcane_jaspr/core/rendering/base/cycle_button_render_base.dart';

/// Neubrutalism cycle button renderer.
class NeubrutalismCycleButton<T> extends CycleButtonRenderBase<T> {
  const NeubrutalismCycleButton(super.props);

  @override
  String get classPrefix => 'neubrutalism';

  @override
  Map<String, String> get clipStyles => const <String, String>{};

  @override
  String get indicatorColor => 'var(--nb-accent, var(--primary))';

  @override
  Map<String, String> variantStyles(CycleButtonVariant variant) =>
      switch (variant) {
        CycleButtonVariant.outline => const <String, String>{
          'background': 'var(--nb-paper, var(--card))',
          'color': 'var(--foreground)',
          'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
          'border-radius': 'var(--nb-radius-soft, 4px)',
          'box-shadow':
              'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
        },
        CycleButtonVariant.primary => const <String, String>{
          'background': 'var(--nb-accent, var(--primary))',
          'color': 'var(--nb-on-accent, #000)',
          'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
          'border-radius': 'var(--nb-radius-soft, 4px)',
          'box-shadow':
              'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
        },
        CycleButtonVariant.secondary => const <String, String>{
          'background': 'var(--nb-paper-soft, var(--card))',
          'color': 'var(--foreground)',
          'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
          'border-radius': 'var(--nb-radius-soft, 4px)',
          'box-shadow':
              'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
        },
        CycleButtonVariant.ghost => const <String, String>{
          'background': 'transparent',
          'color': 'var(--foreground)',
          'border': 'var(--nb-border-thin, 2px) solid transparent',
          'border-radius': 'var(--nb-radius-soft, 4px)',
          'box-shadow': 'none',
        },
        CycleButtonVariant.destructive => const <String, String>{
          'background': 'var(--destructive)',
          'color': 'var(--destructive-foreground, #fff)',
          'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
          'border-radius': 'var(--nb-radius-soft, 4px)',
          'box-shadow':
              'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
        },
      };
}

/// Neubrutalism toggle button renderer.
class NeubrutalismToggleButton extends ToggleButtonRenderBase {
  const NeubrutalismToggleButton(super.props);

  @override
  String get classPrefix => 'neubrutalism';

  @override
  Map<String, String> toggleStyles(Map<String, String> sizeStyles) =>
      <String, String>{
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': '0.6rem',
        ...sizeStyles,
        'font-family': 'var(--font-heading)',
        'font-weight': 'var(--font-weight-semibold)',
        'letter-spacing': '0.06em',
        'background': props.value
            ? 'var(--nb-accent, var(--primary))'
            : 'var(--nb-paper, var(--card))',
        'color': props.value ? 'var(--nb-on-accent, #000)' : 'var(--foreground)',
        'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
        'border-radius': 'var(--nb-radius-soft, 4px)',
        'box-shadow':
            'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
        'cursor': props.disabled ? 'not-allowed' : 'pointer',
        'opacity': props.disabled ? '0.5' : '1',
        'transition':
            'transform var(--nb-transition, 120ms ease), box-shadow var(--nb-transition, 120ms ease), background-color var(--nb-transition, 120ms ease), color var(--nb-transition, 120ms ease)',
      };
}
