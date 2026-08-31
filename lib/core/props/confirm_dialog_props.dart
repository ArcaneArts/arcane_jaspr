import 'package:arcane_jaspr/flutter.dart';
import '../../component/view/icon.dart';

import '../../util/style_types/arcane_style_data.dart';
import '../decoration/arcane_decoration.dart';

/// Confirm dialog component properties.
class ConfirmDialogProps {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final void Function()? onConfirm;
  final void Function()? onCancel;
  final bool destructive;
  final ArcaneGlyph? icon;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const ConfirmDialogProps({
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
  });
}

/// Alert dialog component properties.
class AlertDialogProps {
  final String title;
  final String message;
  final String buttonText;
  final void Function()? onDismiss;
  final ArcaneGlyph? icon;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation intent + theme-specific
  /// fields honored-or-ignored per theme).
  final ArcaneDecoration? decoration;

  const AlertDialogProps({
    required this.title,
    required this.message,
    this.buttonText = 'OK',
    this.onDismiss,
    this.icon,
    this.styles,
    this.decoration,
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
