import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/aspect_ratio_props.dart';

class NeonAspectRatio extends StatelessComponent {
  final AspectRatioProps props;

  const NeonAspectRatio(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String classes = [
      'neon-aspect-ratio',
      if (props.classes != null) props.classes!,
    ].join(' ');

    return dom.div(
      classes: classes,
      styles: dom.Styles(
        raw: {
          'position': 'relative',
          'width': '100%',
          'aspect-ratio': props.ratio.toString(),
          'overflow': 'hidden',
          'border-radius': 'var(--radius-md)',
          ...?props.styles,
        },
      ),
      [
        dom.div(
          classes: 'neon-aspect-ratio-content',
          styles: const dom.Styles(
            raw: {
              'position': 'absolute',
              'inset': '0',
              'width': '100%',
              'height': '100%',
            },
          ),
          [props.child],
        ),
      ],
    );
  }
}
