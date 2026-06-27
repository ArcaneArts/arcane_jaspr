import 'package:arcane_jaspr/core/props/pagination_props.dart';
import 'package:arcane_jaspr/core/rendering/base/pagination_render_base.dart';

/// Neon Pagination renderer.
///
/// Implements the Neon design language:
/// - Larger button sizes
/// - Accent-colored active state with glow
/// - More spacing between items
class NeonPagination extends PaginationRenderBase {
  const NeonPagination(super.props, {super.key});

  @override
  String get themePrefix => 'neon';

  @override
  Map<String, String> buttonStyleVariant(bool isActive) => switch (props.style) {
    PaginationStyleVariant.outline => <String, String>{
      'background': isActive ? 'var(--neon-accent)' : 'transparent',
      'color': isActive ? 'var(--neon-on-accent)' : 'var(--foreground)',
      'border': isActive
          ? '1px solid var(--neon-accent)'
          : '1px solid var(--neon-control-border)',
      'clip-path': 'var(--neon-control-clip)',
      if (isActive) 'box-shadow': 'var(--neon-glow-md)',
    },
    PaginationStyleVariant.filled => <String, String>{
      'background': isActive ? 'var(--neon-accent)' : 'var(--neon-panel-tint)',
      'color': isActive ? 'var(--neon-on-accent)' : 'var(--foreground)',
      'border': 'none',
      'clip-path': 'var(--neon-control-clip)',
      if (isActive) 'box-shadow': 'var(--neon-glow-md)',
    },
    PaginationStyleVariant.ghost => <String, String>{
      'background': isActive ? 'var(--neon-accent-soft)' : 'transparent',
      'color': isActive ? 'var(--neon-accent)' : 'var(--foreground)',
      'border': 'none',
      'clip-path': 'var(--neon-clip-xs)',
    },
    PaginationStyleVariant.simple => <String, String>{
      'background': 'transparent',
      'color': isActive ? 'var(--neon-accent)' : 'var(--muted-foreground)',
      'border': 'none',
      'font-weight': isActive ? '700' : '500',
    },
  };
}
