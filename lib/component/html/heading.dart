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
/// ArcaneHeading(
///   level: HeadingLevel.h1,
///   styles: ArcaneStyleData(
///     fontSize: FontSize.hero,
///     textColor: TextColor.primary,
///   ),
///   child: ArcaneText('Page Title'),
/// )
///
/// // Or use named constructors:
/// ArcaneHeading.h1(child: ArcaneText('Main Title'))
/// ArcaneHeading.h2(child: ArcaneText('Section Title'))
/// ```
class ArcaneHeading extends StatelessComponent {
  /// The heading level (h1-h6)
  final HeadingLevel level;

  /// The content of the heading (single child)
  final Component? _child;

  /// The content of the heading (multiple children)
  final List<Component>? _children;

  /// Optional styling using ArcaneStyleData
  final ArcaneStyleData? styles;

  /// Optional CSS classes
  final String? classes;

  /// Optional ID attribute
  final String? id;

  const ArcaneHeading({
    required this.level,
    required Component child,
    this.styles,
    this.classes,
    this.id,
    super.key,
  })  : _child = child,
        _children = null;

  const ArcaneHeading._withChildren({
    required this.level,
    required List<Component> children,
    this.styles,
    this.classes,
    this.id,
    super.key,
  })  : _child = null,
        _children = children;

  /// Create an h1 heading with single child
  const ArcaneHeading.h1({
    required Component child,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Key? key,
  }) : this(
          level: HeadingLevel.h1,
          child: child,
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

  /// Create an h2 heading with single child
  const ArcaneHeading.h2({
    required Component child,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Key? key,
  }) : this(
          level: HeadingLevel.h2,
          child: child,
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

  /// Create an h3 heading with single child
  const ArcaneHeading.h3({
    required Component child,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Key? key,
  }) : this(
          level: HeadingLevel.h3,
          child: child,
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

  /// Create an h4 heading with single child
  const ArcaneHeading.h4({
    required Component child,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Key? key,
  }) : this(
          level: HeadingLevel.h4,
          child: child,
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

  /// Create an h5 heading with single child
  const ArcaneHeading.h5({
    required Component child,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Key? key,
  }) : this(
          level: HeadingLevel.h5,
          child: child,
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

  /// Create an h6 heading with single child
  const ArcaneHeading.h6({
    required Component child,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Key? key,
  }) : this(
          level: HeadingLevel.h6,
          child: child,
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
    final content = _children ?? [_child!];

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
