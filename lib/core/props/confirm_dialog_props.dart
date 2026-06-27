import 'package:arcane_jaspr/flutter.dart';

/// Confirm dialog component properties.
class ConfirmDialogProps {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final void Function()? onConfirm;
  final void Function()? onCancel;
  final bool destructive;
  final Widget? icon;

  const ConfirmDialogProps({
    required this.title,
    required this.message,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.destructive = false,
    this.icon,
  });
}

/// Alert dialog component properties.
class AlertDialogProps {
  final String title;
  final String message;
  final String buttonText;
  final void Function()? onDismiss;
  final Widget? icon;

  const AlertDialogProps({
    required this.title,
    required this.message,
    this.buttonText = 'OK',
    this.onDismiss,
    this.icon,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for confirm and alert dialog components.
mixin ConfirmDialogRendererContract {
  Widget confirmDialog(ConfirmDialogProps props);
  Widget alertDialog(AlertDialogProps props);
}
