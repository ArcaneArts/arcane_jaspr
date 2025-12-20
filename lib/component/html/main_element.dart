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

/// A main component that wraps the HTML `<main>` element.
///
/// Named `ArcaneMain` to match Dart conventions (avoiding conflict with `main()` function).
///
/// Provides a Flutter-like API with direct `ArcaneStyleData` support,
/// eliminating the need to call `.toStyles()`.
///
/// Example:
/// ```dart
/// ArcaneMain(
///   styles: ArcaneStyleData(
///     flexGrow: FlexGrow.grow,
///     padding: PaddingPreset.xl,
///   ),
///   children: [
///     Section(children: [...]),
///   ],
/// )
/// ```
class ArcaneMain extends StatelessComponent {
  /// The children of the main element
  final List<Component> children;

  /// Optional styling using ArcaneStyleData
  final ArcaneStyleData? styles;

  /// Optional CSS classes
  final String? classes;

  /// Optional ID attribute
  final String? id;

  /// Additional HTML attributes
  final Map<String, String>? attributes;

  const ArcaneMain({
    required this.children,
    this.styles,
    this.classes,
    this.id,
    this.attributes,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return main_(
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      attributes: attributes,
      children,
    );
  }
}
