import 'package:arcane_jaspr/core/rendering/base/menubar_render_base.dart';

/// Neon menubar component.
class NeonMenubar extends MenubarRenderBase {
  const NeonMenubar(super.props, {super.key});

  @override
  String get themePrefix => 'neon';

  @override
  Map<String, String> get rootStyles => <String, String>{
    'display': 'flex',
    'height': '44px',
    'align-items': 'center',
    'gap': '4px',
    'border': '1px solid var(--neon-panel-border)',
    'background': 'var(--neon-panel-tint)',
    'padding': '4px',
    'clip-path': 'var(--neon-clip-sm)',
  };

  @override
  Map<String, String> triggerStyles(bool isOpen) => <String, String>{
    'display': 'flex',
    'cursor': 'default',
    'user-select': 'none',
    'align-items': 'center',
    'padding': '6px 12px',
    'font-size': 'var(--font-size-sm)',
    'font-weight': '500',
    'letter-spacing': '0.04em',
    'outline': 'none',
    'border': 'none',
    'background': isOpen ? 'var(--neon-accent-soft)' : 'transparent',
    'color': isOpen ? 'var(--neon-accent)' : 'var(--foreground)',
    'clip-path': 'var(--neon-clip-xs)',
    'transition': 'background-color 140ms ease, color 140ms ease',
  };

  @override
  Map<String, String> get contentStyles => <String, String>{
    'position': 'absolute',
    'top': '100%',
    'left': '0',
    'z-index': '50',
    'min-width': '200px',
    'overflow': 'hidden',
    'padding': '6px',
    'margin-top': '8px',
    'color': 'var(--popover-foreground)',
  };

  @override
  Map<String, String> get separatorStyles => <String, String>{
    'height': '1px',
    'margin': '6px -6px',
    'background': 'var(--neon-panel-border)',
    'opacity': '0.6',
  };

  @override
  String get itemBorderRadius => 'var(--radius-sm)';

  @override
  String get itemTransition =>
      'background-color var(--arcane-transition), color var(--arcane-transition)';

  @override
  String get indicatorColor => 'var(--neon-accent)';
}
