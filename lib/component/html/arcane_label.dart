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

/// A label component that wraps the HTML `<label>` element.
///
/// Provides a Flutter-like API with direct `ArcaneStyleData` support.
class ArcaneLabel extends StatelessComponent {
  final Component child;
  final ArcaneStyleData? styles;
  final String? classes;
  final String? id;
  final String? htmlFor;

  const ArcaneLabel({
    required this.child,
    this.styles,
    this.classes,
    this.id,
    this.htmlFor,
    super.key,
  });

  const factory ArcaneLabel.children({
    required List<Component> children,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    String? htmlFor,
    Key? key,
  }) = _ArcaneLabelChildren;

  @override
  Component build(BuildContext context) {
    return label(
      [child],
      id: id,
      htmlFor: htmlFor,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
    );
  }
}

class _ArcaneLabelChildren extends ArcaneLabel {
  final List<Component> _children;

  const _ArcaneLabelChildren({
    required List<Component> children,
    super.styles,
    super.classes,
    super.id,
    super.htmlFor,
    super.key,
  })  : _children = children,
        super(child: const _Placeholder());

  @override
  Component build(BuildContext context) {
    return label(
      _children,
      id: id,
      htmlFor: htmlFor,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
    );
  }
}

class _Placeholder extends StatelessComponent {
  const _Placeholder();
  @override
  Component build(BuildContext context) => const Component.text('');
}
