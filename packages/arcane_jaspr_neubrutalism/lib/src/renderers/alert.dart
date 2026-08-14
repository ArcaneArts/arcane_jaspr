import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/alert_props.dart';
import 'package:arcane_jaspr/core/rendering/base/alert_render_base.dart';

class NeubrutalismAlert extends AlertRenderBase {
  const NeubrutalismAlert(super.props, {super.key});

  String get _accentColor => switch (props.color) {
    ColorVariant.info => 'var(--info, #3b82f6)',
    ColorVariant.success => 'var(--success, #22c55e)',
    ColorVariant.warning => 'var(--warning, #facc15)',
    ColorVariant.destructive => 'var(--destructive)',
    ColorVariant.primary => 'var(--nb-accent, var(--primary))',
    ColorVariant.secondary => 'var(--nb-accent-cool, var(--secondary))',
  };

  @override
  Component get defaultIcon => Component.text(switch (props.color) {
    ColorVariant.info => 'ℹ',
    ColorVariant.success => '✓',
    ColorVariant.warning => '⚠',
    ColorVariant.destructive => '✕',
    ColorVariant.primary => 'ℹ',
    ColorVariant.secondary => 'ℹ',
  });

  @override
  String get rootClass => 'neubrutalism-alert';

  @override
  Map<String, String> get rootAttributes => <String, String>{
    'role': 'alert',
    'data-variant': props.color.name,
    'data-style': props.variant.name,
  };

  @override
  Map<String, String> get rootLayoutStyles => const <String, String>{
    'gap': '0.75rem',
    'padding': '1rem 1.125rem',
  };

  @override
  Map<String, String> get containerStyles {
    final String accent = _accentColor;
    return switch (props.variant) {
      AlertStyle.solid => <String, String>{
        'background-color': accent,
        'color': 'var(--nb-ink, #000)',
        'border': 'var(--nb-border-thick, 4px) solid var(--nb-line, #000)',
        'border-radius': 'var(--nb-radius-soft, 4px)',
        'box-shadow':
            'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
      },
      AlertStyle.subtle => <String, String>{
        'background-color': 'var(--nb-paper, var(--card))',
        'border': 'var(--nb-border-thick, 4px) solid var(--nb-line, #000)',
        'border-radius': 'var(--nb-radius-soft, 4px)',
        'box-shadow':
            'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
      },
      AlertStyle.outline => <String, String>{
        'background-color': 'var(--nb-paper, var(--card))',
        'border': 'var(--nb-border-thick, 4px) solid var(--nb-line, #000)',
        'border-radius': 'var(--nb-radius-soft, 4px)',
        'box-shadow':
            'var(--nb-shadow-sm, 3px 3px 0 0 var(--nb-shadow-color, #000))',
      },
      AlertStyle.accent => <String, String>{
        'background-color': 'var(--nb-paper, var(--card))',
        'border': 'var(--nb-border-thick, 4px) solid $accent',
        'border-radius': 'var(--nb-radius-soft, 4px)',
        'box-shadow':
            'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
      },
    };
  }

  @override
  String get iconClass => 'neubrutalism-alert-icon';

  @override
  Map<String, String> get iconStyles {
    final bool isSolid = props.variant == AlertStyle.solid;
    final String accent = _accentColor;
    return <String, String>{
      'flex-shrink': '0',
      'width': '1.5rem',
      'height': '1.5rem',
      'display': 'flex',
      'align-items': 'center',
      'justify-content': 'center',
      'background-color': isSolid ? 'var(--nb-paper, #fff)' : accent,
      'color': isSolid ? accent : 'var(--nb-ink, #000)',
      'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
      'border-radius': 'var(--nb-radius-soft, 4px)',
      'font-size': '0.875rem',
      'font-weight': '900',
      'margin-top': '1px',
    };
  }

  @override
  String get contentClass => 'neubrutalism-alert-content';

  @override
  String get titleClass => 'neubrutalism-alert-title';

  @override
  Map<String, String> get titleStyles {
    final bool isSolid = props.variant == AlertStyle.solid;
    return <String, String>{
      'font-family': 'var(--font-heading)',
      'font-weight': '900',
      'line-height': '1.1',
      'letter-spacing': '-0.01em',
      'color': isSolid ? 'var(--nb-ink, #000)' : 'var(--foreground)',
      if (props.message != null || props.child != null)
        'margin-bottom': '0.25rem',
    };
  }

  @override
  String get descriptionClass => 'neubrutalism-alert-description';

  @override
  Map<String, String> get descriptionStyles {
    final bool isSolid = props.variant == AlertStyle.solid;
    return <String, String>{
      'font-size': 'var(--font-size-sm)',
      'line-height': '1.5',
      'font-weight': '500',
      'color': isSolid ? 'var(--nb-ink, #000)' : 'var(--foreground)',
    };
  }

  @override
  String get actionMarginTop => '0.75rem';

  @override
  String get dismissClass => 'neubrutalism-alert-dismiss';

  @override
  Map<String, String> get dismissStyles => <String, String>{
    'position': 'absolute',
    'right': '0.5rem',
    'top': '0.5rem',
    'display': 'inline-flex',
    'align-items': 'center',
    'justify-content': 'center',
    'width': '1.5rem',
    'height': '1.5rem',
    'padding': '0',
    'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
    'background-color': 'var(--nb-paper, #fff)',
    'color': 'var(--nb-ink, #000)',
    'cursor': 'pointer',
    'border-radius': 'var(--nb-radius-soft, 4px)',
    'font-size': '0.875rem',
    'font-weight': '900',
    'line-height': '1',
  };

  @override
  Component get dismissChild => const Component.text('×');
}
