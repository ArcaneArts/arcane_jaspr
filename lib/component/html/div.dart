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

/// A div component that wraps the HTML `<div>` element.
///
/// Provides a Flutter-like API with direct `ArcaneStyleData` support,
/// eliminating the need to call `.toStyles()`.
///
/// Example:
/// ```dart
/// Div(
///   styles: ArcaneStyleData(
///     display: Display.flex,
///     flexDirection: FlexDirection.column,
///     gap: Gap.md,
///     padding: PaddingPreset.lg,
///   ),
///   children: [
///     Paragraph(child: ArcaneText('First paragraph')),
///     Paragraph(child: ArcaneText('Second paragraph')),
///   ],
/// )
/// ```
class Div extends StatelessComponent {
  /// The children of the div
  final List<Component> children;

  /// Optional styling using ArcaneStyleData
  final ArcaneStyleData? styles;

  /// Optional CSS classes
  final String? classes;

  /// Optional ID attribute
  final String? id;

  /// Event handlers
  final Map<String, void Function(dynamic)>? events;

  const Div({
    required this.children,
    this.styles,
    this.classes,
    this.id,
    this.events,
    super.key,
  });

  /// Create a div with a single child
  const factory Div.child({
    required Component child,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Map<String, void Function(dynamic)>? events,
    Key? key,
  }) = _DivChild;

  @override
  Component build(BuildContext context) {
    return div(
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      events: events,
      children,
    );
  }
}

class _DivChild extends Div {
  final Component _child;

  const _DivChild({
    required Component child,
    super.styles,
    super.classes,
    super.id,
    super.events,
    super.key,
  })  : _child = child,
        super(children: const []);

  @override
  Component build(BuildContext context) {
    return div(
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      events: events,
      [_child],
    );
  }
}
