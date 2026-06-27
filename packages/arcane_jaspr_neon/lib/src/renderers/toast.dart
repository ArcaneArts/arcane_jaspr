import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/toast_props.dart';
import 'package:arcane_jaspr/core/rendering/base/toast_render_base.dart';

/// Neon Toast renderer.
///
/// Implements the Neon design language:
/// - Glass effect with subtle blur
/// - Accent-colored variant glows
/// - Larger padding and border radius
class NeonToast extends ToastRenderBase {
  const NeonToast(super.props, {super.key});

  @override
  String get classPrefix => 'neon';

  @override
  String get loadingAccent => 'var(--neon-accent)';

  @override
  Map<String, String> get rootAttributes => const <String, String>{};

  @override
  Map<String, String> rootBaseStyles(String accentVar) => <String, String>{
    'display': 'flex',
    'align-items': 'flex-start',
    'gap': '0.75rem',
    'width': '360px',
    'max-width': '100%',
    'padding': '1rem 1.25rem',
    'background':
        'linear-gradient(140deg, color-mix(in srgb, $accentVar 9%, transparent), transparent 60%), color-mix(in srgb, var(--neon-panel-surface) 94%, transparent)',
    'backdrop-filter': 'blur(18px) saturate(1.18)',
    '-webkit-backdrop-filter': 'blur(18px) saturate(1.18)',
    'border':
        '1px solid color-mix(in srgb, $accentVar 38%, var(--neon-panel-border))',
    'border-radius': 'var(--neon-radius-panel)',
    'clip-path': 'var(--neon-clip-sm)',
    'box-shadow':
        'var(--neon-shadow-md), 0 0 22px color-mix(in srgb, $accentVar 22%, transparent), var(--neon-inset)',
    'transition':
        'opacity 0.2s ease, transform 0.2s ease, box-shadow 0.2s ease',
  };

  @override
  Map<String, String> actionStyles() => <String, String>{
    'margin-top': '0.5rem',
    'padding': '0.375rem 0.75rem',
    'font-family': 'var(--font-heading)',
    'font-size': 'var(--font-size-xs)',
    'font-weight': '600',
    'letter-spacing': '0.06em',
    'text-transform': 'uppercase',
    'background': props.action!.destructive
        ? 'var(--destructive)'
        : 'var(--neon-accent)',
    'color': props.action!.destructive ? '#ffffff' : 'var(--neon-on-accent)',
    'border': 'none',
    'border-radius': 'var(--neon-radius-control)',
    'clip-path': 'var(--neon-clip-xs)',
    'cursor': 'pointer',
    'transition': 'filter 0.15s ease',
  };

  @override
  String get dismissClasses => 'neon-toast-dismiss';

  @override
  Map<String, String> get dismissStyles => const <String, String>{
    'flex-shrink': '0',
    'width': '24px',
    'height': '24px',
    'display': 'flex',
    'align-items': 'center',
    'justify-content': 'center',
    'background': 'transparent',
    'border': 'none',
    'border-radius': 'var(--neon-radius-control)',
    'color': 'var(--muted-foreground)',
    'cursor': 'pointer',
    'opacity': '0.7',
    'transition': 'opacity 0.15s ease, color 0.15s ease',
  };

  @override
  Component buildLoadingSpinner() => const dom.span(
    classes: 'neon-toast-spinner',
    styles: dom.Styles(
      raw: <String, String>{
        'display': 'inline-block',
        'width': '18px',
        'height': '18px',
        'border':
            '2px solid color-mix(in srgb, var(--neon-accent) 12%, transparent)',
        'border-top-color': 'var(--neon-accent)',
        'border-radius': 'var(--arcane-radius-full)',
        'animation': 'arcane-spin 0.75s linear infinite',
      },
    ),
    <Component>[],
  );
}

/// Neon Toast Container renderer.
class NeonToastContainer extends ToastContainerRenderBase {
  const NeonToastContainer(super.props, {super.key});

  @override
  String get classPrefix => 'neon';

  @override
  Component buildToast(ToastProps toast) => NeonToast(toast);
}
