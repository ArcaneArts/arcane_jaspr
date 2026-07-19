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

enum HeadingLevel { h1, h2, h3, h4, h5, h6 }

/// Styled heading wrapper for h1-h6 elements.
class ArcaneHeading extends StatelessComponent {
  final HeadingLevel level;
  final Component? _child;
  final List<Component>? _children;
  final String? text;
  final ArcaneStyleData? styles;
  final List<String>? classes;
  final String? id;

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

  const ArcaneHeading.h1({
    Component? child,
    String? text,
    ArcaneStyleData? styles,
    List<String>? classes,
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

  const ArcaneHeading.h1Children({
    required List<Component> children,
    ArcaneStyleData? styles,
    List<String>? classes,
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

  const ArcaneHeading.h2({
    Component? child,
    String? text,
    ArcaneStyleData? styles,
    List<String>? classes,
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

  const ArcaneHeading.h2Children({
    required List<Component> children,
    ArcaneStyleData? styles,
    List<String>? classes,
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

  const ArcaneHeading.h3({
    Component? child,
    String? text,
    ArcaneStyleData? styles,
    List<String>? classes,
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

  const ArcaneHeading.h3Children({
    required List<Component> children,
    ArcaneStyleData? styles,
    List<String>? classes,
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

  const ArcaneHeading.h4({
    Component? child,
    String? text,
    ArcaneStyleData? styles,
    List<String>? classes,
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

  const ArcaneHeading.h4Children({
    required List<Component> children,
    ArcaneStyleData? styles,
    List<String>? classes,
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

  const ArcaneHeading.h5({
    Component? child,
    String? text,
    ArcaneStyleData? styles,
    List<String>? classes,
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

  const ArcaneHeading.h5Children({
    required List<Component> children,
    ArcaneStyleData? styles,
    List<String>? classes,
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

  const ArcaneHeading.h6({
    Component? child,
    String? text,
    ArcaneStyleData? styles,
    List<String>? classes,
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

  const ArcaneHeading.h6Children({
    required List<Component> children,
    ArcaneStyleData? styles,
    List<String>? classes,
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
    final List<Component> content;
    if (_children != null) {
      content = _children;
    } else if (_child != null) {
      content = [_child];
    } else {
      content = [Component.text(text!)];
    }

    final baseStyles = styles?.toMap() ?? <String, String>{};
    final mergedStyles = Styles(raw: {
      'font-family': 'var(--font-heading, ui-sans-serif, system-ui, sans-serif)',
      ...baseStyles,
    });

    switch (level) {
      case HeadingLevel.h1:
        return h1(id: id, classes: classes == null ? null : cx(classes!), styles: mergedStyles, content);
      case HeadingLevel.h2:
        return h2(id: id, classes: classes == null ? null : cx(classes!), styles: mergedStyles, content);
      case HeadingLevel.h3:
        return h3(id: id, classes: classes == null ? null : cx(classes!), styles: mergedStyles, content);
      case HeadingLevel.h4:
        return h4(id: id, classes: classes == null ? null : cx(classes!), styles: mergedStyles, content);
      case HeadingLevel.h5:
        return h5(id: id, classes: classes == null ? null : cx(classes!), styles: mergedStyles, content);
      case HeadingLevel.h6:
        return h6(id: id, classes: classes == null ? null : cx(classes!), styles: mergedStyles, content);
    }
  }
}
