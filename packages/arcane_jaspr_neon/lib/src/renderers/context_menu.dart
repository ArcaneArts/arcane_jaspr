import 'package:arcane_jaspr/core/rendering/base/context_menu_render_base.dart';

/// Neon-style context menu component with pattern matching on sealed ArcaneMenuItem types.
class NeonContextMenu extends ContextMenuRenderBase {
  const NeonContextMenu(super.props, {super.key});

  @override
  String get themePrefix => 'neon';

  @override
  String get popoverSuffix => ' neon-popover';

  @override
  Map<String, String> get menuStyles => const <String, String>{
    'z-index': '50',
    'min-width': '160px',
    'overflow': 'hidden',
    'padding': '6px',
    'color': 'var(--popover-foreground)',
  };

  @override
  Map<String, String> get separatorStyles => const <String, String>{
    'height': '1px',
    'margin': '6px -6px',
    'background': 'var(--neon-panel-border)',
    'opacity': '0.6',
  };

  @override
  Map<String, String> get labelStyles => const <String, String>{
    'padding': '8px 10px 4px',
    'font-family': 'var(--font-heading)',
    'font-size': '0.6875rem',
    'font-weight': '600',
    'letter-spacing': '0.12em',
    'text-transform': 'uppercase',
    'color': 'var(--muted-foreground)',
    'user-select': 'none',
  };

  @override
  Map<String, String> actionStyles(bool disabled) => <String, String>{
    'position': 'relative',
    'display': 'flex',
    'align-items': 'center',
    'gap': '10px',
    'padding': '8px 12px',
    'border-radius': 'var(--radius)',
    'cursor': disabled ? 'not-allowed' : 'pointer',
    'transition':
        'color var(--arcane-transition), background-color var(--arcane-transition)',
    'font-size': 'var(--font-size-sm)',
    'user-select': 'none',
    'outline': 'none',
    if (disabled) 'pointer-events': 'none',
    if (disabled) 'opacity': '0.5',
  };

  @override
  Map<String, String> selectableStyles(bool disabled) => <String, String>{
    'position': 'relative',
    'display': 'flex',
    'align-items': 'center',
    'gap': '10px',
    'padding': '8px 12px',
    'padding-left': '36px',
    'font-size': 'var(--font-size-sm)',
    'border-radius': 'var(--radius)',
    'cursor': disabled ? 'not-allowed' : 'pointer',
    'transition':
        'background-color var(--arcane-transition), color var(--arcane-transition)',
    'user-select': 'none',
    'outline': 'none',
    if (disabled) 'pointer-events': 'none',
    if (disabled) 'opacity': '0.5',
  };

  @override
  Map<String, String> submenuTriggerStyles(bool disabled) => <String, String>{
    'position': 'relative',
    'display': 'flex',
    'align-items': 'center',
    'gap': '10px',
    'padding': '8px 12px',
    'border-radius': 'var(--radius)',
    'cursor': disabled ? 'not-allowed' : 'default',
    'transition':
        'color var(--arcane-transition), background-color var(--arcane-transition)',
    'font-size': 'var(--font-size-sm)',
    'user-select': 'none',
    'outline': 'none',
    if (disabled) 'pointer-events': 'none',
    if (disabled) 'opacity': '0.5',
  };

  @override
  Map<String, String> get submenuStyles => const <String, String>{
    'min-width': '160px',
    'padding': '6px',
    'z-index': '101',
  };

  @override
  String get labelTextColor => 'var(--foreground)';

  @override
  String get indicatorColor => 'var(--neon-accent)';

  @override
  String get indicatorLeft => '12px';

  @override
  String get shortcutLetterSpacing => '0';
}
