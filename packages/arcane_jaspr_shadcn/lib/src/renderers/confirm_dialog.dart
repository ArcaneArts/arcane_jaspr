import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/button_props.dart';
import 'package:arcane_jaspr/core/props/dialog_props.dart';
import 'package:arcane_jaspr/core/rendering/base/confirm_dialog_render_base.dart';
import 'button.dart';
import 'dialog.dart';

/// ShadCN Confirm Dialog renderer.
class ShadcnConfirmDialog extends ConfirmDialogRenderBase {
  const ShadcnConfirmDialog(super.props, {super.key});

  @override
  Component buildDialog(DialogProps props) => ShadcnDialog(props);

  @override
  Component buildButton(ButtonProps props) => ShadcnButton(props);

  @override
  double get maxWidth => 400;

  @override
  String get contentClass => 'arcane-confirm-dialog-content';

  @override
  String get contentGap => 'var(--space-4)';

  @override
  String get messageFontSize => 'var(--font-size-sm)';

  @override
  Component buildIcon(Component icon, bool destructive) => dom.div(
    styles: dom.Styles(
      raw: {
        'font-size': '3rem',
        'color': destructive ? 'var(--destructive)' : 'var(--accent)',
      },
    ),
    [icon],
  );
}

/// ShadCN Alert Dialog renderer.
class ShadcnAlertDialog extends AlertDialogRenderBase {
  const ShadcnAlertDialog(super.props, {super.key});

  @override
  Component buildDialog(DialogProps props) => ShadcnDialog(props);

  @override
  Component buildButton(ButtonProps props) => ShadcnButton(props);

  @override
  double get maxWidth => 400;

  @override
  String get contentGap => 'var(--space-4)';

  @override
  String get messageFontSize => 'var(--font-size-sm)';

  @override
  Component buildIcon(Component icon) => dom.div(
    styles: const dom.Styles(
      raw: {'font-size': '3rem', 'color': 'var(--accent)'},
    ),
    [icon],
  );
}
