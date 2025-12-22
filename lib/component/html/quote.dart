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

/// A quote component for displaying quoted text or citations.
///
/// This wraps the HTML `<blockquote>` element with a Flutter-like API.
///
/// Example:
/// ```dart
/// ArcaneQuote(
///   styles: ArcaneStyleData(
///     padding: PaddingPreset.lg,
///     borderLeft: BorderPreset.accent,
///   ),
///   children: [
///     ArcaneParagraph(child: ArcaneText('A wise quote...')),
///   ],
/// )
/// ```
class ArcaneQuote extends StatelessComponent {
  /// The children of the quote
  final List<Component> children;

  /// Optional styling using ArcaneStyleData
  final ArcaneStyleData? styles;

  /// Optional CSS classes
  final String? classes;

  /// Optional ID attribute
  final String? id;

  /// Additional HTML attributes
  final Map<String, String>? attributes;

  const ArcaneQuote({
    required this.children,
    this.styles,
    this.classes,
    this.id,
    this.attributes,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return blockquote(
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      attributes: attributes,
      children,
    );
  }
}

// Legacy alias for backwards compatibility
typedef ArcaneBlockquote = ArcaneQuote;
