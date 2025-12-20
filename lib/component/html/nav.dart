import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight,
        FontStyle,
        StyleRule,
        Display,
        Position,
        Overflow,
        Cursor,
        Visibility,
        TextDecoration,
        TextTransform,
        FontFamily,
        WhiteSpace,
        events;

import '../../util/style_types/arcane_style_data.dart';

/// A nav component that wraps the HTML `<nav>` element.
class ArcaneNav extends StatelessComponent {
  final List<Component> children;
  final ArcaneStyleData? styles;
  final String? classes;
  final String? id;

  const ArcaneNav({
    required this.children,
    this.styles,
    this.classes,
    this.id,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return nav(
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      children,
    );
  }
}
