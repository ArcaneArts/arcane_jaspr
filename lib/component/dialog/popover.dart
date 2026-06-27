import 'package:arcane_jaspr/flutter.dart';

import '../view/floating.dart';

export '../../core/props/floating_props.dart' show FloatingPosition;

class ArcanePopover extends StatelessWidget {
  final String? id;
  final Widget trigger;
  final Widget content;
  final FloatingPosition position;
  final bool? isOpen;
  final void Function(bool isOpen)? onOpenChange;
  final bool showArrow;
  final int offset;
  final bool closeOnOutsideClick;
  final bool closeOnEscape;

  const ArcanePopover({
    this.id,
    required this.trigger,
    required this.content,
    this.position = FloatingPosition.bottom,
    this.isOpen,
    this.onOpenChange,
    this.showArrow = true,
    this.offset = 8,
    this.closeOnOutsideClick = true,
    this.closeOnEscape = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ArcaneHoverCard.popover(
      id: id,
      trigger: trigger,
      content: content,
      position: position,
      isOpen: isOpen,
      onOpenChange: onOpenChange,
      showArrow: showArrow,
      offset: offset,
      closeOnOutsideClick: closeOnOutsideClick,
      closeOnEscape: closeOnEscape,
    );
  }
}
