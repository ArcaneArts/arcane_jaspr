import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/rendering/base/style_layering.dart';
import 'package:arcane_jaspr/core/props/skeleton_props.dart';

/// Shared structural base for themed skeleton renderers.
///
/// Factors the identical build logic shared by every theme's skeleton renderer
/// (the per-shape geometry resolution, the `width`/`height` and conditional
/// `border-radius`/`clip-path` style keys, the root class with its
/// `animate` suffix, and the empty child list) into one place. A concrete
/// theme renderer only supplies the value-producing members below: the root
/// CSS class, the per-shape default geometry, and the theme-specific surface
/// styles (background, animation, borders) appended after the geometry keys.
///
/// This base lives in core and depends only on core props; it must never
/// depend on a theme package.
abstract class SkeletonRenderBase extends StatelessComponent {
  const SkeletonRenderBase(this.props, {super.key});

  final SkeletonProps props;

  /// CSS class applied to the root element (e.g. `'arcane-skeleton'`). [build]
  /// appends `' '` plus the `animate` marker based on `props.animate`.
  String get cssClass;

  /// Per-shape default geometry as `(width, height, clipPath, borderRadius)`.
  /// `clipPath` and `borderRadius` are null when the theme/shape does not use
  /// them; the resolved `border-radius` always wins over `clip-path` when both
  /// are available.
  (String, String, String?, String?) defaultGeometry(SkeletonShape shape);

  /// Theme-specific surface styles appended after the shared geometry keys
  /// (background, animation, borders, etc.). Key insertion order is preserved
  /// in the emitted style map.
  Map<String, String> surfaceStyles(SkeletonProps props);

  /// Per-instance decoration overrides. Default: none. A theme overrides this
  /// to translate an [ArcaneDecoration] (elevation intent, theme-specific
  /// fields) into its own CSS. Fields a theme does not implement are ignored.
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      const <String, String>{};

  @override
  Component build(BuildContext context) {
    final (
      String defaultWidth,
      String defaultHeight,
      String? defaultClip,
      String? defaultRadius,
    ) = defaultGeometry(props.shape);

    final String width = props.width ?? defaultWidth;
    final String height = props.height ?? defaultHeight;
    final String? borderRadius = defaultRadius;
    final bool useChamfer = borderRadius == null && defaultClip != null;

    return dom.div(
      classes: '$cssClass ${props.animate ? 'animate' : ''}',
      attributes: <String, String>{
        if (props.shape == SkeletonShape.circle)
          'data-arcane-intrinsic-shape': 'skeleton-circle',
      },
      styles: dom.Styles(
        raw: layerStyles(
          <String, String>{
            'width': width,
            'height': height,
            'border-radius': ?borderRadius,
            if (useChamfer) 'clip-path': defaultClip,
            ...surfaceStyles(props),
          },
          <Map<String, String>?>[
            props.decoration?.universalStyles(),
            decorationStyles(props.decoration),
            props.styles?.toMap(),
          ],
        ),
      ),
      const <Component>[],
    );
  }
}
