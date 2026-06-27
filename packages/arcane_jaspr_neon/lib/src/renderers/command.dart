import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/command_props.dart';
import 'package:arcane_jaspr/core/rendering/base/command_render_base.dart';

/// Neon Command renderer.
class NeonCommand extends CommandRenderBase {
  const NeonCommand(super.props, {super.key});

  static int _autoCounter = 0;

  @override
  String autoId() {
    _autoCounter++;
    return 'neon-command-$_autoCounter';
  }

  @override
  String get overlayClasses => 'neon-command-overlay arcane-overlay-scrim';

  @override
  Map<String, String> get overlayStyles => const <String, String>{
        'position': 'fixed',
        'inset': '0',
        'z-index': '50',
        'display': 'flex',
        'align-items': 'flex-start',
        'justify-content': 'center',
        'padding-top': '20vh',
        'background':
            'color-mix(in srgb, var(--neon-surface-0) 78%, transparent)',
        'backdrop-filter': 'blur(8px) saturate(1.1)',
        '-webkit-backdrop-filter': 'blur(8px) saturate(1.1)',
        'animation': 'arcane-fade-in var(--arcane-transition-slow)',
      };

  @override
  String get dialogClasses => 'neon-command-dialog neon-panel';

  @override
  Map<String, String> get dialogStyles => const <String, String>{
        'width': '100%',
        'max-width': '640px',
        'color': 'var(--foreground)',
        'overflow': 'hidden',
        'animation': 'arcane-scale-in var(--arcane-transition-slow)',
      };

  @override
  Map<String, String> get searchRowStyles => const <String, String>{
        'display': 'flex',
        'align-items': 'center',
        'gap': '12px',
        'padding': '14px 18px',
        'border-bottom': '1px solid var(--neon-panel-border)',
      };

  @override
  Map<String, String> get searchIconStyles => const <String, String>{
        'color': 'var(--neon-accent)',
        'display': 'flex',
        'align-items': 'center',
      };

  @override
  String get inputClass => 'neon-command-input';

  @override
  String get inputStyleSuffix =>
      'font-size:0.9375rem;color:var(--foreground);outline:none;letter-spacing:0.01em;';

  @override
  String get listClasses => 'neon-command-list';

  @override
  Map<String, String> get listStyles => const <String, String>{
        'max-height': '400px',
        'overflow-y': 'auto',
        'padding': '10px',
      };

  @override
  String get groupHeadingClass => 'neon-command-group-heading';

  @override
  Map<String, String> get groupHeadingStyles => const <String, String>{
        'padding': '10px 14px 4px',
        'font-family': 'var(--font-heading)',
        'font-size': '0.6875rem',
        'font-weight': '600',
        'color': 'var(--muted-foreground)',
        'text-transform': 'uppercase',
        'letter-spacing': '0.12em',
      };

  @override
  Map<String, String> get footerStyles => const <String, String>{
        'display': 'flex',
        'align-items': 'center',
        'gap': '20px',
        'padding': '10px 16px',
        'border-top': '1px solid var(--neon-panel-border)',
        'font-size': 'var(--font-size-xs)',
        'color': 'var(--muted-foreground)',
      };

  @override
  String get itemBaseClass => 'neon-command-item';

  @override
  Map<String, String> itemStyles(CommandItemProps item) => <String, String>{
        'display': 'flex',
        'align-items': 'center',
        'gap': '10px',
        'padding': '10px 14px',
        'clip-path': 'var(--neon-clip-xs)',
        'cursor': item.disabled ? 'not-allowed' : 'pointer',
        'transition': 'background-color var(--arcane-transition)',
        if (item.disabled) 'opacity': '0.5',
      };

  @override
  Component buildShortcut(String shortcut) => dom.span(
        classes: 'neon-kbd',
        styles: const dom.Styles(
          raw: <String, String>{
            'font-size': 'var(--font-size-xs)',
            'padding': '3px 8px',
          },
        ),
        [Component.text(shortcut)],
      );

  @override
  List<Component> buildKeyHints() => <Component>[
        _buildKeyHint('\u{21B5}', 'Select'),
        _buildKeyHint('\u{2191}\u{2193}', 'Navigate'),
        _buildKeyHint('esc', 'Close'),
      ];

  Component _buildKeyHint(String key, String label) {
    return dom.div(
      styles: const dom.Styles(
        raw: <String, String>{
          'display': 'flex',
          'align-items': 'center',
          'gap': '6px',
        },
      ),
      [
        dom.span(
          classes: 'neon-kbd',
          styles: const dom.Styles(
            raw: <String, String>{'padding': '3px 8px'},
          ),
          [Component.text(key)],
        ),
        dom.span([Component.text(label)]),
      ],
    );
  }
}
