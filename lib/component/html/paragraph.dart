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

/// A paragraph component that wraps the HTML `<p>` element.
///
/// Provides a Flutter-like API with direct `ArcaneStyleData` support,
/// eliminating the need to call `.toStyles()`.
///
/// Example:
/// ```dart
/// Paragraph(
///   styles: ArcaneStyleData(
///     fontSize: FontSize.lg,
///     textColor: TextColor.muted,
///     lineHeight: LineHeight.relaxed,
///   ),
///   child: ArcaneText('This is a paragraph of text.'),
/// )
/// ```
class Paragraph extends StatelessComponent {
  /// The content of the paragraph
  final Component child;

  /// Optional styling using ArcaneStyleData
  final ArcaneStyleData? styles;

  /// Optional CSS classes
  final String? classes;

  /// Optional ID attribute
  final String? id;

  const Paragraph({
    required this.child,
    this.styles,
    this.classes,
    this.id,
    super.key,
  });

  /// Create a paragraph with multiple children
  const factory Paragraph.children({
    required List<Component> children,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Key? key,
  }) = _ParagraphChildren;

  @override
  Component build(BuildContext context) {
    return p(
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      [child],
    );
  }
}

class _ParagraphChildren extends Paragraph {
  final List<Component> _children;

  const _ParagraphChildren({
    required List<Component> children,
    super.styles,
    super.classes,
    super.id,
    super.key,
  })  : _children = children,
        super(child: const _Placeholder());

  @override
  Component build(BuildContext context) {
    return p(
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
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
