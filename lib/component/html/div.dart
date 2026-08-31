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

/// Styled div wrapper.
class ArcaneDiv extends StatelessComponent {
  final List<Component> children;
  final ArcaneStyleData? styles;
  final List<String>? classes;
  final String? id;
  final Map<String, void Function(dynamic)>? events;
  final Map<String, String>? attributes;

  const ArcaneDiv({
    required this.children,
    this.styles,
    this.classes,
    this.id,
    this.events,
    this.attributes,
    super.key,
  });

  const factory ArcaneDiv.child({
    required Component child,
    ArcaneStyleData? styles,
    List<String>? classes,
    String? id,
    Map<String, void Function(dynamic)>? events,
    Map<String, String>? attributes,
    Key? key,
  }) = _ArcaneDivChild;

  @override
  Component build(BuildContext context) {
    return div(
      id: id,
      classes: classes == null ? null : cx(classes!),
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      events: events,
      attributes: attributes,
      children,
    );
  }
}

class _ArcaneDivChild extends ArcaneDiv {
  final Component _child;

  const _ArcaneDivChild({
    required Component child,
    super.styles,
    super.classes,
    super.id,
    super.events,
    super.attributes,
    super.key,
  }) : _child = child,
       super(children: const []);

  @override
  Component build(BuildContext context) {
    return div(
      id: id,
      classes: classes == null ? null : cx(classes!),
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      events: events,
      attributes: attributes,
      [_child],
    );
  }
}
