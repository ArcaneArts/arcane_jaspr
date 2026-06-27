import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/alert_props.dart';
import 'package:arcane_jaspr/core/rendering/base/alert_render_base.dart';

/// Neon Alert renderer.
///
/// Implements the Neon accent dark design language:
/// - Elevated borders with accent effects
/// - layered-style gradients
/// - Restrained color variants
class NeonAlert extends AlertRenderBase {
  const NeonAlert(super.props, {super.key});

  (String primary, String background, String border, String shadow)
  get _colors => switch (props.color) {
    ColorVariant.info => (
      'var(--info, #3b82f6)',
      'color-mix(in srgb, var(--info, #3b82f6) 10%, var(--card))',
      'var(--info, #3b82f6)',
      '0 10px 24px rgba(0, 0, 0, 0.28)',
    ),
    ColorVariant.success => (
      'var(--success, #22c55e)',
      'color-mix(in srgb, var(--success, #22c55e) 10%, var(--card))',
      'var(--success, #22c55e)',
      '0 10px 24px rgba(0, 0, 0, 0.28)',
    ),
    ColorVariant.warning => (
      'var(--warning, #f59e0b)',
      'color-mix(in srgb, var(--warning, #f59e0b) 10%, var(--card))',
      'var(--warning, #f59e0b)',
      '0 10px 24px rgba(0, 0, 0, 0.28)',
    ),
    ColorVariant.destructive => (
      'var(--destructive)',
      'color-mix(in srgb, var(--destructive) 10%, var(--card))',
      'var(--destructive)',
      '0 10px 24px rgba(0, 0, 0, 0.28)',
    ),
    ColorVariant.primary => (
      'var(--neon-accent)',
      'color-mix(in srgb, var(--neon-accent) 10%, var(--card))',
      'var(--neon-accent)',
      '0 10px 24px rgba(0, 0, 0, 0.28)',
    ),
    ColorVariant.secondary => (
      'var(--secondary)',
      'color-mix(in srgb, var(--secondary) 10%, var(--card))',
      'var(--secondary)',
      '0 10px 20px rgba(0, 0, 0, 0.24)',
    ),
  };

  @override
  Component get defaultIcon => Component.text(switch (props.color) {
    ColorVariant.info => 'ℹ', // i
    ColorVariant.success => '✓', // checkmark
    ColorVariant.warning => '⚠', // warning
    ColorVariant.destructive => '✕', // x
    ColorVariant.primary => 'ℹ', // i
    ColorVariant.secondary => 'ℹ', // i
  });

  @override
  String get rootClass => 'neon-alert ';

  @override
  Map<String, String> get rootAttributes => <String, String>{
    'role': 'alert',
    'data-variant': props.color.name,
    'data-style': props.style.name,
  };

  @override
  Map<String, String> get rootLayoutStyles => const <String, String>{
    'gap': '12px',
    'padding': '16px',
    'overflow': 'hidden',
    'clip-path': 'var(--neon-panel-clip)',
    'isolation': 'isolate',
  };

  @override
  Map<String, String> get containerStyles {
    final String primary = _colors.$1;
    final String bgColor = _colors.$2;
    final String borderColor = _colors.$3;
    final String shadow = _colors.$4;

    return switch (props.style) {
      AlertStyle.solid => <String, String>{
        'background':
            'linear-gradient(135deg, color-mix(in srgb, $primary 82%, #0d1110), $primary 68%, color-mix(in srgb, var(--neon-accent-cool) 44%, $primary))',
        'border': '1px solid transparent',
        'border-radius': 'var(--neon-radius-panel)',
        'color': '#ffffff',
        'box-shadow': shadow,
      },
      AlertStyle.subtle => <String, String>{
        'background':
            'linear-gradient(135deg, color-mix(in srgb, $primary 9%, transparent), $bgColor), linear-gradient(90deg, color-mix(in srgb, $primary 5%, transparent) 1px, transparent 1px)',
        'background-size': 'auto, 18px 18px',
        'border': '1px solid $borderColor',
        'border-radius': 'var(--neon-radius-panel)',
        'box-shadow': shadow,
      },
      AlertStyle.outline => <String, String>{
        'background':
            'linear-gradient(135deg, color-mix(in srgb, $primary 5%, transparent), color-mix(in srgb, var(--card) 74%, transparent))',
        'border': '1px solid $borderColor',
        'border-radius': 'var(--neon-radius-panel)',
        'box-shadow': shadow,
      },
      AlertStyle.accent => <String, String>{
        'background':
            'linear-gradient(135deg, color-mix(in srgb, $primary 10%, transparent), $bgColor), linear-gradient(90deg, color-mix(in srgb, $primary 8%, transparent) 1px, transparent 1px)',
        'background-size': 'auto, 18px 18px',
        'border': '1px solid $borderColor',
        'border-top': '2px solid $primary',
        'border-radius': 'var(--neon-radius-panel)',
        'box-shadow': shadow,
      },
    };
  }

  @override
  String get iconClass => 'neon-alert-icon';

  @override
  Map<String, String> get iconStyles {
    final bool isSolid = props.style == AlertStyle.solid;
    final String primary = _colors.$1;
    return <String, String>{
      'flex-shrink': '0',
      'width': '16px',
      'height': '16px',
      'display': 'flex',
      'align-items': 'center',
      'justify-content': 'center',
      'color': isSolid ? '#ffffff' : primary,
      'font-size': 'var(--font-size-base)',
      'margin-top': '1px',
      'filter': 'drop-shadow(0 0 8px $primary)',
    };
  }

  @override
  String get contentClass => 'neon-alert-content';

  @override
  String get titleClass => 'neon-alert-title';

  @override
  Map<String, String> get titleStyles {
    final bool isSolid = props.style == AlertStyle.solid;
    return <String, String>{
      'font-family': 'var(--font-heading)',
      'font-weight': 'var(--font-weight-semibold)',
      'line-height': '1.1',
      'letter-spacing': '0.08em',
      'text-transform': 'uppercase',
      'color': isSolid ? '#ffffff' : 'var(--foreground)',
      if (props.message != null || props.child != null) 'margin-bottom': '4px',
    };
  }

  @override
  String get descriptionClass => 'neon-alert-description';

  @override
  Map<String, String> get descriptionStyles {
    final bool isSolid = props.style == AlertStyle.solid;
    return <String, String>{
      'font-size': 'var(--font-size-sm)',
      'line-height': '1.625',
      'color': isSolid ? 'rgba(255, 255, 255, 0.9)' : 'var(--muted-foreground)',
    };
  }

  @override
  String get actionMarginTop => '12px';

  @override
  String get dismissClass => 'neon-alert-dismiss';

  @override
  Map<String, String> get dismissStyles {
    final bool isSolid = props.style == AlertStyle.solid;
    return <String, String>{
      'position': 'absolute',
      'right': '8px',
      'top': '8px',
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'width': '24px',
      'height': '24px',
      'padding': '0',
      'border': 'none',
      'background': 'transparent',
      'color': isSolid ? 'rgba(255, 255, 255, 0.8)' : 'var(--muted-foreground)',
      'cursor': 'pointer',
      'border-radius': 'var(--arcane-radius-xs)',
      'opacity': '0.7',
      'transition': 'opacity var(--arcane-transition)',
      'font-size': 'var(--font-size-base)',
    };
  }

  @override
  Component get dismissChild => const Component.text('×'); // x
}
