import 'package:arcane_jaspr/core/props/skeleton_props.dart';
import 'package:arcane_jaspr/core/rendering/base/skeleton_render_base.dart';

/// Neon Skeleton renderer (neutralized skeleton).
class NeonSkeleton extends SkeletonRenderBase {
  const NeonSkeleton(super.props, {super.key});

  @override
  String get cssClass => 'neon-skeleton';

  @override
  (String, String, String?, String?) defaultGeometry(SkeletonShape shape) =>
      switch (shape) {
        SkeletonShape.rectangle => ('100%', '20px', null, null),
        SkeletonShape.circle => ('48px', '48px', null, '50%'),
        SkeletonShape.text => ('100%', '1rem', null, null),
      };

  @override
  Map<String, String> surfaceStyles(SkeletonProps props) =>
      const <String, String>{};
}
