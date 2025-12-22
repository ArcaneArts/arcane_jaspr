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

/// A bullet list component for displaying unordered items.
///
/// This wraps the HTML `<ul>` element.
///
/// Example:
/// ```dart
/// ArcaneBulletList(
///   children: [
///     ArcaneListItem(child: ArcaneText('First item')),
///     ArcaneListItem(child: ArcaneText('Second item')),
///   ],
/// )
/// ```
class ArcaneBulletList extends StatelessComponent {
  final List<Component> children;
  final ArcaneStyleData? styles;
  final String? classes;
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
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      children,
    );
  }
}

/// A numbered list component for displaying ordered items.
///
/// This wraps the HTML `<ol>` element.
///
/// Example:
/// ```dart
/// ArcaneNumberedList(
///   children: [
///     ArcaneListItem(child: ArcaneText('Step 1')),
///     ArcaneListItem(child: ArcaneText('Step 2')),
///   ],
/// )
/// ```
class ArcaneNumberedList extends StatelessComponent {
  final List<Component> children;
  final ArcaneStyleData? styles;
  final String? classes;
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
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      children,
    );
  }
}

/// A list item component for use inside ArcaneBulletList or ArcaneNumberedList.
///
/// This wraps the HTML `<li>` element.
class ArcaneListItem extends StatelessComponent {
  final Component child;
  final ArcaneStyleData? styles;
  final String? classes;
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
    String? classes,
    String? id,
    Key? key,
  }) = _ArcaneListItemChildren;

  @override
  Component build(BuildContext context) {
    return li(
      id: id,
      classes: classes,
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
      classes: classes,
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

// Legacy aliases for backwards compatibility
typedef ArcaneUnorderedList = ArcaneBulletList;
typedef ArcaneOrderedList = ArcaneNumberedList;
