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

/// Styled anchor link wrapper.
class ArcaneLink extends StatelessComponent {
  final String href;
  final Component child;
  final ArcaneStyleData? styles;
  final List<String>? classes;
  final String? id;
  final String? target;
  final String? rel;
  final Map<String, void Function(dynamic)>? events;

  const ArcaneLink({
    required this.href,
    required this.child,
    this.styles,
    this.classes,
    this.id,
    this.target,
    this.rel,
    this.events,
    super.key,
  });

  const factory ArcaneLink.children({
    required String href,
    required List<Component> children,
    ArcaneStyleData? styles,
    List<String>? classes,
    String? id,
    String? target,
    String? rel,
    Map<String, void Function(dynamic)>? events,
    Key? key,
  }) = _ArcaneLinkChildren;

  const factory ArcaneLink.external({
    required String href,
    required Component child,
    ArcaneStyleData? styles,
    List<String>? classes,
    String? id,
    Map<String, void Function(dynamic)>? events,
    Key? key,
  }) = _ArcaneLinkExternal;

  @override
  Component build(BuildContext context) {
    return a(
      href: href,
      id: id,
      classes: classes == null ? null : cx(classes!),
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      events: events,
      attributes: {
        'target': ?target,
        'rel': ?rel,
      },
      [child],
    );
  }
}

class _ArcaneLinkChildren extends ArcaneLink {
  final List<Component> _children;

  const _ArcaneLinkChildren({
    required super.href,
    required List<Component> children,
    super.styles,
    super.classes,
    super.id,
    super.target,
    super.rel,
    super.events,
    super.key,
  })  : _children = children,
        super(child: const _Placeholder());

  @override
  Component build(BuildContext context) {
    return a(
      href: href,
      id: id,
      classes: classes == null ? null : cx(classes!),
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      events: events,
      attributes: {
        'target': ?target,
        'rel': ?rel,
      },
      _children,
    );
  }
}

class _ArcaneLinkExternal extends ArcaneLink {
  const _ArcaneLinkExternal({
    required super.href,
    required super.child,
    super.styles,
    super.classes,
    super.id,
    super.events,
    super.key,
  }) : super(target: '_blank', rel: 'noopener noreferrer');
}

class _Placeholder extends StatelessComponent {
  const _Placeholder();
  @override
  Component build(BuildContext context) => const Component.text('');
}
