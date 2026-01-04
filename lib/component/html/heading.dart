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
import '../../util/tokens/tokens.dart';

/// Heading level enum
enum HeadingLevel { h1, h2, h3, h4, h5, h6 }

/// A heading component that wraps HTML heading elements (`<h1>` - `<h6>`).
///
/// Provides a Flutter-like API with direct `ArcaneStyleData` support,
/// eliminating the need to call `.toStyles()`.
///
/// Example:
/// ```dart
/// // Using child:
/// ArcaneHeading.h1(child: ArcaneText('Main Title'))
///
/// // Using text: convenience parameter
/// ArcaneHeading.h1(text: 'Main Title')
///
/// // With styling:
/// ArcaneHeading(
///   level: HeadingLevel.h1,
///   text: 'Page Title',
///   styles: ArcaneStyleData(
///     fontSize: FontSize.hero,
///     textColor: TextColor.primary,
///   ),
/// )
/// ```
class ArcaneHeading extends StatelessComponent {
  /// The heading level (h1-h6)
  final HeadingLevel level;

  /// The content of the heading (single child)
  final Component? _child;

  /// The content of the heading (multiple children)
  final List<Component>? _children;

  /// Convenience text parameter - creates a Text component automatically
  final String? text;

  /// Optional styling using ArcaneStyleData
  final ArcaneStyleData? styles;

  /// Optional CSS classes
  final String? classes;

  /// Optional ID attribute
  final String? id;

  /// Creates a heading with the specified level.
  ///
  /// Provide either [child], [text], or use [ArcaneHeading._withChildren] for multiple children.
  const ArcaneHeading({
    required this.level,
    Component? child,
    this.text,
    this.styles,
    this.classes,
    this.id,
    super.key,
  })  : _child = child,
        _children = null,
        assert(child != null || text != null,
            'Either child or text must be provided');

  const ArcaneHeading._withChildren({
    required this.level,
    required List<Component> children,
    this.text,
    this.styles,
    this.classes,
    this.id,
    super.key,
  })  : _child = null,
        _children = children;

  /// Create an h1 heading
  ///
  /// Provide either [child] or [text].
  const ArcaneHeading.h1({
    Component? child,
    String? text,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Key? key,
  }) : this(
          level: HeadingLevel.h1,
          child: child,
          text: text,
          styles: styles,
          classes: classes,
          id: id,
          key: key,
        );

  /// Create an h1 heading with multiple children
  const ArcaneHeading.h1Children({
    required List<Component> children,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Key? key,
  }) : this._withChildren(
          level: HeadingLevel.h1,
          children: children,
          styles: styles,
          classes: classes,
          id: id,
          key: key,
        );

  /// Create an h2 heading
  ///
  /// Provide either [child] or [text].
  const ArcaneHeading.h2({
    Component? child,
    String? text,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Key? key,
  }) : this(
          level: HeadingLevel.h2,
          child: child,
          text: text,
          styles: styles,
          classes: classes,
          id: id,
          key: key,
        );

  /// Create an h2 heading with multiple children
  const ArcaneHeading.h2Children({
    required List<Component> children,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Key? key,
  }) : this._withChildren(
          level: HeadingLevel.h2,
          children: children,
          styles: styles,
          classes: classes,
          id: id,
          key: key,
        );

  /// Create an h3 heading
  ///
  /// Provide either [child] or [text].
  const ArcaneHeading.h3({
    Component? child,
    String? text,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Key? key,
  }) : this(
          level: HeadingLevel.h3,
          child: child,
          text: text,
          styles: styles,
          classes: classes,
          id: id,
          key: key,
        );

  /// Create an h3 heading with multiple children
  const ArcaneHeading.h3Children({
    required List<Component> children,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Key? key,
  }) : this._withChildren(
          level: HeadingLevel.h3,
          children: children,
          styles: styles,
          classes: classes,
          id: id,
          key: key,
        );

  /// Create an h4 heading
  ///
  /// Provide either [child] or [text].
  const ArcaneHeading.h4({
    Component? child,
    String? text,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Key? key,
  }) : this(
          level: HeadingLevel.h4,
          child: child,
          text: text,
          styles: styles,
          classes: classes,
          id: id,
          key: key,
        );

  /// Create an h4 heading with multiple children
  const ArcaneHeading.h4Children({
    required List<Component> children,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Key? key,
  }) : this._withChildren(
          level: HeadingLevel.h4,
          children: children,
          styles: styles,
          classes: classes,
          id: id,
          key: key,
        );

  /// Create an h5 heading
  ///
  /// Provide either [child] or [text].
  const ArcaneHeading.h5({
    Component? child,
    String? text,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Key? key,
  }) : this(
          level: HeadingLevel.h5,
          child: child,
          text: text,
          styles: styles,
          classes: classes,
          id: id,
          key: key,
        );

  /// Create an h5 heading with multiple children
  const ArcaneHeading.h5Children({
    required List<Component> children,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Key? key,
  }) : this._withChildren(
          level: HeadingLevel.h5,
          children: children,
          styles: styles,
          classes: classes,
          id: id,
          key: key,
        );

  /// Create an h6 heading
  ///
  /// Provide either [child] or [text].
  const ArcaneHeading.h6({
    Component? child,
    String? text,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Key? key,
  }) : this(
          level: HeadingLevel.h6,
          child: child,
          text: text,
          styles: styles,
          classes: classes,
          id: id,
          key: key,
        );

  /// Create an h6 heading with multiple children
  const ArcaneHeading.h6Children({
    required List<Component> children,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Key? key,
  }) : this._withChildren(
          level: HeadingLevel.h6,
          children: children,
          styles: styles,
          classes: classes,
          id: id,
          key: key,
        );

  @override
  Component build(BuildContext context) {
    // Resolve content: children > child > text
    final List<Component> content;
    if (_children != null) {
      content = _children!;
    } else if (_child != null) {
      content = [_child!];
    } else {
      content = [Component.text(text!)];
    }

    // Apply heading font family as default, user styles override
    final baseStyles = styles?.toMap() ?? <String, String>{};
    final mergedStyles = Styles(raw: {
      'font-family': ArcaneTypography.fontFamilyHeading,
      ...baseStyles,
    });

    switch (level) {
      case HeadingLevel.h1:
        return h1(id: id, classes: classes, styles: mergedStyles, content);
      case HeadingLevel.h2:
        return h2(id: id, classes: classes, styles: mergedStyles, content);
      case HeadingLevel.h3:
        return h3(id: id, classes: classes, styles: mergedStyles, content);
      case HeadingLevel.h4:
        return h4(id: id, classes: classes, styles: mergedStyles, content);
      case HeadingLevel.h5:
        return h5(id: id, classes: classes, styles: mergedStyles, content);
      case HeadingLevel.h6:
        return h6(id: id, classes: classes, styles: mergedStyles, content);
    }
  }
}
