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

/// An inline styling component that wraps the HTML `<span>` element.
///
/// Use this to apply styles to portions of text within a larger block.
///
/// Example:
/// ```dart
/// ArcaneSpan(
///   styles: ArcaneStyleData(
///     textColor: TextColor.accent,
///     fontWeight: FontWeight.bold,
///   ),
///   child: ArcaneText('Highlighted text'),
/// )
/// ```
class ArcaneSpan extends StatelessComponent {
  /// The content of the span
  final Component child;

  /// Optional styling using ArcaneStyleData
  final ArcaneStyleData? styles;

  /// Optional CSS classes
  final String? classes;

  /// Optional ID attribute
  final String? id;

  /// Event handlers
  final Map<String, void Function(dynamic)>? events;

  const ArcaneSpan({
    required this.child,
    this.styles,
    this.classes,
    this.id,
    this.events,
    super.key,
  });

  /// Create a span with multiple children
  const factory ArcaneSpan.children({
    required List<Component> children,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Map<String, void Function(dynamic)>? events,
    Key? key,
  }) = _ArcaneSpanChildren;

  @override
  Component build(BuildContext context) {
    return span(
      id: id,
      classes: classes,
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
  })  : _children = children,
        super(child: const _Placeholder());

  @override
  Component build(BuildContext context) {
    return span(
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      events: events,
      _children,
    );
  }
}

/// Placeholder component for factory constructor
class _Placeholder extends StatelessComponent {
  const _Placeholder();
  @override
  Component build(BuildContext context) => const Component.text('');
}
