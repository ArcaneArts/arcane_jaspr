import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/dom.dart' as dom;
import 'package:arcane_jaspr/util/arcane.dart';

class Glass extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final EdgeInsets? padding;
  final double radius;
  final bool border;
  final bool disabled;

  const Glass({
    required this.child,
    this.blur = 18,
    this.opacity = 0.72,
    this.padding,
    this.radius = 16,
    this.border = true,
    this.disabled = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) => dom.div(
    styles: dom.Styles(raw: <String, String>{
      'padding': (padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12)).padding,
      'border-radius': '${radius}px',
      'background': disabled
          ? 'transparent'
          : 'color-mix(in srgb, var(--card) ${(opacity * 100).round()}%, transparent)',
      if (!disabled) 'backdrop-filter': 'blur(${blur}px)',
      if (border) 'border': '1px solid color-mix(in srgb, var(--border) 80%, transparent)',
    }),
    <Widget>[child],
  );
}
