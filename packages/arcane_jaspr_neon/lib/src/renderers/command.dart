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
  Map<String, String> get overlayStyles => const <String, String>{};

  @override
  String get dialogClasses => 'neon-command-dialog neon-panel';

  @override
  Map<String, String> get dialogStyles => const <String, String>{};

  @override
  Map<String, String> get searchRowStyles => const <String, String>{};

  @override
  Map<String, String> get searchIconStyles => const <String, String>{};

  @override
  String get inputClass => 'neon-command-input';

  @override
  String get inputStyleSuffix => '';

  @override
  String get listClasses => 'neon-command-list';

  @override
  Map<String, String> get listStyles => const <String, String>{};

  @override
  String get groupHeadingClass => 'neon-command-group-heading';

  @override
  Map<String, String> get groupHeadingStyles => const <String, String>{};

  @override
  Map<String, String> get footerStyles => const <String, String>{};

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
