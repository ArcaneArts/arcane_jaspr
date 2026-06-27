import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/fade_edge_props.dart';

/// Shared structural base for themed fade-edge renderers.
///
/// Every theme's fade edge produces identical markup and styles; only the root
/// CSS class differs. This base factors the gradient/positioning math and the
/// single positioned `div` into one place, leaving the concrete renderer to
/// supply just [cssClass]; the direction modifier class is derived as
/// `'$cssClass $cssClass-<direction>'`.
///
/// This base lives in core and depends only on core props; it must never
/// depend on a theme package.
abstract class FadeEdgeRenderBase extends StatelessComponent {
  const FadeEdgeRenderBase(this.props, {super.key});

  final FadeEdgeProps props;

  /// Root CSS class (e.g. `'arcane-fade-edge'`).
  String get cssClass;

  String _getGradient(String color) {
    return switch (props.direction) {
      FadeDirection.left => 'linear-gradient(to right, $color, transparent)',
      FadeDirection.right => 'linear-gradient(to left, $color, transparent)',
      FadeDirection.top => 'linear-gradient(to bottom, $color, transparent)',
      FadeDirection.bottom => 'linear-gradient(to top, $color, transparent)',
    };
  }

  Map<String, String> _getPositioning() {
    return switch (props.direction) {
      FadeDirection.left => <String, String>{
        'left': '0',
        'top': '0',
        'bottom': '0',
      },
      FadeDirection.right => <String, String>{
        'right': '0',
        'top': '0',
        'bottom': '0',
      },
      FadeDirection.top => <String, String>{
        'top': '0',
        'left': '0',
        'right': '0',
      },
      FadeDirection.bottom => <String, String>{
        'bottom': '0',
        'left': '0',
        'right': '0',
      },
    };
  }

  @override
  Component build(BuildContext context) {
    final String effectiveColor = props.color ?? 'var(--background)';
    final bool isHorizontal =
        props.direction == FadeDirection.left ||
        props.direction == FadeDirection.right;

    final String effectiveWidth = isHorizontal ? (props.width ?? '150px') : '100%';
    final String effectiveHeight = !isHorizontal
        ? (props.height ?? '100px')
        : '100%';
    final String effectiveZIndex = props.zIndex ?? '10';

    return dom.div(
      classes: '$cssClass $cssClass-${props.direction.name}',
      styles: dom.Styles(
        raw: <String, String>{
          'position': 'absolute',
          'width': effectiveWidth,
          'height': effectiveHeight,
          'z-index': effectiveZIndex,
          'pointer-events': 'none',
          'background': _getGradient(effectiveColor),
          ..._getPositioning(),
        },
      ),
      const <Component>[],
    );
  }
}
