import 'package:arcane_jaspr/component/support/icons.dart';
import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/dom.dart' as dom;

class FancyIcon extends StatelessWidget {
  final Widget? child;
  final IconData? icon;
  final IconSize size;
  final String? color;
  final String? backgroundColor;
  final double padding;
  final bool round;

  const FancyIcon({
    this.child,
    this.icon,
    this.size = IconSize.lg,
    this.color,
    this.backgroundColor,
    this.padding = 12,
    this.round = true,
    super.key,
  }) : assert(child != null || icon != null);

  @override
  Widget build(BuildContext context) => dom.span(
    styles: dom.Styles(raw: <String, String>{
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'padding': '${padding}px',
      'border-radius': round ? '9999px' : '0.75rem',
      'background': backgroundColor ?? 'color-mix(in srgb, var(--primary) 12%, transparent)',
      'color': ?color,
    }),
    <Widget>[child ?? Icon(icon!, size: size)],
  );
}
