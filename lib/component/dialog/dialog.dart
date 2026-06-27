import 'package:arcane_jaspr/flutter.dart';

import '../../core/theme_provider.dart';

class ArcaneDialog extends StatelessWidget {
  final String? id;
  final bool isOpen;
  final String? title;
  final Widget? _child;
  final List<Widget>? _children;
  final List<Widget>? actions;
  final bool showCloseButton;
  final void Function()? onClose;
  final double maxWidth;
  final bool barrierDismissible;
  final bool escapeCloses;
  final bool focusTrap;
  final bool restoreFocus;

  const ArcaneDialog({
    this.id,
    this.isOpen = false,
    this.title,
    Widget? child,
    List<Widget>? children,
    this.actions,
    this.showCloseButton = true,
    this.onClose,
    this.maxWidth = 500,
    this.barrierDismissible = true,
    this.escapeCloses = true,
    this.focusTrap = true,
    this.restoreFocus = true,
    super.key,
  })  : _child = child,
        _children = children,
        assert(child != null || children != null,
            'Either child or children must be provided');

  @override
  Widget build(BuildContext context) {
    final List<Widget> content = _children ?? <Widget>[_child!];

    return context.renderers.dialog(DialogProps(
      id: id,
      isOpen: isOpen,
      title: title,
      content: content,
      actions: actions,
      showCloseButton: showCloseButton,
      onClose: onClose,
      maxWidth: maxWidth,
      barrierDismissible: barrierDismissible,
      escapeCloses: escapeCloses,
      focusTrap: focusTrap,
      restoreFocus: restoreFocus,
    ));
  }
}
