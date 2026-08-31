import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/command_props.dart';
import 'package:arcane_jaspr/core/rendering/base/command_render_base.dart';

/// Neon Command renderer (neutralized skeleton).
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
    'z-index': '1000',
    'display': 'flex',
    'align-items': 'center',
    'justify-content': 'center',
    'box-sizing': 'border-box',
    'padding': '1rem',
    'overflow-y': 'auto',
    'background': 'color-mix(in srgb, var(--background) 84%, transparent)',
  };

  @override
  String get dialogClasses => 'neon-command-dialog neon-panel';

  @override
  Map<String, String> get dialogStyles => const <String, String>{
    'display': 'grid',
    'grid-template-rows': 'auto minmax(0, 1fr) auto',
    'width': 'min(42rem, 100%)',
    'max-height': 'calc(100dvh - 2rem)',
    'padding': '0',
    'overflow': 'hidden',
  };

  @override
  Map<String, String> get searchRowStyles => const <String, String>{
    'display': 'flex',
    'align-items': 'center',
    'gap': '0.75rem',
    'padding': '0.875rem 1rem',
    'border-bottom': '1px solid var(--border)',
  };

  @override
  Map<String, String> get searchIconStyles => const <String, String>{
    'display': 'inline-flex',
    'color': 'var(--muted-foreground)',
  };

  @override
  String get inputClass => 'neon-command-input';

  @override
  String get inputStyleSuffix =>
      'min-width:0;color:var(--foreground);font:inherit;';

  @override
  String get listClasses => 'neon-command-list';

  @override
  Map<String, String> get listStyles => const <String, String>{
    'min-height': '0',
    'overflow-y': 'auto',
    'background': 'transparent',
    'border': '0',
    'border-radius': '0',
  };

  @override
  String get groupHeadingClass => 'neon-command-group-heading';

  @override
  Map<String, String> get groupHeadingStyles => const <String, String>{};

  @override
  Map<String, String> get footerStyles => const <String, String>{
    'display': 'flex',
    'align-items': 'center',
    'justify-content': 'flex-end',
    'gap': '0.75rem',
    'padding': '0.75rem 1rem',
    'border-top': '1px solid var(--border)',
    'color': 'var(--muted-foreground)',
    'font-size': 'var(--font-size-xs)',
  };

  @override
  String get itemBaseClass => 'neon-command-item';

  @override
  Map<String, String> itemStyles(CommandItemProps item) =>
      const <String, String>{};

  @override
  Component buildShortcut(String shortcut) =>
      dom.span(<Component>[Component.text(shortcut)]);

  @override
  List<Component> buildKeyHints() => <Component>[
    _buildKeyHint('\u{21B5}', 'Select'),
    _buildKeyHint('\u{2191}\u{2193}', 'Navigate'),
    _buildKeyHint('esc', 'Close'),
  ];

  Component _buildKeyHint(String key, String label) => dom.div(
    styles: const dom.Styles(
      raw: <String, String>{
        'display': 'flex',
        'align-items': 'center',
        'gap': '6px',
      },
    ),
    <Component>[
      dom.span(<Component>[Component.text(key)]),
      dom.span(<Component>[Component.text(label)]),
    ],
  );
}
