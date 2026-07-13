import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/button_props.dart';
import 'package:arcane_jaspr/core/props/dialog_props.dart';
import 'package:arcane_jaspr/core/rendering/base/confirm_dialog_render_base.dart';
import 'button.dart';
import 'dialog.dart';

/// Win95 Confirm Dialog renderer (neutralized skeleton).
class Win95ConfirmDialog extends ConfirmDialogRenderBase {
  const Win95ConfirmDialog(super.props, {super.key});

  @override
  Component buildDialog(DialogProps props) => Win95Dialog(props);

  @override
  Component buildButton(ButtonProps props) => Win95Button(props);

  @override
  double get maxWidth => 420;

  @override
  String get contentClass => 'win95-confirm-dialog-content';

  @override
  String get contentGap => '1.25rem';

  @override
  String get messageFontSize => '0.9375rem';

  @override
  Component buildIcon(Component icon, bool destructive) => dom.div(
    classes: 'win95-confirm-dialog-icon',
    styles: const dom.Styles(
      raw: <String, String>{
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': '3rem',
        'height': '3rem',
        'font-size': '1.5rem',
      },
    ),
    <Component>[icon],
  );
}

/// Win95 Alert Dialog renderer (neutralized skeleton).
class Win95AlertDialog extends AlertDialogRenderBase {
  const Win95AlertDialog(super.props, {super.key});

  @override
  Component buildDialog(DialogProps props) => Win95Dialog(props);

  @override
  Component buildButton(ButtonProps props) => Win95Button(props);

  @override
  double get maxWidth => 420;

  @override
  String get contentGap => '1.25rem';

  @override
  String get messageFontSize => '0.9375rem';

  @override
  Component buildIcon(Component icon) => dom.div(
    classes: 'win95-confirm-dialog-icon',
    styles: const dom.Styles(
      raw: <String, String>{
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': '3rem',
        'height': '3rem',
        'font-size': '1.5rem',
      },
    ),
    <Component>[icon],
  );
}
