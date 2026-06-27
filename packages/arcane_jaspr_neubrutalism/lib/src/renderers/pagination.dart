import 'package:arcane_jaspr/core/props/pagination_props.dart';
import 'package:arcane_jaspr/core/rendering/base/pagination_render_base.dart';

/// Neubrutalism Pagination renderer.
///
/// Implements the Neubrutalism design language:
/// - Larger button sizes
/// - Accent-colored active state with glow
/// - More spacing between items
class NeubrutalismPagination extends PaginationRenderBase {
  const NeubrutalismPagination(super.props, {super.key});

  @override
  String get themePrefix => 'neubrutalism';

  @override
  Map<String, String> buttonStyleVariant(bool isActive) => switch (props.style) {
    PaginationStyleVariant.outline => <String, String>{
      'background': isActive
          ? 'var(--nb-accent, var(--primary))'
          : 'var(--nb-paper, var(--card))',
      'color': isActive
          ? 'var(--nb-ink, #000)'
          : 'var(--nb-ink, var(--foreground))',
      'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
      'box-shadow': 'var(--nb-shadow-sm, 3px 3px 0 0 var(--nb-shadow-color, #000))',
    },
    PaginationStyleVariant.filled => <String, String>{
      'background': isActive ? 'var(--nb-accent, var(--primary))' : 'transparent',
      'color': isActive ? 'var(--nb-ink, #000)' : 'var(--foreground)',
      'border': 'none',
      if (isActive) 'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
    },
    PaginationStyleVariant.ghost => <String, String>{
      'background': isActive ? 'var(--nb-accent, var(--primary))' : 'transparent',
      'color': isActive ? 'var(--nb-ink, #000)' : 'var(--foreground)',
      'border': 'none',
    },
    PaginationStyleVariant.simple => <String, String>{
      'background': 'transparent',
      'color': isActive
          ? 'var(--nb-accent, var(--primary))'
          : 'var(--muted-foreground)',
      'border': 'none',
      'font-weight': isActive ? '700' : '500',
    },
  };
}
