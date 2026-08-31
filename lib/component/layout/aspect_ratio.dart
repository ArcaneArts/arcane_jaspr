import 'package:arcane_jaspr/flutter.dart';

import '../../util/classes.dart';
import '../../core/theme_provider.dart';

export '../../core/props/aspect_ratio_props.dart';

/// A container that maintains a specific aspect ratio.
class ArcaneAspectRatio extends StatelessWidget {
  final double ratio;
  final Widget child;
  final List<String>? classes;
  final Map<String, String>? styles;

  const ArcaneAspectRatio({
    required this.ratio,
    required this.child,
    this.classes,
    this.styles,
    super.key,
  });

  const ArcaneAspectRatio.square({
    required this.child,
    this.classes,
    this.styles,
    super.key,
  }) : ratio = 1.0;

  const ArcaneAspectRatio.video({
    required this.child,
    this.classes,
    this.styles,
    super.key,
  }) : ratio = 16 / 9;

  const ArcaneAspectRatio.ultrawide({
    required this.child,
    this.classes,
    this.styles,
    super.key,
  }) : ratio = 21 / 9;

  const ArcaneAspectRatio.portrait({
    required this.child,
    this.classes,
    this.styles,
    super.key,
  }) : ratio = 3 / 4;

  const ArcaneAspectRatio.photo({
    required this.child,
    this.classes,
    this.styles,
    super.key,
  }) : ratio = 4 / 3;

  const ArcaneAspectRatio.golden({
    required this.child,
    this.classes,
    this.styles,
    super.key,
  }) : ratio = 1.618;

  @override
  Widget build(BuildContext context) {
    return context.renderers.aspectRatio(
      AspectRatioProps(
        ratio: ratio,
        child: child,
        classes: classes == null ? null : cx(classes!),
        styles: styles,
      ),
    );
  }
}
