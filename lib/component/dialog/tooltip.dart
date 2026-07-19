import 'package:arcane_jaspr/flutter.dart';

import '../view/floating.dart';

export '../../core/props/floating_props.dart' show FloatingPosition;

class ArcaneTooltip extends StatelessWidget {
  final Widget child;
  final String? text;
  final Widget? content;
  final FloatingPosition position;
  final double? maxWidth;

  const ArcaneTooltip({
    required this.child,
    required this.text,
    this.position = FloatingPosition.top,
    this.maxWidth = 250,
    super.key,
  }) : content = null;

  const ArcaneTooltip.custom({
    required this.child,
    required this.content,
    this.position = FloatingPosition.top,
    this.maxWidth,
    super.key,
  }) : text = null;

  @override
  Widget build(BuildContext context) {
    final Widget? currentContent = content;
    if (currentContent != null) {
      return ArcaneHoverCard.tooltipCustom(
        child: child,
        content: currentContent,
        position: position,
        maxWidth: maxWidth,
      );
    }

    return ArcaneHoverCard.tooltip(
      child: child,
      textContent: text ?? '',
      position: position,
      maxWidth: maxWidth ?? 250,
    );
  }
}
