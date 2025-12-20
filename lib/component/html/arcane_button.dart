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

/// A raw button component that wraps the HTML `<button>` element.
///
/// This is a low-level wrapper for direct HTML button elements.
/// For styled buttons, use the Button component from arcane_jaspr.
class RawButton extends StatelessComponent {
  final Component child;
  final ArcaneStyleData? styles;
  final String? classes;
  final String? id;
  final String? type;
  final bool disabled;
  final void Function()? onClick;
  final Map<String, void Function(dynamic)>? events;

  const RawButton({
    required this.child,
    this.styles,
    this.classes,
    this.id,
    this.type,
    this.disabled = false,
    this.onClick,
    this.events,
    super.key,
  });

  const factory RawButton.children({
    required List<Component> children,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    String? type,
    bool disabled,
    void Function()? onClick,
    Map<String, void Function(dynamic)>? events,
    Key? key,
  }) = _RawButtonChildren;

  @override
  Component build(BuildContext context) {
    return button(
      id: id,
      classes: classes,
      type: type != null ? ButtonType.values.firstWhere((t) => t.name == type, orElse: () => ButtonType.button) : null,
      disabled: disabled,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      events: {
        if (onClick != null) 'click': (_) => onClick!(),
        ...?events,
      },
      [child],
    );
  }
}

class _RawButtonChildren extends RawButton {
  final List<Component> _children;

  const _RawButtonChildren({
    required List<Component> children,
    super.styles,
    super.classes,
    super.id,
    super.type,
    super.disabled,
    super.onClick,
    super.events,
    super.key,
  })  : _children = children,
        super(child: const _Placeholder());

  @override
  Component build(BuildContext context) {
    return button(
      id: id,
      classes: classes,
      type: type != null ? ButtonType.values.firstWhere((t) => t.name == type, orElse: () => ButtonType.button) : null,
      disabled: disabled,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      events: {
        if (onClick != null) 'click': (_) => onClick!(),
        ...?events,
      },
      _children,
    );
  }
}

class _Placeholder extends StatelessComponent {
  const _Placeholder();
  @override
  Component build(BuildContext context) => const Component.text('');
}
