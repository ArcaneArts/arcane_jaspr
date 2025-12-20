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

/// A main component that wraps the HTML `<main>` element.
class Main extends StatelessComponent {
  final List<Component> children;
  final ArcaneStyleData? styles;
  final String? classes;
  final String? id;

  const Main({
    required this.children,
    this.styles,
    this.classes,
    this.id,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return main_(
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      children,
    );
  }
}

/// A header component that wraps the HTML `<header>` element.
class Header extends StatelessComponent {
  final List<Component> children;
  final ArcaneStyleData? styles;
  final String? classes;
  final String? id;

  const Header({
    required this.children,
    this.styles,
    this.classes,
    this.id,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return header(
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      children,
    );
  }
}

/// A footer component that wraps the HTML `<footer>` element.
class ArcaneFooter extends StatelessComponent {
  final List<Component> children;
  final ArcaneStyleData? styles;
  final String? classes;
  final String? id;

  const ArcaneFooter({
    required this.children,
    this.styles,
    this.classes,
    this.id,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return footer(
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      children,
    );
  }
}
