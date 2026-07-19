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

/// Styled paragraph wrapper.
class ArcaneParagraph extends StatelessComponent {
  final Component child;
  final ArcaneStyleData? styles;
  final List<String>? classes;
  final String? id;

  const ArcaneParagraph({
    required this.child,
    this.styles,
    this.classes,
    this.id,
    super.key,
  });

  const factory ArcaneParagraph.children({
    required List<Component> children,
    ArcaneStyleData? styles,
    List<String>? classes,
    String? id,
    Key? key,
  }) = _ArcaneParagraphChildren;

  @override
  Component build(BuildContext context) {
    return p(
      id: id,
      classes: classes == null ? null : cx(classes!),
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      [child],
    );
  }
}

class _ArcaneParagraphChildren extends ArcaneParagraph {
  final List<Component> _children;

  const _ArcaneParagraphChildren({
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
