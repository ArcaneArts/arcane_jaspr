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

/// Heading level enum
enum HeadingLevel { h1, h2, h3, h4, h5, h6 }

/// A heading component that wraps HTML heading elements (`<h1>` - `<h6>`).
///
/// Provides a Flutter-like API with direct `ArcaneStyleData` support,
/// eliminating the need to call `.toStyles()`.
///
/// Example:
/// ```dart
/// Heading(
///   level: HeadingLevel.h1,
///   styles: ArcaneStyleData(
///     fontSize: FontSize.hero,
///     textColor: TextColor.primary,
///   ),
///   child: ArcaneText('Page Title'),
/// )
///
/// // Or use named constructors:
/// Heading.h1(child: ArcaneText('Main Title'))
/// Heading.h2(child: ArcaneText('Section Title'))
/// ```
class Heading extends StatelessComponent {
  /// The heading level (h1-h6)
  final HeadingLevel level;

  /// The content of the heading
  final Component child;

  /// Optional styling using ArcaneStyleData
  final ArcaneStyleData? styles;

  /// Optional CSS classes
  final String? classes;

  /// Optional ID attribute
  final String? id;

  const Heading({
    required this.level,
    required this.child,
    this.styles,
    this.classes,
    this.id,
    super.key,
  });

  /// Create an h1 heading
  const Heading.h1({
    required this.child,
    this.styles,
    this.classes,
    this.id,
    super.key,
  }) : level = HeadingLevel.h1;

  /// Create an h2 heading
  const Heading.h2({
    required this.child,
    this.styles,
    this.classes,
    this.id,
    super.key,
  }) : level = HeadingLevel.h2;

  /// Create an h3 heading
  const Heading.h3({
    required this.child,
    this.styles,
    this.classes,
    this.id,
    super.key,
  }) : level = HeadingLevel.h3;

  /// Create an h4 heading
  const Heading.h4({
    required this.child,
    this.styles,
    this.classes,
    this.id,
    super.key,
  }) : level = HeadingLevel.h4;

  /// Create an h5 heading
  const Heading.h5({
    required this.child,
    this.styles,
    this.classes,
    this.id,
    super.key,
  }) : level = HeadingLevel.h5;

  /// Create an h6 heading
  const Heading.h6({
    required this.child,
    this.styles,
    this.classes,
    this.id,
    super.key,
  }) : level = HeadingLevel.h6;

  @override
  Component build(BuildContext context) {
    final content = [child];
    final resolvedStyles = styles?.toStyles() ?? const Styles(raw: {});

    switch (level) {
      case HeadingLevel.h1:
        return h1(id: id, classes: classes, styles: resolvedStyles, content);
      case HeadingLevel.h2:
        return h2(id: id, classes: classes, styles: resolvedStyles, content);
      case HeadingLevel.h3:
        return h3(id: id, classes: classes, styles: resolvedStyles, content);
      case HeadingLevel.h4:
        return h4(id: id, classes: classes, styles: resolvedStyles, content);
      case HeadingLevel.h5:
        return h5(id: id, classes: classes, styles: resolvedStyles, content);
      case HeadingLevel.h6:
        return h6(id: id, classes: classes, styles: resolvedStyles, content);
    }
  }
}
