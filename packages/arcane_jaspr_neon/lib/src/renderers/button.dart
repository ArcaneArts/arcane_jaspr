import 'package:arcane_jaspr/core/props/button_props.dart';
import 'package:arcane_jaspr/core/rendering/base/button_render_base.dart';

class NeonButton extends ButtonRenderBase {
  const NeonButton(super.props, {super.key});

  @override
  String get cssClass => 'neon-button';

  @override
  String get arrowTransition => 'transform 0.2s ease';

  @override
  Map<String, String> baseStyles(bool isDisabled) => <String, String>{
    'display': 'inline-flex',
    'align-items': 'center',
    'justify-content': 'center',
    'gap': '0.625rem',
    'white-space': 'nowrap',
    'border-radius': 'var(--neon-radius-control, 0.375rem)',
    'clip-path':
        'polygon(0 var(--neon-cut-sm, 0.625rem), var(--neon-cut-sm, 0.625rem) 0, 100% 0, 100% calc(100% - var(--neon-cut-sm, 0.625rem)), calc(100% - var(--neon-cut-sm, 0.625rem)) 100%, 0 100%)',
    'font-family': 'var(--font-heading)',
    'font-size': 'var(--font-size-sm)',
    'font-weight': 'var(--font-weight-semibold)',
    'line-height': '1.25rem',
    'text-transform': 'uppercase',
    'letter-spacing': '0.06em',
    'outline': 'none',
    'cursor': isDisabled ? 'not-allowed' : 'pointer',
    'pointer-events': isDisabled ? 'none' : 'auto',
    'opacity': isDisabled ? '0.45' : '1',
    'user-select': 'none',
    '-webkit-user-select': 'none',
    'position': 'relative',
    'overflow': 'hidden',
    'transition':
        'color 0.16s ease, background-color 0.16s ease, border-color 0.16s ease, box-shadow 0.16s ease, transform 0.16s ease, filter 0.16s ease',
    'box-shadow': 'var(--neon-inset)',
  };

  @override
  Map<String, String> variantStyles(ButtonVariant variant) => switch (variant) {
    ButtonVariant.primary => <String, String>{
      'background':
          'linear-gradient(150deg, var(--neon-accent) 0%, color-mix(in srgb, var(--neon-accent) 78%, var(--neon-accent-cool)) 100%)',
      'color': 'var(--neon-on-accent)',
      'border':
          '1px solid color-mix(in srgb, var(--neon-accent) 70%, #12151C)',
      'box-shadow':
          '0 6px 18px color-mix(in srgb, var(--neon-accent) 28%, transparent), inset 0 1px 0 color-mix(in srgb, var(--neon-on-accent) 22%, transparent)',
    },
    ButtonVariant.destructive => <String, String>{
      'background':
          'linear-gradient(150deg, var(--destructive) 0%, color-mix(in srgb, var(--destructive) 80%, #12151C) 100%)',
      'color': '#ffffff',
      'border':
          '1px solid color-mix(in srgb, var(--destructive) 60%, #12151C)',
      'box-shadow':
          '0 6px 18px color-mix(in srgb, var(--destructive) 26%, transparent), inset 0 1px 0 color-mix(in srgb, #ffffff 14%, transparent)',
    },
    ButtonVariant.outline => <String, String>{
      'background':
          'color-mix(in srgb, var(--neon-accent) 4%, transparent)',
      'color': 'var(--foreground)',
      'border':
          '1px solid color-mix(in srgb, var(--neon-accent-cool) 32%, var(--neon-control-border))',
      'box-shadow': 'var(--neon-inset)',
    },
    ButtonVariant.secondary => <String, String>{
      'background':
          'color-mix(in srgb, var(--neon-accent-cool) 6%, var(--neon-surface-2))',
      'color': 'var(--secondary-foreground)',
      'border':
          '1px solid color-mix(in srgb, var(--neon-accent-cool) 18%, var(--neon-control-border))',
      'box-shadow': 'var(--neon-inset)',
    },
    ButtonVariant.ghost => <String, String>{
      'background': 'transparent',
      'color': 'var(--foreground)',
      'border':
          '1px solid color-mix(in srgb, var(--foreground) 6%, transparent)',
    },
    ButtonVariant.link => <String, String>{
      'background': 'transparent',
      'color': 'var(--neon-accent)',
      'border': 'none',
      'text-decoration': 'none',
      'text-underline-offset': '4px',
      'padding': '0',
      'height': 'auto',
      'box-shadow': 'none',
    },
    ButtonVariant.success => <String, String>{
      'background':
          'linear-gradient(150deg, var(--success) 0%, color-mix(in srgb, var(--success) 78%, #12151C) 100%)',
      'color': '#ffffff',
      'border': '1px solid color-mix(in srgb, var(--success) 58%, #12151C)',
      'box-shadow':
          '0 6px 18px color-mix(in srgb, var(--success) 24%, transparent), inset 0 1px 0 color-mix(in srgb, #ffffff 14%, transparent)',
    },
    ButtonVariant.warning => <String, String>{
      'background':
          'linear-gradient(150deg, var(--warning) 0%, color-mix(in srgb, var(--warning) 78%, #12151C) 100%)',
      'color': '#0b0b0b',
      'border': '1px solid color-mix(in srgb, var(--warning) 60%, #12151C)',
      'box-shadow':
          '0 6px 18px color-mix(in srgb, var(--warning) 24%, transparent), inset 0 1px 0 color-mix(in srgb, #ffffff 22%, transparent)',
    },
    ButtonVariant.info => <String, String>{
      'background':
          'linear-gradient(150deg, var(--info) 0%, color-mix(in srgb, var(--info) 78%, #12151C) 100%)',
      'color': '#ffffff',
      'border': '1px solid color-mix(in srgb, var(--info) 60%, #12151C)',
      'box-shadow':
          '0 6px 18px color-mix(in srgb, var(--info) 24%, transparent), inset 0 1px 0 color-mix(in srgb, #ffffff 14%, transparent)',
    },
    ButtonVariant.accent => <String, String>{
      'background':
          'linear-gradient(150deg, var(--neon-accent-hot) 0%, var(--neon-accent) 100%)',
      'color': 'var(--neon-on-accent)',
      'border':
          '1px solid color-mix(in srgb, var(--neon-accent-hot) 62%, #12151C)',
      'box-shadow':
          '0 6px 20px color-mix(in srgb, var(--neon-accent-hot) 28%, transparent), inset 0 1px 0 color-mix(in srgb, var(--neon-on-accent) 22%, transparent)',
    },
  };

  @override
  Map<String, String> sizeStyles(ButtonSize size) => switch (size) {
    ButtonSize.sm => <String, String>{
      'height': '2.375rem',
      'padding': '0 1rem',
      'font-size': '0.8125rem',
    },
    ButtonSize.md => <String, String>{
      'height': '2.75rem',
      'padding': '0.625rem 1.25rem',
    },
    ButtonSize.lg => <String, String>{
      'height': '3.125rem',
      'padding': '0 1.75rem',
      'font-size': '0.9375rem',
    },
    ButtonSize.iconSm => <String, String>{
      'height': '2.375rem',
      'width': '2.375rem',
      'padding': '0',
    },
    ButtonSize.iconMd => <String, String>{
      'height': '2.75rem',
      'width': '2.75rem',
      'padding': '0',
    },
    ButtonSize.iconLg => <String, String>{
      'height': '3.125rem',
      'width': '3.125rem',
      'padding': '0',
    },
  };
}
