import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';

export '../../core/props/confirm_dialog_props.dart';

/// Confirmation dialog with confirm/cancel actions.
class ArcaneConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final void Function()? onConfirm;
  final void Function()? onCancel;
  final bool destructive;
  final Widget? icon;
  final ArcaneStyleData? styles;
  final ArcaneDecoration? decoration;

  const ArcaneConfirmDialog({
    required this.title,
    required this.message,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.destructive = false,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return context.renderers.confirmDialog(ConfirmDialogProps(
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      destructive: destructive,
      icon: icon,
      styles: styles,
      decoration: decoration,
    ));
  }
}

/// Simple alert dialog with single dismiss action.
class ArcaneAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final void Function()? onDismiss;
  final Widget? icon;
  final ArcaneStyleData? styles;
  final ArcaneDecoration? decoration;

  const ArcaneAlertDialog({
    required this.title,
    required this.message,
    this.buttonText = 'OK',
    this.onDismiss,
    this.icon,
    this.styles,
    this.decoration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return context.renderers.alertDialog(AlertDialogProps(
      title: title,
      message: message,
      buttonText: buttonText,
      onDismiss: onDismiss,
      icon: icon,
      styles: styles,
      decoration: decoration,
    ));
  }
}
