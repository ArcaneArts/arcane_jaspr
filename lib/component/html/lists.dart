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

/// Styled unordered list wrapper.
class ArcaneBulletList extends StatelessComponent {
  final List<Component> children;
  final ArcaneStyleData? styles;
  final List<String>? classes;
  final String? id;

  const ArcaneBulletList({
    required this.children,
    this.styles,
    this.classes,
    this.id,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ul(
      id: id,
      classes: classes == null ? null : cx(classes!),
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      children,
    );
  }
}

/// Styled ordered list wrapper.
class ArcaneNumberedList extends StatelessComponent {
  final List<Component> children;
  final ArcaneStyleData? styles;
  final List<String>? classes;
  final String? id;

  const ArcaneNumberedList({
    required this.children,
    this.styles,
    this.classes,
    this.id,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ol(
      id: id,
      classes: classes == null ? null : cx(classes!),
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      children,
    );
  }
}

/// Styled list item wrapper.
class ArcaneListItem extends StatelessComponent {
  final Component child;
  final ArcaneStyleData? styles;
  final List<String>? classes;
  final String? id;

  const ArcaneListItem({
    required this.child,
    this.styles,
    this.classes,
    this.id,
    super.key,
  });

  const factory ArcaneListItem.children({
    required List<Component> children,
    ArcaneStyleData? styles,
    List<String>? classes,
    String? id,
    Key? key,
  }) = _ArcaneListItemChildren;

  @override
  Component build(BuildContext context) {
    return li(
      id: id,
      classes: classes == null ? null : cx(classes!),
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      [child],
    );
  }
}

class _ArcaneListItemChildren extends ArcaneListItem {
  final List<Component> _children;

  const _ArcaneListItemChildren({
    required List<Component> children,
    super.styles,
    super.classes,
    super.id,
    super.key,
  })  : _children = children,
        super(child: const _Placeholder());

  @override
  Component build(BuildContext context) {
    return li(
      id: id,
      classes: classes == null ? null : cx(classes!),
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      _children,
    );
  }
}

class _Placeholder extends StatelessComponent {
  const _Placeholder();
  @override
  Component build(BuildContext context) => const Component.text('');
}
