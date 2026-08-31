import 'package:arcane_jaspr/core/props/skeleton_props.dart';
import 'package:arcane_jaspr/core/rendering/base/skeleton_render_base.dart';

/// ShadCN Skeleton renderer.
///
/// Reference: https://ui.shadcn.com/docs/components/skeleton
class ShadcnSkeleton extends SkeletonRenderBase {
  const ShadcnSkeleton(super.props, {super.key});

  @override
  String get cssClass => 'arcane-skeleton';

  @override
  (String, String, String?, String?) defaultGeometry(SkeletonShape shape) =>
      switch (shape) {
        SkeletonShape.circle => ('2.5rem', '2.5rem', null, '50%'),
        SkeletonShape.text => ('100%', '1rem', null, '0.25rem'),
        SkeletonShape.rectangle => ('100%', '1.25rem', null, '0.375rem'),
      };

  // ShadCN Skeleton: animate-pulse rounded-md bg-muted
  @override
  Map<String, String> surfaceStyles(SkeletonProps props) => <String, String>{
    'background-color': 'var(--muted)',
    if (props.animate)
      'animation': 'arcane-pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite',
  };
}
