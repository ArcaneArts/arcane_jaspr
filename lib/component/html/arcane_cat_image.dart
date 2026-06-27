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

/// A random cat image from cataas.com.
///
/// Example usage:
/// ```dart
/// ArcaneCatImage(seed: 'my-cat')
/// ArcaneCatImage.gif(seed: 'animated-cat')
/// ArcaneCatImage.says('Hello World', seed: 'talking-cat')
/// ```
class ArcaneCatImage extends StatelessComponent {
  /// Optional seed string for consistent random cats.
  /// The same seed will always return the same cat.
  final String? seed;

  /// Optional text to display on the cat image.
  final String? text;

  /// Whether to use a GIF instead of a static image.
  final bool gif;

  /// Optional custom width parameter for the API.
  final int? apiWidth;

  /// Optional custom height parameter for the API.
  final int? apiHeight;

  /// Custom styles for the image.
  final ArcaneStyleData? styles;

  /// CSS classes to apply.
  final String? classes;

  /// Element ID.
  final String? id;

  /// HTML width attribute.
  final String? width;

  /// HTML height attribute.
  final String? height;

  /// Loading strategy (lazy, eager).
  final String? loading;

  /// Decoding hint (sync, async, auto).
  final String? decoding;

  /// Event handlers.
  final Map<String, void Function(dynamic)>? events;

  const ArcaneCatImage({
    this.seed,
    this.text,
    this.gif = false,
    this.apiWidth,
    this.apiHeight,
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

  /// Create a GIF cat image.
  const ArcaneCatImage.gif({
    this.seed,
    this.text,
    this.apiWidth,
    this.apiHeight,
    this.styles,
    this.classes,
    this.id,
    this.width,
    this.height,
    this.loading,
    this.decoding,
    this.events,
    super.key,
  }) : gif = true;

  /// Create a cat image with text overlay.
  const ArcaneCatImage.says(
    this.text, {
    this.seed,
    this.gif = false,
    this.apiWidth,
    this.apiHeight,
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

  /// Create a lazy-loaded cat image.
  const ArcaneCatImage.lazy({
    this.seed,
    this.text,
    this.gif = false,
    this.apiWidth,
    this.apiHeight,
    this.styles,
    this.classes,
    this.id,
    this.width,
    this.height,
    this.decoding,
    this.events,
    super.key,
  }) : loading = 'lazy';

  String get _src {
    final StringBuffer url = StringBuffer('https://cataas.com/cat');

    // Add type (gif)
    if (gif) {
      url.write('/gif');
    }

    // Add text overlay
    if (text != null && text!.isNotEmpty) {
      url.write('/says/${Uri.encodeComponent(text!)}');
    }

    // Build query parameters
    final List<String> params = <String>[];

    if (seed != null && seed!.isNotEmpty) {
      params.add(seed!);
    }

    if (apiWidth != null) {
      params.add('width=$apiWidth');
    }

    if (apiHeight != null) {
      params.add('height=$apiHeight');
    }

    if (params.isNotEmpty) {
      url.write('?${params.join('&')}');
    }

    return url.toString();
  }

  @override
  Component build(BuildContext context) {
    return img(
      src: _src,
      alt: text ?? 'Random cat',
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
