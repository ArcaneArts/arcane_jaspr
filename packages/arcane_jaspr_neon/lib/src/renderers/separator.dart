import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/rendering/base/separator_render_base.dart';

/// Neon Separator renderer (neutralized skeleton).
class NeonSeparator extends SeparatorRenderBase {
  const NeonSeparator(super.props, {super.key});

  @override
  String get resolveMargin =>
      props.margin != null ? '${props.margin}px' : '1rem';

  @override
  String get verticalClasses => 'neon-separator neon-separator-vertical';

  @override
  String get labeledClasses => 'neon-separator neon-separator-with-label';

  @override
  Map<String, String> get verticalStretchStyles => const <String, String>{};

  @override
  Map<String, String> labeledContainerStyles(String margin) =>
      const <String, String>{};

  @override
  Map<String, String> get labelSpanStyles => const <String, String>{};

  @override
  Map<String, String> get iconSpanStyles => const <String, String>{};

  @override
  Component buildSimpleHorizontal(
    String thickness,
    String color,
    String margin,
  ) {
    return dom.div(
      classes: 'neon-separator',
      attributes: horizontalAttrs(),
      styles: dom.Styles(
        raw: <String, String>{
          'width': '100%',
          'height': thickness,
          'margin': '$margin 0',
          ...backgroundStyle(color),
          ...?props.decoration?.universalStyles(),
          ...?props.styles?.toMap(),
        },
      ),
      const <Component>[],
    );
  }
}
