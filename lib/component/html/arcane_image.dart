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

/// An image component that wraps the HTML `<img>` element.
///
/// Provides a Flutter-like API with direct `ArcaneStyleData` support,
/// eliminating the need to call `.toStyles()`.
///
/// Example:
/// ```dart
/// ArcaneImage(
///   src: '/images/hero.png',
///   alt: 'Hero image',
///   styles: ArcaneStyleData(
///     width: Size.full,
///     borderRadius: Radius.lg,
///     objectFit: ObjectFit.cover,
///   ),
/// )
/// ```
class ArcaneImage extends StatelessComponent {
  /// The source URL of the image
  final String src;

  /// Alternative text for accessibility
  final String alt;

  /// Optional styling using ArcaneStyleData
  final ArcaneStyleData? styles;

  /// Optional CSS classes
  final String? classes;

  /// Optional ID attribute
  final String? id;

  /// Width attribute (HTML attribute, not CSS)
  final String? width;

  /// Height attribute (HTML attribute, not CSS)
  final String? height;

  /// Loading behavior (lazy, eager)
  final String? loading;

  /// Decoding hint (async, sync, auto)
  final String? decoding;

  /// Event handlers
  final Map<String, void Function(dynamic)>? events;

  const ArcaneImage({
    required this.src,
    required this.alt,
    this.styles,
    this.classes,
    this.id,
    this.width,
    this.height,
    this.loading,
    this.decoding,
    this.events,
    super.key,
  });

  /// Create a lazy-loaded image
  const ArcaneImage.lazy({
    required this.src,
    required this.alt,
    this.styles,
    this.classes,
    this.id,
    this.width,
    this.height,
    this.decoding,
    this.events,
    super.key,
  }) : loading = 'lazy';

  @override
  Component build(BuildContext context) {
    return img(
      src: src,
      alt: alt,
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      events: events,
      attributes: {
        if (width != null) 'width': width!,
        if (height != null) 'height': height!,
        if (loading != null) 'loading': loading!,
        if (decoding != null) 'decoding': decoding!,
      },
    );
  }
}
