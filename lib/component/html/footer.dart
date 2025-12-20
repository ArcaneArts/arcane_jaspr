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

/// A footer component that wraps the HTML `<footer>` element.
///
/// Provides a Flutter-like API with direct `ArcaneStyleData` support,
/// eliminating the need to call `.toStyles()`.
///
/// Example:
/// ```dart
/// Footer(
///   styles: ArcaneStyleData(
///     padding: PaddingPreset.xl,
///     background: Background.card,
///   ),
///   children: [
///     Paragraph(child: ArcaneText('Copyright 2024')),
///   ],
/// )
/// ```
class Footer extends StatelessComponent {
  /// The children of the footer
  final List<Component> children;

  /// Optional styling using ArcaneStyleData
  final ArcaneStyleData? styles;

  /// Optional CSS classes
  final String? classes;

  /// Optional ID attribute
  final String? id;

  /// Additional HTML attributes
  final Map<String, String>? attributes;

  const Footer({
    required this.children,
    this.styles,
    this.classes,
    this.id,
    this.attributes,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return footer(
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      attributes: attributes,
      children,
    );
  }
}
