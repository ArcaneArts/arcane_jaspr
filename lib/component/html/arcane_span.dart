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

/// Styled inline span wrapper.
class ArcaneSpan extends StatelessComponent {
  final Component child;
  final ArcaneStyleData? styles;
  final List<String>? classes;
  final String? id;
  final Map<String, void Function(dynamic)>? events;

  const ArcaneSpan({
    required this.child,
    this.styles,
    this.classes,
    this.id,
    this.events,
    super.key,
  });

  const factory ArcaneSpan.children({
    required List<Component> children,
    ArcaneStyleData? styles,
    List<String>? classes,
    String? id,
    Map<String, void Function(dynamic)>? events,
    Key? key,
  }) = _ArcaneSpanChildren;

  @override
  Component build(BuildContext context) {
    return span(
      id: id,
      classes: classes == null ? null : cx(classes!),
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      events: events,
      [child],
    );
  }
}

class _ArcaneSpanChildren extends ArcaneSpan {
  final List<Component> _children;

  const _ArcaneSpanChildren({
    required List<Component> children,
    super.styles,
    super.classes,
    super.id,
    super.events,
    super.key,
  }) : _children = children,
       super(child: const _Placeholder());

  @override
  Component build(BuildContext context) {
    return span(
      id: id,
      classes: classes == null ? null : cx(classes!),
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      events: events,
      _children,
    );
  }
}

class _Placeholder extends StatelessComponent {
  const _Placeholder();
  @override
  Component build(BuildContext context) => const Component.text('');
}
