import 'package:arcane_jaspr/core/rendering/base/context_menu_render_base.dart';

/// ShadCN-style context menu component
/// Reference: https://ui.shadcn.com/docs/components/context-menu
class ShadcnContextMenu extends ContextMenuRenderBase {
  const ShadcnContextMenu(super.props, {super.key});

  @override
  String get themePrefix => 'arcane';

  @override
  String get popoverSuffix => '';

  @override
  Map<String, String> get menuStyles => const <String, String>{
    'z-index': '50',
    'min-width': '128px',
    'overflow': 'hidden',
    'padding': '4px',
    'background-color': 'var(--popover)',
    'border': '1px solid var(--border)',
    'border-radius': 'var(--radius-sm)',
    'box-shadow':
        '0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)',
    'color': 'var(--popover-foreground)',
  };

  @override
  Map<String, String> get separatorStyles => const <String, String>{
    'height': '1px',
    'margin': '4px -4px',
    'background-color': 'var(--muted)',
  };

  @override
  Map<String, String> get labelStyles => const <String, String>{
    'padding': '6px 8px',
    'font-size': 'var(--font-size-xs)',
    'font-weight': 'var(--font-weight-semibold)',
    'color': 'var(--muted-foreground)',
    'user-select': 'none',
  };

  @override
  Map<String, String> actionStyles(bool disabled) => <String, String>{
    'position': 'relative',
    'display': 'flex',
    'align-items': 'center',
    'gap': 'var(--space-2)',
    'padding': '6px 8px',
    'border-radius': 'var(--radius-xs)',
    'cursor': disabled ? 'not-allowed' : 'pointer',
    'transition':
        'color var(--transition), background-color var(--transition)',
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
    'gap': 'var(--space-2)',
    'padding': '6px 8px',
    'padding-left': '32px',
    'font-size': 'var(--font-size-sm)',
    'border-radius': 'var(--radius-xs)',
    'cursor': disabled ? 'not-allowed' : 'pointer',
    'transition':
        'background-color var(--transition), color var(--transition)',
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
    'gap': 'var(--space-2)',
    'padding': '6px 8px',
    'border-radius': 'var(--radius-xs)',
    'cursor': disabled ? 'not-allowed' : 'default',
    'transition':
        'color var(--transition), background-color var(--transition)',
    'font-size': 'var(--font-size-sm)',
    'user-select': 'none',
    'outline': 'none',
    if (disabled) 'pointer-events': 'none',
    if (disabled) 'opacity': '0.5',
  };

  @override
  Map<String, String> get submenuStyles => const <String, String>{
    'min-width': '128px',
    'padding': '4px',
    'background-color': 'var(--popover)',
    'border': '1px solid var(--border)',
    'border-radius': 'var(--radius-sm)',
    'box-shadow':
        '0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)',
    'z-index': '101',
  };

  @override
  String get labelTextColor => 'var(--popover-foreground)';

  @override
  String get indicatorColor => 'var(--foreground)';

  @override
  String get indicatorLeft => '8px';

  @override
  String get shortcutLetterSpacing => '0.1em';
}
