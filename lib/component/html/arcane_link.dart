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

/// A link component that wraps the HTML `<a>` element.
///
/// Provides a Flutter-like API with direct `ArcaneStyleData` support,
/// eliminating the need to call `.toStyles()`.
///
/// Example:
/// ```dart
/// ArcaneLink(
///   href: '/about',
///   styles: ArcaneStyleData(
///     textColor: TextColor.accent,
///   ),
///   child: ArcaneText('About Us'),
/// )
/// ```
class ArcaneLink extends StatelessComponent {
  /// The URL the link points to
  final String href;

  /// The content of the link
  final Component child;

  /// Optional styling using ArcaneStyleData
  final ArcaneStyleData? styles;

  /// Optional CSS classes
  final String? classes;

  /// Optional ID attribute
  final String? id;

  /// Target attribute (_blank, _self, etc.)
  final String? target;

  /// Rel attribute (noopener, noreferrer, etc.)
  final String? rel;

  /// Event handlers
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

  /// Create a link with multiple children
  const factory ArcaneLink.children({
    required String href,
    required List<Component> children,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    String? target,
    String? rel,
    Map<String, void Function(dynamic)>? events,
    Key? key,
  }) = _ArcaneLinkChildren;

  /// Create an external link (opens in new tab with security attributes)
  const factory ArcaneLink.external({
    required String href,
    required Component child,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Map<String, void Function(dynamic)>? events,
    Key? key,
  }) = _ArcaneLinkExternal;

  @override
  Component build(BuildContext context) {
    return a(
      href: href,
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      events: events,
      attributes: {
        if (target != null) 'target': target!,
        if (rel != null) 'rel': rel!,
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
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      events: events,
      attributes: {
        if (target != null) 'target': target!,
        if (rel != null) 'rel': rel!,
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

/// Placeholder component for factory constructor
class _Placeholder extends StatelessComponent {
  const _Placeholder();
  @override
  Component build(BuildContext context) => const Component.text('');
}
