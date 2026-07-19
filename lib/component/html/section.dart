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

/// Styled section element wrapper.
class ArcaneHtmlSection extends StatelessComponent {
  final List<Component> children;
  final ArcaneStyleData? styles;
  final List<String>? classes;
  final String? id;

  const ArcaneHtmlSection({
    required this.children,
    this.styles,
    this.classes,
    this.id,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return section(
      id: id,
      classes: classes == null ? null : cx(classes!),
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      children,
    );
  }
}
