import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/dom.dart' as dom;

class Image extends StatelessWidget {
  final String src;
  final String alt;
  final double? width;
  final double? height;
  final bool fillWidth;
  final bool cover;

  const Image({
    required this.src,
    required this.alt,
    this.width,
    this.height,
    this.fillWidth = false,
    this.cover = false,
    super.key,
  });

  const Image.network(
    this.src, {
    required this.alt,
    this.width,
    this.height,
    this.fillWidth = false,
    this.cover = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) => dom.img(
    src: src,
    alt: alt,
    styles: dom.Styles(
      raw: <String, String>{
        if (fillWidth) 'width': '100%',
        if (width != null) 'width': '${width}px',
        if (height != null) 'height': '${height}px',
        if (cover) 'object-fit': 'cover',
        'display': 'block',
      },
    ),
  );
}
