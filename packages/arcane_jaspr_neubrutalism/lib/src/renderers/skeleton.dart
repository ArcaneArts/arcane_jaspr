import 'package:arcane_jaspr/core/props/skeleton_props.dart';
import 'package:arcane_jaspr/core/rendering/base/skeleton_render_base.dart';

class NeubrutalismSkeleton extends SkeletonRenderBase {
  const NeubrutalismSkeleton(super.props, {super.key});

  @override
  String get cssClass => 'neubrutalism-skeleton';

  @override
  (String, String, String?, String?) defaultGeometry(SkeletonShape shape) =>
      switch (shape) {
        SkeletonShape.rectangle => ('100%', '20px', 'none', null),
        SkeletonShape.circle => ('48px', '48px', null, '9999px'),
        SkeletonShape.text => (
          '100%',
          '1rem',
          null,
          'var(--nb-radius-soft, 4px)',
        ),
      };

  @override
  Map<String, String> surfaceStyles(SkeletonProps props) => <String, String>{
    'background': 'var(--nb-paper, var(--card))',
    'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
    'box-shadow':
        'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
    'opacity': props.animate ? '0.7' : '0.55',
  };
}
