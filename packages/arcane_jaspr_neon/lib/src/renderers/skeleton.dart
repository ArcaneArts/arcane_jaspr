import 'package:arcane_jaspr/core/props/skeleton_props.dart';
import 'package:arcane_jaspr/core/rendering/base/skeleton_render_base.dart';

/// Neon Skeleton renderer.
///
/// Implements the Neon design language:
/// - Darker skeleton color for OLED
/// - Subtle pulse animation
/// - Larger default border radius
class NeonSkeleton extends SkeletonRenderBase {
  const NeonSkeleton(super.props, {super.key});

  @override
  String get cssClass => 'neon-skeleton';

  @override
  (String, String, String?, String?) defaultGeometry(SkeletonShape shape) =>
      switch (shape) {
        SkeletonShape.rectangle => ('100%', '20px', 'var(--neon-clip-xs)', null),
        SkeletonShape.circle => ('48px', '48px', null, '9999px'),
        SkeletonShape.text => (
          '100%',
          '1rem',
          null,
          'var(--neon-radius-control)',
        ),
      };

  @override
  Map<String, String> surfaceStyles(SkeletonProps props) => <String, String>{
    'background':
        'color-mix(in srgb, var(--neon-accent) 6%, var(--neon-surface-2))',
    if (props.animate) ...{
      'animation': 'neon-skeleton-pulse 1.6s ease-in-out infinite',
      'background':
          'linear-gradient(90deg, color-mix(in srgb, var(--neon-accent) 6%, var(--neon-surface-2)) 0%, color-mix(in srgb, var(--neon-accent) 14%, var(--neon-surface-2)) 50%, color-mix(in srgb, var(--neon-accent) 6%, var(--neon-surface-2)) 100%)',
      'background-size': '200% 100%',
    },
  };
}
