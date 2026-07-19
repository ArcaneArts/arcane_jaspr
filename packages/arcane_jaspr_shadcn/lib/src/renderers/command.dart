import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/command_props.dart';
import 'package:arcane_jaspr/core/rendering/base/command_render_base.dart';

/// ShadCN Command renderer.
///
/// Outputs command palette HTML matching the ShadCN/ui cmdk design language.
/// Reference: https://ui.shadcn.com/docs/components/command
class ShadcnCommand extends CommandRenderBase {
  const ShadcnCommand(super.props, {super.key});

  static int _autoCounter = 0;

  @override
  String autoId() {
    _autoCounter++;
    return 'arcane-command-$_autoCounter';
  }

  @override
  String get overlayClasses => 'arcane-command-overlay arcane-overlay-scrim';

  @override
  Map<String, String> get overlayStyles => const <String, String>{
        'position': 'fixed',
        'inset': '0',
        'z-index': '50',
        'display': 'flex',
        'align-items': 'flex-start',
        'justify-content': 'center',
        'padding-top': '20vh',
        'background-color': 'rgba(0, 0, 0, 0.5)',
        'animation': 'arcane-fade-in var(--transition-slow)',
      };

  @override
  String get dialogClasses => 'arcane-command-dialog';

  @override
  Map<String, String> get dialogStyles => const <String, String>{
        'width': '100%',
        'max-width': '640px',
        'background-color': 'var(--popover)',
        'color': 'var(--popover-foreground)',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius-md)',
        'box-shadow':
            '0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)',
        'overflow': 'hidden',
        'animation': 'arcane-scale-in var(--transition-slow)',
      };

  @override
  Map<String, String> get searchRowStyles => const <String, String>{
        'display': 'flex',
        'align-items': 'center',
        'gap': 'var(--space-2)',
        'padding': '12px 16px',
        'border-bottom': '1px solid var(--border)',
      };

  @override
  Map<String, String> get searchIconStyles => const <String, String>{
        'color': 'var(--muted-foreground)',
        'display': 'flex',
        'align-items': 'center',
      };

  @override
  String get inputClass => 'arcane-command-input';

  @override
  String get inputStyleSuffix =>
      'font-size:var(--font-size-sm);color:var(--foreground);outline:none;';

  @override
  String get listClasses => 'arcane-command-list';

  @override
  Map<String, String> get listStyles => const <String, String>{
        'max-height': '400px',
        'overflow-y': 'auto',
        'padding': '8px',
      };

  @override
  String get groupHeadingClass => 'arcane-command-group-heading';

  @override
  Map<String, String> get groupHeadingStyles => const <String, String>{
        'padding': '8px 12px',
        'font-size': 'var(--font-size-xs)',
        'font-weight': 'var(--font-weight-semibold)',
        'color': 'var(--muted-foreground)',
        'text-transform': 'uppercase',
        'letter-spacing': '0.05em',
      };

  @override
  Map<String, String> get footerStyles => const <String, String>{
        'display': 'flex',
        'align-items': 'center',
        'gap': '16px',
        'padding': '8px 12px',
        'border-top': '1px solid var(--border)',
        'font-size': 'var(--font-size-xs)',
        'color': 'var(--muted-foreground)',
      };

  @override
  String get itemBaseClass => 'arcane-command-item';

  @override
  Map<String, String> itemStyles(CommandItemProps item) => <String, String>{
        'display': 'flex',
        'align-items': 'center',
        'gap': 'var(--space-2)',
        'padding': '8px 12px',
        'border-radius': 'var(--radius-xs)',
        'cursor': item.disabled ? 'not-allowed' : 'pointer',
        'transition': 'background-color var(--transition)',
        if (item.disabled) 'opacity': '0.5',
      };

  @override
  Component buildShortcut(String shortcut) => dom.span(
        styles: const dom.Styles(
          raw: <String, String>{
            'font-size': 'var(--font-size-xs)',
            'color': 'var(--muted-foreground)',
            'padding': '2px 4px',
            'background-color': 'var(--muted)',
            'border-radius': 'var(--radius-xs)',
            'font-family':
                'ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace',
          },
        ),
        [Component.text(shortcut)],
      );

  @override
  List<Component> buildKeyHints() => <Component>[
        _buildKeyHint('Enter', 'Select'),
        _buildKeyHint('Up/Down', 'Navigate'),
        _buildKeyHint('esc', 'Close'),
      ];

  Component _buildKeyHint(String key, String label) {
    return dom.div(
      styles: const dom.Styles(
        raw: <String, String>{
          'display': 'flex',
          'align-items': 'center',
          'gap': 'var(--space-1)',
        },
      ),
      [
        dom.span(
          styles: const dom.Styles(
            raw: <String, String>{
              'padding': '2px 6px',
              'background-color': 'var(--muted)',
              'border-radius': 'var(--radius-xs)',
              'font-family':
                  'ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace',
            },
          ),
          [Component.text(key)],
        ),
        dom.span([Component.text(label)]),
      ],
    );
  }
}
