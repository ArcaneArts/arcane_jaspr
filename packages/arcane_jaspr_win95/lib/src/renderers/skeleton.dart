import 'package:arcane_jaspr/core/props/skeleton_props.dart';
import 'package:arcane_jaspr/core/rendering/base/skeleton_render_base.dart';

/// Win95 Skeleton renderer (neutralized skeleton).
class Win95Skeleton extends SkeletonRenderBase {
  const Win95Skeleton(super.props, {super.key});

  @override
  String get cssClass => 'win95-skeleton';

  /// No shape is rounded: the circle variant keeps its square geometry rather
  /// than authoring generic pill geometry that the theme's corner reset then
  /// has to undo.
  @override
  (String, String, String?, String?) defaultGeometry(SkeletonShape shape) =>
      switch (shape) {
        SkeletonShape.rectangle => ('100%', '20px', null, null),
        SkeletonShape.circle => ('48px', '48px', null, null),
        SkeletonShape.text => ('100%', '1rem', null, null),
      };

  @override
  Map<String, String> surfaceStyles(SkeletonProps props) =>
      const <String, String>{};
}
