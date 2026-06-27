import 'package:arcane_jaspr/flutter.dart';

import '../../core/theme_provider.dart';

export '../../core/props/drawer_props.dart' show DrawerPosition, DrawerSize;

/// Slide-in drawer/sheet panel.
class ArcaneDrawer extends StatelessWidget {
  final String? id;
  final bool isOpen;
  final VoidCallback? onClose;
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

  const ArcaneDrawer({
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
    super.key,
  });

  const ArcaneDrawer.right({
    this.id,
    required this.isOpen,
    required this.child,
    this.onClose,
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
    super.key,
  }) : position = DrawerPosition.right;

  const ArcaneDrawer.left({
    this.id,
    required this.isOpen,
    required this.child,
    this.onClose,
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
    super.key,
  }) : position = DrawerPosition.left;

  const ArcaneDrawer.bottom({
    this.id,
    required this.isOpen,
    required this.child,
    this.onClose,
    this.size = DrawerSize.md,
    this.header,
    this.footer,
    this.showBackdrop = true,
    this.closeOnBackdropClick = true,
    this.showCloseButton = false,
    this.width,
    this.height,
    this.escapeCloses = true,
    this.focusTrap = true,
    this.restoreFocus = true,
    super.key,
  }) : position = DrawerPosition.bottom;

  @override
  Widget build(BuildContext context) {
    return context.renderers.drawer(DrawerProps(
      id: id,
      isOpen: isOpen,
      onClose: onClose,
      position: position,
      size: size,
      child: child,
      header: header,
      footer: footer,
      showBackdrop: showBackdrop,
      closeOnBackdropClick: closeOnBackdropClick,
      showCloseButton: showCloseButton,
      width: width,
      height: height,
      escapeCloses: escapeCloses,
      focusTrap: focusTrap,
      restoreFocus: restoreFocus,
    ));
  }
}
