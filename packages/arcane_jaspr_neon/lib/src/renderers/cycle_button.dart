import 'package:arcane_jaspr/core/props/cycle_button_props.dart';
import 'package:arcane_jaspr/core/rendering/base/cycle_button_render_base.dart';

/// Neon cycle button renderer.
class NeonCycleButton<T> extends CycleButtonRenderBase<T> {
  const NeonCycleButton(super.props);

  @override
  String get classPrefix => 'neon';

  @override
  Map<String, String> get clipStyles => const <String, String>{
    'clip-path': 'var(--neon-clip-sm)',
  };

  @override
  String get indicatorColor => 'var(--neon-accent)';

  @override
  Map<String, String> variantStyles(CycleButtonVariant variant) =>
      switch (variant) {
        CycleButtonVariant.outline => const <String, String>{
          'background': 'var(--neon-surface-1)',
          'color': 'var(--foreground)',
          'border': '1px solid var(--neon-control-border)',
          'box-shadow': 'inset 0 1px 0 var(--neon-inset)',
        },
        CycleButtonVariant.primary => const <String, String>{
          'background':
              'linear-gradient(180deg, color-mix(in srgb, var(--neon-accent) 82%, var(--neon-surface-0)), var(--neon-accent))',
          'color': 'var(--neon-on-accent)',
          'border': '1px solid var(--neon-control-border-strong)',
          'box-shadow':
              '0 0 22px color-mix(in srgb, var(--neon-accent) 28%, transparent), inset 0 1px 0 var(--neon-inset)',
        },
        CycleButtonVariant.secondary => const <String, String>{
          'background': 'var(--neon-surface-2)',
          'color': 'var(--foreground)',
          'border': '1px solid var(--neon-control-border)',
          'box-shadow': 'inset 0 1px 0 var(--neon-inset)',
        },
        CycleButtonVariant.ghost => const <String, String>{
          'background': 'transparent',
          'color': 'var(--foreground)',
          'border': '1px solid transparent',
        },
        CycleButtonVariant.destructive => const <String, String>{
          'background':
              'linear-gradient(180deg, color-mix(in srgb, var(--destructive) 82%, var(--neon-surface-0)), var(--destructive))',
          'color': '#ffffff',
          'border':
              '1px solid color-mix(in srgb, var(--destructive) 50%, transparent)',
          'box-shadow':
              '0 0 22px color-mix(in srgb, var(--destructive) 28%, transparent), inset 0 1px 0 var(--neon-inset)',
        },
      };
}

/// Neon toggle button renderer.
class NeonToggleButton extends ToggleButtonRenderBase {
  const NeonToggleButton(super.props);

  @override
  String get classPrefix => 'neon';

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
        'clip-path': 'var(--neon-clip-sm)',
        'background': props.value
            ? 'color-mix(in srgb, var(--neon-accent) 18%, var(--neon-surface-2))'
            : 'var(--neon-surface-1)',
        'color': props.value ? 'var(--neon-accent)' : 'var(--foreground)',
        'border': props.value
            ? '1px solid var(--neon-control-border-strong)'
            : '1px solid var(--neon-control-border)',
        'box-shadow': props.value
            ? '0 0 18px color-mix(in srgb, var(--neon-accent) 22%, transparent), inset 0 1px 0 var(--neon-inset)'
            : 'inset 0 1px 0 var(--neon-inset)',
        'cursor': props.disabled ? 'not-allowed' : 'pointer',
        'opacity': props.disabled ? '0.5' : '1',
        'transition':
            'background 200ms ease, border-color 200ms ease, color 200ms ease, box-shadow 200ms ease',
      };
}
