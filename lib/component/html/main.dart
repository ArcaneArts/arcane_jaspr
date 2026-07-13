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

import '../../util/classes.dart';
import '../../util/style_types/arcane_style_data.dart';

/// Styled main element wrapper.
class ArcaneMain extends StatelessComponent {
  final List<Component> children;
  final ArcaneStyleData? styles;
  final List<String>? classes;
  final String? id;

  const ArcaneMain({
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
      classes: classes == null ? null : cx(classes!),
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      children,
    );
  }
}

/// Styled header element wrapper.
class ArcaneHeader extends StatelessComponent {
  final List<Component> children;
  final ArcaneStyleData? styles;
  final List<String>? classes;
  final String? id;

  const ArcaneHeader({
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
      classes: classes == null ? null : cx(classes!),
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      children,
    );
  }
}

/// Styled footer element wrapper.
class ArcaneFooter extends StatelessComponent {
  final List<Component> children;
  final ArcaneStyleData? styles;
  final List<String>? classes;
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
      classes: classes == null ? null : cx(classes!),
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      children,
    );
  }
}
