import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/tokens/tokens.dart';
import '../input/button.dart';
import 'dialog.dart';

/// A confirmation dialog component.
class ConfirmDialog extends StatelessComponent {
  /// Dialog title
  final String title;

  /// Dialog message
  final String message;

  /// Confirm button text
  final String confirmText;

  /// Cancel button text
  final String cancelText;

  /// Confirm callback
  final void Function()? onConfirm;

  /// Cancel callback
  final void Function()? onCancel;

  /// Whether this is a destructive action
  final bool destructive;

  /// Custom icon
  final Component? icon;

  const ConfirmDialog({
    required this.title,
    required this.message,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.destructive = false,
    this.icon,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneDialog(
      title: title,
      onClose: onCancel,
      maxWidth: 400,
      child: div(
        classes: 'arcane-confirm-dialog-content',
        styles: Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'align-items': 'center',
          'text-align': 'center',
          'gap': ArcaneSpacing.md,
        }),
        [
          if (icon != null)
            div(
              styles: Styles(raw: {
                'font-size': '3rem',
                'color': destructive ? ArcaneColors.error : ArcaneColors.accent,
              }),
              [icon!],
            ),
          div(
            styles: Styles(raw: {
              'color': ArcaneColors.onSurface,
              'font-size': ArcaneTypography.fontSm,
              'line-height': ArcaneTypography.lineHeightRelaxed,
            }),
            [text(message)],
          ),
        ],
      ),
      actions: [
        ArcaneButton.outline(
          label: cancelText,
          onPressed: onCancel,
        ),
        destructive
            ? ArcaneButton.destructive(
                label: confirmText,
                onPressed: onConfirm,
              )
            : ArcaneButton.primary(
                label: confirmText,
                onPressed: onConfirm,
              ),
      ],
    );
  }
}

/// A simple alert dialog
class AlertDialog extends StatelessComponent {
  final String title;
  final String message;
  final String buttonText;
  final void Function()? onDismiss;
  final Component? icon;

  const AlertDialog({
    required this.title,
    required this.message,
    this.buttonText = 'OK',
    this.onDismiss,
    this.icon,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneDialog(
      title: title,
      onClose: onDismiss,
      maxWidth: 400,
      child: div(
        styles: Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'align-items': 'center',
          'text-align': 'center',
          'gap': ArcaneSpacing.md,
        }),
        [
          if (icon != null)
            div(
              styles: Styles(raw: {
                'font-size': '3rem',
                'color': ArcaneColors.accent,
              }),
              [icon!],
            ),
          div(
            styles: Styles(raw: {
              'color': ArcaneColors.onSurface,
              'font-size': ArcaneTypography.fontSm,
              'line-height': ArcaneTypography.lineHeightRelaxed,
            }),
            [text(message)],
          ),
        ],
      ),
      actions: [
        ArcaneButton.primary(
          label: buttonText,
          onPressed: onDismiss,
        ),
      ],
    );
  }
}
