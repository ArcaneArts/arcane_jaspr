import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/gutter_props.dart';

/// Win95 Gutter renderer.
class Win95Gutter extends StatelessComponent {
  final GutterProps props;

  const Win95Gutter(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final double size = props.size.pixels;
    return dom.div(
      classes: 'win95-gutter',
      styles: dom.Styles(
        raw: {
          if (props.horizontal) 'width': '${size}px' else 'height': '${size}px',
          'flex-shrink': '0',
        },
      ),
      [],
    );
  }
}
