import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/props/alert_props.dart';
import 'package:arcane_jaspr/core/rendering/base/alert_render_base.dart';

/// ShadCN Alert renderer.
///
/// Reference: https://ui.shadcn.com/docs/components/alert
class ShadcnAlert extends AlertRenderBase {
  const ShadcnAlert(super.props, {super.key});

  (String primary, String background, String border) get _colors =>
      switch (props.color) {
        ColorVariant.info => (
          'var(--info, #3b82f6)',
          'color-mix(in srgb, var(--info, #3b82f6) 10%, transparent)',
          'color-mix(in srgb, var(--info, #3b82f6) 30%, transparent)',
        ),
        ColorVariant.success => (
          'var(--success, #22c55e)',
          'color-mix(in srgb, var(--success, #22c55e) 10%, transparent)',
          'color-mix(in srgb, var(--success, #22c55e) 30%, transparent)',
        ),
        ColorVariant.warning => (
          'var(--warning, #f59e0b)',
          'color-mix(in srgb, var(--warning, #f59e0b) 10%, transparent)',
          'color-mix(in srgb, var(--warning, #f59e0b) 30%, transparent)',
        ),
        ColorVariant.destructive => (
          'var(--destructive)',
          'color-mix(in srgb, var(--destructive) 10%, transparent)',
          'color-mix(in srgb, var(--destructive) 30%, transparent)',
        ),
        ColorVariant.primary => (
          'var(--primary)',
          'color-mix(in srgb, var(--primary) 10%, transparent)',
          'color-mix(in srgb, var(--primary) 30%, transparent)',
        ),
        ColorVariant.secondary => (
          'var(--secondary)',
          'color-mix(in srgb, var(--secondary) 10%, transparent)',
          'color-mix(in srgb, var(--secondary) 30%, transparent)',
        ),
      };

  @override
  Component get defaultIcon => switch (props.color) {
    ColorVariant.info => ArcaneIcon.info(size: IconSize.sm),
    ColorVariant.success => ArcaneIcon.circleCheck(size: IconSize.sm),
    ColorVariant.warning => ArcaneIcon.triangleAlert(size: IconSize.sm),
    ColorVariant.destructive => ArcaneIcon.circleX(size: IconSize.sm),
    ColorVariant.primary => ArcaneIcon.info(size: IconSize.sm),
    ColorVariant.secondary => ArcaneIcon.info(size: IconSize.sm),
  };

  @override
  String get rootClass => 'arcane-alert';

  @override
  Map<String, String> get rootAttributes =>
      const <String, String>{'role': 'alert'};

  @override
  Map<String, String> get rootLayoutStyles =>
      const <String, String>{'gap': '12px', 'padding': '16px'};

  @override
  Map<String, String> get containerStyles {
    final String primary = _colors.$1;
    final String bgColor = _colors.$2;
    final String borderColor = _colors.$3;

    // ShadCN Alert styles vary by style
    return switch (props.style) {
      AlertStyle.subtle => <String, String>{
        'background-color': bgColor,
        'border': '1px solid $borderColor',
        'border-radius': 'var(--radius-md)', // rounded-lg
      },
      AlertStyle.solid => <String, String>{
        'background-color': primary,
        'border': '1px solid transparent',
        'border-radius': 'var(--radius-md)',
        'color': 'var(--primary-foreground)',
      },
      AlertStyle.outline => <String, String>{
        'background-color': 'var(--background)',
        'border': '1px solid $borderColor',
        'border-radius': 'var(--radius-md)',
        'color': 'var(--foreground)',
      },
      AlertStyle.accent => <String, String>{
        'background-color': bgColor,
        'border': '1px solid $borderColor',
        'border-left': '4px solid $primary',
        'border-radius': 'var(--radius-md)',
      },
    };
  }

  @override
  String get iconClass => 'arcane-alert-icon';

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
      'color': isSolid ? 'var(--primary-foreground)' : primary,
      'margin-top': '1px',
    };
  }

  @override
  String get contentClass => 'arcane-alert-content';

  @override
  String get titleClass => 'arcane-alert-title';

  @override
  Map<String, String> get titleStyles {
    final bool isSolid = props.style == AlertStyle.solid;
    return <String, String>{
      'font-weight': 'var(--font-weight-medium)',
      'line-height': '1',
      'letter-spacing': '-0.025em',
      'color': isSolid ? 'var(--primary-foreground)' : 'var(--foreground)',
      if (props.message != null || props.child != null) 'margin-bottom': '4px',
    };
  }

  @override
  String get descriptionClass => 'arcane-alert-description';

  @override
  Map<String, String> get descriptionStyles {
    final bool isSolid = props.style == AlertStyle.solid;
    return <String, String>{
      'font-size': 'var(--font-size-sm)',
      'line-height': '1.625',
      'color': isSolid ? 'var(--primary-foreground)' : 'var(--muted-foreground)',
    };
  }

  @override
  String get actionMarginTop => '12px';

  @override
  String get dismissClass => 'arcane-alert-dismiss';

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
      'color': isSolid ? 'var(--primary-foreground)' : 'var(--muted-foreground)',
      'cursor': 'pointer',
      'border-radius': 'var(--radius-xs)', // rounded-sm
      'opacity': '0.7',
      'transition': 'opacity var(--transition)',
    };
  }

  @override
  Component get dismissChild => ArcaneIcon.x(size: IconSize.sm);
}
