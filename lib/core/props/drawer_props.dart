import 'package:arcane_jaspr/flutter.dart';

enum DrawerPosition {
  left,
  right,
  top,
  bottom,
}

enum DrawerSize {
  sm,
  md,
  lg,
  xl,
  full,
}

/// Drawer component properties.
class DrawerProps {
  final String? id;
  final bool isOpen;
  final void Function()? onClose;
  final DrawerPosition position;
  final DrawerSize size;
  final Widget child;
  final Widget? header;
  final Widget? footer;
  final bool showBackdrop;
  final bool closeOnBackdropClick;
  final bool showCloseButton;
  final String? width;
  final String? height;
  final bool escapeCloses;
  final bool focusTrap;
  final bool restoreFocus;

  const DrawerProps({
    this.id,
    required this.isOpen,
    required this.child,
    this.onClose,
    this.position = DrawerPosition.right,
    this.size = DrawerSize.md,
    this.header,
    this.footer,
    this.showBackdrop = true,
    this.closeOnBackdropClick = true,
    this.showCloseButton = true,
    this.width,
    this.height,
    this.escapeCloses = true,
    this.focusTrap = true,
    this.restoreFocus = true,
  });

  DrawerProps copyWith({
    String? id,
    bool? isOpen,
    void Function()? onClose,
    DrawerPosition? position,
    DrawerSize? size,
    Widget? child,
    Widget? header,
    Widget? footer,
    bool? showBackdrop,
    bool? closeOnBackdropClick,
    bool? showCloseButton,
    String? width,
    String? height,
    bool? escapeCloses,
    bool? focusTrap,
    bool? restoreFocus,
  }) {
    return DrawerProps(
      id: id ?? this.id,
      isOpen: isOpen ?? this.isOpen,
      onClose: onClose ?? this.onClose,
      position: position ?? this.position,
      size: size ?? this.size,
      child: child ?? this.child,
      header: header ?? this.header,
      footer: footer ?? this.footer,
      showBackdrop: showBackdrop ?? this.showBackdrop,
      closeOnBackdropClick: closeOnBackdropClick ?? this.closeOnBackdropClick,
      showCloseButton: showCloseButton ?? this.showCloseButton,
      width: width ?? this.width,
      height: height ?? this.height,
      escapeCloses: escapeCloses ?? this.escapeCloses,
      focusTrap: focusTrap ?? this.focusTrap,
      restoreFocus: restoreFocus ?? this.restoreFocus,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for drawer components.
mixin DrawerRendererContract {
  Widget drawer(DrawerProps props);
}
