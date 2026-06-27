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

/// Styled image wrapper.
class ArcaneImage extends StatelessComponent {
  final String src;
  final String alt;
  final ArcaneStyleData? styles;
  final String? classes;
  final String? id;
  final String? width;
  final String? height;
  final String? loading;
  final String? decoding;
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
        'width': ?width,
        'height': ?height,
        'loading': ?loading,
        'decoding': ?decoding,
      },
    );
  }
}
