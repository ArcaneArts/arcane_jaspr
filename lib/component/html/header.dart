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

/// A header component that wraps the HTML `<header>` element.
///
/// Provides a Flutter-like API with direct `ArcaneStyleData` support,
/// eliminating the need to call `.toStyles()`.
///
/// Example:
/// ```dart
/// Header(
///   styles: ArcaneStyleData(
///     padding: PaddingPreset.md,
///     background: Background.surface,
///   ),
///   children: [
///     Logo(),
///     Nav(children: [...]),
///   ],
/// )
/// ```
class Header extends StatelessComponent {
  /// The children of the header
  final List<Component> children;

  /// Optional styling using ArcaneStyleData
  final ArcaneStyleData? styles;

  /// Optional CSS classes
  final String? classes;

  /// Optional ID attribute
  final String? id;

  /// Additional HTML attributes
  final Map<String, String>? attributes;

  const Header({
    required this.children,
    this.styles,
    this.classes,
    this.id,
    this.attributes,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return header(
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      attributes: attributes,
      children,
    );
  }
}
